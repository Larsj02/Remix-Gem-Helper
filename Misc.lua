---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants

local misc = {
    clickThrottles = {}
}
Private.Misc = misc

---@param percent number
---@return ColorMixin
function misc:GetPercentColor(percent)
    if percent == 100 then
        return const.COLORS.POSITIVE
    end
    if percent >= 50 then
        return const.COLORS.NEUTRAL
    end
    return const.COLORS.NEGATIVE
end

---@param clickType any
---@return boolean
function misc:IsAllowedForClick(clickType)
    local currentTime = GetTime()
    if not self.clickThrottles[clickType] then
        self.clickThrottles[clickType] = currentTime
        return true
    end
    if self.clickThrottles[clickType] + .5 < currentTime then
        self.clickThrottles[clickType] = currentTime
        return true
    end
    if self.clickThrottles[clickType] + .25 < currentTime then
        UIErrorsFrame:AddExternalErrorMessage("You're clicking too fast")
    end
    return false
end
