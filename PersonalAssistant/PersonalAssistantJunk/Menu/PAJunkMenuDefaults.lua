-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local PAJunkMenuDefaults = {
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
        Weapons = {
            action = PAC.ITEM_ACTION.NOTHING,
        },
        Armor = {
            action = PAC.ITEM_ACTION.NOTHING,
        },
        Jewelry = {
            action = PAC.ITEM_ACTION.NOTHING,
        },
        styleMaterialAction = PAC.ITEM_ACTION.NOTHING,
        traitItemAction = PAC.ITEM_ACTION.NOTHING,
        lureAction = PAC.ITEM_ACTION.NOTHING,
        ingredientAction = PAC.ITEM_ACTION.NOTHING,
        foodAction = PAC.ITEM_ACTION.NOTHING,
        drinkAction = PAC.ITEM_ACTION.NOTHING,
        treasureAction = PAC.ITEM_ACTION.NOTHING,
    },
    Custom = {
        customItemsEnabled = true,
        PAItemIds = {
        }
    },
    AutoDestroy = {
        destroyWorthlessJunk = false
    },
    QuestProtection = {
        ClockworkCity = {
            excludeNibblesAndBits = false,
            excludeMorselsAndPecks = false,
            excludeAMatterOfLeisure = false,
            excludeAMatterOfRespect = false,
            excludeAMatterOfTributes = false,
        },
        NewLifeFestival = {
            excludeRareFish = true,
        }
    },

    ignoreMailboxItems = true,
    autoSellJunk = true,

    KeyBindings = {
        enableMarkUnmarkAsJunkKeybind = true,
        showMarkUnmarkAsJunkKeybind = true,
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