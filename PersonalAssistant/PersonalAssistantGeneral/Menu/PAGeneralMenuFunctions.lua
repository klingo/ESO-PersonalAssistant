-- Local instances of Global tables --
local PA = PersonalAssistant
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PAGProfileManager = PA.ProfileManager.PAGeneral

-- ---------------------------------------------------------------------------------------------------------------------

-- TODO: Make sure these are specific to each module!
local function getValue(...)
    if PAGProfileManager.isNoProfileSelected() then return true end
    return PAMF.getValue(PA.General.SavedVars, ...)
end

-- TODO: Make sure these are specific to each module!
local function setValue(value, ...)
    if PAGProfileManager.isNoProfileSelected() then return true end
    PAMF.setValue(PA.General.SavedVars, value, ...)
end

-- TODO: Make sure these are specific to each module!
local function setValueAndRefreshEvents(savedVarsTable, value, attributeTbl)
    setValue(savedVarsTable, value, attributeTbl)
    PAEM.RefreshEventRegistration.PAGeneral()
end

-- TODO: Make sure these are specific to each module!
local function isDisabled(...)
    if PAGProfileManager.isNoProfileSelected() then return true end
    return PAMF.isDisabled(PA.General.SavedVars, ...)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- PAGeneral   teleportToPrimaryHouse
---------------------------------
local function doPAGeneralTeleportToPrimaryHouse()
    local houseId = GetHousingPrimaryHouse()
    if houseId and CanLeaveCurrentLocationViaTeleport() then
        local jumpOutside = getValue({"jumpOutside"})
        RequestJumpToHouse(houseId, jumpOutside)
    end
end

-- =====================================================================================================================
-- Export
PAMF.PAGeneral = {
    getWelcomeMessageSetting = function() return getValue({"welcomeMessage"}) end,
    setWelcomeMessageSetting = function(value) setValue(value, {"welcomeMessage"}) end,

    isTeleportToPrimaryHouseDisabled = function() return not CanLeaveCurrentLocationViaTeleport() end,
    teleportToPrimaryHouse = doPAGeneralTeleportToPrimaryHouse,

    getJumpOutsideSetting = function() return getValue({"jumpOutside"}) end,
    setJumpOutsideSetting = function(value) setValue(value, {"jumpOutside"}) end,
}