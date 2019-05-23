-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAJunkMenuDefaults = {
    autoMarkAsJunkEnabled = false,

    Trash = {
        autoMarkTrash = true,
        excludeNibblesAndBits = false,
        excludeMorselsAndPecks = false,
    },
    Collectibles = {
        autoMarkSellToMerchant = true,
    },
    Miscellaneous = {
        autoMarkTreasure = false,
        excludeAMatterOfLeisure = false,
        excludeAMatterOfRespect = false,
        excludeAMatterOfTributes = false,
        autoMarkGlyphQualityThreshold = -1
    },
    Weapons = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkUnknownTraits = false,
    },
    Armor = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkUnknownTraits = false,
    },
    Jewelry = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkUnknownTraits = false,
    },

    autoSellJunk = true,

    KeyBindings = {
        showMarkUnmarkAsJunkKeybind = true,
        showDestroyItemKeybind = false,
        destroyItemQualityThreshold = ITEM_QUALITY_LEGENDARY,
        destroyUnknownItems = false
    },

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAJunk = PAJunkMenuDefaults