-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAJunkMenuDefaults = {
    autoMarkAsJunkEnabled = false,

    Trash = {
        autoMarkTrash = true,
    },
    Collectibles = {
        autoMarkSellToMerchant = false,
    },
    Weapons = {
        autoMarkOrnate = true,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkUnknownTraits = false,
    },
    Armor = {
        autoMarkOrnate = true,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkUnknownTraits = false,
    },
    Jewelry = {
        autoMarkOrnate = true,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkUnknownTraits = false,
    },

    autoSellJunk = true,

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAJunk = PAJunkMenuDefaults