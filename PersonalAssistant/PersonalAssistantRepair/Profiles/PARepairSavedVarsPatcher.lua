-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local function _getCurrentSavedVarsVersion()
    local PARSavedVars = PA.SavedVars.Repair
    if PARSavedVars.savedVarsVersion then
        return tonumber(PARSavedVars.savedVarsVersion)
    elseif type(PAC.ADDON.VERSION_ADDON) == "number" then
        -- first time player init
        return PAC.ADDON.VERSION_ADDON
    end
    -- first time local DEV init - return mock
    return PAC.ADDON.VERSION_MOCK
end

local function _updateSavedVarsVersion(savedVarsVersion)
    local currentSavedVarsVersion = _getCurrentSavedVarsVersion()
    if currentSavedVarsVersion < savedVarsVersion then
        local PARSavedVars = PA.SavedVars.Repair
        PARSavedVars.savedVarsVersion = savedVarsVersion
        PA.Repair.logger:Info(table.concat({"Patched PARepair from [", tostring(currentSavedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local currentVersion = _getCurrentSavedVarsVersion()
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

local function _setLocalProfileCounter(PASavedVars)
    local profileCounter = PASavedVars.General.profileCounter
    PASavedVars.Repair.profileCounter = (type(profileCounter) == 'number' and profileCounter) or 0
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_11(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PASavedVars = PA.SavedVars
        -- copy the profileCounter value
        _setLocalProfileCounter(PASavedVars)
        -- then loop through all profiles and copy the profileName
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Repair[profileNo]) then
                PASavedVars.Repair[profileNo].name = PASavedVars.General[profileNo].name
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
PA.SavedVarsPatcher.applyPARepairPatchIfNeeded = applyPatchIfNeeded