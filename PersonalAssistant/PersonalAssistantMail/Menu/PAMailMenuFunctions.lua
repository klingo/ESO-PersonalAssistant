-- Local instances of Global tables --
local PA = PersonalAssistant
local PAM = PA.Mail
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

local PAMailMenuFunctions = {
    -- -----------------------------------------------------------------------------------
    -- HIRELINGS
    -- -----------------------------
    getHirelingAutoMailEnabledSetting = function() return getValue(PAM.SavedVars, {"hirelingAutoMailEnabled"}) end,
    setHirelingAutoMailEnabledSetting = function(value) setValue(PAM.SavedVars, value, {"hirelingAutoMailEnabled"}) end,

    isHirelingDeleteEmptyMailsDisabled = function() return isDisabled(PAM.SavedVars, {"hirelingAutoMailEnabled"}) end,
    getHirelingDeleteEmptyMailsSetting = function() return getValue(PAM.SavedVars, {"hirelingDeleteEmptyMails"}) end,
    setHirelingDeleteEmptyMailsSetting = function(value) setValue(PAM.SavedVars, value, {"hirelingDeleteEmptyMails"}) end,

    -- -----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = false, -- always enabled
    getSilentModeSetting = function() return getValue(PAM.SavedVars, {"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(PAM.SavedVars, value, {"silentMode"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAMail = PAMailMenuFunctions