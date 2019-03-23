-- Local instances of Global tables --
local PA = PersonalAssistant
local PAM = PA.Mail
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function getValue(...)
    return PAMF.getValue(PAM.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAM.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAM.SavedVars, ...)
end

-- =================================================================================================================

local PAMailMenuFunctions = {
    -- -----------------------------------------------------------------------------------
    -- HIRELINGS
    -- -----------------------------
    getHirelingAutoMailEnabledSetting = function() return getValue({"hirelingAutoMailEnabled"}) end,
    setHirelingAutoMailEnabledSetting = function(value) setValue(value, {"hirelingAutoMailEnabled"}) end,

    isHirelingDeleteEmptyMailsDisabled = function() return isDisabled({"hirelingAutoMailEnabled"}) end,
    getHirelingDeleteEmptyMailsSetting = function() return getValue({"hirelingDeleteEmptyMails"}) end,
    setHirelingDeleteEmptyMailsSetting = function(value) setValue(value, {"hirelingDeleteEmptyMails"}) end,

    -- -----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = false, -- always enabled
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAMail = PAMailMenuFunctions