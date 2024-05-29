---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants
local widgets = Private.Widgets

---@class ButtonFrameSettings
---@field width number?
---@field height number?
---@field points table?
---@field text string?

---@param parent Frame
---@param data ButtonFrameSettings
function widgets:CreateButton(parent, data)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetText(data.text)
    button:SetSize(data.width or 100, data.height or 100)
    if data.points then
        for _, point in ipairs(data.points) do
            button:SetPoint(unpack(point))
        end
    end
    return button
end