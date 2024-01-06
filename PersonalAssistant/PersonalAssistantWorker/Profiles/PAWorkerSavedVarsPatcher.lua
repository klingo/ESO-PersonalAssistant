-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _updateSavedVarsVersion(savedVarsVersion)
    local PAWSavedVars = PA.SavedVars.Worker
    if tonumber(PARSavedVars.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({ PAC.COLORED_TEXTS.PA, " - Patched PAWorker from [", tostring(PAWSavedVars.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PAWSavedVars.savedVarsVersion = savedVarsVersion
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local PAWSavedVars = PA.SavedVars.Worker
    local currentVersion = tonumber(PAWSavedVars.savedVarsVersion) or PAC.ADDON.VERSION_ADDON
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

local function _setLocalProfileCounter(PASavedVars)
    local profileCounter = PASavedVars.General.profileCounter
    PASavedVars.Worker.profileCounter = (type(profileCounter) == 'number' and profileCounter) or 0
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_11(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PASavedVars = PA.SavedVars
        -- copy the profileCounter value
        _setLocalProfileCounter(PASavedVars)
        -- then loop through all profiles and copy the profileName
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Worker[profileNo]) then
                PASavedVars.Worker[profileNo].name = PASavedVars.General[profileNo].name
            end
        end
        _updateSavedVarsVersion(savedVarsVersion)
    end
end

-- local function _applyPatch_x_x_x(savedVarsVersion, isPatchingNeeded)

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()
    -- Patch 2.5.11     April 23, 2021
    _applyPatch_2_5_11(_getIsPatchNeededInfo(020511))
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyPAWorkerPatchIfNeeded = applyPatchIfNeeded