-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPAIntegrationNoCopyProfileSelected()
    return (PA.Integration.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPAIntegrationNoDeleteProfileSelected()
    return (PA.Integration.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPAIntegrationProfileNo()
    local profileCounter = PA.SavedVars.Integration.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Integration[1] ~= nil then
            -- Migration Use-Case: profileCounter not yet initialized, but profiles are existing
            -- Return previous default number of profiles: 10
            return 10
        end
    end
    -- Normal Use-Case: profileCounter initialized
    return profileCounter
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileList
---------------------------------
local function getPAIntegrationProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Integration.profileCounter do
    local highestProfileNo = _getHighestPAIntegrationProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Integration[profileNo]) then
            table.insert(profiles, PA.SavedVars.Integration[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Integration.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPAIntegrationProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Integration.profileCounter do
    local highestProfileNo = _getHighestPAIntegrationProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Integration[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Integration.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPAIntegrationInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Integration.profileCounter do
    local highestProfileNo = _getHighestPAIntegrationProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Integration[profileNo]) and profileNo ~= PA.SavedVars.Profile.Integration.activeProfile then
            table.insert(profiles, PA.SavedVars.Integration[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPAIntegrationInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Integration.profileCounter do
    local highestProfileNo = _getHighestPAIntegrationProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Integration[profileNo]) and profileNo ~= PA.SavedVars.Profile.Integration.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPAIntegrationProfileList()
    local profiles = getPAIntegrationProfileList()
    local profileValues = getPAIntegrationProfileListValues()
    PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPAIntegrationInactiveProfileList()
    local inactiveProfiles = getPAIntegrationInactiveProfileList()
    local inactiveProfileValues = getPAIntegrationInactiveProfileListValues()
    PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPAIntegrationDefaultProfile()
    local PAISavedVars = PA.SavedVars.Integration
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PAISavedVars.profileCounter == nil or PAISavedVars.profileCounter == 0) and PAISavedVars[1] == nil then
        -- initialize the first profile
        PAISavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PAISavedVars[1], PA.MenuDefaults.PAIntegration)
        -- and set the savedVarsVersion and profileCounter
        PAISavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PAISavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPAIntegrationProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PAISavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PAISavedVars[profileNo], PA.MenuDefaults.PAIntegration)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPAIntegrationActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Integration.activeProfile
        -- then save the new one
        PASavedVars.Profile.Integration.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPAIntegrationProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPAIntegrationInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Integration.selectedCopyProfile = nil
        PA.Integration.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PAIntegration()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PAIntegration()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPAIntegrationActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Integration.activeProfile
    if (istable(PA.SavedVars.Integration[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Integration.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPAIntegrationActiveProfile()
    local activeProfile = getPAIntegrationActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Integration.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPAIntegrationActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Integration.activeProfile
    if not istable(PA.SavedVars.Integration[activeProfile]) then return end
    return PA.SavedVars.Integration[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPAIntegrationActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Integration.activeProfile
        PA.SavedVars.Integration[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPAIntegrationProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPAIntegrationProfileSubMenuHeader()
    local activeProfile = getPAIntegrationActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPAIntegrationActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPAIntegrationNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Integration.profileCounter = PASavedVars.Integration.profileCounter + 1
    local newProfileNo = PASavedVars.Integration.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Integration[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PAIntegration, PASavedVars.Integration[newProfileNo])
    PASavedVars.Integration[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPAIntegrationProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAIntegrationInactiveProfileList()

    -- then select the new profile
    setPAIntegrationActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPAIntegrationSelectedProfile()
    local selectedCopyProfile = PA.Integration.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Integration.activeProfile

    local profileSourceName = PA.SavedVars.Integration[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Integration[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Integration[selectedCopyProfile], PASavedVars.Integration[activeProfile])
    PASavedVars.Integration[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Integration.selectedCopyProfile = nil
    PA.Integration.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PAIntegration()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PAIntegration()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePAIntegrationSelectedProfile()
    local selectedDeleteProfile = PA.Integration.selectedDeleteProfile
    local profileName = PA.SavedVars.Integration[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Integration[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Integration.selectedCopyProfile = nil
    PA.Integration.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPAIntegrationProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAIntegrationInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPAIntegrationCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Integration.profileCounter do
        if istable(PASavedVars.Integration[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPAIntegrationOnlyOneProfile()
    local profileCount = _getPAIntegrationCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPAIntegrationNoProfileSelected()
    return (PA.SavedVars.Profile.Integration.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPAIntegrationActiveProfile()
    return not isPAIntegrationNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPAIntegrationMaxProfileCountReached()
    local profileCount = _getPAIntegrationCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PAIntegration = {
    isNoCopyProfileSelected = isPAIntegrationNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPAIntegrationNoDeleteProfileSelected,

    getProfileList = getPAIntegrationProfileList,
    getProfileListValues = getPAIntegrationProfileListValues,
    getInactiveProfileList = getPAIntegrationInactiveProfileList,
    getInactiveProfileListValues = getPAIntegrationInactiveProfileListValues,

    initDefaultProfile = initPAIntegrationDefaultProfile,
    setActiveProfile = setPAIntegrationActiveProfile,
    getActiveProfile = getPAIntegrationActiveProfile,
    fixActiveProfile = fixPAIntegrationActiveProfile,

    getActiveProfileName = getPAIntegrationActiveProfileName,
    setActiveProfileName = setPAIntegrationActiveProfileName,
    getProfileSubMenuHeader = getPAIntegrationProfileSubMenuHeader,

    createNewProfile = createPAIntegrationNewProfile,
    copySelectedProfile = copyPAIntegrationSelectedProfile,
    deleteSelectedProfile = deletePAIntegrationSelectedProfile,

    hasOnlyOneProfile = hasPAIntegrationOnlyOneProfile,
    isNoProfileSelected = isPAIntegrationNoProfileSelected,
    hasActiveProfile = hasPAIntegrationActiveProfile,
    hasMaxProfileCountReached = hasPAIntegrationMaxProfileCountReached
}