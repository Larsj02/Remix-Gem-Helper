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
        "|A:newplayertutorial-icon-mouse-leftbutton:16:16|a 在列表中点击宝石来镶嵌或取出。\n" ..
        "“镶嵌于背包装备!”或者“已镶嵌”表示你已经镶嵌了此宝石。\n" ..
        "“在背包”表示宝石在你的背包中可用于镶嵌。\n\n" ..
        "将鼠标悬停在一个“已镶嵌”的宝石上，可以在角色信息界面突出显示镶嵌了此宝石的装备。\n" ..
        "你可以使用顶部的下拉菜单或者搜索栏来筛选你的列表。\n" ..
        "本插件也在鼠标提示里显示你的永恒潜能披风当前的等级和属性。\n" ..
        "在角色信息界面右上方有一个沙漏图标，可以用来隐藏或显示此插件的界面。\n" ..
        "在宝石列表下方，你可以点击图标打开宝箱，使用帛线或组合宝石。\n\n" ..
        "Shift+点击本提示的图标可以关闭本提示。\n希望国服早日重开！",

    -- UIElements.lua
    ["You don't have a valid free Slot for this Gem"] = "你没有空插槽来使用这个宝石",
}
