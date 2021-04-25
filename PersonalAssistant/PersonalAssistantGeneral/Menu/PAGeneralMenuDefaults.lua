-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local PAGeneralMenuDefaults = {
    General = {
        welcomeMessage = true,
        jumpOutside = false,
    },
    Banking = {
        activeProfile = 1,
    },
    Integration = {
        activeProfile = 1,
    },
    Junk = {
        activeProfile = 1,
    },
    Loot = {
        activeProfile = 1,
    },
    Repair = {
        activeProfile = 1,
    },

    -- ----------------------------------
    debug = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAGeneral = PAGeneralMenuDefaults