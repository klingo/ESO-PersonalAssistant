-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _updateSavedVarsVersion(savedVarsVersion)
    local PAJSavedVars = PA.SavedVars.Junk
    if tonumber(PAJSavedVars.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({ PAC.COLORED_TEXTS.PA, " - Patched PAJunk from [", tostring(PAJSavedVars.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PAJSavedVars.savedVarsVersion = savedVarsVersion
    end
end

local function _getIsPatchNeededInfo(savedVarsVersion)
    local PAJSavedVars = PA.SavedVars.Junk
    local currentVersion = tonumber(PAJSavedVars.savedVarsVersion)
    return savedVarsVersion, (currentVersion < savedVarsVersion)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_5_11(savedVarsVersion, isPatchingNeeded)
    if isPatchingNeeded then
        local PASavedVars = PA.SavedVars
        -- copy the profileCounter value
        PASavedVars.Junk.profileCounter = PASavedVars.General.profileCounter
        -- then loop through all profiles and copy the profileName
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Junk[profileNo]) then
                -- 1) Copy profile name
                PASavedVars.Junk[profileNo].name = PASavedVars.General[profileNo].name
                -- 2) Remove permanent PAJunk rules for items that cannot be sold
                local PAJCustomPAItemIds = PASavedVars.Junk[profileNo].Custom.PAItemIds
                for _, junkConfig in pairs(PAJCustomPAItemIds) do
                    local itemLink = junkConfig.itemLink
                    local sellInformation = GetItemLinkSellInformation(itemLink)
                    if sellInformation == ITEM_SELL_INFORMATION_CANNOT_SELL then
                        -- remove from permanent junk
                        PA.Junk.Custom.removeItemLinkFromPermanentJunk(itemLink)
                    end
                end
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
PA.SavedVarsPatcher.applyPAJunkPatchIfNeeded = applyPatchIfNeeded