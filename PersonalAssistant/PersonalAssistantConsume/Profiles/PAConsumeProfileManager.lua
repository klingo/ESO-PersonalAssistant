-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPAConsumeNoCopyProfileSelected()
    return (PA.Consume.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPAConsumeNoDeleteProfileSelected()
    return (PA.Consume.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPAConsumeProfileNo()
    local profileCounter = PA.SavedVars.Consume.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Consume[1] ~= nil then
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
local function getPAConsumeProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Consume.profileCounter do
    local highestProfileNo = _getHighestPAConsumeProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Consume[profileNo]) then
            table.insert(profiles, PA.SavedVars.Consume[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Consume.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPAConsumeProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Consume.profileCounter do
    local highestProfileNo = _getHighestPAConsumeProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Consume[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Consume.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPAConsumeInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Consume.profileCounter do
    local highestProfileNo = _getHighestPAConsumeProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Consume[profileNo]) and profileNo ~= PA.SavedVars.Profile.Consume.activeProfile then
            table.insert(profiles, PA.SavedVars.Consume[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPAConsumeInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Consume.profileCounter do
    local highestProfileNo = _getHighestPAConsumeProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Consume[profileNo]) and profileNo ~= PA.SavedVars.Profile.Consume.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPAConsumeProfileList()
    local profiles = getPAConsumeProfileList()
    local profileValues = getPAConsumeProfileListValues()
    PERSONALASSISTANT_Consume_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_Consume_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPAConsumeInactiveProfileList()
    local inactiveProfiles = getPAConsumeInactiveProfileList()
    local inactiveProfileValues = getPAConsumeInactiveProfileListValues()
    PERSONALASSISTANT_Consume_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_Consume_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_Consume_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_Consume_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPAConsumeDefaultProfile()
    local PACOSavedVars = PA.SavedVars.Consume
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PACOSavedVars.profileCounter == nil or PACOSavedVars.profileCounter == 0) and PACOSavedVars[1] == nil then
        -- initialize the first profile
        PACOSavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PACOSavedVars[1], PA.MenuDefaults.PAConsume)
        -- and set the savedVarsVersion and profileCounter
        PACOSavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PACOSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPAConsumeProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PACOSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PACOSavedVars[profileNo], PA.MenuDefaults.PAConsume)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPAConsumeActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Consume.activeProfile
        -- then save the new one
        PASavedVars.Profile.Consume.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPAConsumeProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPAConsumeInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Consume.selectedCopyProfile = nil
        PA.Consume.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PAConsume()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PAConsume()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPAConsumeActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Consume.activeProfile
    if (istable(PA.SavedVars.Consume[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Consume.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPAConsumeActiveProfile()
    local activeProfile = getPAConsumeActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Consume.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPAConsumeActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Consume.activeProfile
    if not istable(PA.SavedVars.Consume[activeProfile]) then return end
    return PA.SavedVars.Consume[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPAConsumeActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Consume.activeProfile
        PA.SavedVars.Consume[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPAConsumeProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPAConsumeProfileSubMenuHeader()
    local activeProfile = getPAConsumeActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPAConsumeActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPAConsumeNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Consume.profileCounter = PASavedVars.Consume.profileCounter + 1
    local newProfileNo = PASavedVars.Consume.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Consume[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PAConsume, PASavedVars.Consume[newProfileNo])
    PASavedVars.Consume[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPAConsumeProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAConsumeInactiveProfileList()

    -- then select the new profile
    setPAConsumeActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPAConsumeSelectedProfile()
    local selectedCopyProfile = PA.Consume.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Consume.activeProfile

    local profileSourceName = PA.SavedVars.Consume[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Consume[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Consume[selectedCopyProfile], PASavedVars.Consume[activeProfile])
    PASavedVars.Consume[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Consume.selectedCopyProfile = nil
    PA.Consume.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PAConsume()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PAConsume()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePAConsumeSelectedProfile()
    local selectedDeleteProfile = PA.Consume.selectedDeleteProfile
    local profileName = PA.SavedVars.Consume[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Consume[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Consume.selectedCopyProfile = nil
    PA.Consume.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPAConsumeProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAConsumeInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPAConsumeCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Consume.profileCounter do
        if istable(PASavedVars.Consume[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPAConsumeOnlyOneProfile()
    local profileCount = _getPAConsumeCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPAConsumeNoProfileSelected()
    return (PA.SavedVars.Profile.Consume.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPAConsumeActiveProfile()
    return not isPAConsumeNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPAConsumeMaxProfileCountReached()
    local profileCount = _getPAConsumeCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PAConsume = {
    isNoCopyProfileSelected = isPAConsumeNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPAConsumeNoDeleteProfileSelected,

    getProfileList = getPAConsumeProfileList,
    getProfileListValues = getPAConsumeProfileListValues,
    getInactiveProfileList = getPAConsumeInactiveProfileList,
    getInactiveProfileListValues = getPAConsumeInactiveProfileListValues,

    initDefaultProfile = initPAConsumeDefaultProfile,
    setActiveProfile = setPAConsumeActiveProfile,
    getActiveProfile = getPAConsumeActiveProfile,
    fixActiveProfile = fixPAConsumeActiveProfile,

    getActiveProfileName = getPAConsumeActiveProfileName,
    setActiveProfileName = setPAConsumeActiveProfileName,
    getProfileSubMenuHeader = getPAConsumeProfileSubMenuHeader,

    createNewProfile = createPAConsumeNewProfile,
    copySelectedProfile = copyPAConsumeSelectedProfile,
    deleteSelectedProfile = deletePAConsumeSelectedProfile,

    hasOnlyOneProfile = hasPAConsumeOnlyOneProfile,
    isNoProfileSelected = isPAConsumeNoProfileSelected,
    hasActiveProfile = hasPAConsumeActiveProfile,
    hasMaxProfileCountReached = hasPAConsumeMaxProfileCountReached
}