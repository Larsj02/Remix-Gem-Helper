---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants
local misc = Private.Misc

---@class SocketTypeInfo
---@field name string
---@field icon integer
---@field color colorRGB

local gemUtil = {
    owned_gems = {}
}
Private.GemUtil = gemUtil

---@param key number|string|?
---@return SocketTypeInfo|?
function gemUtil:GetSocketTypeInfo(key)
    if not key then return end
    if type(key) == "number" then
        key = const.SOCKET_TYPES_INDEX[key]
    end
    local category = const.SOCKET_TYPE_INFO[key]
    return category
end

---@param key number|string|?
---@return string
function gemUtil:GetSocketTypeName(key)
    local typeInfo = self:GetSocketTypeInfo(key)
    return typeInfo and typeInfo.name or "All"
end

---@param socketTypeName string
---@return integer|? equipmentSlot
---@return integer|? socketSlot
function gemUtil:GetFreeSocket(socketTypeName)
    misc:MuteSounds()
    for _, equipmentSlot in ipairs(const.SOCKET_EQUIPMENT_SLOTS) do
        SocketInventoryItem(equipmentSlot)
        for socketSlot = 1, GetNumSockets() do
            if (not GetExistingSocketInfo(socketSlot)) and (GetSocketTypes(socketSlot) == socketTypeName) then
                return equipmentSlot, socketSlot
            end
        end
        CloseSocketInfo()
    end
    misc:UnmuteSounds()
end

---@param socketTypeName string
---@return integer usedSlots
---@return integer maxSlots
function gemUtil:GetSocketsInfo(socketTypeName)
    local usedSlots, maxSlots = 0, 0
    for _, equipmentSlot in ipairs(const.SOCKET_EQUIPMENT_SLOTS) do
        local itemLoc = ItemLocation:CreateFromEquipmentSlot(equipmentSlot)
        if itemLoc:IsValid() then
            local itemLink = C_Item.GetItemLink(itemLoc)
            if itemLink then
                local itemStats = C_Item.GetItemStats(itemLink)
                for stat, count in pairs(itemStats) do
                    if stat:match("EMPTY_SOCKET_"..socketTypeName:upper()) then
                        maxSlots = maxSlots + count
                        usedSlots = usedSlots + #gemUtil:GetItemGems(itemLink)
                    end
                end
            end
        end
    end
    return usedSlots, maxSlots
end

---@param itemInfo table
---@param locType "BAG"|"SOCKET"
---@param locIndex integer
---@param locSlot integer
function gemUtil:AddGemData(itemInfo, locType, locIndex, locSlot)
    ---@cast itemInfo ContainerItemInfo
    if not itemInfo then return end
    local itemType = select(6, C_Item.GetItemInfoInstant(itemInfo.hyperlink))
    if itemType == 3 and self:GetGemSocketType(itemInfo.itemID) then
        for i = 1, itemInfo.stackCount do
            tinsert(self.owned_gems, {
                itemID = itemInfo.itemID,
                type = locType,
                index = locIndex,
                slot = locSlot,
                gemType = self:GetSocketTypeName(self:GetGemSocketType(itemInfo.itemID)),
            })
            Private.Cache:CacheItemInfo(itemInfo.itemID)
        end
    end
end

function gemUtil:RefreshOwnedGems()
    wipe(self.owned_gems)
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
function gemUtil:GetGemSocketType(itemID)
    return const.GEM_SOCKET_TYPE[itemID]
end

function gemUtil:GetItemGems(itemLink)
    local _, linkOptions = LinkUtil.ExtractLink(itemLink)
    local item = { strsplit(":", linkOptions) }
    local gemsList = {}
    for i = 1, 4 do
        local gem = tonumber(item[i + 2])
        if gem then
            tinsert(gemsList, gem)
        end
    end
    return gemsList
end

local function passesFilter(itemID, filter)
    filter = filter:gsub("%%", "%%%%"):gsub("%+", "%%+")
    local gemItemInfo = Private.Cache:GetItemInfo(itemID)
    local gemNameAndDesc = (gemItemInfo and gemItemInfo.name or "") ..
        (gemItemInfo and gemItemInfo.description or ""):lower()
    if not (filter and not gemNameAndDesc:match(filter)) then
        return true
    end
    return false
end

---@param category string|number|?
---@param nameFilter string|?
---@return table
function gemUtil:GetFilteredGems(category, nameFilter)
    local validGems = {}
    self:RefreshOwnedGems()
    if nameFilter then nameFilter = nameFilter:lower() end
    if type(category) == "number" then
        category = self:GetSocketTypeName(category)
    end
    category = category or "ALL"
    category = category:upper()
    for _, socketType in ipairs(const.SOCKET_TYPES_INDEX) do
        validGems[socketType] = {}
    end
    for _, gemInfo in pairs(self.owned_gems) do
        local gemCategory = self:GetGemSocketType(gemInfo.itemID)
        if category == "ALL" or gemCategory == category then
            if gemCategory ~= "PRIMORDIAL" or Private.Settings:GetSetting("show_primordial") then
                if passesFilter(gemInfo.itemID, nameFilter) then
                    tinsert(validGems[gemCategory], gemInfo)
                end
            end
        end
    end

    if Private.Settings:GetSetting("show_unowned") then
        for gemItemID, gemCategory in pairs(const.GEM_SOCKET_TYPE) do
            if category == "ALL" or gemCategory == category then
                if passesFilter(gemItemID, nameFilter) then
                    local dupeID = false
                    for _, gemInf in ipairs(self.owned_gems) do
                        if gemInf.itemID == gemItemID then
                            dupeID = true
                            break
                        end
                    end
                    if (not dupeID) and (gemCategory ~= "PRIMORDIAL" or Private.Settings:GetSetting("show_primordial")) then
                        tinsert(validGems[gemCategory], {
                            itemID = gemItemID,
                            type = "UNCOLLECTED",
                            gemType = self:GetSocketTypeName(gemCategory),
                        })
                    end
                end
            end
        end
    end
    return validGems
end
