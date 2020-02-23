-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- --------------------------------------------------------------------------------------------------------

local function getProfileList()
    local PASavedVars = PA.SavedVars

    local profiles = {}
    for profileNo = 1, PASavedVars.General.profileCounter do
        if istable(PASavedVars.General[profileNo]) then
            table.insert(profiles, PASavedVars.General[profileNo].name)
        end
    end

    if PASavedVars.Profile.activeProfile == nil then
        profiles[PAC.GENERAL.NO_PROFILE_SELECTED_ID] = GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)
    end

    return profiles
end

local function getProfileListValues()
    local PASavedVars = PA.SavedVars

    local profileValues = {}
    for profileNo = 1, PASavedVars.General.profileCounter do
        if istable(PASavedVars.General[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end

    if PASavedVars.Profile.activeProfile == nil then
        profileValues[PAC.GENERAL.NO_PROFILE_SELECTED_ID] = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end

    return profileValues
end

local function getInactiveProfileList()
    local PASavedVars = PA.SavedVars

    local profiles = {}
    for profileNo = 1, PASavedVars.General.profileCounter do
        if istable(PASavedVars.General[profileNo]) and profileNo ~= PASavedVars.Profile.activeProfile then
            table.insert(profiles, PASavedVars.General[profileNo].name)
        end
    end

    return profiles
end

local function getInactiveProfileListValues()
    local PASavedVars = PA.SavedVars

    local profileValues = {}
    for profileNo = 1, PASavedVars.General.profileCounter do
        if istable(PASavedVars.General[profileNo]) and profileNo ~= PASavedVars.Profile.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end

    return profileValues
end

local function reloadProfileList()
    local profiles = getProfileList()
    local profileValues = getProfileListValues()
    PERSONALASSISTANT_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_PROFILEDROPDOWN:UpdateValue()
end

local function reloadInactiveProfileList()
    local inactiveProfiles = getInactiveProfileList()
    local inactiveProfileValues = getInactiveProfileListValues()
    PERSONALASSISTANT_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_PROFILEDROPDOWN_DELETE:UpdateValue()
end

local function getTextIfRequiredAddonNotRunning(textKeyIfNotRunning, addonTableToCheck)
    if istable(addonTableToCheck) then return nil end
    return GetString(textKeyIfNotRunning)
end

-- --------------------------------------------------------------------------------------------------------

-- Export
PA.MenuHelper = {
    getProfileList = getProfileList,
    getProfileListValues = getProfileListValues,
    getInactiveProfileList = getInactiveProfileList,
    getInactiveProfileListValues = getInactiveProfileListValues,
    reloadProfileList = reloadProfileList,
    reloadInactiveProfileList = reloadInactiveProfileList,
    getTextIfRequiredAddonNotRunning = getTextIfRequiredAddonNotRunning,
}
