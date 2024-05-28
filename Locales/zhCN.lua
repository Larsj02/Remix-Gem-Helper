---@class RemixGemHelperPrivate
local Private = select(2, ...)
Private.Locales = Private.Locales or {}

Private.Locales["zhCN"] = {
    --isEditing = true,

    -- addon title
    ["Remix Gem Helper"] = "幻彩再造宝石助手",

    -- gem types
    ["All"] = "全部",
    ["Meta"] = "多彩宝石",
    ["Cogwheel"] = "齿轮宝石",
    ["Tinker"] = "匠械宝石",
    ["Prismatic"] = "棱彩宝石",

    -- ItemTooltips.lua
    ["Rank"] = "等级",
    ["Upgradeable"] = "可升级",
    ["Not Upgradeable"] = "不可升级",

    -- Core.lua
    ["Socketed"] = "已镶嵌",
    ["In Bag"] = "在背包",
    ["In Bag Item!"] = "镶嵌于背包装备!",
    ["Uncollected"] = "未获得",
    ["Scrappable Items"] = "可拆解物品",
    ["NOTHING TO SCRAP"] = "*无可拆解物品*",
    ["Resocket Gems"] = "重新镶嵌宝石",
    ["Toggle the %s UI"] = "切换 %s 界面", -- %s is the Addon name and needs to be included!
    ["Search Gems"] = "搜索宝石",
    ["Unowned"] = "未拥有",
    ["Show Unowned Gems in the List."] = "在列表中显示未拥有的宝石。",
    ["Primordial"] = "始源之石",
    ["Show Primordial Gems in the List."] = "在列表中显示始源之石。",
    ["Open, Use and Combine"] = "可打开，使用或组合",
    ["NOTHING TO USE"] = "*无*",
    ["HelpText"] =
        "|A:newplayertutorial-icon-mouse-leftbutton:16:16|a Click a Gem in this list to Socket or Unsocket.\n" ..
        "'In Bag Item' or 'Socketed' indicates that you unsocket it.\n" ..
        "'In Bag' indicates that the Gem is in your bag and ready to be socketed.\n\n" ..
        "When hovering over a Gem that is 'Socketed' you will see the item highlighted in your character panel.\n" ..
        "You can use the dropdown or the search bar at the top to filter your list.\n" ..
        "This Addon also adds the current Rank and stats of your cloak inside the cloak tooltip.\n" ..
        "You should see an icon in the top right of your character frame which can be used to hide or show this frame.\n" ..
        "Below the Gem list you should have some clickable buttons to quickly open Chests or combine Gems\n\n" ..
        "And to get rid of this frame simply shift click it.\nHave fun!",

    -- UIElements.lua
    ["You don't have a valid free Slot for this Gem"] = "你没有空插槽来使用这个宝石",
}
