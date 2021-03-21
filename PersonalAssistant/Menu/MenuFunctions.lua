-- Local instances of Global tables --
local PA = PersonalAssistant
local PAEM = PA.EventManager
local PAGProfileManager = PA.ProfileManager.PAGeneral

-- ---------------------------------------------------------------------------------------------------------------------

local function getValueV2(savedVarsTable, attributeTbl)
    if #attributeTbl > 0 then
        for _, attribute in ipairs(attributeTbl) do
            savedVarsTable = savedVarsTable[attribute]
        end
        return savedVarsTable
    else return end
end

local function setValueV2(savedVarsTable, value, attributeTbl)
    if #attributeTbl > 0 then
        for index, attribute in ipairs(attributeTbl) do
            if index < #attributeTbl then
                savedVarsTable = savedVarsTable[attribute]
            else
                savedVarsTable[attribute] = value
            end
        end
    else return end
end


local function isDisabledV2(savedVarsTable, ...)
    local args = { ... }
    for _, attributeTbl in ipairs(args) do
        -- return true when ANY setting is OFF
        local localSavedVarsTable = savedVarsTable
        if #attributeTbl > 0 then
            for _, attribute in ipairs(attributeTbl) do
                localSavedVarsTable = localSavedVarsTable[attribute]
            end
            if not localSavedVarsTable then return true end
        end
    end
    -- return false when ALL settings are ON (or no settings provided)
    return false
end

local function isDisabledAllV2(savedVarsTable, ...)
    local args = { ... }
    for _, attributeTbl in ipairs(args) do
        -- return false when ANY setting is ON
        local localSavedVarsTable = savedVarsTable
        if #attributeTbl > 0 then
            for _, attribute in ipairs(attributeTbl) do
                localSavedVarsTable = localSavedVarsTable[attribute]
            end
            if localSavedVarsTable then return false end
        end
    end
    -- return true when ALL settings are OFF (or no settings provided)
    return true
end

-- TODO: Make sure these are specific to each module!
local function getValue(...)
    if PAGProfileManager.isNoProfileSelected() then return true end
    return getValueV2(PA.General.SavedVars, ...)
end

-- TODO: Make sure these are specific to each module!
local function setValueAndRefreshEvents(savedVarsTable, value, attributeTbl)
    setValueV2(savedVarsTable, value, attributeTbl)
    PAEM.RefreshEventRegistration.PAGeneral()
end

-- TODO: Make sure these are specific to each module!
local function setValue(value, ...)
    if PAGProfileManager.isNoProfileSelected() then return true end
    setValueV2(PA.General.SavedVars, value, ...)
end

-- TODO: Make sure these are specific to each module!
local function isDisabled(...)
    if PAGProfileManager.isNoProfileSelected() then return true end
    return isDisabledV2(PA.General.SavedVars, ...)
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
PA.MenuFunctions = {
    PAGeneral = {
        getWelcomeMessageSetting = function() return getValue({"welcomeMessage"}) end,
        setWelcomeMessageSetting = function(value) setValue(value, {"welcomeMessage"}) end,

        isTeleportToPrimaryHouseDisabled = function() return not CanLeaveCurrentLocationViaTeleport() end,
        teleportToPrimaryHouse = doPAGeneralTeleportToPrimaryHouse,

        getJumpOutsideSetting = function() return getValue({"jumpOutside"}) end,
        setJumpOutsideSetting = function(value) setValue(value, {"jumpOutside"}) end,
    },
}

PA.MenuFunctions.isDisabled = isDisabledV2
PA.MenuFunctions.isDisabledAll = isDisabledAllV2
PA.MenuFunctions.getValue = getValueV2
PA.MenuFunctions.setValue = setValueV2
PA.MenuFunctions.setValueAndRefreshEvents = setValueAndRefreshEvents