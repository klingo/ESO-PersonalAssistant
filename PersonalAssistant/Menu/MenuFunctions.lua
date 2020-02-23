-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMH = PA.MenuHelper
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PA.SavedVars.Profile.activeProfile
    if (istable(PA.SavedVars.General[activeProfile])) then
        -- activeProfile is valid, return it
        return activeProfile
    else
        -- activeProfile is NOT valid, user must select a new one
        -- TODO: inform user
        d("activeProfile is NOT valid, user must select a new one")
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end
end

local function setPAGeneralActiveProfile(profileNo)
    if profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        local PASavedVars = PA.SavedVars
        local PAMenuHelper = PA.MenuHelper
        -- get the previously active profile first
        local prevProfile = PASavedVars.Profile.activeProfile
        -- then save the new one
        PASavedVars.Profile.activeProfile = profileNo
        PA.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if prevProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
            PAMenuHelper.reloadProfileList()
        end
        -- refresh the profiles to be copy/deleted
        PAMenuHelper.reloadInactiveProfileList()
        -- reset the selected entry from from the copy/delete dropdowns
        PA.selectedCopyProfile = nil
        PA.selectedDeleteProfile = nil
        -- refresh all SavedVar references that are profile-specific
        PAEM.RefreshAllSavedVarReferences(profileNo)
        -- and also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
    end
end

local function isDisabledPAGeneralNoProfileSelected()
    return (PA.activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID)
end

local function isDisabledPAGeneralNoCopyProfileSelected()
    return (PA.selectedCopyProfile == nil)
end

local function isDisabledPAGeneralNoDeleteProfileSelected()
    return (PA.selectedDeleteProfile == nil)
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
    return getValueV2(PA.General.SavedVars, ...)
end

local function setValue(value, ...)
    setValueV2(PA.General.SavedVars, value, ...)
end

local function isDisabled(...)
    return isDisabledV2(PA.General.SavedVars, ...)
end

--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
local function setPAGeneralActiveProfileRename(profileName)
    if profileName ~= nil and profileName ~= "" then
        setValue(profileName, {"name"})
        -- when profile was changed, reload the profile list
        local PAMenuHelper = PA.MenuHelper
        PAMenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PAGeneral   createNewProfile
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

    if PA.Banking then
        PASavedVars.Banking[newProfileNo] = {}
        ZO_DeepTableCopy(PAMenuDefaults.PABanking, PASavedVars.Banking[newProfileNo])
    end
    if PA.Integration then
        PASavedVars.Integration[newProfileNo] = {}
        ZO_DeepTableCopy(PAMenuDefaults.PAIntegration, PASavedVars.Integration[newProfileNo])
    end
    if PA.Junk then
        PASavedVars.Junk[newProfileNo] = {}
        ZO_DeepTableCopy(PAMenuDefaults.PAJunk, PASavedVars.Junk[newProfileNo])
    end
    if PA.Loot then
        PASavedVars.Loot[newProfileNo] = {}
        ZO_DeepTableCopy(PAMenuDefaults.PALoot, PASavedVars.Loot[newProfileNo])
    end
    if PA.Repair then
        PASavedVars.Repair[newProfileNo] = {}
        ZO_DeepTableCopy(PAMenuDefaults.PARepair, PASavedVars.Repair[newProfileNo])
    end

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, newProfileName)

    -- refresh the active profile list
    PAMH.reloadProfileList()
    -- refresh the profiles to be copy/deleted
    PAMH.reloadInactiveProfileList()

    -- then select the new profile
    setPAGeneralActiveProfile(newProfileNo)
end

--------------------------------------------------------------------------
-- PAGeneral   copySelectedProfile
---------------------------------
local function copyPAGeneralSelectedProfile()
    local profileSourceName = PA.SavedVars.General[PA.selectedCopyProfile].name
    local profileTargetName = PA.SavedVars.General[PA.activeProfile].name

    -- attempt to copy over all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    if PA.Banking then
        ZO_DeepTableCopy(PASavedVars.Banking[PA.selectedCopyProfile], PASavedVars.Banking[PA.activeProfile])
    end
    if PA.Integration then
        ZO_DeepTableCopy(PASavedVars.Integration[PA.selectedCopyProfile], PASavedVars.Integration[PA.activeProfile])
    end
    if PA.Junk then
        ZO_DeepTableCopy(PASavedVars.Junk[PA.selectedCopyProfile], PASavedVars.Junk[PA.activeProfile])
    end
    if PA.Loot then
        ZO_DeepTableCopy(PASavedVars.Loot[PA.selectedCopyProfile], PASavedVars.Loot[PA.activeProfile])
    end
    if PA.Repair then
        ZO_DeepTableCopy(PASavedVars.Repair[PA.selectedCopyProfile], PASavedVars.Repair[PA.activeProfile])
    end
    ZO_DeepTableCopy(PASavedVars.General[PA.selectedCopyProfile], PASavedVars.General[PA.activeProfile])
    PASavedVars.General[PA.activeProfile].name = profileTargetName

    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, profileSourceName, profileTargetName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.selectedCopyProfile = nil
    PA.selectedDeleteProfile = nil

    -- settings have been updated and thus the SavedVars for that profile need to be refresh
    PAEM.RefreshAllSavedVarReferences(PA.activeProfile)

    -- then also all the events need to be re-initialized
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PAGeneral   deleteSelectedProfile
---------------------------------
local function deletePAGeneralSelectedProfile()
    local profileName = PA.SavedVars.General[PA.selectedDeleteProfile].name

    -- attempt to delete all settings (might fail if a sub-addon is not loaded)
    local PASavedVars = PA.SavedVars
    if PA.Banking then
        PASavedVars.Banking[PA.selectedDeleteProfile] = nil
    end
    if PA.Integration then
        PASavedVars.Integration[PA.selectedDeleteProfile] = nil
    end
    if PA.Junk then
        PASavedVars.Junk[PA.selectedDeleteProfile] = nil
    end
    if PA.Loot then
        PASavedVars.Loot[PA.selectedDeleteProfile] = nil
    end
    if PA.Repair then
        PASavedVars.Repair[PA.selectedDeleteProfile] = nil
    end
    PASavedVars.General[PA.selectedDeleteProfile] = nil

    -- inform player
    PA.println(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, profileName)

    -- reset the selected entry from from the copy/delete dropdowns
    PA.selectedCopyProfile = nil
    PA.selectedDeleteProfile = nil
    -- refresh the active profile list
    PAMH.reloadProfileList()
    -- refresh the profiles to be copy/deleted
    PAMH.reloadInactiveProfileList()
end

--------------------------------------------------------------------------
-- PAGeneral   getCurrentProfileCount
---------------------------------
local function getPAGeneralCurrentProfileCount()
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
-- PAGeneral   hasOnlyOneProfile
---------------------------------
local function hasPAGeneralOnlyOneProfile()
    local profileCount = getPAGeneralCurrentProfileCount()
    return profileCount <= 1
end


--------------------------------------------------------------------------
-- PAGeneral   hasMaxProfileCountReached
---------------------------------
local function hasPAGeneralMaxProfileCountReached()
    local profileCount = getPAGeneralCurrentProfileCount()
    return profileCount >= PAC.GENERAL.MAX_PROFILES
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
        isNoCopyProfileSelected = isDisabledPAGeneralNoCopyProfileSelected,
        isNoDeleteProfileSelected = isDisabledPAGeneralNoDeleteProfileSelected,

        getActiveProfile = getPAGeneralActiveProfile,
        setActiveProfile = setPAGeneralActiveProfile,
        getActiveProfileRename = function() return getValue({"name"}) end,
        setActiveProfileRename = setPAGeneralActiveProfileRename,

        createNewProfile = createPAGeneralNewProfile,
        copySelectedProfile = copyPAGeneralSelectedProfile,
        deleteSelectedProfile = deletePAGeneralSelectedProfile,
        getCurrentProfileCount = getPAGeneralCurrentProfileCount,
        hasOnlyOneProfile = hasPAGeneralOnlyOneProfile,
        hasMaxProfileCountReached = hasPAGeneralMaxProfileCountReached,

        getWelcomeMessageSetting = function() return getValue({"welcomeMessage"}) end,
        setWelcomeMessageSetting = function(value) setValue(value, {"welcomeMessage"}) end,

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