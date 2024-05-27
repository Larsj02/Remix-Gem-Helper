---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants

local itemUpgradeUtil = {}
Private.ItemUpgradeUtil = itemUpgradeUtil

---@param invSlot number
---@return table?
function itemUpgradeUtil:GetSlotUpgradeInfo(invSlot)
    return const.ITEM_UPGRADES[invSlot]
end

---@param invSlot number
---@param rank number
---@return table?
function itemUpgradeUtil:GetRankUpgradeInfo(invSlot, rank)
    local info = self:GetSlotUpgradeInfo(invSlot)
    if info and info[rank] then
        return info[rank]
    end
end

---@param invSlot number
---@return number
function itemUpgradeUtil:GetNumRanks(invSlot)
    local info = self:GetSlotUpgradeInfo(invSlot)
    if info then
        return #info
    end
    return 0
end

---@param invSlot number
---@param itemLevel number
---@return table?
function itemUpgradeUtil:GetRankInfoByItemLevel(invSlot, itemLevel)
    local info = self:GetSlotUpgradeInfo(invSlot)
    if not info then return end
    for _, rankInfo in ipairs(info) do
        if rankInfo.ItemLevel == itemLevel then
            return rankInfo
        end
    end
end

---@param invSlot number
---@param level number
---@return table?
function itemUpgradeUtil:GetRankInfoByLevel(invSlot, level)
    local info = self:GetSlotUpgradeInfo(invSlot)
    if not info then return end
    local last = {}
    for _, rankInfo in ipairs(info) do
        if rankInfo.LevelRequired <= level then
            last = rankInfo
        else
            return last
        end
    end
end

---@param invSlot number
---@param rank number
---@return table?
function itemUpgradeUtil:GetRankInfoByRank(invSlot, rank)
    local info = self:GetSlotUpgradeInfo(invSlot)
    if not info then return end
    return info[rank]
end

---@param rankUpgradeInfo table
---@return boolean?
function itemUpgradeUtil:CanPlayerUpgrade(rankUpgradeInfo)
    local required = rankUpgradeInfo.LevelRequired
    local maxLevel = GetMaxLevelForLatestExpansion()
    if required > maxLevel then
        for invSlot in pairs(const.ITEM_UPGRADES) do
            local itemLoc = ItemLocation:CreateFromEquipmentSlot(invSlot)
            if not itemLoc:IsValid() then return end
            if C_Item.GetCurrentItemLevel(itemLoc) < required then return end
        end
    elseif UnitLevel("player") < required then
        return
    end
    return true
end
