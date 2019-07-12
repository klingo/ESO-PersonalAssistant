-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PA.SavedVars.Profile.activeProfile
    if activeProfile == nil then
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

local function setPAGeneralActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active prefoile first
        local prevProfile = PASavedVars.Profile.activeProfile
        -- then save the new one
        PASavedVars.Profile.activeProfile = profileNo
        PA.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == nil then
            local PAMenuHelper = PA.MenuHelper
            PAMenuHelper.reloadProfileList()
        end
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshAllSavedVarReferences(profileNo)
        -- and also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
    end
end

local function isDisabledPAGeneralNoProfileSelected()
    return (PA.activeProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getValueV2(savedVarsTable, attributeTbl)
    if isDisabledPAGeneralNoProfileSelected() then return end
    if #attributeTbl > 0 then
        for _, attribute in ipairs(attributeTbl) do
            savedVarsTable = savedVarsTable[attribute]
        end
        return savedVarsTable
    else return end
end

local function setValueV2(savedVarsTable, value, attributeTbl)
    if isDisabledPAGeneralNoProfileSelected() then return end
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

local function setValueAndRefreshEvents(savedVarsTable, value, attributeTbl)
    setValueV2(savedVarsTable, value, attributeTbl)
    PAEM.RefreshAllEventRegistrations()
end

local function isDisabledV2(savedVarsTable, ...)
    if isDisabledPAGeneralNoProfileSelected() then return true end
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
    if isDisabledPAGeneralNoProfileSelected() then return true end
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

-- ---------------------------------------------------------------------------------------------------------------------

local function getValue(...)
    return getValueV2(PA.SavedVars.General[PA.activeProfile], ...)
end

local function setValue(value, ...)
    setValueV2(PA.SavedVars.General[PA.activeProfile], value, ...)
end

local function isDisabled(...)
    return isDisabledV2(PA.SavedVars.General[PA.activeProfile], ...)
end

--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
local function getPAGeneralActiveProfileRename()
    if isDisabledPAGeneralNoProfileSelected() then return end
    return PA.SavedVars.General[PA.activeProfile].name
end

local function setPAGeneralActiveProfileRename(profileName)
    if profileName ~= nil and profileName ~= "" then
        local PAMenuHelper = PA.MenuHelper
        PA.SavedVars.General[PA.activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        PAMenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PAGeneral   welcomeMessage
---------------------------------
local function getPAGeneralWelcomeMessage()
    if isDisabledPAGeneralNoProfileSelected() then return end
    return PA.SavedVars.General[PA.activeProfile].welcome
end

local function setPAGeneralWelcomeMessage(value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    PA.SavedVars.General[PA.activeProfile].welcome = value
end


--------------------------------------------------------------------------
-- PAGeneral   teleportToPrimaryHouse
---------------------------------
local function doPAGeneralTeleportToPrimaryHouse()
    local houseId = GetHousingPrimaryHouse()
    if houseId and CanLeaveCurrentLocationViaTeleport() then
        RequestJumpToHouse(houseId)
    end
end

-- =====================================================================================================================

-- Export
PA.MenuFunctions = {
    PAGeneral = {
        isNoProfileSelected = isDisabledPAGeneralNoProfileSelected,

        getActiveProfile = getPAGeneralActiveProfile,
        setActiveProfile = setPAGeneralActiveProfile,
        getActiveProfileRename = getPAGeneralActiveProfileRename,
        setActiveProfileRename = setPAGeneralActiveProfileRename,

        getWelcomeMessageSetting = getPAGeneralWelcomeMessage,
        setWelcomeMessageSetting = setPAGeneralWelcomeMessage,

        isTeleportToPrimaryHouseDisabled = function() return not CanLeaveCurrentLocationViaTeleport() end,
        teleportToPrimaryHouse = doPAGeneralTeleportToPrimaryHouse,
    },
}

PA.MenuFunctions.isDisabledPAGeneralNoProfileSelected = isDisabledPAGeneralNoProfileSelected
PA.MenuFunctions.isDisabled = isDisabledV2
PA.MenuFunctions.isDisabledAll = isDisabledAllV2
PA.MenuFunctions.getValue = getValueV2
PA.MenuFunctions.setValue = setValueV2
PA.MenuFunctions.setValueAndRefreshEvents = setValueAndRefreshEvents