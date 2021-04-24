-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function _updateSavedVarsVersion(savedVarsVersion, patchPAG, patchPAB, patchPAI, patchPAJ, patchPAL, patchPAR)
    local PASavedVars = PA.SavedVars
    if patchPAG and tonumber(PASavedVars.General.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Patched PAGeneral from [", tostring(PASavedVars.General.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PASavedVars.General.savedVarsVersion = savedVarsVersion
    end
    if patchPAB and tonumber(PASavedVars.Banking.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Patched PABanking from [", tostring(PASavedVars.Banking.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PASavedVars.Banking.savedVarsVersion = savedVarsVersion
    end
    if patchPAI and tonumber(PASavedVars.Integration.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Patched PAIntegration from [", tostring(PASavedVars.Integration.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PASavedVars.Integration.savedVarsVersion = savedVarsVersion
    end
    if patchPAJ and tonumber(PASavedVars.Junk.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Patched PAJunk from [", tostring(PASavedVars.Junk.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PASavedVars.Junk.savedVarsVersion = savedVarsVersion
    end
    if patchPAL and tonumber(PASavedVars.Loot.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Patched PALoot from [", tostring(PASavedVars.Loot.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PASavedVars.Loot.savedVarsVersion = savedVarsVersion
    end
    if patchPAR and tonumber(PASavedVars.Repair.savedVarsVersion) < savedVarsVersion then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Patched PARepair from [", tostring(PASavedVars.Repair.savedVarsVersion), "] to [", tostring(savedVarsVersion), "]"}))
        PASavedVars.Repair.savedVarsVersion = savedVarsVersion
    end
end

local function _getActiveAddonSavedVarsVersion()
    local PASavedVars = PA.SavedVars
    local PAGversion, PABversion, PAIVersion, PAJversion, PALversion, PARversion
    if PASavedVars.General then PAGversion = tonumber(PASavedVars.General.savedVarsVersion) end
    if PASavedVars.Banking then PABversion = tonumber(PASavedVars.Banking.savedVarsVersion) end
    if PASavedVars.Integration then PAIVersion = tonumber(PASavedVars.Integration.savedVarsVersion) end
    if PASavedVars.Junk then PAJversion = tonumber(PASavedVars.Junk.savedVarsVersion) end
    if PASavedVars.Loot then PALversion = tonumber(PASavedVars.Loot.savedVarsVersion) end
    if PASavedVars.Repair then PARversion = tonumber(PASavedVars.Repair.savedVarsVersion) end
    return PAGversion, PABversion, PAIVersion, PAJversion, PALversion, PARversion
end

local function _getIsPatchNeededInfo(targetSVV)
    local PAGv, PABv, PAIv, PAJv, PALv, PARv = _getActiveAddonSavedVarsVersion()
    return targetSVV, (PAGv and PAGv < targetSVV), (PABv and PABv < targetSVV), (PAIv and PAIv < targetSVV), (PAJv and PAJv < targetSVV), (PALv and PALv < targetSVV), (PARv and PARv < targetSVV)
end

local function _resetSavedVarsVersionIfMissingTo(targetSVV)
    local PASavedVars = PA.SavedVars
    if PASavedVars.General and PASavedVars.General.savedVarsVersion == nil then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Reset PAGeneral from [nil] to [", tostring(targetSVV), "]"}))
        PASavedVars.General.savedVarsVersion = targetSVV
    end
    if PASavedVars.Banking and PASavedVars.Banking.savedVarsVersion == nil then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Reset PABanking from [nil] to [", tostring(targetSVV), "]"}))
        PASavedVars.Banking.savedVarsVersion = targetSVV
    end
    if PASavedVars.Integration and PASavedVars.Integration.savedVarsVersion == nil then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Reset PAIntegration from [nil] to [", tostring(targetSVV), "]"}))
        PASavedVars.Integration.savedVarsVersion = targetSVV
    end
    if PASavedVars.Junk and PASavedVars.Junk.savedVarsVersion == nil then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Reset PAJunk from [nil] to [", tostring(targetSVV), "]"}))
        PASavedVars.Junk.savedVarsVersion = targetSVV
    end
    if PASavedVars.Loot and PASavedVars.Loot.savedVarsVersion == nil then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Reset PALoot from [nil] to [", tostring(targetSVV), "]"}))
        PASavedVars.Loot.savedVarsVersion = targetSVV
    end
    if PASavedVars.Repair and PASavedVars.Repair.savedVarsVersion == nil then
        PAHF.debuglnAuthor(table.concat({PAC.COLORED_TEXTS.PA, " - Reset PARepair from [nil] to [", tostring(targetSVV), "]"}))
        PASavedVars.Repair.savedVarsVersion = targetSVV
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _applyPatch_2_0_3(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 5 do
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
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
end


local function _applyPatch_2_1_0(savedVarsVersion, patchPAG, patchPAB, _, patchPAJ, patchPAL, patchPAR)
    if patchPAG or patchPAB or patchPAJ or patchPAL or patchPAR then
        local PASavedVars = PA.SavedVars
        -- 1) initialize three new profiles with default values
        local PAMenuDefaults = PA.MenuDefaults
        for profileNo = 6, 8 do
            if not istable(PASavedVars.General[profileNo]) then
                if patchPAB then PASavedVars.Banking[profileNo] = PAMenuDefaults.PABanking end
                if patchPAJ then PASavedVars.Junk[profileNo] = PAMenuDefaults.PAJunk end
                if patchPAL then PASavedVars.Loot[profileNo] = PAMenuDefaults.PALoot end
                if patchPAR then PASavedVars.Repair[profileNo] = PAMenuDefaults.PARepair end
                if patchPAG then
                    PASavedVars.General[profileNo] = {
                        name = PAHF.getDefaultProfileName(profileNo),
                        welcome = true
                    }
                end
            end
        end
        if patchPAB then
            for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
                -- 2) initialize:    PABanking.Advanced.ItemTraitTypes
                PASavedVars.Banking[profileNo].Advanced.ItemTraitTypes = PAMenuDefaults.PABanking.Advanced.ItemTraitTypes
                -- 3) initialize:    PABanking.AvA
                PASavedVars.Banking[profileNo].AvA = PA.MenuDefaults.PABanking.AvA
            end
        end
        _updateSavedVarsVersion(savedVarsVersion, patchPAG, patchPAB, false, patchPAJ, patchPAL, patchPAR)
    end
end


local function _applyPatch_2_2_0(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
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
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
end


local function _applyPatch_2_2_2(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
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
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
end


local function _applyPatch_2_3_0(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
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
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
end


local function _applyPatch_2_4_0(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 1) migrate   PABanking.Individual.ItemIds
            local oldItemIdConfigs = PASavedVars.Banking[profileNo].Individual.ItemIds
            for itemId, moveConfig in pairs(oldItemIdConfigs) do
                if istable(moveConfig) then
                    -- only migrate if the item had a rule defined (and if e.g. generics had a bagAmount)
                    if moveConfig.operator ~= PAC.OPERATOR.NONE and moveConfig.bagAmount then
                        PASavedVars.Banking[profileNo].Custom.ItemIds[itemId] = {
                            bagAmount = moveConfig.bagAmount,
                            itemLink = table.concat({"|H0:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"}),
                            operator = moveConfig.operator,
                        }
                    end
                end
            end

            -- 2) get rid of    PABanking.Individual
            PASavedVars.Banking[profileNo].Individual = nil

            -- 3) if enabled, refresh the list
            if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
        end
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
end


local function _applyPatch_2_4_2(savedVarsVersion, _, patchPAB, _, patchPAJ,  _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 1) migrate   PABanking.lazyWritCraftingCompatiblity (if PAIntegration is enabled)
            if PA.Integration then
                PASavedVars.Integration[profileNo].LazyWritCrafter.compatibility = PASavedVars.Banking[profileNo].lazyWritCraftingCompatiblity
            end

            -- 2) get rid of    PABanking.lazyWritCraftingCompatiblity
            PASavedVars.Banking[profileNo].lazyWritCraftingCompatiblity = nil
        end
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
    if patchPAJ then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 1) migrate:      PAJunk.KeyBindings.showMarkUnmarkAsJunkKeybind
            PASavedVars.Junk[profileNo].KeyBindings.enableMarkUnmarkAsJunkKeybind = PASavedVars.Junk[profileNo].KeyBindings.showMarkUnmarkAsJunkKeybind
            -- 2) migrate:      PAJunk.KeyBindings.showDestroyItemKeybind
            PASavedVars.Junk[profileNo].KeyBindings.enableDestroyItemKeybind = PASavedVars.Junk[profileNo].KeyBindings.showDestroyItemKeybind
        end
        _updateSavedVarsVersion(savedVarsVersion, false, false, false, patchPAJ, false, false)
    end
end


local function _applyPatch_2_4_4(savedVarsVersion, _, _, _, patchPAJ, _, _)
    if patchPAJ then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 0) bug-fix:      PAJunk.Stolen
            if not PASavedVars.Junk[profileNo].Stolen.Treasure then PASavedVars.Junk[profileNo].Stolen.Treasure = {} end

            -- 1) migrate:      PAJunk.Miscellaneous.autoMarkTreasure
            -- As of Version 2.5.11, this needs to be skipped because "PAC.ITEM_ACTION" was decommissioned

            -- 2) migrate:      PAJunk.Miscellaneous.excludeAMatterOfLeisure
            PASavedVars.Junk[profileNo].Stolen.Treasure.excludeAMatterOfLeisure = PASavedVars.Junk[profileNo].Miscellaneous.excludeAMatterOfLeisure

            -- 3) migrate:      PAJunk.Miscellaneous.excludeAMatterOfRespect
            PASavedVars.Junk[profileNo].Stolen.Treasure.excludeAMatterOfRespect = PASavedVars.Junk[profileNo].Miscellaneous.excludeAMatterOfRespect

            -- 4) migrate:      PAJunk.Miscellaneous.excludeAMatterOfTributes
            PASavedVars.Junk[profileNo].Stolen.Treasure.excludeAMatterOfTributes = PASavedVars.Junk[profileNo].Miscellaneous.excludeAMatterOfTributes

            -- 5) cleanup everything
            PASavedVars.Junk[profileNo].Miscellaneous.autoMarkTreasure = nil
            PASavedVars.Junk[profileNo].Miscellaneous.excludeAMatterOfLeisure = nil
            PASavedVars.Junk[profileNo].Miscellaneous.excludeAMatterOfRespect = nil
            PASavedVars.Junk[profileNo].Miscellaneous.excludeAMatterOfTributes = nil
        end
        _updateSavedVarsVersion(savedVarsVersion, false, false, false, patchPAJ, false, false)
    end
end


local function _applyPatch_2_4_6(savedVarsVersion, _, _, _, patchPAJ, _, _)
    if patchPAJ then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 1) migrate:      PASavedVars.Junk[profileNo].Stolen.Treasure.action
            -- As of Version 2.5.11, this needs to be skipped because "PAC.ITEM_ACTION" was decommissioned
            PASavedVars.Junk[profileNo].Stolen.treasureAction = PASavedVars.Junk[profileNo].Stolen.Treasure.action

            -- 2) migrate:      PAJunk.Trash.excludeNibblesAndBits
            PASavedVars.Junk[profileNo].QuestProtection.ClockworkCity.excludeNibblesAndBits = PASavedVars.Junk[profileNo].Trash.excludeNibblesAndBits

            -- 3) migrate:      PAJunk.Trash.excludeMorselsAndPecks
            PASavedVars.Junk[profileNo].QuestProtection.ClockworkCity.excludeMorselsAndPecks = PASavedVars.Junk[profileNo].Trash.excludeMorselsAndPecks

            -- 4) migrate:      PAJunk.Stolen.Treasure.excludeAMatterOfLeisure
            PASavedVars.Junk[profileNo].QuestProtection.ClockworkCity.excludeAMatterOfLeisure = PASavedVars.Junk[profileNo].Stolen.Treasure.excludeAMatterOfLeisure

            -- 5) migrate:      PAJunk.Stolen.Treasure.excludeAMatterOfRespect
            PASavedVars.Junk[profileNo].QuestProtection.ClockworkCity.excludeAMatterOfRespect = PASavedVars.Junk[profileNo].Stolen.Treasure.excludeAMatterOfRespect

            -- 6) migrate:      PAJunk.Stolen.Treasure.excludeAMatterOfTributes
            PASavedVars.Junk[profileNo].QuestProtection.ClockworkCity.excludeAMatterOfTributes = PASavedVars.Junk[profileNo].Stolen.Treasure.excludeAMatterOfTributes

            -- 7) cleanup everything
            PASavedVars.Junk[profileNo].Trash.excludeNibblesAndBits = nil
            PASavedVars.Junk[profileNo].Trash.excludeMorselsAndPecks = nil
            PASavedVars.Junk[profileNo].Stolen.Treasure = nil
        end
        _updateSavedVarsVersion(savedVarsVersion, false, false, false, patchPAJ, false, false)
    end
end


local function _applyPatch_2_4_9(savedVarsVersion, patchPAG, _, _, _, _, _)
    if patchPAG then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 1) get rid of    PAGeneral.welcome
            PASavedVars.General[profileNo].welcome = nil
        end
        _updateSavedVarsVersion(savedVarsVersion, patchPAG, false, false, false, false, false)
    end
end


local function _applyPatch_2_4_13(savedVarsVersion, _, _, _, _, patchPAL, _)
    -- As of Version 2.5.11, this needs to be skipped because "iconPositionGrid" was decommissioned
end


local function _applyPatch_2_4_14(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 8 do
            -- 1) patch      PABanking.Custom.ItemIds.ruleEnabled
            local customItemIds = PASavedVars.Banking[profileNo].Custom.ItemIds

            for itemId, _ in pairs(customItemIds) do
                if PASavedVars.Banking[profileNo].Custom.ItemIds[itemId].ruleEnabled == nil then
                    PASavedVars.Banking[profileNo].Custom.ItemIds[itemId].ruleEnabled = true
                end
            end
        end

        -- also refresh the PABankingRulesList with the updated values
        PAEM.FireCallbacks("PersonalAssistant", EVENT_ADD_ON_LOADED, "InitPABankingRulesList")
--        _updateSavedVarsVersion(savedVarsVersion, patchPAG, patchPAB, patchPAI, patchPAJ, patchPAL, patchPAR)
        _updateSavedVarsVersion(savedVarsVersion, false, patchPAB, false, false, false, false)
    end
end


local function _applyPatch_2_4_18(savedVarsVersion, patchPAG, patchPAB, patchPAI, patchPAJ, patchPAL, patchPAR)
    if patchPAG or patchPAB or patchPAI or patchPAJ or patchPAL or patchPAR then
        local PASavedVars = PA.SavedVars
        -- 1) initialize two new profiles with default values
        local PAMenuDefaults = PA.MenuDefaults
        for profileNo = 9, 10 do
            if not istable(PASavedVars.General[profileNo]) then
                if patchPAB then PASavedVars.Banking[profileNo] = PAMenuDefaults.PABanking end
                if patchPAI then PASavedVars.Integration[profileNo] = PAMenuDefaults.PAIntegration end
                if patchPAJ then PASavedVars.Junk[profileNo] = PAMenuDefaults.PAJunk end
                if patchPAL then PASavedVars.Loot[profileNo] = PAMenuDefaults.PALoot end
                if patchPAR then PASavedVars.Repair[profileNo] = PAMenuDefaults.PARepair end
                if patchPAG then
                    PASavedVars.General[profileNo] = {
                        name = PAHF.getDefaultProfileName(profileNo),
                        welcome = true
                    }
                end
            end
        end
        _updateSavedVarsVersion(savedVarsVersion, patchPAG, patchPAB, patchPAI, patchPAJ, patchPAL, patchPAR)
    end
end


local function _applyPatch_2_4_19(savedVarsVersion, _, patchPAB, _, patchPAJ, _, _)
    if patchPAB and PA.Banking then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 10 do
            -- 1) migrate   PABanking.Custom.ItemIds
            local oldItemIdConfigs = PASavedVars.Banking[profileNo].Custom.ItemIds
            if PASavedVars.Banking[profileNo].Custom.PAItemIds == nil then
                PASavedVars.Banking[profileNo].Custom.PAItemIds = {}
            end
            if oldItemIdConfigs ~= nil then -- in case player did not had 10 profiles?
                for itemId, moveConfig in pairs(oldItemIdConfigs) do
                    if istable(moveConfig) then
                        local paItemId = PAHF.getPAItemLinkIdentifier(moveConfig.itemLink)
                        PASavedVars.Banking[profileNo].Custom.PAItemIds[paItemId] = moveConfig
                    end
                end
                PASavedVars.Banking[profileNo].Custom.ItemIds = nil
            end

            -- 2) if enabled, refresh the list
            if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
        end
        _updateSavedVarsVersion(savedVarsVersion, nil, patchPAB, nil, nil, nil, nil)
    end

    if patchPAJ and PA.Junk then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, 10 do
            -- 1) migrate   PAJunk.Custom.ItemIds
            local oldItemIdConfigs = PASavedVars.Junk[profileNo].Custom.ItemIds
            if PASavedVars.Junk[profileNo].Custom.PAItemIds == nil then
                PASavedVars.Junk[profileNo].Custom.PAItemIds = {}
            end
            if oldItemIdConfigs ~= nil then -- in case player did not had 10 profiles?
                for itemId, moveConfig in pairs(oldItemIdConfigs) do
                    if istable(moveConfig) then
                        local paItemId = PAHF.getPAItemLinkIdentifier(moveConfig.itemLink)
                        PASavedVars.Junk[profileNo].Custom.PAItemIds[paItemId] = moveConfig
                    end
                end
                PASavedVars.Junk[profileNo].Custom.ItemIds = nil
            end

            -- 2) if enabled, refresh the list
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        end
        _updateSavedVarsVersion(savedVarsVersion, nil, nil, nil, patchPAJ, nil, nil)
    end
end


local function _applyPatch_2_5_0(savedVarsVersion, patchPAG, _, _, _, _, _)
    if patchPAG and PA then
        local PASavedVars = PA.SavedVars
        PASavedVars.General.profileCounter = 10
        _updateSavedVarsVersion(savedVarsVersion, patchPAG, nil, nil, nil, nil, nil)
    end
end

local function _applyPatch_2_5_1(savedVarsVersion, _, _, _, patchPAJ, _, _)
    if patchPAJ and PA.Junk then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Junk[profileNo]) then
                PASavedVars.Junk[profileNo].ignoreCraftedItems = true
                -- As of Version 2.5.11, this needs to be skipped because "PAC.ITEM_ACTION" was decommissioned
            end
        end
        _updateSavedVarsVersion(savedVarsVersion, nil, nil, nil, patchPAJ, nil, nil)
    end
end

local function _applyPatch_2_5_4(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB and PA.Banking then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Banking[profileNo]) then
                -- 1) Migrate Survey Reports
                local currSurveySetting = PASavedVars.Banking[profileNo].Advanced.SpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT]
                PASavedVars.Banking[profileNo].Advanced.SpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT] = {
                    [ITEMFILTERTYPE_BLACKSMITHING] = currSurveySetting,
                    [ITEMFILTERTYPE_CLOTHING] = currSurveySetting,
                    [ITEMFILTERTYPE_ENCHANTING] = currSurveySetting,
                    [ITEMFILTERTYPE_ALCHEMY] = currSurveySetting,
                    [ITEMFILTERTYPE_WOODWORKING] = currSurveySetting,
                    [ITEMFILTERTYPE_JEWELRYCRAFTING] = currSurveySetting
                }
                -- 2) Initialize autoExecuteItemTransfers
                PASavedVars.Banking[profileNo].autoExecuteItemTransfers = true

                -- 3) Initialize Advanced.HolidayWrits
                PASavedVars.Banking[profileNo].Advanced.HolidayWrits = {
                    [SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT] = PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_INVALID]
                }

                -- 4) Reset CRAFTING_TYPE_INVALID (was formerly used for holiday writs)
                PASavedVars.Banking[profileNo].Advanced.MasterWritCraftingTypes[CRAFTING_TYPE_INVALID] = nil
            end
        end
        _updateSavedVarsVersion(savedVarsVersion, nil, patchPAB, nil, nil, nil, nil)
    end
end

local function _applyPatch_2_5_5(savedVarsVersion, _, patchPAB, _, _, _, _)
    if patchPAB and PA.Banking then
        local PASavedVars = PA.SavedVars
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Banking[profileNo]) then
                -- 1) Make sure Advanced.HolidayWrits is properly initialized!
                if not istable(PASavedVars.Banking[profileNo].Advanced.HolidayWrits) then
                    PASavedVars.Banking[profileNo].Advanced.HolidayWrits = {
                        [SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT] = PAC.MOVE.IGNORE,
                    }
                elseif PASavedVars.Banking[profileNo].Advanced.HolidayWrits[SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT] == nil then
                    PASavedVars.Banking[profileNo].Advanced.HolidayWrits[SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT] = PAC.MOVE.IGNORE
                end
            end
        end
        _updateSavedVarsVersion(savedVarsVersion, nil, patchPAB, nil, nil, nil, nil)
    end
end

-- local function _applyPatch_x_x_x(savedVarsVersion, patchPAG, patchPAB, patchPAI, patchPAJ, patchPAL, patchPAR)
local function _applyPatch_2_5_10(savedVarsVersion, _, _, _, patchPAJ, _, _)
    if patchPAJ and PA.Junk then
        local PASavedVars = PA.SavedVars
        local PAMenuDefaults = PA.MenuDefaults
        for profileNo = 1, PASavedVars.General.profileCounter do
            if istable(PASavedVars.Junk[profileNo]) then
                -- 1) Make sure Miscellaneous.autoMarkGlyphQualityThreshold is numeric!
                if not (tonumber(PASavedVars.Junk[profileNo].Miscellaneous.autoMarkGlyphQualityThreshold)) then
                    PASavedVars.Junk[profileNo].Miscellaneous.autoMarkGlyphQualityThreshold = PAMenuDefaults.PAJunk.Miscellaneous.autoMarkGlyphQualityThreshold
                end
                -- 2) Make sure KeyBindings are properly updated!
                PASavedVars.Junk[profileNo].KeyBindings.enableMarkUnmarkAsPermJunkKeybind = true
                PASavedVars.Junk[profileNo].KeyBindings.showMarkUnmarkAsPermJunkKeybind = true
            end
        end
        _updateSavedVarsVersion(savedVarsVersion, nil, nil, nil, patchPAJ, nil, nil)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function applyLegacyPatchIfNeeded()
    -- first unregister the event again
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED, "SavedVarsPatcher")

    -- Patch 2.0.3      April 24, 2019
    _applyPatch_2_0_3(_getIsPatchNeededInfo(020003))

    -- Patch 2.1.0      April 28, 2019
    _applyPatch_2_1_0(_getIsPatchNeededInfo(020100))

    -- Patch 2.2.0      May 09, 2019
    _applyPatch_2_2_0(_getIsPatchNeededInfo(020200))

    -- Patch 2.2.2      May 17, 2019
    _applyPatch_2_2_2(_getIsPatchNeededInfo(020202))

    -- Patch 2.3.0      May 19, 2019
    _applyPatch_2_3_0(_getIsPatchNeededInfo(020300))

    -- Patch 2.4.0      June 30, 2019
    _applyPatch_2_4_0(_getIsPatchNeededInfo(020400))

    -- Patch 2.4.2      July 13, 2019
    _applyPatch_2_4_2(_getIsPatchNeededInfo(020402))

    -- Patch 2.4.4      July 16, 2019
    _applyPatch_2_4_4(_getIsPatchNeededInfo(020404))

    -- Patch 2.4.6      July 25, 2019
    _applyPatch_2_4_6(_getIsPatchNeededInfo(020406))

    -- Patch 2.4.9      August 09, 2019
    _applyPatch_2_4_9(_getIsPatchNeededInfo(020409))

    -- Patch 2.4.13     December 18, 2019
    _applyPatch_2_4_13(_getIsPatchNeededInfo(020413))

    -- Patch 2.4.14     December 19, 2019
    _applyPatch_2_4_14(_getIsPatchNeededInfo(020414))

    -- Patch 2.4.18     February 24, 2020
    _applyPatch_2_4_18(_getIsPatchNeededInfo(020418))

    -- Patch 2.4.19     May 26, 2020
    _applyPatch_2_4_19(_getIsPatchNeededInfo(020419))

    -- Patch 2.5.0      October 03, 2020
    _applyPatch_2_5_0(_getIsPatchNeededInfo(020500))

    -- Patch 2.5.1      October 12, 2020
    _applyPatch_2_5_1(_getIsPatchNeededInfo(020501))

    -- ensure all SavedVars are set and existing before running subsequent patch to 2.5.4
    _resetSavedVarsVersionIfMissingTo(020501)

    -- Patch 2.5.4      October 31, 2020
    _applyPatch_2_5_4(_getIsPatchNeededInfo(020504))

    -- Patch 2.5.5      October 31, 2020
    _applyPatch_2_5_5(_getIsPatchNeededInfo(020505))

    -- Patch 2.5.10     March 18, 2021
    _applyPatch_2_5_10(_getIsPatchNeededInfo(020510))
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.SavedVarsPatcher.applyLegacyPatchIfNeeded = applyLegacyPatchIfNeeded