-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAGeneralMenuDefaults = {
    name = nil,
    welcomeMessage = true,
    jumpOutside = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAGeneral = PAGeneralMenuDefaults