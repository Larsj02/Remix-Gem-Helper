local restrictions = {
    [21] = "RACECLASS",
    [22] = "FACTION",
    [23] = "SKILL",
    [24] = "PVPMEDAL",
    [25] = "REPUTATION",
    [26] = "OWNED",
    [27] = "LEVEL"
}

local function getRestriction(lines)
    for _, lineData in ipairs(lines) do
        if restrictions[lineData.type] then
            return restrictions[lineData.type]
        end
    end
    return "NONE"
end

function GetItemsFromMerchant()
    local items = {}

    for itemIndex = 1, GetMerchantNumItems() do
        local _, itemIcon, itemCopperCost = GetMerchantItemInfo(itemIndex)
        local itemInfo = C_TooltipInfo.GetMerchantItem(itemIndex)
        if itemInfo then
            local restriction = getRestriction(itemInfo.lines)
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
            --print(itemInfo.hyperlink, itemIcon, restriction)
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


local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", function (...)
    rasuL = GetItemsFromMerchant()
end)