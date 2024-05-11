---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants

local gemUtil = {
    itemInfo = {}
}
Private.GemUtil = gemUtil

---@param key number|string
---@return string
function gemUtil.GetSocketTypeName(key)
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