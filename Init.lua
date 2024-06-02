---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants

local timeFormatter = CreateFromMixins(SecondsFormatterMixin)
timeFormatter:Init(1, 3, true, true)


local defaultDatabase = {
    show_unowned = false,
    show_primordial = false,
    show_frame = true,
    show_helpframe = true
}

local addon = LibStub("RasuAddon"):CreateAddon(
    const.ADDON_NAME,
    "RemixGemHelperDB",
    defaultDatabase,
    Private.Locales
)

Private.TimeFormatter = timeFormatter
Private.Addon = addon
