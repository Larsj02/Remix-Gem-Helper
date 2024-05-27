---@class RemixGemHelperPrivate
local Private = select(2, ...)
local addon = Private.Addon
local const = Private.constants
local itemUpgradeUtil = Private.ItemUpgradeUtil
local function getCloakLevel()
    local level, highest = 0, 0
    for achievementID = const.CLOAK_BUFF.ACHIEVEMENT_ID_START, const.CLOAK_BUFF.ACHIEVEMENT_ID_END do
        local completed = select(4, GetAchievementInfo(achievementID))
        level = level + 1
        if completed then
            highest = level
        end
    end
    return string.format(" [%s %d/%d]", addon.Loc["Rank"], highest, level)
end

local function getCloakStats()
    local cloakAura = C_UnitAuras.GetPlayerAuraBySpellID(const.CLOAK_BUFF.AURA_ID)
    if not cloakAura then return end
    local cloakTooltip = C_TooltipInfo.GetUnitBuffByAuraInstanceID("player", cloakAura.auraInstanceID)
    if not cloakTooltip.lines or not cloakTooltip.lines[2] then return "" end
    return cloakTooltip.lines[2].leftText
end
--|A:CovenantSanctum-Upgrade-Icon-Available:16:16|a
local function updateItemTooltip(tooltip, tooltipData)
    if not tooltipData.guid then return end
    local guid = tooltipData.guid
    if not guid or not C_Item.IsItemGUIDInInventory(guid) then return end

    if tooltipData.id == const.CLOAK_BUFF.ITEM_ID then
        tooltip.TextLeft1:SetText((tooltip.TextLeft1:GetText() or "") .. getCloakLevel())
        local stats = getCloakStats()
        if stats then
            tooltip.TextLeft2:SetText((tooltip.TextLeft2:GetText() or "") .. "\n|cFFFFFFFF" .. stats)
        end
        return
    end
    local invSlot = C_Item.GetItemInventoryTypeByID(tooltipData.guid)
    invSlot = const.ITEM_TYPE_INVSLOT[invSlot]
    local itemLevel = C_Item.GetDetailedItemLevelInfo(tooltipData.guid)
    if invSlot and itemLevel then
        local rankInfo = itemUpgradeUtil:GetRankInfoByItemLevel(invSlot, itemLevel)
        if not rankInfo then return end
        local maxRank = itemUpgradeUtil:GetNumRanks(invSlot)
        local rankText = string.format(" [%d/%d]", rankInfo.Rank, maxRank)
        if rankInfo.Rank < maxRank then
            local nextRankInfo = itemUpgradeUtil:GetRankInfoByRank(invSlot, rankInfo.Rank + 1)
            if nextRankInfo then
                local isUpgradeable = itemUpgradeUtil:CanPlayerUpgrade(nextRankInfo)
                local color = isUpgradeable and const.COLORS.POSITIVE or const.COLORS.NEGATIVE
                local upText = isUpgradeable and addon.Loc["Upgradeable"] or addon.Loc["Not Upgradeable"]
                rankText = string.format("%s\n|cFFFFFFFF[%s%s|r]", rankText, color:GenerateHexColorMarkup(), upText)
            end
        end
        tooltip.TextLeft1:SetText((tooltip.TextLeft1:GetText() or "") .. rankText)
    end
end


TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, updateItemTooltip)
