---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants

local gemUtil = {
    ownedGems = {}
}
Private.GemUtil = gemUtil

---@param key number|string|?
---@return string
function gemUtil.GetSocketTypeName(key)
    if not key then return "ALL" end
    if type(key) == "number" then
        key = const.SOCKET_TYPES_INDEX[key]
    end
    local category = const.SOCKET_TYPE_INFO[key]
    return category and category.name or "All"
end

---@param socketTypeName string
---@return integer|? equipmentSlot
---@return integer|? socketSlot
function gemUtil.GetFreeSocket(socketTypeName)
    for _, equipmentSlot in ipairs(const.SOCKET_EQUIPMENT_SLOTS) do
        SocketInventoryItem(equipmentSlot)
        for socketSlot = 1, GetNumSockets() do
            if (not GetExistingSocketInfo(socketSlot)) and (GetSocketTypes(socketSlot) == socketTypeName) then
                return equipmentSlot, socketSlot
            end
        end
    end
end

---@param itemInfo table
---@param locType "BAG"|"SOCKET"
---@param locIndex integer
---@param locSlot integer
function gemUtil:AddGemData(itemInfo, locType, locIndex, locSlot)
    ---@cast itemInfo ContainerItemInfo
    if not itemInfo then return end
    local itemType = select(6, C_Item.GetItemInfoInstant(itemInfo.hyperlink))
    if itemType == 3 and self.GetGemSocketType(itemInfo.itemID) then
        for i = 1, itemInfo.stackCount do
            tinsert(self.ownedGems, {
                itemID = itemInfo.itemID,
                type = locType,
                index = locIndex,
                slot = locSlot,
                gemType = self.GetSocketTypeName(self.GetGemSocketType(itemInfo.itemID)),
            })
            Private.Cache:CacheItemInfo(itemInfo.itemID)
        end
    end
end

function gemUtil:RefreshOwnedGems()
    wipe(self.ownedGems)
    for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            self:AddGemData(C_Container.GetContainerItemInfo(bag, slot), "BAG", bag, slot)
        end
    end
    for _, itemSlot in ipairs(const.SOCKET_EQUIPMENT_SLOTS) do
        local itemLoc = ItemLocation:CreateFromEquipmentSlot(itemSlot)

        if itemLoc:IsValid() then
            local itemLink = C_Item.GetItemLink(itemLoc)
            if itemLink then
                for gemIndex = 1, 3 do
                    local gemName, gemLink = C_Item.GetItemGem(itemLink, gemIndex)
                    if gemName and gemLink then
                        self:AddGemData({
                            itemName = gemName,
                            itemID = C_Item.GetItemInfoInstant(gemLink),
                            stackCount = 1,
                            hyperlink = gemLink
                        }, "SOCKET", itemSlot, gemIndex)
                    end
                end
            end
        end
    end
end

---@param itemID integer
---@return string|?
function gemUtil.GetGemSocketType(itemID)
    return const.GEM_SOCKET_TYPE[itemID]
end

---@param category string|number|?
---@param nameFilter string|?
---@return table
function gemUtil:GetFilteredGems(category, nameFilter)
    local validGems = {}
    self:RefreshOwnedGems()
    if nameFilter then nameFilter = nameFilter:lower() end
    if type(category) == "number" then
        category = self.GetSocketTypeName(category)
    end
    category = category or "ALL"
    category = category:upper()
    for _, socketType in ipairs(const.SOCKET_TYPES_INDEX) do
        validGems[socketType] = {}
    end
    for _, gemInfo in pairs(self.ownedGems) do
        local gemCategory = self.GetGemSocketType(gemInfo.itemID)
        if category == "ALL" or gemCategory == category then
            local gemItemInfo = Private.Cache:GetItemInfo(gemInfo.itemID)
            local gemName = (gemItemInfo and gemItemInfo.name or ""):lower()
            if not (nameFilter and not gemName:match(nameFilter)) then
                tinsert(validGems[gemCategory], gemInfo)
            end
        end
    end
    return validGems
end
