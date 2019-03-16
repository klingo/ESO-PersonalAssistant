-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAJunkMenuDefaults = {
    autoMarkAsJunkEnabled = false,
    chatOutput = true,

    Trash = {
        autoMarkTrash = true,
    },
    Collectibles = {
        autoMarkSellToMerchant = false,
    },
    Weapons = {
        autoMarkOrnate = true,
        autoMarkQuality = false,
        autoMarkQualityThreshold = 0,
        autoMarkIncludingSets = false,
        autoMarkUnknownTraits = false,
    },
    Armor = {
        autoMarkOrnate = true,
        autoMarkQuality = false,
        autoMarkQualityThreshold = 0,
        autoMarkIncludingSets = false,
        autoMarkUnknownTraits = false,
    },
    Jewelry = {
        autoMarkOrnate = true,
        autoMarkQuality = false,
        autoMarkQualityThreshold = 0,
        autoMarkIncludingSets = false,
        autoMarkUnknownTraits = false,
    },

    autoSellJunk = true,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAJunk = PAJunkMenuDefaults