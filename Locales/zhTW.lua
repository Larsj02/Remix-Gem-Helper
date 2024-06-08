---@class RemixGemHelperPrivate
local Private = select(2, ...)
Private.Locales = Private.Locales or {}

Private.Locales["zhTW"] = {
    --isEditing = true,

    -- addon title
    ["Remix Gem Helper"] = "混搭寶石助手",

    -- ItemTooltips.lua
    ["Rank"] = "等級",
    ["Upgradeable"] = "可升級",
    ["Not Upgradeable"] = "不可升級",

    -- Core.lua
    ["Socketed"] = "已鑲嵌",
    ["In Bag"] = "在背包",
    ["In Bag Item!"] = "在背包內的物品中!",
    ["Uncollected"] = "尚未收集",
    ["Scrappable Items"] = "拆解物品",
    ["NOTHING TO SCRAP"] = "無可拆解物品",
    ["Resocket Gems"] = "重新鑲嵌寶石",
    ["Toggle the %s UI"] = "開啟 %s 介面", -- %s is the Addon name and needs to be included!
    ["Search Gems"] = "搜尋寶石",
    ["Unowned"] = "尚未擁有",
    ["Show Unowned Gems in the List."] = "在清單中顯示尚未擁有的寶石.",
    ["All"] = "所有",
    ["Meta"] = "變換",
    ["Cogwheel"] = "榫輪",
    ["Tinker"] = "技工",
    ["Prismatic"] = "稜彩",
    ["Primordial"] = "原初之石",
    ["Show Primordial Gems in the List."] = "在清單中顯示原初之石.",
    ["Open, Use and Combine"] = "開啟, 使用或組合",
    ["NOTHING TO USE"] = "沒有東西可以使用",
    ["HelpText"] =
        "|A:newplayertutorial-icon-mouse-leftbutton:16:16|a 在清單中點選一個寶石來鑲嵌或拆下.\n" ..
        "'在背包內的物品中' 或 '已鑲嵌' 表示你將會拆下該寶石.\n" ..
        "'在背包' 表示寶石已在你的背包內並準備被鑲嵌.\n\n" ..
        "當指到顯示 '已鑲嵌' 的寶石時, 角色介面上被鑲嵌的物品會高亮顯示.\n" ..
        "你可以使用頂部的下拉選單或是搜尋列來過濾你的清單.\n" ..
        "此插件也加入了披風等級和屬性顯示到披風的滑鼠提示上.\n" ..
        "你可以在你的角色介面右上角看到一個圖標來顯示或隱藏此插件.\n" ..
        "在寶石清單的下方你可以看到一些可點選的按鈕來快速開啟箱子或是組合寶石\n\n" ..
        "Shift + 點選來關閉此視窗.\n祝玩得高興!",

    -- Misc.lua
    ["You're clicking too fast"] = "你點得太快了",

    -- Base.lua
    ["You don't have a valid free Slot for this Gem"] = "你沒有可使用此寶石的有效空插槽",
}
