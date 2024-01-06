-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPAWorkerNoCopyProfileSelected()
    return (PA.Worker.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPAWorkerNoDeleteProfileSelected()
    return (PA.Worker.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPAWorkerProfileNo()
    local profileCounter = PA.SavedVars.Worker.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Worker[1] ~= nil then
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
local function getPAWorkerProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Worker.profileCounter do
    local highestProfileNo = _getHighestPAWorkerProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Worker[profileNo]) then
            table.insert(profiles, PA.SavedVars.Worker[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Worker.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPAWorkerProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Worker.profileCounter do
    local highestProfileNo = _getHighestPAWorkerProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Worker[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Worker.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPAWorkerInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Worker.profileCounter do
    local highestProfileNo = _getHighestPAWorkerProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Worker[profileNo]) and profileNo ~= PA.SavedVars.Profile.Worker.activeProfile then
            table.insert(profiles, PA.SavedVars.Worker[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPAWorkerInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Worker.profileCounter do
    local highestProfileNo = _getHighestPAWorkerProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Worker[profileNo]) and profileNo ~= PA.SavedVars.Profile.Worker.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPAWorkerProfileList()
    local profiles = getPAWorkerProfileList()
    local profileValues = getPAWorkerProfileListValues()
    PERSONALASSISTANT_WORKER_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_WORKER_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPAWorkerInactiveProfileList()
    local inactiveProfiles = getPAWorkerInactiveProfileList()
    local inactiveProfileValues = getPAWorkerInactiveProfileListValues()
    PERSONALASSISTANT_WORKER_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_WORKER_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_WORKER_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_WORKER_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPAWorkerDefaultProfile()
    local PAWSavedVars = PA.SavedVars.Worker
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PAWSavedVars.profileCounter == nil or PAWSavedVars.profileCounter == 0) and PAWSavedVars[1] == nil then
        -- initialize the first profile
        PAWSavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PAWSavedVars[1], PA.MenuDefaults.PAWorker)
        -- and set the savedVarsVersion and profileCounter
        PAWSavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PAWSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPAWorkerProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PAWSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PAWSavedVars[profileNo], PA.MenuDefaults.PAWorker)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPAWorkerActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Worker.activeProfile
        -- then save the new one
        PASavedVars.Profile.Worker.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPAWorkerProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPAWorkerInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Worker.selectedCopyProfile = nil
        PA.Worker.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PAWorker()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PAWorker()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPAWorkerActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Worker.activeProfile
    if (istable(PA.SavedVars.Worker[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Worker.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPAWorkerActiveProfile()
    local activeProfile = getPAWorkerActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Worker.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPAWorkerActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Worker.activeProfile
    if not istable(PA.SavedVars.Worker[activeProfile]) then return end
    return PA.SavedVars.Worker[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPAWorkerActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Worker.activeProfile
        PA.SavedVars.Worker[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPAWorkerProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPAWorkerProfileSubMenuHeader()
    local activeProfile = getPAWorkerActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPAWorkerActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPAWorkerNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Worker.profileCounter = PASavedVars.Worker.profileCounter + 1
    local newProfileNo = PASavedVars.Worker.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Worker[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PAWorker, PASavedVars.Worker[newProfileNo])
    PASavedVars.Worker[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPAWorkerProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAWorkerInactiveProfileList()

    -- then select the new profile
    setPAWorkerActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPAWorkerSelectedProfile()
    local selectedCopyProfile = PA.Worker.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Worker.activeProfile

    local profileSourceName = PA.SavedVars.Worker[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Worker[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Worker[selectedCopyProfile], PASavedVars.Worker[activeProfile])
    PASavedVars.Worker[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Worker.selectedCopyProfile = nil
    PA.Worker.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PAWorker()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PAWorker()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePAWorkerSelectedProfile()
    local selectedDeleteProfile = PA.Worker.selectedDeleteProfile
    local profileName = PA.SavedVars.Worker[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Worker[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Worker.selectedCopyProfile = nil
    PA.Worker.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPAWorkerProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAWorkerInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPAWorkerCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Worker.profileCounter do
        if istable(PASavedVars.Worker[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPAWorkerOnlyOneProfile()
    local profileCount = _getPAWorkerCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPAWorkerNoProfileSelected()
    return (PA.SavedVars.Profile.Worker.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPAWorkerActiveProfile()
    return not isPAWorkerNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPAWorkerMaxProfileCountReached()
    local profileCount = _getPAWorkerCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PAWorker = {
    isNoCopyProfileSelected = isPAWorkerNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPAWorkerNoDeleteProfileSelected,

    getProfileList = getPAWorkerProfileList,
    getProfileListValues = getPAWorkerProfileListValues,
    getInactiveProfileList = getPAWorkerInactiveProfileList,
    getInactiveProfileListValues = getPAWorkerInactiveProfileListValues,

    initDefaultProfile = initPAWorkerDefaultProfile,
    setActiveProfile = setPAWorkerActiveProfile,
    getActiveProfile = getPAWorkerActiveProfile,
    fixActiveProfile = fixPAWorkerActiveProfile,

    getActiveProfileName = getPAWorkerActiveProfileName,
    setActiveProfileName = setPAWorkerActiveProfileName,
    getProfileSubMenuHeader = getPAWorkerProfileSubMenuHeader,

    createNewProfile = createPAWorkerNewProfile,
    copySelectedProfile = copyPAWorkerSelectedProfile,
    deleteSelectedProfile = deletePAWorkerSelectedProfile,

    hasOnlyOneProfile = hasPAWorkerOnlyOneProfile,
    isNoProfileSelected = isPAWorkerNoProfileSelected,
    hasActiveProfile = hasPAWorkerActiveProfile,
    hasMaxProfileCountReached = hasPAWorkerMaxProfileCountReached
}