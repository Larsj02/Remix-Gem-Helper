local selection = 0
local categories = {
    "Meta Gems",
    "Cogwheel Gems",
    "Tinker Gems",
    "Prismatic Gems",
    [0] = "All Gems",
}

local gemList = {
    [221982] = "META",      -- Bulwark of the Black Ox
    [221977] = "META",      -- Funeral Pyre
    [220211] = "META",      -- Precipice of Madness
    [220120] = "META",      -- Soul Tether
    [220117] = "META",      -- Ward of Salvation
    [219878] = "META",      -- Tireless Spirit
    [219386] = "META",      -- Locus of Power
    [216974] = "META",      -- Morphing Elements
    [216711] = "META",      -- Chi-ji, the Red Crane
    [216695] = "META",      -- Lifestorm
    [216671] = "META",      -- Thundering Orb
    [216663] = "META",      -- Oblivion Sphere

    [218110] = "COGWHEEL",  -- Soulshape
    [218109] = "COGWHEEL",  -- Death's Advance
    [218108] = "COGWHEEL",  -- Dark Pact
    [218082] = "COGWHEEL",  -- Spiritwalker's Grace
    [218046] = "COGWHEEL",  -- Spirit Walk
    [218045] = "COGWHEEL",  -- Door of Shadows
    [218044] = "COGWHEEL",  -- Pursuit of Justice
    [218043] = "COGWHEEL",  -- Wild Charge
    [218005] = "COGWHEEL",  -- Stampeding Roar
    [218004] = "COGWHEEL",  -- Vanish
    [218003] = "COGWHEEL",  -- Leap of Faith
    [217989] = "COGWHEEL",  -- Trailblazer
    [217983] = "COGWHEEL",  -- Disengage
    [216632] = "COGWHEEL",  -- Sprint
    [216631] = "COGWHEEL",  -- Roll
    [216630] = "COGWHEEL",  -- Heroic Leap
    [216629] = "COGWHEEL",  -- Blink

    [219801] = "TINKER",    -- Ankh of Reincarnation
    [212366] = "TINKER",    -- Arcanist's Edge
    [219944] = "TINKER",    -- Bloodthirsty Coral
    [219818] = "TINKER",    -- Brilliance
    [216649] = "TINKER",    -- Brittle
    [216648] = "TINKER",    -- Cold Front
    [217957] = "TINKER",    -- Deliverance
    [212694] = "TINKER",    -- Enkindle
    [212749] = "TINKER",    -- Explosive Barrage
    [212365] = "TINKER",    -- Fervor
    [219817] = "TINKER",    -- Freedom
    [212916] = "TINKER",    -- Frost Armor
    [219777] = "TINKER",    -- Grounding
    [217964] = "TINKER",    -- Holy Martyr
    [216647] = "TINKER",    -- Hailstorm
    [212758] = "TINKER",    -- Incendiary Terror
    [219389] = "TINKER",    -- Lightning Rod
    [216624] = "TINKER",    -- Mark of Arrogance
    [216650] = "TINKER",    -- Memory of Vengeance
    [212759] = "TINKER",    -- Meteor Storm
    [212361] = "TINKER",    -- Opportunist
    [216625] = "TINKER",    -- Quick Strike
    [217961] = "TINKER",    -- Righteous Frenzy
    [217927] = "TINKER",    -- Savior
    [216651] = "TINKER",    -- Searing Light
    [216626] = "TINKER",    -- Slay
    [219452] = "TINKER",    -- Static Charge
    [219523] = "TINKER",    -- Storm Overload
    [212362] = "TINKER",    -- Sunstrider's Flourish
    [216627] = "TINKER",    -- Tinkmaster's Shield
    [219527] = "TINKER",    -- Vampiric Aura
    [216628] = "TINKER",    -- Victory Fire
    [217903] = "TINKER",    -- Vindication
    [217907] = "TINKER",    -- Warmth
    [212760] = "TINKER",    -- Wildfire
    [219516] = "TINKER",    -- Windweaver

    [210715] = "PRISMATIC", -- Chipped Masterful Amethyst
    [216640] = "PRISMATIC", -- Flawed Masterful Amethyst
    [211106] = "PRISMATIC", -- Masterful Amethyst
    [211108] = "PRISMATIC", -- Perfect Masterful Amethyst
    [210714] = "PRISMATIC", -- Chipped Deadly Sapphire
    [216644] = "PRISMATIC", -- Flawed Deadly Sapphire
    [211123] = "PRISMATIC", -- Deadly Sapphire
    [211102] = "PRISMATIC", -- Perfect Deadly Sapphire
    [210681] = "PRISMATIC", -- Chipped Quick Topaz
    [216643] = "PRISMATIC", -- Flawed Quick Topaz
    [211107] = "PRISMATIC", -- Quick Topaz
    [211110] = "PRISMATIC", -- Perfect Quick Topaz
    [220371] = "PRISMATIC", -- Chipped Versatile Diamond
    [220372] = "PRISMATIC", -- Flawed Versatile Diamond
    [220374] = "PRISMATIC", -- Versatile Diamond
    [220373] = "PRISMATIC", -- Perfect Versatile Diamond
    [220367] = "PRISMATIC", -- Chipped Stalwart Pearl
    [220368] = "PRISMATIC", -- Flawed Stalwart Pearl
    [220370] = "PRISMATIC", -- Stalwart Pearl
    [220369] = "PRISMATIC", -- Perfect Stalwart Pearl
    [211109] = "PRISMATIC", -- Chipped Sustaining Emerald
    [216642] = "PRISMATIC", -- Flawed Sustaining Emerald
    [211125] = "PRISMATIC", -- Sustaining Emerald
    [211105] = "PRISMATIC", -- Perfect Sustaining Emerald
    [210717] = "PRISMATIC", -- Chipped Hungering Ruby
    [216641] = "PRISMATIC", -- Flawed Hungering Ruby
    [210718] = "PRISMATIC", -- Hungering Ruby
    [211103] = "PRISMATIC", -- Perfect Hungering Ruby
    [210716] = "PRISMATIC", -- Chipped Swift Opal
    [216639] = "PRISMATIC", -- Flawed Swift Opal
    [211124] = "PRISMATIC", -- Swift Opal
    [211101] = "PRISMATIC", -- Perfect Swift Opal
}

local gems = CreateFrame("Frame", nil, CharacterFrame, "ButtonFrameTemplate")
ButtonFrameTemplate_HidePortrait(gems)
gems:ClearAllPoints()
gems:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMRIGHT")
gems:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT")
gems:SetWidth(300)
gems:Show()
--gems.CloseButton:Hide()
gems:SetTitle("Remix Gems Manager")
gems.Inset:ClearAllPoints()
gems.Inset:SetPoint("TOP", 0, -65)
gems.Inset:SetPoint("BOTTOM", 0, 35)
gems.Inset:SetPoint("LEFT", 20, 0)
gems.Inset:SetPoint("RIGHT", -15, 0)

local search = CreateFrame("EditBox", nil, gems, "InputBoxInstructionsTemplate")
search.Instructions:SetText("Search Gems")
search:ClearFocus()
search:SetAutoFocus(false)
search:SetPoint("TOPRIGHT", gems.TopTileStreaks, -5, -15)
search:SetPoint("BOTTOMLEFT", gems.TopTileStreaks, "BOTTOM", 0, 15)

local dropDown = CreateFrame("Frame", nil, gems, "UIDropDownMenuTemplate")
dropDown:SetPoint("TOPLEFT", gems.TopTileStreaks, -10, -10)
dropDown:SetPoint("RIGHT", search, "LEFT", -15, 0)

local apply = CreateFrame("Button", nil, gems, "UIPanelButtonTemplate")
apply:SetPoint("TOPRIGHT", gems.Inset, "BOTTOMRIGHT", -5, -5)
apply:SetPoint("BOTTOMLEFT", gems, "BOTTOM", 0, 10)
apply:SetText(TALENT_FRAME_APPLY_BUTTON_TEXT)

local version = gems:CreateFontString(nil, "ARTWORK", "GameFontDisableSmallLeft")
version:SetPoint("BOTTOMLEFT", 15, 10)
version:SetText("v1.0.0\nBy Rasu")

local function updateText()
    UIDropDownMenu_SetText(dropDown, categories[selection] or "?")
end

UIDropDownMenu_Initialize(dropDown, function(self)
    local info = UIDropDownMenu_CreateInfo()
    for i = 0, #categories do
        local name = categories[i]
        info.func = self.SetValue
        info.arg1 = i
        info.checked = selection == i
        info.text = name
        UIDropDownMenu_AddButton(info)
    end
    updateText()
end)

function dropDown:SetValue(selIndex)
    selection = selIndex
    updateText()
    CloseDropDownMenus()
end

local scrollBox = CreateFrame("Frame", nil, gems, "WowScrollBoxList")
scrollBox:SetAllPoints(gems.Inset)

local scrollBar = CreateFrame("EventFrame", nil, gems, "MinimalScrollBar")
scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 5, 0)
scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")
scrollBar:SetHideIfUnscrollable(true)

local scrollView = CreateScrollBoxListLinearView()
scrollView:SetElementInitializer("BackdropTemplate", function(frame, data)
    ---@cast frame Frame
    if not frame.initialized then
        local tex = frame:CreateTexture()
        tex:SetAllPoints()

        local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLeft")
        text:SetPoint("LEFT", 5, 0)

        frame.text = text
        frame.tex = tex
        frame.initialized = true
    end
    local tex = frame.tex
    local r, g, b = math.random(), math.random(), math.random()
    local icon = select(5, C_Item.GetItemInfoInstant(data.id))
    frame.text:SetText(string.format("|T%s:16|t %s", icon, data.id))
    tex:SetColorTexture(r, g, b)
end)
ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)

scrollView:SetElementExtentCalculator(function(index, node)
    return index * 25
end)

function scrollView:UpdateContentData(data)
    local scrollPercent = scrollBox:GetScrollPercentage()
    self:Flush()
    local dataProvider = CreateDataProvider()
    self:SetDataProvider(dataProvider)
    if not data then return end
    for _, part in pairs(data) do
        dataProvider:Insert(part)
    end
    scrollBox:SetScrollPercentage(scrollPercent or 1)
end

local function getGemsByCategory(category)
    category = category:upper()
    local validGems = {
        META = {},
        COGWHEEL = {},
        TINKER = {},
        PRISMATIC = {},
    }
    for gemID, gemCategory in pairs(gemList) do
        if category == "ALL" or gemCategory == category then
            tinsert(validGems[gemCategory], { id = gemID })
        end
    end
    return validGems
end


scrollView:UpdateContentData(getGemsByCategory("ALL"))
