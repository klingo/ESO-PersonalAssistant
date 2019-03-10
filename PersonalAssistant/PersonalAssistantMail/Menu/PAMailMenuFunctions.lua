-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

local PAMailMenuFunctions = {
    isChatOutputDisabled = false, -- always enabled
    getChatOutputSetting = function() return getValue(PASV.Mail, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PASV.Mail, value, {"chatOutput"}) end,

    -- -----------------------------------------------------------------------------------
    -- HIRELINGS
    -- -----------------------------
    getHirelingAutoMailEnabledSetting = function() return getValue(PASV.Mail, {"hirelingAutoMailEnabled"}) end,
    setHirelingAutoMailEnabledSetting = function(value) setValue(PASV.Mail, value, {"hirelingAutoMailEnabled"}) end,

    isHirelingDeleteEmptyMailsDisabled = function() return isDisabled(PASV.Mail, {"hirelingAutoMailEnabled"}) end,
    getHirelingDeleteEmptyMailsSetting = function() return getValue(PASV.Mail, {"hirelingDeleteEmptyMails"}) end,
    setHirelingDeleteEmptyMailsSetting = function(value) setValue(PASV.Mail, value, {"hirelingDeleteEmptyMails"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAMail = PAMailMenuFunctions