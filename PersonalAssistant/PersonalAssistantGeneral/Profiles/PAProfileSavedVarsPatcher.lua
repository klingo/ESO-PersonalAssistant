-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local function _getCurrentSavedVarsVersion()
    local PAPSavedVars = PA.SavedVars.Profile
    if PAPSavedVars.savedVarsVersion then
        return tonumber(PAPSavedVars.savedVarsVersion)
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
        local PAPSavedVars = PA.SavedVars.Profile
        PAPSavedVars.savedVarsVersion = savedVarsVersion
        PA.logger:Info(table.concat({"Patched PAProfile from [", tostring(currentSavedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local currentVersion = _getCurrentSavedVarsVersion()
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_14(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PAPSavedVars = PA.SavedVars.Profile
        local oldActiveProfile = PAPSavedVars.activeProfile
        if oldActiveProfile ~= nil then
            -- copy the previously selected profile
            PAPSavedVars.General.activeProfile = oldActiveProfile
            PAPSavedVars.Banking.activeProfile = oldActiveProfile
            PAPSavedVars.Integration.activeProfile = oldActiveProfile
            PAPSavedVars.Junk.activeProfile = oldActiveProfile
            PAPSavedVars.Loot.activeProfile = oldActiveProfile
            PAPSavedVars.Repair.activeProfile = oldActiveProfile
            -- remove the old activeProfile
            PAPSavedVars.activeProfile = nil
        end
        _updateSavedVarsVersion(savedVarsVersion)
    end
end

local function _applyPatch_2_5_24(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PAPSavedVars = PA.SavedVars.Profile
        -- cleanup old debug flag and language entry
        PAPSavedVars.debug = nil
        PAPSavedVars.language = nil
        -- cleanup old activeProfile for PAGeneral (does not have profiles anymore)
        PAPSavedVars.General.activeProfile = nil
        _updateSavedVarsVersion(savedVarsVersion)
    end
end

-- local function _applyPatch_x_x_x(savedVarsVersion, isPatchingNeeded)

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()
    -- Patch 2.5.14     April 24, 2021
    _applyPatch_2_5_14(_getIsPatchNeededInfo(020514))

    -- Patch 2.5.24     tbd
    _applyPatch_2_5_24(_getIsPatchNeededInfo(020524))
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyPAProfilePatchIfNeeded = applyPatchIfNeeded