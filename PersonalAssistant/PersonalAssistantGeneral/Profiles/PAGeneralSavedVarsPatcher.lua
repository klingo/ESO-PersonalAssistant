-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local function _getCurrentSavedVarsVersion()
    local PAGSavedVars = PA.SavedVars.General
    if PAGSavedVars.savedVarsVersion then
        return tonumber(PAGSavedVars.savedVarsVersion)
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
        local PAGSavedVars = PA.SavedVars.General
        PAGSavedVars.savedVarsVersion = savedVarsVersion
        PA.logger:Info(table.concat({ "Patched PAGeneral from [", tostring(currentSavedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local currentVersion = _getCurrentSavedVarsVersion()
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_24(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PAGSavedVars = PA.SavedVars.General
        -- cleanup Debug stuff that was added with 2.5.22
        PAGSavedVars.Debug = nil
        -- cleanup all old profiles
        for profileNo = 1, PAGSavedVars.profileCounter do
            PAGSavedVars[profileNo] = nil
        end
        PAGSavedVars.profileCounter = nil
        _updateSavedVarsVersion(savedVarsVersion)
    end
end

-- local function _applyPatch_x_x_x(savedVarsVersion, isPatchingNeeded)

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()
    -- Patch 2.5.24     tbd
    _applyPatch_2_5_24(_getIsPatchNeededInfo(020524))
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyPAGeneralPatchIfNeeded = applyPatchIfNeeded