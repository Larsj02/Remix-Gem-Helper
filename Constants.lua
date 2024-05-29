local ADDON_NAME = ...
---@cast ADDON_NAME string

---@class RemixGemHelperPrivate
local Private = select(2, ...)

local constants = {}

Private.constants = constants

constants.ADDON_NAME = ADDON_NAME
constants.LOCALE = GetLocale()
constants.ADDON_VERSION = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
constants.EXTRACT_GEM_SPELL = GetSpellInfo(433397)
constants.SOCKET_TYPES_INDEX = {
    "META",
    "COGWHEEL",
    "TINKER",
    "PRISMATIC",
    "PRIMORDIAL",
    [0] = "ALL"
}
constants.GEM_SOCKET_TYPE = {
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
    --[211109] = "PRISMATIC",  -- Chipped Sustaining Emerald
    --[216642] = "PRISMATIC",  -- Flawed Sustaining Emerald
    --[211125] = "PRISMATIC",  -- Sustaining Emerald
    --[211105] = "PRISMATIC",  -- Perfect Sustaining Emerald
    [210717] = "PRISMATIC",  -- Chipped Hungering Ruby
    [216641] = "PRISMATIC",  -- Flawed Hungering Ruby
    [210718] = "PRISMATIC",  -- Hungering Ruby
    [211103] = "PRISMATIC",  -- Perfect Hungering Ruby
    [210716] = "PRISMATIC",  -- Chipped Swift Opal
    [216639] = "PRISMATIC",  -- Flawed Swift Opal
    [211124] = "PRISMATIC",  -- Swift Opal
    [211101] = "PRISMATIC",  -- Perfect Swift Opal

    [204019] = "PRIMORDIAL", -- Harmonic Music Stone
    [204018] = "PRIMORDIAL", -- Humming Arcane Stone
    [204025] = "PRIMORDIAL", -- Obscure Pastel Stone
    [204014] = "PRIMORDIAL", -- Sparkling Mana Stone
    [204009] = "PRIMORDIAL", -- Gleaming Iron Stone
    [204006] = "PRIMORDIAL", -- Indomitable Earth Stone
    [204007] = "PRIMORDIAL", -- Shining Obsidian Stone
    [204005] = "PRIMORDIAL", -- Entropic Fel Stone
    [204002] = "PRIMORDIAL", -- Flame Licked Stone
    [204003] = "PRIMORDIAL", -- Raging Magma Stone
    [204004] = "PRIMORDIAL", -- Searing Smokey Stone
    [204012] = "PRIMORDIAL", -- Cold Frost Stone
    [204010] = "PRIMORDIAL", -- Deluging Water Stone
    [204013] = "PRIMORDIAL", -- Exuding Steam Stone
    [204011] = "PRIMORDIAL", -- Freezing Ice Stone
    [204001] = "PRIMORDIAL", -- Echoing Thunder Stone
    [204022] = "PRIMORDIAL", -- Pestilent Plague Stone
    [204000] = "PRIMORDIAL", -- Storm-Infused Stone
    [204020] = "PRIMORDIAL", -- Wild Spirit Stone
    [204030] = "PRIMORDIAL", -- Wind Sculpted Stone
    [204027] = "PRIMORDIAL", -- Desirous Blood Stone
    [204021] = "PRIMORDIAL", -- Necromantic Death Stone
    [204029] = "PRIMORDIAL", -- Prophetic Twilight Stone
    [204015] = "PRIMORDIAL", -- Swirling Mojo Stone

}
constants.SOCKET_EQUIPMENT_SLOTS = {
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
constants.SOCKET_EQUIPMENT_SLOTS_FRAMES = {
    [INVSLOT_HEAD] = "CharacterHeadSlot",
    [INVSLOT_NECK] = "CharacterNeckSlot",
    [INVSLOT_SHOULDER] = "CharacterShoulderSlot",
    [INVSLOT_CHEST] = "CharacterChestSlot",
    [INVSLOT_WAIST] = "CharacterWaistSlot",
    [INVSLOT_LEGS] = "CharacterLegsSlot",
    [INVSLOT_FEET] = "CharacterFeetSlot",
    [INVSLOT_WRIST] = "CharacterWristSlot",
    [INVSLOT_HAND] = "CharacterHandsSlot",
    [INVSLOT_FINGER1] = "CharacterFinger0Slot",
    [INVSLOT_FINGER2] = "CharacterFinger1Slot",
    [INVSLOT_TRINKET1] = "CharacterTrinket0Slot",
    [INVSLOT_TRINKET2] = "CharacterTrinket1Slot",
}
-- https://github.com/Gethe/wow-ui-source/blob/55a42b7a1dc672ebb8e6f19eea3b1d377afe53b9/Interface/AddOns/Blizzard_ItemSocketingUI/Blizzard_ItemSocketingUI.lua#L7
constants.SOCKET_TYPE_INFO = {
    META = {
        icon = 630620,
        name = "Meta",
        color = CreateColor(1, 1, 1)
    },
    COGWHEEL = {
        icon = 134063,
        name = "Cogwheel",
        color = CreateColor(1, 1, 1)
    },
    TINKER = {
        icon = 133871,
        name = "Tinker",
        color = CreateColor(1, .47, .67)
    },
    PRISMATIC = {
        icon = 133259,
        name = "Prismatic",
        color = CreateColor(1, 1, 1)
    },
    PRIMORDIAL = {
        icon = 4638590,
        name = "Primordial",
        color = CreateColor(1, 1, 1)
    }
}
constants.CLOAK_BUFF = {
    AURA_ID = 440393,
    ITEM_ID = 210333,
    ACHIEVEMENT_ID_START = 20527,
    ACHIEVEMENT_ID_END = 20538,
}
constants.USABLE_BAG_ITEMS = {
    -- Prismatic Gems for Combining
    [210715] = "GEM", -- Chipped Masterful Amethyst
    [216640] = "GEM", -- Flawed Masterful Amethyst
    [211106] = "GEM", -- Masterful Amethyst
    [211108] = "GEM", -- Perfect Masterful Amethyst
    [210714] = "GEM", -- Chipped Deadly Sapphire
    [216644] = "GEM", -- Flawed Deadly Sapphire
    [211123] = "GEM", -- Deadly Sapphire
    [211102] = "GEM", -- Perfect Deadly Sapphire
    [210681] = "GEM", -- Chipped Quick Topaz
    [216643] = "GEM", -- Flawed Quick Topaz
    [211107] = "GEM", -- Quick Topaz
    [211110] = "GEM", -- Perfect Quick Topaz
    [220371] = "GEM", -- Chipped Versatile Diamond
    [220372] = "GEM", -- Flawed Versatile Diamond
    [220374] = "GEM", -- Versatile Diamond
    [220373] = "GEM", -- Perfect Versatile Diamond
    [220367] = "GEM", -- Chipped Stalwart Pearl
    [220368] = "GEM", -- Flawed Stalwart Pearl
    [220370] = "GEM", -- Stalwart Pearl
    [220369] = "GEM", -- Perfect Stalwart Pearl
    [210717] = "GEM", -- Chipped Hungering Ruby
    [216641] = "GEM", -- Flawed Hungering Ruby
    [210718] = "GEM", -- Hungering Ruby
    [211103] = "GEM", -- Perfect Hungering Ruby
    [210716] = "GEM", -- Chipped Swift Opal
    [216639] = "GEM", -- Flawed Swift Opal
    [211124] = "GEM", -- Swift Opal
    [211101] = "GEM", -- Perfect Swift Opal

    -- Random Gem Items
    [223907] = "RANDOM_GEM", -- Asynchronized Prismatic Gem
    [223906] = "RANDOM_GEM", -- Asynchronized Tinker Gem
    [223904] = "RANDOM_GEM", -- Asynchronized Cogwheel Gem
    [223905] = "RANDOM_GEM", -- Asynchronized Meta Gem

    -- Threads
    [226144] = "THREAD", -- Lesser Spool of Eternal Thread
    [226145] = "THREAD", -- Minor Spool of Eternal Thread
    [226143] = "THREAD", -- Spool of Eternal Thread
    [226142] = "THREAD", -- Greater Spool of Eternal Thread
    [217722] = "THREAD", -- Thread of Experience
    [210990] = "THREAD", -- Thread of Versatility
    [210989] = "THREAD", -- Thread of Mastery
    [210987] = "THREAD", -- Thread of Leech
    [210986] = "THREAD", -- Thread of Speed
    [210985] = "THREAD", -- Thread of Haste
    [210984] = "THREAD", -- Thread of Critical Strike
    [210983] = "THREAD", -- Thread of Stamina
    [210982] = "THREAD", -- Thread of Power
    [219262] = "THREAD", -- Temporal Thread of Mastery
    [219258] = "THREAD", -- Temporal Thread of Critical Strike
    [219261] = "THREAD", -- Temporal Thread of Leech
    [219260] = "THREAD", -- Temporal Thread of Speed
    [219263] = "THREAD", -- Temporal Thread of Versatility
    [219259] = "THREAD", -- Temporal Thread of Haste
    [219256] = "THREAD", -- Temporal Thread of Power
    [219257] = "THREAD", -- Temporal Thread of Stamina
    [219264] = "THREAD", -- Temporal Thread of Experience
    [219270] = "THREAD", -- Perpetual Thread of Leech
    [219272] = "THREAD", -- Perpetual Thread of Versatility
    [219267] = "THREAD", -- Perpetual Thread of Critical Strike
    [219268] = "THREAD", -- Perpetual Thread of Haste
    [219269] = "THREAD", -- Perpetual Thread of Speed
    [219265] = "THREAD", -- Perpetual Thread of Power
    [219271] = "THREAD", -- Perpetual Thread of Mastery
    [219266] = "THREAD", -- Perpetual Thread of Stamina
    [219273] = "THREAD", -- Perpetual Thread of Experience
    [219279] = "THREAD", -- Infinite Thread of Leech
    [219278] = "THREAD", -- Infinite Thread of Speed
    [219276] = "THREAD", -- Infinite Thread of Critical Strike
    [219277] = "THREAD", -- Infinite Thread of Haste
    [219281] = "THREAD", -- Infinite Thread of Versatility
    [219282] = "THREAD", -- Infinite Thread of Experience
    [219280] = "THREAD", -- Infinite Thread of Mastery
    [219274] = "THREAD", -- Infinite Thread of Power
    [219275] = "THREAD", -- Infinite Thread of Stamina

    -- Cache
    [211279] = "CACHE", -- Cache of Infinite Treasure
    [211932] = "CACHE", -- Cache of Infinite Treasure
    [223908] = "CACHE", -- Minor Bronze Cache
    [223909] = "CACHE", -- Lesser Bronze Cache
    [223910] = "CACHE", -- Bronze Cache
    [223911] = "CACHE", -- Greater Bronze Cache
}
constants.ITEM_UPGRADES = {
    [INVSLOT_HEAD] = {
        { ItemLevel = 31,  LevelRequired = 18,  Rank = 1 },
        { ItemLevel = 49,  LevelRequired = 23,  Rank = 2 },
        { ItemLevel = 63,  LevelRequired = 28,  Rank = 3 },
        { ItemLevel = 78,  LevelRequired = 33,  Rank = 4 },
        { ItemLevel = 94,  LevelRequired = 38,  Rank = 5 },
        { ItemLevel = 110, LevelRequired = 43,  Rank = 6 },
        { ItemLevel = 128, LevelRequired = 48,  Rank = 7 },
        { ItemLevel = 147, LevelRequired = 53,  Rank = 8 },
        { ItemLevel = 166, LevelRequired = 58,  Rank = 9 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 10 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 11 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 12 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 13 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 14 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 15 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 16 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 17 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 18 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 19 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 20 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 21 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 22 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 23 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 24 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 25 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 26 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 27 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 28 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 29 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 30 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 31 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 32 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 33 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 34 },
    },
    [INVSLOT_SHOULDER] = {
        { ItemLevel = 34,  LevelRequired = 18,  Rank = 1 },
        { ItemLevel = 49,  LevelRequired = 23,  Rank = 2 },
        { ItemLevel = 63,  LevelRequired = 28,  Rank = 3 },
        { ItemLevel = 78,  LevelRequired = 33,  Rank = 4 },
        { ItemLevel = 94,  LevelRequired = 38,  Rank = 5 },
        { ItemLevel = 110, LevelRequired = 43,  Rank = 6 },
        { ItemLevel = 128, LevelRequired = 48,  Rank = 7 },
        { ItemLevel = 147, LevelRequired = 53,  Rank = 8 },
        { ItemLevel = 166, LevelRequired = 58,  Rank = 9 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 10 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 11 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 12 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 13 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 14 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 15 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 16 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 17 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 18 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 19 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 20 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 21 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 22 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 23 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 24 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 25 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 26 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 27 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 28 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 29 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 30 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 31 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 32 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 33 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 34 },
    },
    [INVSLOT_CHEST] = {
        { ItemLevel = 13,  LevelRequired = 10,  Rank = 1 },
        { ItemLevel = 28,  LevelRequired = 15,  Rank = 2 },
        { ItemLevel = 41,  LevelRequired = 20,  Rank = 3 },
        { ItemLevel = 54,  LevelRequired = 25,  Rank = 4 },
        { ItemLevel = 69,  LevelRequired = 30,  Rank = 5 },
        { ItemLevel = 84,  LevelRequired = 35,  Rank = 6 },
        { ItemLevel = 100, LevelRequired = 40,  Rank = 7 },
        { ItemLevel = 117, LevelRequired = 45,  Rank = 8 },
        { ItemLevel = 135, LevelRequired = 50,  Rank = 9 },
        { ItemLevel = 154, LevelRequired = 55,  Rank = 10 },
        { ItemLevel = 174, LevelRequired = 60,  Rank = 11 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 12 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 13 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 14 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 15 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 16 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 17 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 18 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 19 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 20 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 21 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 22 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 23 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 24 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 25 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 26 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 27 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 28 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 29 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 30 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 31 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 32 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 33 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 34 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 35 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 36 },
    },
    [INVSLOT_WAIST] = {
        { ItemLevel = 36,  LevelRequired = 0,   Rank = 1 },
        { ItemLevel = 52,  LevelRequired = 24,  Rank = 2 },
        { ItemLevel = 66,  LevelRequired = 29,  Rank = 3 },
        { ItemLevel = 81,  LevelRequired = 34,  Rank = 4 },
        { ItemLevel = 97,  LevelRequired = 39,  Rank = 5 },
        { ItemLevel = 114, LevelRequired = 44,  Rank = 6 },
        { ItemLevel = 132, LevelRequired = 49,  Rank = 7 },
        { ItemLevel = 150, LevelRequired = 54,  Rank = 8 },
        { ItemLevel = 170, LevelRequired = 59,  Rank = 9 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 10 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 11 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 12 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 13 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 14 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 15 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 16 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 17 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 18 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 19 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 20 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 21 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 22 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 23 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 24 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 25 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 26 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 27 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 28 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 29 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 30 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 31 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 32 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 33 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 34 },
    },
    [INVSLOT_LEGS] = {
        { ItemLevel = 13,  LevelRequired = 10,  Rank = 1 },
        { ItemLevel = 28,  LevelRequired = 15,  Rank = 2 },
        { ItemLevel = 41,  LevelRequired = 20,  Rank = 3 },
        { ItemLevel = 54,  LevelRequired = 25,  Rank = 4 },
        { ItemLevel = 69,  LevelRequired = 30,  Rank = 5 },
        { ItemLevel = 84,  LevelRequired = 35,  Rank = 6 },
        { ItemLevel = 100, LevelRequired = 40,  Rank = 7 },
        { ItemLevel = 117, LevelRequired = 45,  Rank = 8 },
        { ItemLevel = 135, LevelRequired = 50,  Rank = 9 },
        { ItemLevel = 154, LevelRequired = 55,  Rank = 10 },
        { ItemLevel = 174, LevelRequired = 60,  Rank = 11 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 12 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 13 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 14 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 15 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 16 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 17 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 18 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 19 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 20 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 21 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 22 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 23 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 24 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 25 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 26 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 27 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 28 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 29 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 30 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 31 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 32 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 33 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 34 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 35 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 36 },
    },
    [INVSLOT_FEET] = {
        { ItemLevel = 26,  LevelRequired = 17,  Rank = 1 },
        { ItemLevel = 46,  LevelRequired = 22,  Rank = 2 },
        { ItemLevel = 60,  LevelRequired = 27,  Rank = 3 },
        { ItemLevel = 75,  LevelRequired = 32,  Rank = 4 },
        { ItemLevel = 90,  LevelRequired = 37,  Rank = 5 },
        { ItemLevel = 107, LevelRequired = 42,  Rank = 6 },
        { ItemLevel = 124, LevelRequired = 47,  Rank = 7 },
        { ItemLevel = 143, LevelRequired = 52,  Rank = 8 },
        { ItemLevel = 162, LevelRequired = 57,  Rank = 9 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 10 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 11 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 12 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 13 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 14 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 15 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 16 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 17 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 18 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 19 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 20 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 21 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 22 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 23 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 24 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 25 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 26 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 27 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 28 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 29 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 30 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 31 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 32 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 33 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 34 },
    },
    [INVSLOT_WRIST] = {
        { ItemLevel = 20,  LevelRequired = 16,  Rank = 1 },
        { ItemLevel = 44,  LevelRequired = 21,  Rank = 2 },
        { ItemLevel = 57,  LevelRequired = 26,  Rank = 3 },
        { ItemLevel = 72,  LevelRequired = 31,  Rank = 4 },
        { ItemLevel = 87,  LevelRequired = 36,  Rank = 5 },
        { ItemLevel = 104, LevelRequired = 41,  Rank = 6 },
        { ItemLevel = 121, LevelRequired = 46,  Rank = 7 },
        { ItemLevel = 139, LevelRequired = 51,  Rank = 8 },
        { ItemLevel = 158, LevelRequired = 56,  Rank = 9 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 10 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 11 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 12 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 13 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 14 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 15 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 16 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 17 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 18 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 19 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 20 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 21 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 22 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 23 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 24 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 25 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 26 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 27 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 28 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 29 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 30 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 31 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 32 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 33 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 34 },
    },
    [INVSLOT_HAND] = {
        { ItemLevel = 23,  LevelRequired = 17,  Rank = 1 },
        { ItemLevel = 46,  LevelRequired = 22,  Rank = 2 },
        { ItemLevel = 60,  LevelRequired = 27,  Rank = 3 },
        { ItemLevel = 75,  LevelRequired = 32,  Rank = 4 },
        { ItemLevel = 90,  LevelRequired = 37,  Rank = 5 },
        { ItemLevel = 107, LevelRequired = 42,  Rank = 6 },
        { ItemLevel = 124, LevelRequired = 47,  Rank = 7 },
        { ItemLevel = 143, LevelRequired = 52,  Rank = 8 },
        { ItemLevel = 162, LevelRequired = 57,  Rank = 9 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 10 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 11 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 12 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 13 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 14 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 15 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 16 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 17 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 18 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 19 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 20 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 21 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 22 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 23 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 24 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 25 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 26 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 27 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 28 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 29 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 30 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 31 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 32 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 33 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 34 },
    },
    [INVSLOT_MAINHAND] = {
        { ItemLevel = 13,  LevelRequired = 10,  Rank = 1 },
        { ItemLevel = 28,  LevelRequired = 15,  Rank = 2 },
        { ItemLevel = 41,  LevelRequired = 20,  Rank = 3 },
        { ItemLevel = 54,  LevelRequired = 25,  Rank = 4 },
        { ItemLevel = 69,  LevelRequired = 30,  Rank = 5 },
        { ItemLevel = 84,  LevelRequired = 35,  Rank = 6 },
        { ItemLevel = 100, LevelRequired = 40,  Rank = 7 },
        { ItemLevel = 117, LevelRequired = 45,  Rank = 8 },
        { ItemLevel = 135, LevelRequired = 50,  Rank = 9 },
        { ItemLevel = 154, LevelRequired = 55,  Rank = 10 },
        { ItemLevel = 174, LevelRequired = 60,  Rank = 11 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 12 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 13 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 14 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 15 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 16 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 17 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 18 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 19 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 20 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 21 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 22 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 23 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 24 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 25 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 26 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 27 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 28 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 29 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 30 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 31 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 32 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 33 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 34 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 35 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 36 },
    },
    [INVSLOT_OFFHAND] = {
        { ItemLevel = 13,  LevelRequired = 10,  Rank = 1 },
        { ItemLevel = 28,  LevelRequired = 15,  Rank = 2 },
        { ItemLevel = 41,  LevelRequired = 20,  Rank = 3 },
        { ItemLevel = 54,  LevelRequired = 25,  Rank = 4 },
        { ItemLevel = 69,  LevelRequired = 30,  Rank = 5 },
        { ItemLevel = 84,  LevelRequired = 35,  Rank = 6 },
        { ItemLevel = 100, LevelRequired = 40,  Rank = 7 },
        { ItemLevel = 117, LevelRequired = 45,  Rank = 8 },
        { ItemLevel = 135, LevelRequired = 50,  Rank = 9 },
        { ItemLevel = 154, LevelRequired = 55,  Rank = 10 },
        { ItemLevel = 174, LevelRequired = 60,  Rank = 11 },
        { ItemLevel = 220, LevelRequired = 61,  Rank = 12 },
        { ItemLevel = 234, LevelRequired = 62,  Rank = 13 },
        { ItemLevel = 248, LevelRequired = 63,  Rank = 14 },
        { ItemLevel = 262, LevelRequired = 64,  Rank = 15 },
        { ItemLevel = 276, LevelRequired = 65,  Rank = 16 },
        { ItemLevel = 290, LevelRequired = 66,  Rank = 17 },
        { ItemLevel = 304, LevelRequired = 67,  Rank = 18 },
        { ItemLevel = 318, LevelRequired = 68,  Rank = 19 },
        { ItemLevel = 332, LevelRequired = 69,  Rank = 20 },
        { ItemLevel = 346, LevelRequired = 70,  Rank = 21 },
        { ItemLevel = 360, LevelRequired = 346, Rank = 22 },
        { ItemLevel = 374, LevelRequired = 360, Rank = 23 },
        { ItemLevel = 388, LevelRequired = 374, Rank = 24 },
        { ItemLevel = 402, LevelRequired = 388, Rank = 25 },
        { ItemLevel = 416, LevelRequired = 402, Rank = 26 },
        { ItemLevel = 430, LevelRequired = 416, Rank = 27 },
        { ItemLevel = 444, LevelRequired = 430, Rank = 28 },
        { ItemLevel = 458, LevelRequired = 444, Rank = 29 },
        { ItemLevel = 472, LevelRequired = 458, Rank = 30 },
        { ItemLevel = 486, LevelRequired = 472, Rank = 31 },
        { ItemLevel = 500, LevelRequired = 486, Rank = 32 },
        { ItemLevel = 514, LevelRequired = 500, Rank = 33 },
        { ItemLevel = 528, LevelRequired = 514, Rank = 34 },
        { ItemLevel = 542, LevelRequired = 528, Rank = 35 },
        { ItemLevel = 556, LevelRequired = 542, Rank = 36 },
    }
}
constants.ITEM_TYPE_INVSLOT = {
    [1] = INVSLOT_HEAD,
    [2] = INVSLOT_NECK,
    [3] = INVSLOT_SHOULDER,
    [4] = INVSLOT_BODY,
    [5] = INVSLOT_CHEST,
    [6] = INVSLOT_WAIST,
    [7] = INVSLOT_LEGS,
    [8] = INVSLOT_FEET,
    [9] = INVSLOT_WRIST,
    [10] = INVSLOT_HAND,
    [11] = INVSLOT_FINGER1,
    [12] = INVSLOT_TRINKET1,
    [13] = INVSLOT_MAINHAND,
    [14] = INVSLOT_OFFHAND,
    [15] = INVSLOT_MAINHAND,
    [16] = INVSLOT_BACK,
    [17] = INVSLOT_MAINHAND,
    [19] = INVSLOT_TABARD,
    [20] = INVSLOT_CHEST,
    [21] = INVSLOT_MAINHAND,
    [22] = INVSLOT_MAINHAND,
    [23] = INVSLOT_OFFHAND,
    [25] = INVSLOT_MAINHAND,
    [26] = INVSLOT_MAINHAND,
}
constants.MERCHANT_RESTRICTIONS = {
    [21] = "RACECLASS",
    [22] = "FACTION",
    [23] = "SKILL",
    [24] = "PVPMEDAL",
    [25] = "REPUTATION",
    [26] = "OWNED",
    [27] = "LEVEL"
}

constants.COLORS = {
    POSITIVE = CreateColorFromHexString("FF2ecc71"),
    NEUTRAL = CreateColorFromHexString("FFf1c40f"),
    NEGATIVE = CreateColorFromHexString("FFe74c3c"),
    WHITE = CreateColorFromHexString("FFecf0f1"),
    GREY = CreateColorFromHexString("FFbdc3c7"),
}
constants.MEDIA = {
    FONTS = {
        DEFAULT = [[\NotoSans-Bold.ttf]],
    },
    TEXTURES = {
        LOGO = [[Interface\Addons\]] .. constants.ADDON_NAME .. [[\Media\Textures\logo.tga]]
    }
}

constants.FONT_OBJECTS = {
    NORMAL = constants.ADDON_NAME .. 'Normal',
    HEADING = constants.ADDON_NAME .. 'Heading'
}

constants.LANG_TO_FONT = {
    ["enUS"] = "Default",
    ["frFR"] = "Default",
    ["deDE"] = "Default",
    ["esES"] = "Default",
    ["esMX"] = "Default",
    ["ruRU"] = "Default",
    ["ptBR"] = "Default",
    ["itIT"] = "Default",
    ["koKR"] = "koKR",
    ["zhCN"] = "zhCN",
    ["zhTW"] = "zhTW",
}


for lang, langInfo in pairs(Private.Locales) do
    if langInfo.isEditing then
        constants.LOCALE = lang
    end
end
for fontName, fontPath in pairs(constants.MEDIA.FONTS) do
    local langPath = constants.LANG_TO_FONT[constants.LOCALE]
    constants.MEDIA.FONTS[fontName] = [[Interface\Addons\]] ..
        constants.ADDON_NAME .. [[\Media\Fonts\]] .. langPath .. fontPath
end

do
    local font = CreateFont(constants.FONT_OBJECTS.NORMAL)
    font:SetFont(constants.MEDIA.FONTS.DEFAULT, 12, "OUTLINE")
    font:SetJustifyH("LEFT")
    font:SetJustifyV("MIDDLE")
    font:SetTextColor(constants.COLORS.WHITE:GetRGBA())
end
do
    local font = CreateFont(constants.FONT_OBJECTS.HEADING)
    font:SetFont(constants.MEDIA.FONTS.DEFAULT, 16, "OUTLINE")
    font:SetJustifyH("LEFT")
    font:SetJustifyV("MIDDLE")
    font:SetTextColor(constants.COLORS.WHITE:GetRGBA())
end
