-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAJunkMenuDefaults = {
    name = table.concat({GetString(SI_PA_PROFILE), " ", 1}),

    -- ---------------------------------------------
    autoMarkAsJunkEnabled = false,

    Trash = {
        autoMarkTrash = true,
    },
    Collectibles = {
        autoMarkSellToMerchant = true,
    },
    Miscellaneous = {
        autoMarkGlyphQualityThreshold = -1,
        autoMarkTreasure = false,
    },
    Weapons = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkKnownTraits = true,
        autoMarkUnknownTraits = false,
    },
    Armor = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkKnownTraits = true,
        autoMarkUnknownTraits = false,
    },
    Jewelry = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkKnownTraits = true,
        autoMarkUnknownTraits = false,
    },
    Stolen = {
        trash = false,
        weapons = false,
        apparels = false,
        jewelries = false,
        styleMaterials = false,
        traitItems = false,
        lures = false,
        ingredients = false,
        food = false,
        drinks = false,
        solvents = false,
        treasures = false,
    },
    Custom = {
        customItemsEnabled = true,
        PAItemIds = {
        }
    },
    AutoDestroy = {
        destroyJunk = false,
        destroyMaxValueThreshold = 0,
        destroyMaxQualityThreshold = ITEM_FUNCTIONAL_QUALITY_TRASH,

        destroyStolenJunk = false,
        destroyMaxStolenValueThreshold = 0,
        destroyMaxStolenQualityThreshold = ITEM_FUNCTIONAL_QUALITY_TRASH,
    },
    QuestProtection = {
        ClockworkCity = {
            excludeNibblesAndBits = false,
            excludeMorselsAndPecks = false,
            excludeAMatterOfLeisure = false,
            excludeAMatterOfRespect = false,
            excludeAMatterOfTributes = false,
        },
        ThievesGuild = {
            excludeTheCovetousCountess = false,
        },
        NewLifeFestival = {
            excludeRareFish = true,
        }
    },

    ignoreMailboxItems = true,
    ignoreCraftedItems = true,
    autoSellJunk = true,
    autoSellJunkPirharri = false,

    KeyBindings = {
        enableMarkUnmarkAsJunkKeybind = true,
        showMarkUnmarkAsJunkKeybind = true,
        enableMarkUnmarkAsPermJunkKeybind = true,
        showMarkUnmarkAsPermJunkKeybind = true,
        enableDestroyItemKeybind = false,
        showDestroyItemKeybind = true,
        destroyItemQualityThreshold = ITEM_FUNCTIONAL_QUALITY_LEGENDARY,
        destroyExcludeUnknownItems = false,
    },

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAJunk = PAJunkMenuDefaults