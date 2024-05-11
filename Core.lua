local selectedCategory = 0
local EXTRACT_GEM = GetSpellInfo(433397)
local CATEGORIES = {
    "META",
    "COGWHEEL",
    "TINKER",
    "PRISMATIC",
    "PRIMORDIAL",
    [0] = "ALL"
}

local GEM_CATEGORY = {
    [221982] = "META",      -- Bulwark of the Black Ox
    [221977] = "META",      -- Funeral Pyre
    [220211] = "META",      -- Precipice of Madness
    [220120] = "META",      -- Soul Tether
    [220117] = "META",      -- Ward of Salvation
    [219878] = "META",      -- Tireless Spirit
    [219386] = "META",      -- Locus of Power
    --[216974] = "META",      -- Morphing Elements
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

    [204000] = "PRIMORDIAL", -- 
    [204027] = "PRIMORDIAL", -- 
    [204029] = "PRIMORDIAL", -- 
    [204018] = "PRIMORDIAL", -- 

}
local GEM_SLOTS = {
    INVSLOT_HEAD,
    INVSLOT_NECK,
    INVSLOT_SHOULDER,
    INVSLOT_CHEST,
    INVSLOT_WAIST,
    INVSLOT_LEGS,
    INVSLOT_FEET,
    INVSLOT_WRIST,
    INVSLOT_HAND,
    INVSLOT_FINGER1,
    INVSLOT_FINGER2,
    INVSLOT_TRINKET1,
    INVSLOT_TRINKET2,
}
local GEM_NAME = {}
local ownedGems = {}

for itemID in pairs(GEM_CATEGORY) do
    local item = Item:CreateFromItemID(itemID)
    item:ContinueOnItemLoad(function()
        GEM_NAME[itemID] = item:GetItemName()
    end)
end

local ICONS = {
    META = 630620,
    COGWHEEL = 134063,
    TINKER = 133871,
    PRISMATIC = 133259,
}

local COLORS = {
    POSITIVE = CreateColorFromHexString("FF2ecc71"),
    NEGATIVE = CreateColorFromHexString("FFe74c3c"),
}

local function getCatString(index)
    index = index or selectedCategory
    return (CATEGORIES[index] or "?"):lower():gsub("^%l", string.upper)
end

local function getFreeSlot(searchType)
    searchType = searchType:lower()
    for _, invSlot in ipairs(GEM_SLOTS) do
        SocketInventoryItem(invSlot)
        for socketSlot = 1, GetNumSockets() do
            local socketType = GetSocketTypes(socketSlot)
            socketType = socketType and socketType:lower() or ""
            if (not GetExistingSocketInfo(socketSlot)) and (socketType == searchType) then
                return invSlot, socketSlot
            end
        end
    end
end

local function createExtractBtn(parent)
    local btn = CreateFrame("Button", nil, parent, "InsecureActionButtonTemplate")
    btn:SetScript("PreClick", function(self)
        if not self.info then return end
        local info = self.info
        if info.type == "SOCKET" then
            SocketInventoryItem(info.index)
        elseif info.type == "BAG" then
            local equipSlot, equipSocket = getFreeSlot(info.gemType)
            C_Container.PickupContainerItem(info.index, info.slot)
            SocketInventoryItem(equipSlot)
            info.gemSlot = equipSocket
        end
    end)
    btn:SetScript("PostClick", function(self)
        if not self.info then return end
        local info = self.info
        if info.type == "SOCKET" then
            ClickSocketButton(info.slot)
        elseif info.type == "BAG" then
            ClearCursor()
            if not info.gemSlot then
                UIErrorsFrame:AddExternalErrorMessage("You don't have a valid free Slot for this Gem")
                CloseSocketInfo()
                return
            end
            C_Container.PickupContainerItem(info.index, info.slot)
            ClickSocketButton(info.gemSlot)
            AcceptSockets()
        end
        CloseSocketInfo()
    end)
    btn:SetAllPoints()
    btn:RegisterForClicks("AnyDown")
    btn:SetAttribute("type", "macro")

    function btn:UpdateInfo(infoType, infoIndex, infoSlot, infoGemType)
        self.info = {
            type = infoType,
            index = infoIndex,
            slot = infoSlot,
            gemType = infoGemType,
            gemSlot = 0,
        }
        if infoType == "SOCKET" then
            local txt = "/cast " .. EXTRACT_GEM
            txt = "/click ExtraActionButton1" -- For test reasons
            self:SetAttribute("macrotext", txt)
        else
            self:SetAttribute("macrotext", "")
        end
    end

    return btn
end

local gems = CreateFrame("Frame", nil, CharacterStatsPane, "ButtonFrameTemplate")
gems:RegisterEvent("BAG_UPDATE_DELAYED")
ButtonFrameTemplate_HidePortrait(gems)
gems:ClearAllPoints()
gems:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMRIGHT")
gems:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT")
gems:SetWidth(300)
gems:Show()
gems.CloseButton:Hide()
gems:SetTitle("Remix Gems Manager")
gems.Inset:ClearAllPoints()
gems.Inset:SetPoint("TOP", 0, -65)
gems.Inset:SetPoint("BOTTOM", 0, 35)
gems.Inset:SetPoint("LEFT", 20, 0)
gems.Inset:SetPoint("RIGHT", -20, 0)

local search = CreateFrame("EditBox", nil, gems, "InputBoxInstructionsTemplate")
search.Instructions:SetText("Search Gems")
search:ClearFocus()
search:SetAutoFocus(false)
search:SetPoint("TOPRIGHT", gems.TopTileStreaks, -5, -15)
search:SetPoint("BOTTOMLEFT", gems.TopTileStreaks, "BOTTOM", 0, 15)

local dropDown = CreateFrame("Frame", nil, gems, "UIDropDownMenuTemplate")
dropDown:SetPoint("TOPLEFT", gems.TopTileStreaks, -10, -10)
dropDown:SetPoint("RIGHT", search, "LEFT", -15, 0)

--local apply = CreateFrame("Button", nil, gems, "UIPanelButtonTemplate")
--apply:SetPoint("TOPRIGHT", gems.Inset, "BOTTOMRIGHT", -5, -5)
--apply:SetPoint("BOTTOMLEFT", gems, "BOTTOM", 0, 10)
--apply:SetText(TALENT_FRAME_APPLY_BUTTON_TEXT)

local version = gems:CreateFontString(nil, "ARTWORK", "GameFontDisableSmallLeft")
version:SetPoint("BOTTOMLEFT", 15, 10)
version:SetText("v1.0.0\nBy Rasu")

local function updateText()
    UIDropDownMenu_SetText(dropDown, getCatString())
end

UIDropDownMenu_Initialize(dropDown, function(self)
    local info = UIDropDownMenu_CreateInfo()
    for i = 0, #CATEGORIES do
        info.func = self.SetValue
        info.arg1 = i
        info.checked = selectedCategory == i
        info.text = getCatString(i)
        UIDropDownMenu_AddButton(info)
    end
    updateText()
end)

local scrollBox = CreateFrame("Frame", nil, gems, "WowScrollBoxList")
scrollBox:SetAllPoints(gems.Inset)

local scrollBar = CreateFrame("EventFrame", nil, gems, "MinimalScrollBar")
scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 5, 0)
scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")
scrollBar:SetHideIfUnscrollable(true)

local scrollView = CreateScrollBoxListLinearView()
scrollView:SetElementInitializer("BackDropTemplate", function(button, data)
    ---@cast button Frame
    local index = data.index
    local isHeader = data.isHeader or false
    local icon = data.icon
    local name = data.text

    if not button.initialized then
        local font = button:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
        font:SetPoint("LEFT", 5, 0)
        button.Name = font

        local texture = button:CreateTexture(nil, "OVERLAY")
        texture:SetPoint("RIGHT", -5, 0)
        texture:SetSize(16, 16)
        button.Icon = texture

        local highlight = button:CreateTexture()
        highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
        highlight:SetPoint("BOTTOMLEFT", 5, 0)
        highlight:SetPoint("TOPRIGHT", -5, 0)
        button.Highlight = highlight
        highlight:Hide()

        local stripe = button:CreateTexture()
        stripe:SetColorTexture(1, 1, 1, .08)
        stripe:SetPoint("BOTTOMLEFT", 5, 0)
        stripe:SetPoint("TOPRIGHT", -5, 0)
        button.Stripe = stripe

        local extractButton = createExtractBtn(button)
        button.Extract = extractButton

        button:SetScript("OnEnter", function(self)
            self.Highlight:Show()
            if self.id then
                GameTooltip:ClearLines()
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
                GameTooltip:SetHyperlink("item:" .. self.id)
                GameTooltip:Show()
            end
        end)

        button:SetScript("OnLeave", function(self)
            self.Highlight:Hide()
            if self.id then
                GameTooltip:Hide()
            end
        end)

        extractButton:HookScript("OnEnter", function()
            button:GetScript("OnEnter")(button)
        end)
        extractButton:HookScript("OnLeave", function()
            button:GetScript("OnLeave")(button)
        end)

        button.initialized = true
    end

    button.Name:SetText(name)
    button.Name:SetFontObject("GameFontHighlightLeft")
    button.Icon:SetTexture(icon)
    if (isHeader) then
        button.Name:SetFontObject("GameFontNormal")
        button.Extract:Hide()
    else
        button.Extract:Show()
        local exInf = data.info
        button.Extract:UpdateInfo(
            exInf.type,
            exInf.index,
            exInf.slot,
            exInf.gemType
        )
        local state, color 
        if exInf.type == "SOCKET" then
            state, color = "Socketed", COLORS.POSITIVE
        else
            state, color = "In Bag", COLORS.NEGATIVE
        end
        button.Name:SetText(string.format("%s (%s)", GEM_NAME[data.id], color:WrapTextInColorCode(state)))
    end

    button.index = index
    button.isHeader = isHeader
    button.id = data.id
    button.Stripe:SetShown(data.index % 2 == 1)
end)
ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)

scrollView:SetElementExtent(20)

function scrollView:UpdateTree(data)
    if not data then return end
    local scrollPercent = scrollBox:GetScrollPercentage()
    self:Flush()
    local dataProvider = CreateDataProvider()
    self:SetDataProvider(dataProvider)
    for category, categoryData in pairs(data) do
        if #categoryData > 0 then
            dataProvider:Insert({ text = category, isHeader = true, icon = ICONS[category], index = 0 })
            sort(categoryData, function(a, b)
                return a.itemID > b.itemID
            end)
            for itemIndex, itemInfo in ipairs(categoryData) do
                local itemID = itemInfo.itemID
                local icon = select(5, C_Item.GetItemInfoInstant(itemID))
                dataProvider:Insert({ id = itemID, icon = icon, index = itemIndex, info = itemInfo })
            end
        end
    end
    scrollBox:SetScrollPercentage(scrollPercent or 1)
end

local function addGems(itemInfo, locType, locIndex, locSlot)
    ---@cast itemInfo ContainerItemInfo
    if not itemInfo then return end
    local itemType = select(6, C_Item.GetItemInfoInstant(itemInfo.hyperlink))
    if itemType == 3 and GEM_CATEGORY[itemInfo.itemID] then
        for i = 1, itemInfo.stackCount do
            tinsert(ownedGems, {
                itemID = itemInfo.itemID,
                type = locType,
                index = locIndex,
                slot = locSlot,
                gemType = "Primordial",
            })
            GEM_NAME[itemInfo.itemID] = itemInfo.itemName
        end
    end
end

local function scanForGems()
    wipe(ownedGems)
    for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            addGems(C_Container.GetContainerItemInfo(bag, slot), "BAG", bag, slot)
        end
    end
    for _, itemSlot in ipairs(GEM_SLOTS) do
        local itemLoc = ItemLocation:CreateFromEquipmentSlot(itemSlot)

        if itemLoc:IsValid() then
            local itemLink = C_Item.GetItemLink(itemLoc)
            if itemLink then
                for gemIndex = 1, 3 do
                    local gemName, gemLink = C_Item.GetItemGem(itemLink, gemIndex)
                    if gemName and gemLink then
                        addGems({
                            itemName = gemName,
                            itemID = C_Item.GetItemInfoInstant(gemLink),
                            stackCount = 1,
                            hyperlink = gemLink
                        }, "SOCKET", itemSlot, gemIndex)
                    end
                end
            end
        end
    end
end

local function getFilteredGems(category, nameFilter)
    scanForGems()
    if nameFilter then nameFilter = nameFilter:lower() end
    category = category or CATEGORIES[selectedCategory] or "ALL"
    category = category:upper()
    local validGems = {}
    for _, cat in ipairs(CATEGORIES) do
        validGems[cat] = {}
    end
    for _, gemInfo in pairs(ownedGems) do
        local gemID = gemInfo.itemID
        local gemCategory = GEM_CATEGORY[gemID]
        if category == "ALL" or gemCategory == category then
            local gemName = (GEM_NAME[gemID] or ""):lower()
            if not (nameFilter and not gemName:match(nameFilter)) then
                tinsert(validGems[gemCategory], gemInfo)
            end
        end
    end
    return validGems
end

function dropDown:SetValue(selIndex)
    selectedCategory = selIndex
    updateText()
    CloseDropDownMenus()
    scrollView:UpdateTree(getFilteredGems())
end

search:HookScript("OnTextChanged", function(self)
    scrollView:UpdateTree(getFilteredGems(nil, self:GetText() or ""))
end)

gems:SetScript("OnEvent", function(self, event)
    if event == "BAG_UPDATE_DELAYED" then
        scrollView:UpdateTree(getFilteredGems(nil, search:GetText() or ""))
    end
end)


scrollView:UpdateTree(getFilteredGems())
