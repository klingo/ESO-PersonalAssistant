-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAMailMenuDefaults = {
    hirelingAutoMailEnabled = false,
    hirelingDeleteEmptyMails = false,

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAMail = PAMailMenuDefaults