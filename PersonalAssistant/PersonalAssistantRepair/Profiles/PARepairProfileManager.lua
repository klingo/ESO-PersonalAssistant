-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoCopyProfileSelected
---------------------------------
local function isPARepairNoCopyProfileSelected()
    return (PA.Repair.selectedCopyProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoDeleteProfileSelected
---------------------------------
local function isPARepairNoDeleteProfileSelected()
    return (PA.Repair.selectedDeleteProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _getHighest___ProfileNo
---------------------------------
local function _getHighestPARepairProfileNo()
    local profileCounter = PA.SavedVars.Repair.profileCounter
    if profileCounter == nil or profileCounter == 0 then
        if PA.SavedVars.Repair[1] ~= nil then
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
local function getPARepairProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Repair.profileCounter do
    local highestProfileNo = _getHighestPARepairProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Repair[profileNo]) then
            table.insert(profiles, PA.SavedVars.Repair[profileNo].name)
        end
    end
    if PA.SavedVars.Profile.Repair.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profiles, GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT))
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileListValues
---------------------------------
local function getPARepairProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Repair.profileCounter do
    local highestProfileNo = _getHighestPARepairProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Repair[profileNo]) then
            table.insert(profileValues, profileNo)
        end
    end
    if PA.SavedVars.Profile.Repair.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        table.insert(profileValues, PAC.GENERAL.NO_PROFILE_SELECTED_ID)
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileList
---------------------------------
local function getPARepairInactiveProfileList()
    local profiles = {}
    -- for profileNo = 1, PASavedVars.Repair.profileCounter do
    local highestProfileNo = _getHighestPARepairProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Repair[profileNo]) and profileNo ~= PA.SavedVars.Profile.Repair.activeProfile then
            table.insert(profiles, PA.SavedVars.Repair[profileNo].name)
        end
    end
    return profiles
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___InactiveProfileListValues
---------------------------------
local function getPARepairInactiveProfileListValues()
    local profileValues = {}
    -- for profileNo = 1, PASavedVars.Repair.profileCounter do
    local highestProfileNo = _getHighestPARepairProfileNo()
    for profileNo = 1, highestProfileNo do
        if istable(PA.SavedVars.Repair[profileNo]) and profileNo ~= PA.SavedVars.Profile.Repair.activeProfile then
            table.insert(profileValues, profileNo)
        end
    end
    return profileValues
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___ProfileList
---------------------------------
local function _reloadPARepairProfileList()
    local profiles = getPARepairProfileList()
    local profileValues = getPARepairProfileListValues()
    PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _reload___InactiveProfileList
---------------------------------
local function _reloadPARepairInactiveProfileList()
    local inactiveProfiles = getPARepairInactiveProfileList()
    local inactiveProfileValues = getPARepairInactiveProfileListValues()
    PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN_COPY:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN_COPY:UpdateValue()
    PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN_DELETE:UpdateChoices(inactiveProfiles, inactiveProfileValues)
    PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN_DELETE:UpdateValue()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- init___DefaultProfile
---------------------------------
local function initPARepairDefaultProfile()
    local PARSavedVars = PA.SavedVars.Repair
    local PAZO_SavedVars = PA.ZO_SavedVars
    -- check if there even is a profile yet
    if (PARSavedVars.profileCounter == nil or PARSavedVars.profileCounter == 0) and PARSavedVars[1] == nil then
        -- initialize the first profile
        PARSavedVars[1] = {}
        PAZO_SavedVars.CopyDefaults(PARSavedVars[1], PA.MenuDefaults.PARepair)
        -- and set the savedVarsVersion and profileCounter
        PARSavedVars.savedVarsVersion = PAC.ADDON.VERSION_ADDON
        PARSavedVars.profileCounter = 1
    else
        -- at least one profile is existing, check with others
        local highestProfileNo = _getHighestPARepairProfileNo()
        for profileNo = 1, highestProfileNo do
            if istable(PARSavedVars[profileNo]) then
                -- profile exists, make sure it has all default values
                PAZO_SavedVars.CopyDefaults(PARSavedVars[profileNo], PA.MenuDefaults.PARepair)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfile
---------------------------------
local function setPARepairActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.Repair.activeProfile
        -- then save the new one
        PASavedVars.Profile.Repair.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            _reloadPARepairProfileList()
        end
        -- refresh the profiles to be copy/deleted
        _reloadPARepairInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.Repair.selectedCopyProfile = nil
        PA.Repair.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshSavedVarReference.PARepair()
        -- and also refresh all event registrations
        PAEM.RefreshEventRegistration.PARepair()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfile
---------------------------------
local function getPARepairActiveProfile()
    local activeProfile = PA.SavedVars.Profile.Repair.activeProfile
    if (istable(PA.SavedVars.Repair[activeProfile])) then
        -- activeProfile is valid, return it
        PA.Repair.activeProfile = activeProfile
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- fix___ActiveProfile
---------------------------------
local function fixPARepairActiveProfile()
    local activeProfile = getPARepairActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        PA.SavedVars.Profile.Repair.activeProfile = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ActiveProfileName
---------------------------------
local function getPARepairActiveProfileName()
    local activeProfile = PA.SavedVars.Profile.Repair.activeProfile
    if not istable(PA.SavedVars.Repair[activeProfile]) then return end
    return PA.SavedVars.Repair[activeProfile].name
end

-- ---------------------------------------------------------------------------------------------------------------------
-- set___ActiveProfileName
---------------------------------
local function setPARepairActiveProfileName(profileName)
    if profileName ~= nil and profileName ~= "" then
        local activeProfile = PA.SavedVars.Profile.Repair.activeProfile
        PA.SavedVars.Repair[activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        _reloadPARepairProfileList()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- get___ProfileSubMenuHeader
---------------------------------
local function getPARepairProfileSubMenuHeader()
    local activeProfile = getPARepairActiveProfile()
    local prefix = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_PROFILE))
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        return table.concat({prefix, " ", GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)})
    else
        return table.concat({prefix, " ", getPARepairActiveProfileName()})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- create___NewProfile
---------------------------------
local function createPARepairNewProfile()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults

    PASavedVars.Repair.profileCounter = PASavedVars.Repair.profileCounter + 1
    local newProfileNo = PASavedVars.Repair.profileCounter
    local newProfileName = PAHF.getDefaultProfileName(newProfileNo)

    PASavedVars.Repair[newProfileNo] = {}
    ZO_DeepTableCopy(PAMenuDefaults.PARepair, PASavedVars.Repair[newProfileNo])
    PASavedVars.Repair[newProfileNo].name = newProfileName

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    _reloadPARepairProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPARepairInactiveProfileList()

    -- then select the new profile
    setPARepairActiveProfile(newProfileNo)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- copy___SelectedProfile
---------------------------------
local function copyPARepairSelectedProfile()
    local selectedCopyProfile = PA.Repair.selectedCopyProfile
    local activeProfile = PA.SavedVars.Profile.Repair.activeProfile

    local profileSourceName = PA.SavedVars.Repair[selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.Repair[activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    ZO_DeepTableCopy(PASavedVars.Repair[selectedCopyProfile], PASavedVars.Repair[activeProfile])
    PASavedVars.Repair[activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Repair.selectedCopyProfile = nil
    PA.Repair.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshSavedVarReference.PARepair()

    -- then also all the events need to be re-initialized
    PAEM.RefreshEventRegistration.PARepair()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- delete___SelectedProfile
---------------------------------
local function deletePARepairSelectedProfile()
    local selectedDeleteProfile = PA.Repair.selectedDeleteProfile
    local profileName = PA.SavedVars.Repair[selectedDeleteProfile].name

    -- attempt to delete the settings
    PA.SavedVars.Repair[selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.Repair.selectedCopyProfile = nil
    PA.Repair.selectedDeleteProfile = nil

    -- refresh the active profile list
    _reloadPARepairProfileList()
    -- refresh the profiles to be copy/deleted
    _reloadPARepairInactiveProfileList()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- _get___CurrentProfileCount
---------------------------------
local function _getPARepairCurrentProfileCount()
    local profileCount = 0
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.Repair.profileCounter do
        if istable(PASavedVars.Repair[profileNo]) then
            profileCount = profileCount + 1
        end
    end
    return profileCount
end

--------------------------------------------------------------------------
-- has___OnlyOneProfile
---------------------------------
local function hasPARepairOnlyOneProfile()
    local profileCount = _getPARepairCurrentProfileCount()
    return profileCount <= 1
end

-- ---------------------------------------------------------------------------------------------------------------------
-- is___NoProfileSelected
---------------------------------
local function isPARepairNoProfileSelected()
    return (PA.SavedVars.Profile.Repair.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___ActiveProfile
---------------------------------
local function hasPARepairActiveProfile()
    return not isPARepairNoProfileSelected()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- has___MaxProfileCountReached
---------------------------------
local function hasPARepairMaxProfileCountReached()
    local profileCount = _getPARepairCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
end

-- =====================================================================================================================
-- Export
PA.ProfileManager = PA.ProfileManager or {}
PA.ProfileManager.PARepair = {
    isNoCopyProfileSelected = isPARepairNoCopyProfileSelected,
    isNoDeleteProfileSelected = isPARepairNoDeleteProfileSelected,

    getProfileList = getPARepairProfileList,
    getProfileListValues = getPARepairProfileListValues,
    getInactiveProfileList = getPARepairInactiveProfileList,
    getInactiveProfileListValues = getPARepairInactiveProfileListValues,

    initDefaultProfile = initPARepairDefaultProfile,
    setActiveProfile = setPARepairActiveProfile,
    getActiveProfile = getPARepairActiveProfile,
    fixActiveProfile = fixPARepairActiveProfile,

    getActiveProfileName = getPARepairActiveProfileName,
    setActiveProfileName = setPARepairActiveProfileName,
    getProfileSubMenuHeader = getPARepairProfileSubMenuHeader,

    createNewProfile = createPARepairNewProfile,
    copySelectedProfile = copyPARepairSelectedProfile,
    deleteSelectedProfile = deletePARepairSelectedProfile,

    hasOnlyOneProfile = hasPARepairOnlyOneProfile,
    isNoProfileSelected = isPARepairNoProfileSelected,
    hasActiveProfile = hasPARepairActiveProfile,
    hasMaxProfileCountReached = hasPARepairMaxProfileCountReached
}