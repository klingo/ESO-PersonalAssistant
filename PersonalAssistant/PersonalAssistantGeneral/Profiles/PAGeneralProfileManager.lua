-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPAGeneralNoCopyProfileSelected()
    return (PA.General.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPAGeneralNoDeleteProfileSelected()
    return (PA.General.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPAGeneralProfileNo()
    local profileCounter = PA.SavedVars.General.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.General[1] ~= nil then
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
local function getPAGeneralProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.General.profileCounter do
    local highestProfileNo = _getHighestPAGeneralProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.General[profileNo]) then
            table.insert(profiles, PA.SavedVars.General[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.General.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPAGeneralProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.General.profileCounter do
    local highestProfileNo = _getHighestPAGeneralProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.General[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.General.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPAGeneralInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.General.profileCounter do
    local highestProfileNo = _getHighestPAGeneralProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.General[profileNo]) and profileNo ~= PA.SavedVars.Profile.General.activeProfile then
            table.insert(profiles, PA.SavedVars.General[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPAGeneralInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.General.profileCounter do
    local highestProfileNo = _getHighestPAGeneralProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.General[profileNo]) and profileNo ~= PA.SavedVars.Profile.General.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPAGeneralProfileList()
    local profiles = getPAGeneralProfileList()
    local profileValues = getPAGeneralProfileListValues()
    PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPAGeneralInactiveProfileList()
    local inactiveProfiles = getPAGeneralInactiveProfileList()
    local inactiveProfileValues = getPAGeneralInactiveProfileListValues()
    PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPAGeneralDefaultProfile()
    local PAGSavedVars = PA.SavedVars.General
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if PAGSavedVars.profileCounter == 0 and PAGSavedVars[1] == nil then
        -- initialize the first profile
        PAZO_SavedVars.CopyDefaults(PAGSavedVars[1], PA.MenuDefaults.PAGeneral)
        -- and set the savedVarsVersion and profileCounter
        PAGSavedVars.savedVarsVersion = PAC.ADDON.SAVED_VARS_VERSION.MINOR
        PAGSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPAGeneralProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PAGSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PAGSavedVars[profileNo], PA.MenuDefaults.PAGeneral)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPAGeneralActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.General.activeProfile
        -- then save the new one
        PASavedVars.Profile.General.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPAGeneralProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPAGeneralInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.General.selectedCopyProfile = nil
        PA.General.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PAGeneral()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PAGeneral()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PA.SavedVars.Profile.General.activeProfile
    if (istable(PA.SavedVars.General[activeProfile])) then
        -- activeProfile is valid, return it
        PA.General.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPAGeneralActiveProfile()
    local activeProfile = getPAGeneralActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.General.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPAGeneralActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.General.activeProfile
    return PA.SavedVars.General[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPAGeneralActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.General.activeProfile
        PA.SavedVars.General[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPAGeneralProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPAGeneralProfileSubMenuHeader()
    local activeProfile = getPAGeneralActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPAGeneralActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPAGeneralNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.General.profileCounter = PASavedVars.General.profileCounter + 1
    local newProfileNo = PASavedVars.General.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.General[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PAGeneral, PASavedVars.General[newProfileNo])
    PASavedVars.General[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPAGeneralProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAGeneralInactiveProfileList()

    -- then select the new profile
    setPAGeneralActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPAGeneralSelectedProfile()
    local selectedCopyProfile = PA.General.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.General.activeProfile

    local profileSourceName = PA.SavedVars.General[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.General[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.General[selectedCopyProfile], PASavedVars.General[activeProfile])
    PASavedVars.General[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.General.selectedCopyProfile = nil
    PA.General.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PAGeneral()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PAGeneral()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePAGeneralSelectedProfile()
    local selectedDeleteProfile = PA.General.selectedDeleteProfile
    local profileName = PA.SavedVars.General[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.General[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.General.selectedCopyProfile = nil
    PA.General.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPAGeneralProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAGeneralInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPAGeneralCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.General.profileCounter do
        if istable(PASavedVars.General[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPAGeneralOnlyOneProfile()
    local profileCount = _getPAGeneralCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPAGeneralNoProfileSelected()
    return (PA.SavedVars.Profile.General.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPAGeneralActiveProfile()
    return not isPAGeneralNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPAGeneralMaxProfileCountReached()
    local profileCount = _getPAGeneralCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PAGeneral = {
    isNoCopyProfileSelected = isPAGeneralNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPAGeneralNoDeleteProfileSelected,

    getProfileList = getPAGeneralProfileList,
    getProfileListValues = getPAGeneralProfileListValues,
    getInactiveProfileList = getPAGeneralInactiveProfileList,
    getInactiveProfileListValues = getPAGeneralInactiveProfileListValues,

    initDefaultProfile = initPAGeneralDefaultProfile,
    setActiveProfile = setPAGeneralActiveProfile,
    getActiveProfile = getPAGeneralActiveProfile,
    fixActiveProfile = fixPAGeneralActiveProfile,

    getActiveProfileName = getPAGeneralActiveProfileName,
    setActiveProfileName = setPAGeneralActiveProfileName,
    getProfileSubMenuHeader = getPAGeneralProfileSubMenuHeader,

    createNewProfile = createPAGeneralNewProfile,
    copySelectedProfile = copyPAGeneralSelectedProfile,
    deleteSelectedProfile = deletePAGeneralSelectedProfile,

    hasOnlyOneProfile = hasPAGeneralOnlyOneProfile,
    isNoProfileSelected = isPAGeneralNoProfileSelected,
    hasActiveProfile = hasPAGeneralActiveProfile,
    hasMaxProfileCountReached = hasPAGeneralMaxProfileCountReached
}