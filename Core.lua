---@class RemixGemHelperPrivate
local Private = select(2, ...)

local const = Private.constants
local gemUtil = Private.GemUtil
local cache = Private.Cache
local settings = Private.Settings

for itemID in pairs(const.GEM_SOCKET_TYPE) do
    cache:CacheItemInfo(itemID)
end

local function createExtractBtn(parent)
    ---@class ExtractButton : Button
    ---@field UpdateInfo fun(self:ExtractButton, infoType:"SOCKET"|"BAG", infoIndex:number, infoSlot:number, infoGemType:"Meta"|"Cogwheel"|"Tinker"|"Prismatic"|"Primordial")
    local btn = CreateFrame("Button", nil, parent, "InsecureActionButtonTemplate")
    btn:SetScript("PreClick", function(self)
        if not self.info then return end
        local info = self.info
        if info.type == "SOCKET" then
            SocketInventoryItem(info.index)
        elseif info.type == "BAG" then
            local equipSlot, equipSocket = gemUtil:GetFreeSocket(info.gemType)
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
        local txt = ""
        if infoType == "SOCKET" then
            txt = "/cast " .. const.EXTRACT_GEM_SPELL
            if infoGemType == "Primordial" then
                txt = "/click ExtraActionButton1"
            end
        end
        self:SetAttribute("macrotext", txt)
    end

    return btn
end

local function createCheckButton(parent, data)
    local checkButton = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
    checkButton:SetPoint(unpack(data.point))
    checkButton.Text:SetText(data.text)
    checkButton.tooltip = data.tooltip
    checkButton:HookScript("OnClick", data.onClick)
    local check = checkButton:CreateTexture()
    local checkDisable = checkButton:CreateTexture()
    check:SetAtlas("checkmark-minimal")
    checkDisable:SetAtlas("checkmark-minimal-disabled")
    checkButton:SetDisabledCheckedTexture(checkDisable)
    checkButton:SetCheckedTexture(check)
    checkButton:SetNormalAtlas("checkbox-minimal")
    checkButton:SetPushedAtlas("checkbox-minimal")
    return checkButton
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function()
    eventFrame:UnregisterAllEvents()
    eventFrame:SetScript("OnEvent", nil)
    ---@class GemsFrame : Frame
    ---@field CloseButton Button
    ---@field SetTitle fun(self:GemsFrame, title:string)
    ---@field Inset Frame
    ---@field TopTileStreaks Frame
    local gems = CreateFrame("Frame", nil, CharacterStatsPane, "ButtonFrameTemplate")
    gems:SetTitle(const.ADDON_NAME)
    gems:RegisterEvent("BAG_UPDATE_DELAYED")
    gems:SetWidth(300)
    gems:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMRIGHT")
    gems:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT")

    local frameToggle = CreateFrame("Frame", nil, CharacterStatsPane)
    frameToggle:SetFrameStrata("HIGH")
    frameToggle:SetSize(42, 42)
    frameToggle:SetPoint("BOTTOMRIGHT", CharacterStatsPane, "TOPRIGHT", 5, 0)
    frameToggle:EnableMouse(true)
    local ftBg = frameToggle:CreateTexture()
    ftBg:SetAllPoints()
    ftBg:SetTexture(514608)
    ftBg:SetTexCoord(0.01562500, 0.79687500, 0.61328125, 0.7812500)
    local ftTex = frameToggle:CreateTexture()
    ftTex:SetPoint("TOPLEFT", 10, -15)
    ftTex:SetPoint("BOTTOMRIGHT", -7.5, 7.5)
    ftTex:SetAtlas("timerunning-glues-icon")
    frameToggle:SetScript("OnEnter", function (self)
        GameTooltip:ClearLines()
        GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
        GameTooltip:AddLine(string.format("Toggle the %s UI", const.ADDON_NAME), 1, 1, 1)
        GameTooltip:Show()
    end)
    frameToggle:SetScript("OnLeave", function ()
        GameTooltip:Hide()
    end)
    frameToggle:SetScript("OnMouseDown", function ()
        settings:UpdateSetting("show_frame", not settings:GetSetting("show_frame"))
    end)

    ButtonFrameTemplate_HidePortrait(gems)
    gems.CloseButton:Hide()
    gems.Inset:ClearAllPoints()
    gems.Inset:SetPoint("TOP", 0, -65)
    gems.Inset:SetPoint("BOTTOM", 0, 35)
    gems.Inset:SetPoint("LEFT", 20, 0)
    gems.Inset:SetPoint("RIGHT", -20, 0)

    ---@class SearchFrame : EditBox
    ---@field Instructions FontString
    local search = CreateFrame("EditBox", nil, gems, "InputBoxInstructionsTemplate")
    search.Instructions:SetText("Search Gems")
    search:ClearFocus()
    search:SetAutoFocus(false)
    search:SetPoint("TOPRIGHT", gems.TopTileStreaks, -5, -15)
    search:SetPoint("BOTTOMLEFT", gems.TopTileStreaks, "BOTTOM", 0, 15)

    ---@class Dropdown : Frame
    ---@field SetValue fun(self:Dropdown, ...:any)
    ---@field Text FontString
    local dropDown = CreateFrame("Frame", nil, gems, "UIDropDownMenuTemplate")
    dropDown:SetPoint("TOPLEFT", gems.TopTileStreaks, -10, -10)
    dropDown:SetPoint("RIGHT", search, "LEFT", -15, 0)
    function dropDown:UpdateSelection(selection)
        self.selection = selection
        self.Text:SetText(gemUtil:GetSocketTypeName(selection))
        CloseDropDownMenus()
    end

    local version = gems:CreateFontString(nil, "ARTWORK", "GameFontDisableSmallLeft")
    version:SetPoint("BOTTOMLEFT", 22, 15)
    version:SetText(string.format("v%s By Rasu", const.ADDON_VERSION))

    ---@class CheckButton
    ---@field Text FontString
    ---@field tooltip string

    local showUnowned = createCheckButton(gems, {
        point = {"BOTTOMRIGHT", -75, 7.5},
        text = "Unowned",
        tooltip = "Show Unowned Gems in the List.",
        onClick = function (self)
            settings:UpdateSetting("show_unowned", self:GetChecked())
        end
    })

    local showPrimordial = createCheckButton(gems, {
        point = {"BOTTOMRIGHT", -175, 7.5},
        text = "Primordial",
        tooltip = "Show Primordial Gems in the List.",
        onClick = function (self)
            settings:UpdateSetting("show_primordial", self:GetChecked())
        end
    })

    UIDropDownMenu_Initialize(dropDown, function(self)
        local info = UIDropDownMenu_CreateInfo()
        for i = 0, #const.SOCKET_TYPES_INDEX do
            local socketType = gemUtil:GetSocketTypeName(i)
            if socketType ~= "Primordial" or settings:GetSetting("show_primordial") then
                info.func = self.SetValue
                info.arg1 = i
                info.checked = dropDown.selection == i
                info.text = socketType
                UIDropDownMenu_AddButton(info)
            end
        end
        dropDown:UpdateSelection(dropDown.selection or 0)
    end)

    ---@class ScrollBox : Frame
    ---@field GetScrollPercentage fun(self:ScrollBox)
    ---@field SetScrollPercentage fun(self:ScrollBox, percentage:number)
    local scrollBox = CreateFrame("Frame", nil, gems, "WowScrollBoxList")
    scrollBox:SetAllPoints(gems.Inset)

    ---@class MinimalScrollBar : EventFrame
    ---@field SetHideIfUnscrollable fun(self:MinimalScrollBar, state:boolean)
    local scrollBar = CreateFrame("EventFrame", nil, gems, "MinimalScrollBar")
    scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT", 5, 0)
    scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")
    scrollBar:SetHideIfUnscrollable(true)


    local scrollView = CreateScrollBoxListLinearView()
    scrollView:SetElementInitializer("BackDropTemplate", function(frame, data)
        ---@class GemListEntry : Frame
        ---@field Name FontString
        ---@field Icon Texture
        ---@field Highlight Texture
        ---@field Stripe Texture
        ---@field Extract ExtractButton
        ---@field initialized boolean
        ---@field index number
        ---@field isHeader boolean|?
        ---@field id number|?
        ---@cast frame GemListEntry
        if not frame.initialized then
            local rowName = frame:CreateFontString(nil, "ARTWORK", const.FONT_OBJECTS.NORMAL)
            rowName:SetPoint("LEFT", 5, 0)
            frame.Name = rowName

            local iconTexture = frame:CreateTexture(nil, "OVERLAY")
            iconTexture:SetPoint("RIGHT", -5, 0)
            iconTexture:SetSize(16, 16)
            frame.Icon = iconTexture

            local highlightTexture = frame:CreateTexture()
            highlightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
            highlightTexture:SetPoint("BOTTOMLEFT", 5, 0)
            highlightTexture:SetPoint("TOPRIGHT", -5, 0)
            highlightTexture:Hide()
            frame.Highlight = highlightTexture

            local unevenStripe = frame:CreateTexture()
            unevenStripe:SetColorTexture(1, 1, 1, .08)
            unevenStripe:SetPoint("BOTTOMLEFT", 5, 0)
            unevenStripe:SetPoint("TOPRIGHT", -5, 0)
            frame.Stripe = unevenStripe

            local extractButton = createExtractBtn(frame)
            frame.Extract = extractButton

            frame:SetScript("OnEnter", function(self)
                self.Highlight:Show()
                if self.id then
                    GameTooltip:ClearLines()
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
                    GameTooltip:SetHyperlink("item:" .. self.id)
                    GameTooltip:Show()
                end
            end)

            frame:SetScript("OnLeave", function(self)
                self.Highlight:Hide()
                if self.id then
                    GameTooltip:Hide()
                end
            end)

            extractButton:HookScript("OnEnter", function()
                frame:GetScript("OnEnter")(frame)
            end)
            extractButton:HookScript("OnLeave", function()
                frame:GetScript("OnLeave")(frame)
            end)

            frame.initialized = true
        end
        local index = data.index
        local isHeader = data.isHeader or false
        local icon = data.icon
        local name = data.text
        local rowColor = data.color or CreateColor(1, 1, 1)

        frame.Icon:SetTexture(icon)
        frame.Name:SetTextColor(rowColor:GetRGBA())
        if isHeader then
            frame.Icon:SetDesaturated(false)
            frame.Name:SetFontObject(const.FONT_OBJECTS.HEADING)
            frame.Name:SetText(name)
            frame.Extract:Hide()
        else
            frame.Name:SetFontObject(const.FONT_OBJECTS.NORMAL)
            local exInf = data.info
            if exInf and exInf.type ~= "UNCOLLECTED" then
                frame.Icon:SetDesaturated(false)
                frame.Extract:Show()
                frame.Extract:UpdateInfo(
                    exInf.type,
                    exInf.index,
                    exInf.slot,
                    exInf.gemType
                )
            else
                frame.Icon:SetDesaturated(true)
                frame.Extract:Hide()
            end

            local state, color
            if exInf.type == "SOCKET" then
                state, color = "Socketed", const.COLORS.POSITIVE
            elseif exInf.type == "BAG" then
                state, color = "In Bag", const.COLORS.NEGATIVE
            else
                state, color = "Uncollected", const.COLORS.GREY
                name = color:WrapTextInColorCode(name)
            end
            frame.Name:SetText(string.format("%s (%s)", name, color:WrapTextInColorCode(state)))
        end

        frame.index = index
        frame.id = data.id
        frame.Stripe:SetShown(data.index % 2 == 1)
    end)
    ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)

    scrollView:SetElementExtent(25)

    function scrollView:UpdateTree(data)
        if not data then return end
        local scrollPercent = scrollBox:GetScrollPercentage()
        self:Flush()
        local dataProvider = CreateDataProvider()
        self:SetDataProvider(dataProvider)
        for socketType, socketTypeData in pairs(data) do
            if #socketTypeData > 0 then
                local typeInfo = gemUtil:GetSocketTypeInfo(socketType)
                if typeInfo then
                    dataProvider:Insert({
                        text = typeInfo.name,
                        isHeader = true,
                        icon = typeInfo.icon,
                        index = 0
                    })
                    sort(socketTypeData, function(a, b)
                        return a.itemID > b.itemID
                    end)
                    for itemIndex, itemInfo in ipairs(socketTypeData) do
                        local cachedInfo = cache:GetItemInfo(itemInfo.itemID)
                        if not cachedInfo then return end
                        dataProvider:Insert({
                            id = itemInfo.itemID,
                            icon = cachedInfo.icon,
                            text = cachedInfo.name,
                            index = itemIndex,
                            info = itemInfo
                        })
                    end
                end
            end
        end
        scrollBox:SetScrollPercentage(scrollPercent or 1)
    end

    local function selectionTreeUpdate()
        scrollView:UpdateTree(gemUtil:GetFilteredGems(dropDown.selection, search:GetText() or ""))
    end

    function dropDown:SetValue(selIndex)
        dropDown:UpdateSelection(selIndex)
        selectionTreeUpdate()
    end

    search:HookScript("OnTextChanged", selectionTreeUpdate)

    gems:SetScript("OnEvent", function(_, event)
        if event == "BAG_UPDATE_DELAYED" then
            selectionTreeUpdate()
        end
    end)

    selectionTreeUpdate()
    settings:CreateSettingCallback("show_frame", function(_, newState)
        if newState then
            gems:Show()
        else
            gems:Hide()
        end
    end)
    settings:CreateSettingCallback("show_unowned", function(_, newState)
        selectionTreeUpdate()
        showUnowned:SetChecked(newState)
    end)
    settings:CreateSettingCallback("show_primordial", function(_, newState)
        selectionTreeUpdate()
        showPrimordial:SetChecked(newState)
    end)
end)
