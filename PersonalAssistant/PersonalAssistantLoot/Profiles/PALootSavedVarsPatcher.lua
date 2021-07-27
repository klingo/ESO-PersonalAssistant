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
    local currentVersion = tonumber(PALSavedVars.savedVarsVersion) or PAC.ADDON.VERSION_ADDON
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