-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _updateSavedVarsVersion(savedVarsVersion)
    local PAGSavedVars = PA.SavedVars.General
    if tonumber(PAGSavedVars.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({ PAC.COLORED_TEXTS.PA, " - Patched PAGeneral from [", tostring(PAGSavedVars.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PAGSavedVars.savedVarsVersion = savedVarsVersion
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local PAGSavedVars = PA.SavedVars.General
    local currentVersion = tonumber(PAGSavedVars.savedVarsVersion) or PAC.ADDON.VERSION_ADDON
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

local function _setLocalProfileCounter(PASavedVars)
    local profileCounter = PASavedVars.General.profileCounter
    PASavedVars.General.profileCounter = (type(profileCounter) == 'number' and profileCounter) or 0
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_14(savedVarsVersion, isPatchingNeeded)
    -- always run this because we never know when all profiles got migrated :-(
    local PASavedVars = PA.SavedVars
    local oldActiveProfile = PASavedVars.Profile.activeProfile
    if oldActiveProfile ~= nil then
        -- copy the previously selected profile
        PASavedVars.Profile.General.activeProfile = oldActiveProfile
        PASavedVars.Profile.Banking.activeProfile = oldActiveProfile
        PASavedVars.Profile.Integration.activeProfile = oldActiveProfile
        PASavedVars.Profile.Junk.activeProfile = oldActiveProfile
        PASavedVars.Profile.Loot.activeProfile = oldActiveProfile
        PASavedVars.Profile.Repair.activeProfile = oldActiveProfile
        -- remove the old activeProfile
        PASavedVars.Profile.activeProfile = nil
    end
    -- cannot do "_updateSavedVarsVersion", because this needs to run for every character!
end

-- local function _applyPatch_x_x_x(savedVarsVersion, isPatchingNeeded)

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()
    -- Patch 2.5.14     April 24, 2021
    _applyPatch_2_5_14(_getIsPatchNeededInfo(020514))
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyPAGeneralPatchIfNeeded = applyPatchIfNeeded