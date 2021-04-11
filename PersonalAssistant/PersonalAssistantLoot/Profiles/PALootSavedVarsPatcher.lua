-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _updateSavedVarsVersion(savedVarsVersion)
    local PALSavedVars = PA.SavedVars.Loot
    if tonumber(PALSavedVars.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({ PAC.COLORED_TEXTS.PA, " - Patched PALoot from [", tostring(PALSavedVars.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PALSavedVars.savedVarsVersion = savedVarsVersion
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local PALSavedVars = PA.SavedVars.Loot
    local currentVersion = tonumber(PALSavedVars.savedVarsVersion)
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_11(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PASavedVars = PA.SavedVars
        -- copy the profileCounter value
        PASavedVars.Loot.profileCounter = PASavedVars.General.profileCounter
        -- then loop through all profiles and copy the profileName
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Loot[profileNo]) then
                PASavedVars.Loot[profileNo].name = PASavedVars.General[profileNo].name
            end
        end
        _updateSavedVarsVersion(savedVarsVersion)
    end
end

-- local function _applyPatch_x_x_x(savedVarsVersion)

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()
    -- Patch 2.5.11     tbd, 2021
    _applyPatch_2_5_11(_getIsPatchNeededInfo(020511))
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyPALootPatchIfNeeded = applyPatchIfNeeded