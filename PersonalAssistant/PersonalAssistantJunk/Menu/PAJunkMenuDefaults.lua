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
    Custom = {
        customItemsEnabled = true,
        ItemIds = {
        }
    },

    autoSellJunk = true,

    KeyBindings = {
        enableMarkUnmarkAsJunkKeybind = true,
        showMarkUnmarkAsJunkKeybind = true,
        enableDestroyItemKeybind = false,
        showDestroyItemKeybind = true,
        destroyItemQualityThreshold = ITEM_QUALITY_LEGENDARY,
        destroyExcludeUnknownItems = false,
    },

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAJunk = PAJunkMenuDefaults