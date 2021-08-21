-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local function _getCurrentSavedVarsVersion()
    local PALSavedVars = PA.SavedVars.Loot
    if PALSavedVars.savedVarsVersion then
        return tonumber(PALSavedVars.savedVarsVersion)
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
        local PALSavedVars = PA.SavedVars.Loot
        PALSavedVars.savedVarsVersion = savedVarsVersion
        PA.Loot.logger:Info(table.concat({"Patched PALoot from [", tostring(currentSavedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local currentVersion = _getCurrentSavedVarsVersion()
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

local function _setLocalProfileCounter(PASavedVars)
    local profileCounter = PASavedVars.General.profileCounter
    PASavedVars.Loot.profileCounter = (type(profileCounter) == 'number' and profileCounter) or 0
end


-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_11(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PASavedVars = PA.SavedVars
        -- copy the profileCounter value
        _setLocalProfileCounter(PASavedVars)
        -- then loop through all profiles
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Loot[profileNo]) then
                -- 1) copy the profileName
                PASavedVars.Loot[profileNo].name = PASavedVars.General[profileNo].name
                -- 2 ) delete the iconPositionGrid
                PASavedVars.Loot[profileNo].ItemIcons.iconPositionGrid = nil
                -- 3) make sure iconXOffsetGrid and iconYOffsetGrid have valid values by resetting to default
                PASavedVars.Loot[profileNo].ItemIcons.iconXOffsetGrid = PA.MenuDefaults.PALoot.ItemIcons.iconXOffsetGrid
                PASavedVars.Loot[profileNo].ItemIcons.iconYOffsetGrid = PA.MenuDefaults.PALoot.ItemIcons.iconYOffsetGrid
                -- 4) rename "iconSizeRow" to "iconSizeList"
                PASavedVars.Loot[profileNo].ItemIcons.iconSizeList = PASavedVars.Loot[profileNo].ItemIcons.iconSizeRow
                PASavedVars.Loot[profileNo].ItemIcons.iconSizeRow = nil
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
PA.SavedVarsPatcher.applyPALootPatchIfNeeded = applyPatchIfNeeded