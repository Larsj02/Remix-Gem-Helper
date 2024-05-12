---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants


local settings = {
    db = {
        show_unowned = false,
        show_primordial = false,
    },
    callbacks = {}
}
Private.Settings = settings

function settings:GetSetting(settingName)
    return self.db[settingName]
end

function settings:UpdateSetting(settingName, newState)
    self.db[settingName] = newState
    if self.callbacks[settingName] then
        for _, callback in ipairs(self.callbacks[settingName]) do
            callback(settingName, newState)
        end
    end
end

function settings:CreateSettingCallback(settingName, callback)
    if not self.callbacks[settingName] then
        self.callbacks[settingName] = {}
    end
    tinsert(self.callbacks[settingName], callback)
    callback(settingName, self.db[settingName])
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function (self, event, addon)
    if event == "ADDON_LOADED" and addon == const.ADDON_NAME then
        self:UnregisterAllEvents()
        self:SetScript("OnEvent", nil)

        RemixGemHelperDB = RemixGemHelperDB or settings.db
        settings.db = RemixGemHelperDB

        for settingName, state in pairs(settings.db) do
            if settings.callbacks[settingName] then
                for _, callback in ipairs(self.callbacks[settingName]) do
                    callback(settingName, state)
                end
            end
        end
    end
end)