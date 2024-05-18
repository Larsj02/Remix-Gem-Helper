---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants
local gemUtil = Private.GemUtil
local misc = Private.Misc

local uiElements = {}
Private.UIElements = uiElements
local function extractPreClick(self)
    if not misc:IsAllowedForClick("EXTRACT_PRECLICK") then return end
    if not self.info then return end
    local info = self.info
    if info.locType == "SOCKET" then
        SocketInventoryItem(info.locIndex)
    elseif info.locType == "BAG" then
        local equipSlot, equipSocket = select(3, gemUtil:GetSocketsInfo(info.gemType))
        C_Container.PickupContainerItem(info.locIndex, info.locSlot)
        SocketInventoryItem(equipSlot)
        info.freeSlot = equipSocket
    end
end

local function extractPostClick(self)
    if not misc:IsAllowedForClick("EXTRACT_POSTCLICK") then return end
    if not self.info then return end
    local info = self.info
    if info.locType == "BAG" then
        ClearCursor()
        if not info.freeSlot then
            UIErrorsFrame:AddExternalErrorMessage("You don't have a valid free Slot for this Gem")
            CloseSocketInfo()
            return
        end
        C_Container.PickupContainerItem(info.locIndex, info.locSlot)
        ClickSocketButton(info.freeSlot)
        AcceptSockets()
    end
    CloseSocketInfo()
end
function uiElements:CreateExtractButton(parent)
    ---@class ExtractButton : Button
    ---@field UpdateInfo fun(self:ExtractButton, infoType:"BAG_GEM"|"BAG_SOCKET"|"EQUIP_SOCKET", infoIndex:number, infoSlot:number, infoGemType:"Meta"|"Cogwheel"|"Tinker"|"Prismatic"|"Primordial")
    local extractButton = CreateFrame("Button", nil, parent, "InsecureActionButtonTemplate")
    extractButton:SetAllPoints()
    extractButton:SetScript("PreClick", extractPreClick)
    extractButton:SetScript("PostClick", extractPostClick)
    extractButton:RegisterForClicks("AnyDown", "AnyUp")
    extractButton:SetAttribute("type", "macro")

    function extractButton:UpdateInfo(newType, newIndex, newSlot, newGemType)
        self.info = {
            locType = newType,
            locIndex = newIndex,
            locSlot = newSlot,
            gemType = newGemType,

            gemSlot = 0,
        }
        local txt = ""
        if newType == "SOCKET" then
            txt = "/cast " .. const.EXTRACT_GEM_SPELL
            if newSlot == "Primordial" then
                txt = "/click ExtraActionButton1"
            end
            txt = string.format("%s\n/click ItemSocketingSocket%s", txt, newSlot)
        end
        self:SetAttribute("macrotext", txt)
    end

    return extractButton
end

function uiElements:CreateCheckButton(parent, data)
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
