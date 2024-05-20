---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants
local function getCloakLevel()
    local level = 0
    for achievementID = const.CLOAK_BUFF.ACHIEVEMENT_ID_START, const.CLOAK_BUFF.ACHIEVEMENT_ID_END do
        local completed = select(4, GetAchievementInfo(achievementID))
        if completed then
            level = level + 1
        end
    end
    return string.format(" [Rank %d/12]", level)
end

local function getCloakStats()
    local cloakAura = C_UnitAuras.GetPlayerAuraBySpellID(const.CLOAK_BUFF.AURA_ID)
    if not cloakAura then return end
    local cloakTooltip = C_TooltipInfo.GetUnitBuffByAuraInstanceID("player", cloakAura.auraInstanceID)
    return cloakTooltip.lines[2].leftText
end

local function updateItemTooltip(tooltip)
    if not tooltip or not tooltip.GetItem then return end
    local link = select(2, tooltip:GetItem())
    if not link then return end
    local itemID = C_Item.GetItemInfoInstant(link)
    if itemID == const.CLOAK_BUFF.ITEM_ID then
        tooltip.TextLeft1:SetText((tooltip.TextLeft1:GetText() or "") .. getCloakLevel())
        tooltip.TextLeft2:SetText((tooltip.TextLeft2:GetText() or "").. "\n" .. getCloakStats())
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, updateItemTooltip)
