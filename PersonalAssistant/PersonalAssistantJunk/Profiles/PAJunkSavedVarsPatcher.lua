-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local function _getCurrentSavedVarsVersion()
    local PAJSavedVars = PA.SavedVars.Junk
    if PAJSavedVars.savedVarsVersion then
        return tonumber(PAJSavedVars.savedVarsVersion)
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
        local PAJSavedVars = PA.SavedVars.Junk
        PAJSavedVars.savedVarsVersion = savedVarsVersion
        PA.Junk.logger:Info(table.concat({"Patched PAJunk from [", tostring(currentSavedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local currentVersion = _getCurrentSavedVarsVersion()
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

local function _setLocalProfileCounter(PASavedVars)
    local profileCounter = PASavedVars.General.profileCounter
    PASavedVars.Junk.profileCounter = (type(profileCounter) == 'number' and profileCounter) or 0
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_11(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PASavedVars = PA.SavedVars
        -- copy the profileCounter value
        _setLocalProfileCounter(PASavedVars)
        -- then loop through all profiles and copy the profileName
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Junk[profileNo]) then
                -- 1) Copy profile name
                PASavedVars.Junk[profileNo].name = PASavedVars.General[profileNo].name
                -- 2) Migrate 'destroyWorthlessJunk' to 'destroyJunk'
                PASavedVars.Junk[profileNo].AutoDestroy.destroyJunk = PASavedVars.Junk[profileNo].AutoDestroy.destroyWorthlessJunk
                PASavedVars.Junk[profileNo].AutoDestroy.destroyWorthlessJunk = nil
                -- 3) Migrate Stolen section
                PASavedVars.Junk[profileNo].Stolen.weapons = (PASavedVars.Junk[profileNo].Stolen.Weapons.action ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.Weapons = nil
                PASavedVars.Junk[profileNo].Stolen.apparels = (PASavedVars.Junk[profileNo].Stolen.Armor.action ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.Armor = nil
                PASavedVars.Junk[profileNo].Stolen.jewelries = (PASavedVars.Junk[profileNo].Stolen.Jewelry.action ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.Jewelry = nil
                PASavedVars.Junk[profileNo].Stolen.trash = (PASavedVars.Junk[profileNo].Stolen.trashAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.trashAction = nil
                PASavedVars.Junk[profileNo].Stolen.styleMaterials = (PASavedVars.Junk[profileNo].Stolen.styleMaterialAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.styleMaterialAction = nil
                PASavedVars.Junk[profileNo].Stolen.traitItems = (PASavedVars.Junk[profileNo].Stolen.traitItemAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.traitItemAction = nil
                PASavedVars.Junk[profileNo].Stolen.lures = (PASavedVars.Junk[profileNo].Stolen.lureAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.lureAction = nil
                PASavedVars.Junk[profileNo].Stolen.ingredients = (PASavedVars.Junk[profileNo].Stolen.ingredientAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.ingredientAction = nil
                PASavedVars.Junk[profileNo].Stolen.food = (PASavedVars.Junk[profileNo].Stolen.foodAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.foodAction = nil
                PASavedVars.Junk[profileNo].Stolen.drinks = (PASavedVars.Junk[profileNo].Stolen.drinkAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.drinkAction = nil
                PASavedVars.Junk[profileNo].Stolen.solvents = (PASavedVars.Junk[profileNo].Stolen.solventAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.solventAction = nil
                PASavedVars.Junk[profileNo].Stolen.treasures = (PASavedVars.Junk[profileNo].Stolen.treasureAction ~= PAC.ITEM_ACTION.NOTHING)
                PASavedVars.Junk[profileNo].Stolen.treasureAction = nil
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
PA.SavedVarsPatcher.applyPAJunkPatchIfNeeded = applyPatchIfNeeded