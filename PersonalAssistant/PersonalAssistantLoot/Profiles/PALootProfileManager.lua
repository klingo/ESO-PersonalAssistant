-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPALootNoCopyProfileSelected()
    return (PA.Loot.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPALootNoDeleteProfileSelected()
    return (PA.Loot.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPALootProfileNo()
    local profileCounter = PA.SavedVars.Loot.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Loot[1] ~= nil then
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
local function getPALootProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Loot.profileCounter do
    local highestProfileNo = _getHighestPALootProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Loot[profileNo]) then
            table.insert(profiles, PA.SavedVars.Loot[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Loot.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPALootProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Loot.profileCounter do
    local highestProfileNo = _getHighestPALootProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Loot[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Loot.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPALootInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Loot.profileCounter do
    local highestProfileNo = _getHighestPALootProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Loot[profileNo]) and profileNo ~= PA.SavedVars.Profile.Loot.activeProfile then
            table.insert(profiles, PA.SavedVars.Loot[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPALootInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Loot.profileCounter do
    local highestProfileNo = _getHighestPALootProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Loot[profileNo]) and profileNo ~= PA.SavedVars.Profile.Loot.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPALootProfileList()
    local profiles = getPALootProfileList()
    local profileValues = getPALootProfileListValues()
    PERSONALASSISTANT_LOOT_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_LOOT_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPALootInactiveProfileList()
    local inactiveProfiles = getPALootInactiveProfileList()
    local inactiveProfileValues = getPALootInactiveProfileListValues()
    PERSONALASSISTANT_LOOT_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_LOOT_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_LOOT_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_LOOT_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPALootDefaultProfile()
    local PALSavedVars = PA.SavedVars.Loot
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PALSavedVars.profileCounter == nil or PALSavedVars.profileCounter == 0) and PALSavedVars[1] == nil then
        -- initialize the first profile
        PALSavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PALSavedVars[1], PA.MenuDefaults.PALoot)
        -- and set the savedVarsVersion and profileCounter
        PALSavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PALSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPALootProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PALSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PALSavedVars[profileNo], PA.MenuDefaults.PALoot)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPALootActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Loot.activeProfile
        -- then save the new one
        PASavedVars.Profile.Loot.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPALootProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPALootInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Loot.selectedCopyProfile = nil
        PA.Loot.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PALoot()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PALoot()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPALootActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Loot.activeProfile
    if (istable(PA.SavedVars.Loot[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Loot.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPALootActiveProfile()
    local activeProfile = getPALootActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Loot.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPALootActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Loot.activeProfile
    if not istable(PA.SavedVars.Loot[activeProfile]) then return end
    return PA.SavedVars.Loot[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPALootActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Loot.activeProfile
        PA.SavedVars.Loot[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPALootProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPALootProfileSubMenuHeader()
    local activeProfile = getPALootActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPALootActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPALootNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Loot.profileCounter = PASavedVars.Loot.profileCounter + 1
    local newProfileNo = PASavedVars.Loot.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Loot[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PALoot, PASavedVars.Loot[newProfileNo])
    PASavedVars.Loot[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPALootProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPALootInactiveProfileList()

    -- then select the new profile
    setPALootActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPALootSelectedProfile()
    local selectedCopyProfile = PA.Loot.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Loot.activeProfile

    local profileSourceName = PA.SavedVars.Loot[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Loot[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Loot[selectedCopyProfile], PASavedVars.Loot[activeProfile])
    PASavedVars.Loot[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Loot.selectedCopyProfile = nil
    PA.Loot.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PALoot()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PALoot()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePALootSelectedProfile()
    local selectedDeleteProfile = PA.Loot.selectedDeleteProfile
    local profileName = PA.SavedVars.Loot[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Loot[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Loot.selectedCopyProfile = nil
    PA.Loot.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPALootProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPALootInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPALootCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Loot.profileCounter do
        if istable(PASavedVars.Loot[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPALootOnlyOneProfile()
    local profileCount = _getPALootCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPALootNoProfileSelected()
    return (PA.SavedVars.Profile.Loot.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPALootActiveProfile()
    return not isPALootNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPALootMaxProfileCountReached()
    local profileCount = _getPALootCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PALoot = {
    isNoCopyProfileSelected = isPALootNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPALootNoDeleteProfileSelected,

    getProfileList = getPALootProfileList,
    getProfileListValues = getPALootProfileListValues,
    getInactiveProfileList = getPALootInactiveProfileList,
    getInactiveProfileListValues = getPALootInactiveProfileListValues,

    initDefaultProfile = initPALootDefaultProfile,
    setActiveProfile = setPALootActiveProfile,
    getActiveProfile = getPALootActiveProfile,
    fixActiveProfile = fixPALootActiveProfile,

    getActiveProfileName = getPALootActiveProfileName,
    setActiveProfileName = setPALootActiveProfileName,
    getProfileSubMenuHeader = getPALootProfileSubMenuHeader,

    createNewProfile = createPALootNewProfile,
    copySelectedProfile = copyPALootSelectedProfile,
    deleteSelectedProfile = deletePALootSelectedProfile,

    hasOnlyOneProfile = hasPALootOnlyOneProfile,
    isNoProfileSelected = isPALootNoProfileSelected,
    hasActiveProfile = hasPALootActiveProfile,
    hasMaxProfileCountReached = hasPALootMaxProfileCountReached
}