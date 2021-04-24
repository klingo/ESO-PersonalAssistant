-- Local instances of Global tables --
local PA = PersonalAssistant
local PAMF = PA.MenuFunctions

-- =====================================================================================================================

local function getValue(...)
    return PAMF.getValue(PA.SavedVars.Profile.General, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PA.SavedVars.Profile.General, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PA.SavedVars.Profile.General, ...)
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