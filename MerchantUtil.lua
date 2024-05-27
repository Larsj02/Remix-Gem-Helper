---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants
local addon = Private.Addon

local merchantUtil = {}
Private.MerchantUtil = merchantUtil

---@param lines table
---@return string
function merchantUtil:GetRestriction(lines)
    for _, lineData in ipairs(lines) do
        if const.MERCHANT_RESTRICTIONS[lineData.type] then
            return const.MERCHANT_RESTRICTIONS[lineData.type]
        end
    end
    return "NONE"
end

function merchantUtil:GetMerchantItems()
    local items = {}

    for itemIndex = 1, GetMerchantNumItems() do
        local _, itemIcon, itemCopperCost = GetMerchantItemInfo(itemIndex)
        local itemInfo = C_TooltipInfo.GetMerchantItem(itemIndex)
        if itemInfo then
            local restriction = self:GetRestriction(itemInfo.lines)
            if not items[restriction] then items[restriction] = {} end
            local itemCost = {}
            if itemCopperCost > 0 then
                tinsert(itemCost, {
                    type = "MONEY",
                    value = itemCopperCost,
                })
                if not items[restriction].cost then items[restriction].cost = {} end
                if not items[restriction].cost["MONEY"] then items[restriction].cost["MONEY"] = 0 end
                items[restriction].cost["MONEY"] = items[restriction].cost["MONEY"] + itemCopperCost
            end
            for costIndex = 1, GetMerchantItemCostInfo(itemIndex) do
                local costIcon, costValue, costLink = GetMerchantItemCostItem(itemIndex, costIndex)
                tinsert(itemCost, {
                    type = "CURRENCY",
                    icon = costIcon,
                    link = costLink,
                    value = costValue
                })
                if costIcon then
                    if not items[restriction].cost then items[restriction].cost = {} end
                    if not items[restriction].cost[costIcon] then items[restriction].cost[costIcon] = 0 end
                    items[restriction].cost[costIcon] = items[restriction].cost[costIcon] + costValue
                end
            end
            tinsert(items[restriction], {
                icon = itemIcon,
                link = itemInfo.hyperlink,
                costInfo = itemCost,
            })
        end
    end

    return items
end
