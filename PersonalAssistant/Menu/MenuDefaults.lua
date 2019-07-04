-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAGeneralMenuDefaults = {
    welcomeMessage = true,

    Integrations = {
        fcoisEnabled = true,
    },
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAGeneral = PAGeneralMenuDefaults