-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

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
    Stolen = {
        styleMaterialAction = PAC.ITEM_ACTION.NOTHING,
        ingredientAction = PAC.ITEM_ACTION.NOTHING,
        treasureAction = PAC.ITEM_ACTION.NOTHING,
        excludeAMatterOfLeisure = false,
        excludeAMatterOfRespect = false,
        excludeAMatterOfTributes = false,
    },
    Custom = {
        customItemsEnabled = true,
        ItemIds = {
        }
    },
    AutoDestroy = {
        destroyWorthlessJunk = false
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