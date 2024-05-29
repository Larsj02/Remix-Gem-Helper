---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants
local widgets = Private.Widgets

---@class BaseFrameSettings
---@field width number?
---@field height number?
---@field points table?
---@field title string?
---@field showPortrait boolean?
---@field frameStyle "Flat"|"Default"|"DefaultBase"|?
---@field isClosable boolean?
---@field frameStrata FrameStrata?

local frameStyles = {
    Flat = "PortraitFrameFlatTemplate",
    Default = "ButtonFrameTemplate",
    DefaultBase = "ButtonFrameBaseTemplate"
}

---@param parent Frame
---@param data BaseFrameSettings
function widgets:CreateBaseFrame(parent, data)
    local template = frameStyles[data.frameStyle or "Default"]
    ---@class BaseFrame : Frame
    ---@field CloseButton Button
    ---@field SetTitle fun(self:BaseFrame, title:string)
    ---@field Inset Frame?
    ---@field TopTileStreaks Frame
    local frame = CreateFrame("Frame", nil, parent, template)
    frame:SetTitle(data.title)
    frame:SetSize(data.width or 100, data.height or 100)
    if data.points then
        for _, point in ipairs(data.points) do
            frame:SetPoint(unpack(point))
        end
    end
    if data.frameStrata then
        frame:SetFrameStrata(data.frameStrata)
    end
    if not data.showPortrait then
        ButtonFrameTemplate_HidePortrait(frame)
    end
    if not data.isClosable then
        frame.CloseButton:Hide()
    end
    if frame.Inset then
        frame.Inset:ClearAllPoints()
        frame.Inset:SetPoint("TOP", 0, -65)
        frame.Inset:SetPoint("BOTTOM", 0, 35)
        frame.Inset:SetPoint("LEFT", 20, 0)
        frame.Inset:SetPoint("RIGHT", -20, 0)
    end

    return frame
end