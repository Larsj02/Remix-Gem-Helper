---@class RemixGemHelperPrivate
local Private = select(2, ...)
local const = Private.constants

local misc = {}
Private.Misc = misc

function misc:getPercentColor(percent)
    if percent == 100 then
        return const.COLORS.POSITIVE
    end
    if percent >= 50 then
        return const.COLORS.NEUTRAL
    end
    return const.COLORS.NEGATIVE
end

function misc:MuteSounds() -- This doesn't seem to work on PlaySound() rn
    MuteSoundFile(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
    MuteSoundFile(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
    MuteSoundFile(SOUNDKIT.MAP_PING)
end

function misc:UnmuteSounds()
    UnmuteSoundFile(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
    UnmuteSoundFile(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
    UnmuteSoundFile(SOUNDKIT.MAP_PING)
end
