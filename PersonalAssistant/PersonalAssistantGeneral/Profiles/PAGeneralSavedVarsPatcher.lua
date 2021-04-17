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
    local currentVersion = tonumber(PAGSavedVars.savedVarsVersion)
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

-- ---------------------------------------------------------------------------------------------------------------------

-- local function _applyPatch_x_x_x(savedVarsVersion)

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()

end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyPAGeneralPatchIfNeeded = applyPatchIfNeeded