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
        activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID,
    },
    Integration = {
        activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID,
    },
    Junk = {
        activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID,
    },
    Loot = {
        activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID,
    },
    Repair = {
        activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID,
    },

    -- ----------------------------------
    debug = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAGeneral = PAGeneralMenuDefaults