-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function applyPatchIfNeeded()
    -- first unregister the event again
    PAEM.UnregisterForEvent(PACAddon.NAME_RAW.GENERAL, EVENT_PLAYER_ACTIVATED, "SavedVarsPatcher")

    -- then get stored savedVarsVersion for comparison
    local PASavedVars = PA.SavedVars
    local prevStoredSavedVarsVersion = tonumber(PASavedVars.General.savedVarsVersion)

    -- Upgrade to v2.0.3
    if prevStoredSavedVarsVersion >= 020000 and prevStoredSavedVarsVersion < 020003 then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - START Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020003]"}))
        for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
            -- 1) get rid of:   PABanking.transactionInterval
            PASavedVars.Banking[profileNo].transactionInterval = nil
            -- 2) get rid of:   PABanking.Crafting.TransactionSettings
            PASavedVars.Banking[profileNo].Crafting.TransactionSettings = nil
            -- 3) migrate:      PABanking.Crafting.ItemTypes
            local oldItemTypes = PASavedVars.Banking[profileNo].Crafting.ItemTypes
            for itemTypeId, moveConfig in pairs(oldItemTypes) do
                if istable(moveConfig) then
                    PASavedVars.Banking[profileNo].Crafting.ItemTypes[itemTypeId] = moveConfig.moveMode
                end
            end
        end
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - FINISH Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020003]"}))
    end

    -- in the end, update the savedVarsVersion
    PASavedVars.General.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher = {
    applyPatchIfNeeded = applyPatchIfNeeded
}