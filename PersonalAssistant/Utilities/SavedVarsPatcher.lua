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

    -- Upgrade to v2.1.0
    if prevStoredSavedVarsVersion < 020100 then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - START Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020100]"}))
        -- 1) initialize three new profiles with default values
        local PAMenuDefaults = PA.MenuDefaults
        for profileNo = 6, PAC.GENERAL.MAX_PROFILES do
            if not istable(PASavedVars.General[profileNo]) then
                PASavedVars.Banking[profileNo] = PAMenuDefaults.PABanking
                PASavedVars.Junk[profileNo] = PAMenuDefaults.PAJunk
                PASavedVars.Loot[profileNo] = PAMenuDefaults.PALoot
                PASavedVars.Repair[profileNo] = PAMenuDefaults.PARepair
                PASavedVars.General[profileNo] = {
                    name = PAHF.getDefaultProfileName(profileNo),
                    welcome = true
                }
            end
        end
        for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
            -- 2) initialize:    PABanking.Advanced.ItemTraitTypes
            PASavedVars.Banking[profileNo].Advanced.ItemTraitTypes = PAMenuDefaults.PABanking.Advanced.ItemTraitTypes
            -- 3) initialize:    PABanking.AvA
            PASavedVars.Banking[profileNo].AvA = PA.MenuDefaults.PABanking.AvA
        end
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - FINISH Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020100]"}))
    end

    -- Upgrade to v2.2.0
    if prevStoredSavedVarsVersion < 020200 then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - START Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020200]"}))
        for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
            -- 1) migrate:      PABanking.Advanced.LearnableItemTypes
            PASavedVars.Banking[profileNo].Advanced.LearnableItemTypes = {
                [ITEMTYPE_RACIAL_STYLE_MOTIF] = {
                    Known = PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_RACIAL_STYLE_MOTIF],
                    Unknown = PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_RACIAL_STYLE_MOTIF],
                },
                [ITEMTYPE_RECIPE] = {
                    Known = PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_RECIPE],
                    Unknown = PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_RECIPE],
                }
            }
            -- 2) get rid of:   PABanking.Advanced.ItemTypes
            PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_RACIAL_STYLE_MOTIF] = nil
            PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_RECIPE] = nil
        end
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - FINISH Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020200]"}))
    end

    -- Upgrade to v2.2.2
    if prevStoredSavedVarsVersion < 020202 then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - START Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020202]"}))
        for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
            -- 1) migrate       PABanking.Advanced.MasterWritCraftingTypes
            local masterWritMoveSetting = PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_MASTER_WRIT]
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_INVALID] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_BLACKSMITHING] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_CLOTHIER] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_ENCHANTING] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_ALCHEMY] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_PROVISIONING] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_WOODWORKING] = masterWritMoveSetting
            PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_JEWELRYCRAFTING] = masterWritMoveSetting

            -- 2) get rid of    PABanking.Advanced.ItemTypes[ITEMTYPE_MASTER_WRIT]
            PASavedVars.Banking[profileNo].Advanced.ItemTypes[ITEMTYPE_MASTER_WRIT] = nil
        end
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - FINISH Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020202]"}))
    end


    -- Upgrade to v2.3.0
    if prevStoredSavedVarsVersion < 020300 then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - START Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020300]"}))
        for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
            -- 1) migrate   PABanking.Individual.ItemIds
            local oldItemIdConfigs = PASavedVars.Banking[profileNo].Individual.ItemIds
            for itemId, moveConfig in pairs(oldItemIdConfigs) do
                if istable(moveConfig) then
                    PASavedVars.Banking[profileNo].Individual.ItemIds[itemId].bagAmount = moveConfig.backpackAmount
                    PASavedVars.Banking[profileNo].Individual.ItemIds[itemId].backpackAmount = nil
                end
            end

            -- 2) migrate   PABanking.AvA.CrossAllianceItemIds
            local oldAvACrossAllianceItemIdConfigs = PASavedVars.Banking[profileNo].AvA.CrossAllianceItemIds
            for itemId, moveConfig in pairs(oldAvACrossAllianceItemIdConfigs) do
                if istable(moveConfig) then
                    PASavedVars.Banking[profileNo].AvA.CrossAllianceItemIds[itemId].bagAmount = moveConfig.backpackAmount
                    PASavedVars.Banking[profileNo].AvA.CrossAllianceItemIds[itemId].backpackAmount = nil
                end
            end

            -- 3) migrate   PABanking.AvA.ItemIds
            local oldAvAItemIdConfigs = PASavedVars.Banking[profileNo].AvA.ItemIds
            for itemId, moveConfig in pairs(oldAvAItemIdConfigs) do
                if istable(moveConfig) then
                    PASavedVars.Banking[profileNo].AvA.ItemIds[itemId].bagAmount = moveConfig.backpackAmount
                    PASavedVars.Banking[profileNo].AvA.ItemIds[itemId].backpackAmount = nil
                end
            end
        end
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - FINISH Upgrading SavedVarsVersion from [", tostring(prevStoredSavedVarsVersion), "] to [020300]"}))
    end

    -- in the end, update the savedVarsVersion
    PASavedVars.General.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher = {
    applyPatchIfNeeded = applyPatchIfNeeded
}