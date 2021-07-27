-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPAJunkNoCopyProfileSelected()
    return (PA.Junk.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPAJunkNoDeleteProfileSelected()
    return (PA.Junk.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPAJunkProfileNo()
    local profileCounter = PA.SavedVars.Junk.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Junk[1] ~= nil then
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
local function getPAJunkProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Junk.profileCounter do
    local highestProfileNo = _getHighestPAJunkProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Junk[profileNo]) then
            table.insert(profiles, PA.SavedVars.Junk[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Junk.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPAJunkProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Junk.profileCounter do
    local highestProfileNo = _getHighestPAJunkProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Junk[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Junk.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPAJunkInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Junk.profileCounter do
    local highestProfileNo = _getHighestPAJunkProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Junk[profileNo]) and profileNo ~= PA.SavedVars.Profile.Junk.activeProfile then
            table.insert(profiles, PA.SavedVars.Junk[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPAJunkInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Junk.profileCounter do
    local highestProfileNo = _getHighestPAJunkProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Junk[profileNo]) and profileNo ~= PA.SavedVars.Profile.Junk.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPAJunkProfileList()
    local profiles = getPAJunkProfileList()
    local profileValues = getPAJunkProfileListValues()
    PERSONALASSISTANT_JUNK_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_JUNK_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPAJunkInactiveProfileList()
    local inactiveProfiles = getPAJunkInactiveProfileList()
    local inactiveProfileValues = getPAJunkInactiveProfileListValues()
    PERSONALASSISTANT_JUNK_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_JUNK_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_JUNK_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_JUNK_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPAJunkDefaultProfile()
    local PAJSavedVars = PA.SavedVars.Junk
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PAJSavedVars.profileCounter == nil or PAJSavedVars.profileCounter == 0) and PAJSavedVars[1] == nil then
        -- initialize the first profile
        PAJSavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PAJSavedVars[1], PA.MenuDefaults.PAJunk)
        -- and set the savedVarsVersion and profileCounter
        PAJSavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PAJSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPAJunkProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PAJSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PAJSavedVars[profileNo], PA.MenuDefaults.PAJunk)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPAJunkActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Junk.activeProfile
        -- then save the new one
        PASavedVars.Profile.Junk.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPAJunkProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPAJunkInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Junk.selectedCopyProfile = nil
        PA.Junk.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PAJunk()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PAJunk()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPAJunkActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Junk.activeProfile
    if (istable(PA.SavedVars.Junk[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Junk.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPAJunkActiveProfile()
    local activeProfile = getPAJunkActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Junk.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPAJunkActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Junk.activeProfile
    if not istable(PA.SavedVars.Junk[activeProfile]) then return end
    return PA.SavedVars.Junk[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPAJunkActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Junk.activeProfile
        PA.SavedVars.Junk[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPAJunkProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPAJunkProfileSubMenuHeader()
    local activeProfile = getPAJunkActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPAJunkActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPAJunkNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Junk.profileCounter = PASavedVars.Junk.profileCounter + 1
    local newProfileNo = PASavedVars.Junk.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Junk[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PAJunk, PASavedVars.Junk[newProfileNo])
    PASavedVars.Junk[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPAJunkProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAJunkInactiveProfileList()

    -- then select the new profile
    setPAJunkActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPAJunkSelectedProfile()
    local selectedCopyProfile = PA.Junk.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Junk.activeProfile

    local profileSourceName = PA.SavedVars.Junk[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Junk[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Junk[selectedCopyProfile], PASavedVars.Junk[activeProfile])
    PASavedVars.Junk[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Junk.selectedCopyProfile = nil
    PA.Junk.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PAJunk()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PAJunk()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePAJunkSelectedProfile()
    local selectedDeleteProfile = PA.Junk.selectedDeleteProfile
    local profileName = PA.SavedVars.Junk[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Junk[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Junk.selectedCopyProfile = nil
    PA.Junk.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPAJunkProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPAJunkInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPAJunkCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Junk.profileCounter do
        if istable(PASavedVars.Junk[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPAJunkOnlyOneProfile()
    local profileCount = _getPAJunkCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPAJunkNoProfileSelected()
    return (PA.SavedVars.Profile.Junk.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPAJunkActiveProfile()
    return not isPAJunkNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPAJunkMaxProfileCountReached()
    local profileCount = _getPAJunkCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PAJunk = {
    isNoCopyProfileSelected = isPAJunkNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPAJunkNoDeleteProfileSelected,

    getProfileList = getPAJunkProfileList,
    getProfileListValues = getPAJunkProfileListValues,
    getInactiveProfileList = getPAJunkInactiveProfileList,
    getInactiveProfileListValues = getPAJunkInactiveProfileListValues,

    initDefaultProfile = initPAJunkDefaultProfile,
    setActiveProfile = setPAJunkActiveProfile,
    getActiveProfile = getPAJunkActiveProfile,
    fixActiveProfile = fixPAJunkActiveProfile,

    getActiveProfileName = getPAJunkActiveProfileName,
    setActiveProfileName = setPAJunkActiveProfileName,
    getProfileSubMenuHeader = getPAJunkProfileSubMenuHeader,

    createNewProfile = createPAJunkNewProfile,
    copySelectedProfile = copyPAJunkSelectedProfile,
    deleteSelectedProfile = deletePAJunkSelectedProfile,

    hasOnlyOneProfile = hasPAJunkOnlyOneProfile,
    isNoProfileSelected = isPAJunkNoProfileSelected,
    hasActiveProfile = hasPAJunkActiveProfile,
    hasMaxProfileCountReached = hasPAJunkMaxProfileCountReached
}