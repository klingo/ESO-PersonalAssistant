-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPABankingNoCopyProfileSelected()
    return (PA.Banking.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPABankingNoDeleteProfileSelected()
    return (PA.Banking.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPABankingProfileNo()
    local profileCounter = PA.SavedVars.Banking.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Banking[1] ~= nil then
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
local function getPABankingProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Banking.profileCounter do
    local highestProfileNo = _getHighestPABankingProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Banking[profileNo]) then
            table.insert(profiles, PA.SavedVars.Banking[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Banking.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPABankingProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Banking.profileCounter do
    local highestProfileNo = _getHighestPABankingProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Banking[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Banking.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPABankingInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Banking.profileCounter do
    local highestProfileNo = _getHighestPABankingProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Banking[profileNo]) and profileNo ~= PA.SavedVars.Profile.Banking.activeProfile then
            table.insert(profiles, PA.SavedVars.Banking[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPABankingInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Banking.profileCounter do
    local highestProfileNo = _getHighestPABankingProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Banking[profileNo]) and profileNo ~= PA.SavedVars.Profile.Banking.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPABankingProfileList()
    local profiles = getPABankingProfileList()
    local profileValues = getPABankingProfileListValues()
    PERSONALASSISTANT_BANKING_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_BANKING_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPABankingInactiveProfileList()
    local inactiveProfiles = getPABankingInactiveProfileList()
    local inactiveProfileValues = getPABankingInactiveProfileListValues()
    PERSONALASSISTANT_BANKING_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_BANKING_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_BANKING_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_BANKING_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPABankingDefaultProfile()
    local PABSavedVars = PA.SavedVars.Banking
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PABSavedVars.profileCounter == nil or PABSavedVars.profileCounter == 0) and PABSavedVars[1] == nil then
        -- initialize the first profile
        PABSavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PABSavedVars[1], PA.MenuDefaults.PABanking)
        -- and set the savedVarsVersion and profileCounter
        PABSavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PABSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPABankingProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PABSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PABSavedVars[profileNo], PA.MenuDefaults.PABanking)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPABankingActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Banking.activeProfile
        -- then save the new one
        PASavedVars.Profile.Banking.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPABankingProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPABankingInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Banking.selectedCopyProfile = nil
        PA.Banking.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PABanking()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PABanking()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPABankingActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Banking.activeProfile
    if (istable(PA.SavedVars.Banking[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Banking.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPABankingActiveProfile()
    local activeProfile = getPABankingActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Banking.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPABankingActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Banking.activeProfile
    if not istable(PA.SavedVars.Banking[activeProfile]) then return end
    return PA.SavedVars.Banking[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPABankingActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Banking.activeProfile
        PA.SavedVars.Banking[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPABankingProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPABankingProfileSubMenuHeader()
    local activeProfile = getPABankingActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPABankingActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPABankingNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Banking.profileCounter = PASavedVars.Banking.profileCounter + 1
    local newProfileNo = PASavedVars.Banking.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Banking[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PABanking, PASavedVars.Banking[newProfileNo])
    PASavedVars.Banking[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPABankingProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPABankingInactiveProfileList()

    -- then select the new profile
    setPABankingActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPABankingSelectedProfile()
    local selectedCopyProfile = PA.Banking.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Banking.activeProfile

    local profileSourceName = PA.SavedVars.Banking[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Banking[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Banking[selectedCopyProfile], PASavedVars.Banking[activeProfile])
    PASavedVars.Banking[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Banking.selectedCopyProfile = nil
    PA.Banking.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PABanking()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PABanking()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePABankingSelectedProfile()
    local selectedDeleteProfile = PA.Banking.selectedDeleteProfile
    local profileName = PA.SavedVars.Banking[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Banking[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Banking.selectedCopyProfile = nil
    PA.Banking.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPABankingProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPABankingInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPABankingCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Banking.profileCounter do
        if istable(PASavedVars.Banking[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPABankingOnlyOneProfile()
    local profileCount = _getPABankingCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPABankingNoProfileSelected()
    return (PA.SavedVars.Profile.Banking.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPABankingActiveProfile()
    return not isPABankingNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPABankingMaxProfileCountReached()
    local profileCount = _getPABankingCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PABanking = {
    isNoCopyProfileSelected = isPABankingNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPABankingNoDeleteProfileSelected,

    getProfileList = getPABankingProfileList,
    getProfileListValues = getPABankingProfileListValues,
    getInactiveProfileList = getPABankingInactiveProfileList,
    getInactiveProfileListValues = getPABankingInactiveProfileListValues,

    initDefaultProfile = initPABankingDefaultProfile,
    setActiveProfile = setPABankingActiveProfile,
    getActiveProfile = getPABankingActiveProfile,
    fixActiveProfile = fixPABankingActiveProfile,

    getActiveProfileName = getPABankingActiveProfileName,
    setActiveProfileName = setPABankingActiveProfileName,
    getProfileSubMenuHeader = getPABankingProfileSubMenuHeader,

    createNewProfile = createPABankingNewProfile,
    copySelectedProfile = copyPABankingSelectedProfile,
    deleteSelectedProfile = deletePABankingSelectedProfile,

    hasOnlyOneProfile = hasPABankingOnlyOneProfile,
    isNoProfileSelected = isPABankingNoProfileSelected,
    hasActiveProfile = hasPABankingActiveProfile,
    hasMaxProfileCountReached = hasPABankingMaxProfileCountReached
}