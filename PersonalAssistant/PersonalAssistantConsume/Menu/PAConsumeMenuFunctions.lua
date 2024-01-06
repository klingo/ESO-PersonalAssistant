-- Local instances of Global tables --
local PA = PersonalAssistant
local PACO = PA.Consume
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PARProfileManager = PA.ProfileManager.PAConsume
local PASavedVars = PA.SavedVars

-- =====================================================================================================================

local isNoProfileSelected = PARProfileManager.isNoProfileSelected

local function getValue(...)
    if isNoProfileSelected() then return end
    return PAMF.getValue(PACO.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return end
    PAMF.setValue(PACO.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    setValue(value, ...)
    PAEM.RefreshEventRegistration.PAConsume()
end

local function isDisabled(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabled(PACO.SavedVars, ...)
end

local function isDisabledAll(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabledAll(PACO.SavedVars, ...)
end

-- =================================================================================================================

local PAConsumeMenuFunctions = {
    -- -----------------------------------------------------------------------------------
    -- Consume poison
    -- -----------------------------
    getAutoConsumePoisonSetting = function() return getValue({"autoConsumePoisonEnabled"}) end,
    setAutoConsumePoisonSetting = function(value) setValueAndRefreshEvents(value, {"autoConsumePoisonEnabled"}) end,
	
	
    -- -----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return isDisabledAll({"autoConsumeEnabled"}, {"autoConsumePoisonEnabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,

}

-- =====================================================================================================================
-- Export
PAMF.PAConsume = PAConsumeMenuFunctions