-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAMailMenuDefaults = {
    chatOutput = true,

    hirelingAutoMailEnabled = false,
    hirelingDeleteEmptyMails = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAMail = PAMailMenuDefaults