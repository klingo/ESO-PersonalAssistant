-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults
local PAMenuChoices = PA.MenuChoices
local L = PA.Localization

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
    type = "panel",
    name = "PersonalAssistant",
    displayName = L.MMenu_Title,
    author = "Klingo",
    version = PA.AddonVersion,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pa",
    registerForRefresh = true,
    registerForDefaults = true,
}

local optionsTable = setmetatable({}, { __index = table })

local PABCurrencyGoldSubmenuTable = setmetatable({}, { __index = table })
local PABCurrencyAlliancePointsSubmenuTable = setmetatable({}, { __index = table })
local PABCurrencyTelVarSubmenuTable = setmetatable({}, { __index = table })
local PABCurrencyWritVouchersSubmenuTable = setmetatable({}, { __index = table })

local PABCraftingBlacksmithingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingClothingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingWoodworkingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingJewelcraftingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingAlchemySubmenuTable = setmetatable({}, { __index = table })
local PABCraftingEnchantingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingProvisioningSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingStyleMaterialsSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingTraitItemsSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingFurnishingSubmenuTable = setmetatable({}, { __index = table })

local PABAdvancedMotifSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedRecipeSubmenuTable = setmetatable({}, { __index = table })

local PABAdvancedGlyphsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedLiquidsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedTrophiesSubmenuTable = setmetatable({}, { __index = table })

local PABIndividualLockpickSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualSoulGemSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualGenericSubmenuTable = setmetatable({}, { __index = table })

local PALHarvestableItemSubmenuTable = setmetatable({}, { __index = table })
local PALLootableItemSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function createPAGeneralMenu()
    optionsTable:insert({
        type = "header",
        name = L.PAGMenu_Header
    })

    optionsTable:insert({
        type = "dropdown",
        name = L.PAGMenu_ActiveProfile,
        tooltip = L.PAGMenu_ActiveProfile_T,
        choices = PAMenuHelper.getProfileList(),
        choicesValues = PAMenuHelper.getProfileListValues(),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfile,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfile,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN",
    })

    optionsTable:insert({
        type = "editbox",
        name = L.PAGMenu_ActiveProfileRename,
        tooltip = L.PAGMenu_ActiveProfileRename_T,
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfileRename,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfileRename,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PAGMenu_Welcome,
        tooltip = L.PAGMenu_Welcome_T,
        getFunc = PAMenuFunctions.PAGeneral.getWelcomeMessageSetting,
        setFunc = PAMenuFunctions.PAGeneral.setWelcomeMessageSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAGeneral.welcomeMessage,
    })
end

local function createPARepairMenu()
    optionsTable:insert({
        type = "header",
        name = L.PARMenu_Header
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PARMenu_Enable,
        tooltip = L.PARMenu_Enable_T,
        getFunc = PAMenuFunctions.PARepair.isEnabled,
        setFunc = PAMenuFunctions.PARepair.setIsEnabled,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PARepair.enabled,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PARMenu_RepairWornGold,
        tooltip = L.PARMenu_RepairWornGold_T,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairEquippedSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairEquippedSetting,
        disabled = PAMenuFunctions.PARepair.isRepairEquippedDisabled,
        default = PAMenuDefaults.PARepair.repairEquipped,
    })

    optionsTable:insert({
        type = "slider",
        name = L.PARMenu_RepairWornGoldDura,
        tooltip = L.PARMenu_RepairWornGoldDura_T,
        min = 0,
        max = 99,
        step = 1,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairEquippedThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairEquippedThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isRepairEquippedThresholdDisabled,
        default = PAMenuDefaults.PARepair.repairEquippedThreshold,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PARMenu_RepairWornKit,
        tooltip = L.PARMenu_RepairWornKit_T,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairEquippedWithKitSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairEquippedWithKitSetting,
        disabled = PAMenuFunctions.PARepair.isRepairEquippedWithKitDisabled,
        default = PAMenuDefaults.PARepair.repairEquippedWithKit,
    })

    optionsTable:insert({
        type = "slider",
        name = L.PARMenu_RepairWornKitDura,
        tooltip = L.PARMenu_RepairWornKitDura_T,
        min = 0,
        max = 99,
        step = 1,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairEquippedWithKitThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairEquippedWithKitThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isRepairEquippedWithKitThresholdDisabled,
        default = PAMenuDefaults.PARepair.repairEquippedWithKitThreshold,
    })

    optionsTable:insert({
        type = "dropdown",
        name = L.PARMenu_RepairFullChatMode,
        tooltip = L.PARMenu_RepairFullChatMode_T,
        choices = PAMenuChoices.choices.PARepair.repairFullChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.repairFullChatMode,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairFullChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairFullChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isRepairFullChatModeDisabled,
        default = PAMenuDefaults.PARepair.repairFullChatMode,
    })

    optionsTable:insert({
        type = "dropdown",
        name = L.PARMenu_RepairPartialChatMode,
        tooltip = L.PARMenu_RepairPartialChatMode_T,
        choices = PAMenuChoices.choices.PARepair.repairPartialChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.repairPartialChatMode,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairPartialChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairPartialChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isRepairPartialChatModeDisabled,
        default = PAMenuDefaults.PARepair.repairPartialChatMode,
    })

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PARMenu_ChargeWeapons,
        tooltip = L.PARMenu_ChargeWeapons_T,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsSetting,
        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsSetting,
        disabled = PAMenuFunctions.PARepair.isChargeWeaponsDisabled,
        default = PAMenuDefaults.PARepair.chargeWeapons,
    })

    optionsTable:insert({
        type = "slider",
        name = L.PARMenu_ChargeWeaponsDura,
        tooltip = L.PARMenu_ChargeWeaponsDura_T,
        min = 0,
        max = 99,
        step = 1,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isChargeWeaponsThresholdDisabled,
        default = PAMenuDefaults.PARepair.chargeWeaponsThreshold,
    })

    -- chargin output-mode
    optionsTable:insert({
        type = "dropdown",
        name = L.PARMenu_ChargeWeaponsChatMode,
        tooltip = L.PARMenu_ChargeWeaponsChatMode_T,
        choices = PAMenuChoices.choices.PARepair.chargeWeaponsChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.chargeWeaponsChatMode,
        width = "half",
        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isChargeWeaponsChatModeDisabled,
        default = PAMenuDefaults.PARepair.chargeWeaponsChatMode,
    })

    -- soul gem alert

    -- soul gem amount for alert
end

local function createPABankingMenu()
    optionsTable:insert({
        type = "header",
        name = L.PABMenu_Header
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PABMenu_Currency_Enable,
        tooltip = L.PABMenu_Currency_Enable_T,
        getFunc = PAMenuFunctions.PABanking.getCurrenciesEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setCurrenciesEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Currencies.currenciesEnabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Currency_Gold_Header,
        -- tooltip = L.PABMenu_Currency_Gold_Header_T,
        controls = PABCurrencyGoldSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isGoldTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Currency_AlliancePoints_Header,
        -- tooltip = L.PABMenu_Currency_AlliancePoints_Header_T,
        controls = PABCurrencyAlliancePointsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Currency_TelVar_Header,
        -- tooltip = L.PABMenu_Currency_TelVar_Header_T,
        controls = PABCurrencyTelVarSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isTelVarTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Currency_WritVouchers_Header,
        -- tooltip = L.PABMenu_Currency_WritVouchers_Header_T,
        controls = PABCurrencyWritVouchersSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isWritVouchersTransactionMenuDisabled,
    })

    -- -----------------------------------------------------------------------------------

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    if (IsESOPlusSubscriber()) then
        -- In case of ESO Plus Subscription, only show a remark that Crafting Material Banking
        -- options are not available (--> Virtual Bag)

        optionsTable:insert({
            type = "description",
            text = L.PABMenu_Crafting_ESOPlusDesc
        })

    else
        -- Regular player without ESO Plus Subscription
        optionsTable:insert({
            type = "checkbox",
            name = L.PABMenu_Crafting_Enable,
            tooltip = L.PABMenu_Crafting_Enable_T,
            getFunc = PAMenuFunctions.PABanking.getCraftingItemsEnabledSetting,
            setFunc = PAMenuFunctions.PABanking.setCraftingItemsEnabledSetting,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PABanking.Crafting.craftingItemsEnabled,
        })

        optionsTable:insert({
            type = "description",
            text = L.PABMenu_Crafting_Description
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Blacksmithing_Header,
            -- tooltip = L.PABMenu_Crafting_Blacksmithing_Header_T,
            controls = PABCraftingBlacksmithingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isBlacksmithingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Clothing_Header,
            -- tooltip = L.PABMenu_Crafting_Clothing_Header_T,
            controls = PABCraftingClothingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isClothingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Woodworking_Header,
            -- tooltip = L.PABMenu_Crafting_Woodworking_Header_T,
            controls = PABCraftingWoodworkingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isWoodworkingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Jewelcrafting_Header,
            -- tooltip = L.PABMenu_Crafting_Jewelcrafting_Header_T,
            controls = PABCraftingJewelcraftingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isJewelcraftingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Alchemy_Header,
            -- tooltip = L.PABMenu_Crafting_Alchemy_Header_T,
            controls = PABCraftingAlchemySubmenuTable,
            disabled = PAMenuFunctions.PABanking.isAlchemyTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Enchanting_Header,
            -- tooltip = L.PABMenu_Crafting_Enchanting_Header_T,
            controls = PABCraftingEnchantingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isEnchantingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Provisioning_Header,
            -- tooltip = L.PABMenu_Crafting_Provisioning_Header_T,
            controls = PABCraftingProvisioningSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isProvisioningTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_StyleMaterials_Header,
            -- tooltip = L.PABMenu_Crafting_StyleMaterials_Header_T,
            controls = PABCraftingStyleMaterialsSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isStyleMaterialsTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_TraitItems_Header,
            -- tooltip = L.PABMenu_Crafting_TraitItems_Header_T,
            controls = PABCraftingTraitItemsSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isTraitItemsTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Crafting_Furnishing_Header,
            -- tooltip = L.PABMenu_Crafting_Furnishing_Header_T,
            controls = PABCraftingFurnishingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isFurnishingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PABMenu_Crafting_GlobalMoveMode,
            tooltip = L.PABMenu_Crafting_GlobalMoveMode_T,
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            getFunc = function() return end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemsGlobalMoveModeSetting(value) end,
            disabled = PAMenuFunctions.PABanking.isCraftingItemsGlobalMoveModeDisabled,
            warning = L.PABMenu_Crafting_GlobalMoveMode_W,
            reference = "PERSONALASSISTANT_PAB_GLOBAL_MOVE_MODE",
        })
    end

    -- ---------------------------------------------------------------------------------------------------------

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PABMenu_Advanced_Enable,
        tooltip = L.PABMenu_Advanced_Enable_T,
        getFunc = PAMenuFunctions.PABanking.getAdvancedItemsEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setAdvancedItemsEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Advanced.advancedItemsEnabled,
    })

    optionsTable:insert({
        type = "description",
        text = L.PABMenu_Advanced_Description
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Advanced_Motif_Header,
        -- tooltip = L.PABMenu_Advanced_Motif_Header_T,
        controls = PABAdvancedMotifSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isMotifTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Advanced_Recipe_Header,
        -- tooltip = L.PABMenu_Advanced_Recipe_Header_T,
        controls = PABAdvancedRecipeSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isRecipeTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Advanced_Glyphs_Header,
        -- tooltip = L.PABMenu_Advanced_Glyphs_Header_T,
        controls = PABAdvancedGlyphsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isGlyphsTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Advanced_Liquids_Header,
        -- tooltip = L.PABMenu_Advanced_Liquids_Header_T,
        controls = PABAdvancedLiquidsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isLiquidsTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Advanced_Trophies_Header,
        -- tooltip = L.PABMenu_Advanced_Trophies_Header_T,
        controls = PABAdvancedTrophiesSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isTrophiesTransactionMenuDisabled,
    })

    -- -----------------------------------------------------------------------------------

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PABMenu_Individual_Enable,
        tooltip = L.PABMenu_Individual_Enable_T,
        getFunc = PAMenuFunctions.PABanking.getIndividualItemsEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setIndividualItemsEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Individual.individualItemsEnabled,
    })

    optionsTable:insert({
        type = "description",
        text = L.PABMenu_Individual_Description
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Individual_Lockpick_Header,
        -- tooltip = L.PABMenu_Individual_Lockpick_Header_T,
        controls = PABIndividualLockpickSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Individual_SoulGem_Header,
        -- tooltip = L.PABMenu_Individual_SoulGem_Header_T,
        controls = PABIndividualSoulGemSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = L.PABMenu_Individual_RepairKit_Header,
        -- tooltip = L.PABMenu_Individual_RepairKit_Header_T,
        controls = PABIndividualRepairKitSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
    })

    -- check if there are any generic items added; if not skip the menu
    if (#PAC.BANKING_INDIVIDUAL.GENERIC > 0) then
        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Individual_Generic_Header,
            -- tooltip = L.PABMenu_Individual_Generic_Header_T,
            controls = PABIndividualGenericSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isGenericTransactionMenuDisabled,
        })
    end


    -- ---------------------------------------------------------------------------------------------------------

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    optionsTable:insert({
        type = "dropdown",
        name = L.PABMenu_DepositStacking,
        tooltip = L.PABMenu_DepositStacking_T,
        choices = PAMenuChoices.choices.PABanking.stackingType,
        choicesValues = PAMenuChoices.choicesValues.PABanking.stackingType,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getTransactionDepositStackingSetting,
        setFunc = PAMenuFunctions.PABanking.setTransactionDepositStackingSetting,
        disabled = PAMenuFunctions.PABanking.isTransactionDepositStackingDisabled,
        default = PAMenuDefaults.PABanking.transactionDepositStacking,
    })

    optionsTable:insert({
        type = "dropdown",
        name = L.PABMenu_WithdrawalStacking,
        tooltip = L.PABMenu_WithdrawalStacking_T,
        choices = PAMenuChoices.choices.PABanking.stackingType,
        choicesValues = PAMenuChoices.choicesValues.PABanking.stackingType,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getTransactionWithdrawalStackingSetting,
        setFunc = PAMenuFunctions.PABanking.setTransactionWithdrawalStackingSetting,
        disabled = PAMenuFunctions.PABanking.isTransactionWithdrawalStackingDisabled,
        default = PAMenuDefaults.PABanking.transactionWithdrawalStacking,
    })

    optionsTable:insert({
        type = "slider",
        name = L.PABMenu_Transaction_Interval,
        tooltip = L.PABMenu_Transaction_Interval_T,
        min = 100,
        max = 1000,
        step = 50,
        getFunc = PAMenuFunctions.PABanking.getTransactionInvervalSetting,
        setFunc = PAMenuFunctions.PABanking.setTransactionInvervalSetting,
        disabled = PAMenuFunctions.PABanking.isTransactionInvervalDisabled,
        default = PAMenuDefaults.PABanking.transactionInterval,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PABMenu_AutoStackBank,
        tooltip = L.PABMenu_AutoStackBank_T,
        getFunc = PAMenuFunctions.PABanking.getAutoStackBankSetting,
        setFunc = PAMenuFunctions.PABanking.setAutoStackBankSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.autoStackBank,
    })
end

local function createPALootMenu()
    optionsTable:insert({
        type = "header",
        name = L.PALMenu_Header
    })

    if (GetSetting_Bool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)) then
        -- In case of ESO Auto Loot is enabled, only show a remark that PALoot options are not available
        optionsTable:insert({
            type = "description",
            text = L.PALMenu_ESOAutoLootDesc
        })

    else
        -- ESO Auto Loot disabled
        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_Enable,
            tooltip = L.PALMenu_Enable_T,
            getFunc = PAMenuFunctions.PALoot.isEnabled,
            setFunc = PAMenuFunctions.PALoot.setIsEnabled,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PALoot.enabled,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_LootGold,
            tooltip = L.PALMenu_LootGold_T,
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootGoldSetting,
            setFunc = PAMenuFunctions.PALoot.setLootGoldSetting,
            disabled = PAMenuFunctions.PALoot.isLootGoldDisabled,
            default = PAMenuDefaults.PALoot.lootGold,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PALMenu_LootGoldChatMode,
            tooltip = L.PALMenu_LootGoldChatMode_T,
            choices = PAMenuChoices.choices.PALoot.lootGoldChatMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.lootGoldChatMode,
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootGoldChatModeSetting,
            setFunc = PAMenuFunctions.PALoot.setLootGoldChatModeSetting,
            disabled = PAMenuFunctions.PALoot.isLootGoldChatModeDisabled,
            default = PAMenuDefaults.PALoot.lootGoldChatMode,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_LootItems,
            tooltip = L.PALMenu_LootItems_T,
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootItemsSetting,
            setFunc = PAMenuFunctions.PALoot.setLootItemsSetting,
            disabled = PAMenuFunctions.PALoot.isLootItemsDisabled,
            default = PAMenuDefaults.PALoot.lootItems,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PALMenu_LootItemsChatMode,
            tooltip = L.PALMenu_LootItemsChatMode_T,
            choices = PAMenuChoices.choices.PALoot.lootItemsChatMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.lootItemsChatMode,
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootItemsChatModeSetting,
            setFunc = PAMenuFunctions.PALoot.setLootItemsChatModeSetting,
            disabled = PAMenuFunctions.PALoot.isLootItemsChatModeDisabled,
            default = PAMenuDefaults.PALoot.lootItemsChatMode,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_LootStolenItems,
            tooltip = L.PALMenu_LootStolenItems_T,
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootStolenItemsSetting,
            setFunc = PAMenuFunctions.PALoot.setLootStolenItemsSetting,
            disabled = PAMenuFunctions.PALoot.isLootStolenItemsSettingDisabled,
            default = PAMenuDefaults.PALoot.lootStolenItems,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PALMenu_HarvestableItems,
            tooltip = L.PALMenu_HarvestableItems_T,
            controls = PALHarvestableItemSubmenuTable,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PALMenu_LootableItems,
            tooltip = L.PALMenu_LootableItems_T,
            controls = PALLootableItemSubmenuTable,
        })
    end
end

local function createPAJunkMenu()
    optionsTable:insert({
        type = "header",
        name = L.PAJMenu_Header
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PAJMenu_Enable,
        tooltip = L.PAJMenu_Enable_T,
        getFunc = PAMenuFunctions.PAJunk.isEnabled,
        setFunc = PAMenuFunctions.PAJunk.setIsEnabled,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAJunk.enabled,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PAJMenu_AutoSellJunk,
        tooltip = L.PAJMenu_AutoSellJunk_T,
        getFunc = PAMenuFunctions.PAJunk.getAutoSellJunkSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoSellJunkSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoSellJunkDisabled,
        default = PAMenuDefaults.PAJunk.autoSellJunk,
    })

    optionsTable:insert({
        type = "description",
        text = L.PAJMenu_ItemTypeDesc,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PAJMenu_AutoMarkTrash,
        tooltip = L.PAJMenu_AutoMarkTrash_T,
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkTrashSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkTrashSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkTrashDisabled,
        default = PAMenuDefaults.PAJunk.autoMarkTrash,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PAJMenu_AutoMarkOrnate,
        tooltip = L.PAJMenu_AutoMarkOrnate_T,
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.autoMarkOrnate,
    })
end

-- =================================================================================================================

local function createPABCurrencyGoldSubmenuTable()
    PABCurrencyGoldSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Currency_Gold_Enabled,
        tooltip = L.PABMenu_Currency_Gold_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getGoldTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setGoldTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isGoldTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.goldTransaction,
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_Gold_MinToKeep,
        tooltip = L.PABMenu_Currency_Gold_MinToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getGoldMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setGoldMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isGoldMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.goldMinToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MIN",
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_Gold_MaxToKeep,
        tooltip = L.PABMenu_Currency_Gold_MaxToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getGoldMaxToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setGoldMaxToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isGoldMaxToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.goldMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCurrencyAlliancePointsSubmenuTable()
    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Currency_AlliancePoints_Enabled,
        tooltip = L.PABMenu_Currency_AlliancePoints_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getAlliancePointsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setAlliancePointsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.alliancePointsTransaction,
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_AlliancePoints_MinToKeep,
        tooltip = L.PABMenu_Currency_AlliancePoints_MinToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getAlliancePointsMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setAlliancePointsMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.alliancePointsMinToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN",
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_AlliancePoints_MaxToKeep,
        tooltip = L.PABMenu_Currency_AlliancePoints_MaxToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getAlliancePointsMaxToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setAlliancePointsMaxToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsMaxToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.alliancePointsMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCurrencyTelVarSubmenuTable()
    PABCurrencyTelVarSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Currency_TelVar_Enabled,
        tooltip = L.PABMenu_Currency_TelVar_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getTelVarTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setTelVarTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isTelVarTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.telVarTransaction,
    })

    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_TelVar_MinToKeep,
        tooltip = L.PABMenu_Currency_TelVar_MinToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getTelVarMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setTelVarMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isTelVarMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.telVarMinToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MIN",
    })
    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_TelVar_MaxToKeep,
        tooltip = L.PABMenu_Currency_TelVar_MaxToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getTelVarMaxToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setTelVarMaxToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isTelVarMaxToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.telVarMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCurrencyWritVouchersSubmenuTable()
    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Currency_WritVouchers_Enabled,
        tooltip = L.PABMenu_Currency_WritVouchers_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getWritVouchersTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setWritVouchersTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isWritVouchersTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.writVouchersTransaction,
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_WritVouchers_MinToKeep,
        tooltip = L.PABMenu_Currency_WritVouchers_MinToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getWritVouchersMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setWritVouchersMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isWritVouchersMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.writVouchersMinToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN",
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = L.PABMenu_Currency_WritVouchers_MaxToKeep,
        tooltip = L.PABMenu_Currency_WritVouchers_MaxToKeep_T,
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getWritVouchersMaxToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setWritVouchersMaxToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isWritVouchersMaxToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.writVouchersMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX",
    })
end

-- =================================================================================================================

local function createPABCraftingBlacksmithingSubmenuTable()
    PABCraftingBlacksmithingSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Blacksmithing_Enabled,
        tooltip = L.PABMenu_Crafting_Blacksmithing_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getBlacksmithingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setBlacksmithingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isBlacksmithingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.blacksmithingTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.BLACKSMITHING) do
        PABCraftingBlacksmithingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isBlacksmithingTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingClothingSubmenuTable()
    PABCraftingClothingSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Clothing_Enabled,
        tooltip = L.PABMenu_Crafting_Clothing_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getClothingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setClothingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isClothingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.clothingTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.CLOTHING) do
        PABCraftingClothingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isClothingTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingWoodworkingSubmenuTable()
    PABCraftingWoodworkingSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Woodworking_Enabled,
        tooltip = L.PABMenu_Crafting_Woodworking_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getWoodworkingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setWoodworkingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isWoodworkingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.woodworkingTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.WOODWORKING) do
        PABCraftingWoodworkingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isWoodworkingTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingJewelcraftingSubmenuTable()
    PABCraftingJewelcraftingSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Jewelcrafting_Enabled,
        tooltip = L.PABMenu_Crafting_Jewelcrafting_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getJewelcraftingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setJewelcraftingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isJewelcraftingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.jewelcraftingTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.JEWELCRAFTING) do
        PABCraftingJewelcraftingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isJewelcraftingTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingAlchemySubmenuTable()
    PABCraftingAlchemySubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Alchemy_Enabled,
        tooltip = L.PABMenu_Crafting_Alchemy_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getAlchemyTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setAlchemyTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isAlchemyTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.alchemyTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.ALCHEMY) do
        PABCraftingAlchemySubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isAlchemyTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingEnchantingSubmenuTable()
    PABCraftingEnchantingSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Enchanting_Enabled,
        tooltip = L.PABMenu_Crafting_Enchanting_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getEnchantingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setEnchantingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isEnchantingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.enchantingTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.ENCHANTING) do
        PABCraftingEnchantingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isEnchantingTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingProvisioningSubmenuTable()
    PABCraftingProvisioningSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Provisioning_Enabled,
        tooltip = L.PABMenu_Crafting_Provisioning_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getProvisioningTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setProvisioningTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isProvisioningTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.provisioningTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.PROVISIONING) do
        PABCraftingProvisioningSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isProvisioningTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingStyleMaterialsSubmenuTable()
    PABCraftingStyleMaterialsSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_StyleMaterials_Enabled,
        tooltip = L.PABMenu_Crafting_StyleMaterials_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getStyleMaterialsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setStyleMaterialsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isStyleMaterialsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.styleMaterialsTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.STYLEMATERIALS) do
        PABCraftingStyleMaterialsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isStyleMaterialsTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingTraitItemsSubmenuTable()
    PABCraftingTraitItemsSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_TraitItems_Enabled,
        tooltip = L.PABMenu_Crafting_TraitItems_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getTraitItemsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setTraitItemsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isTraitItemsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.traitItemsTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.TRAITITEMS) do
        PABCraftingTraitItemsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isTraitItemsTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABCraftingFurnishingSubmenuTable()
    PABCraftingFurnishingSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Crafting_Furnishing_Enabled,
        tooltip = L.PABMenu_Crafting_Furnishing_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getFurnishingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setFurnishingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isFurnishingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.furnishingTransaction,
    })

    for _, itemType in pairs(PAC.BANKING.FURNISHING) do
        PABCraftingFurnishingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isFurnishingTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- =================================================================================================================

local function createPABAdvancedMotifSubmenuTable()
    PABAdvancedMotifSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Advanced_Motif_Enabled,
        tooltip = L.PABMenu_Advanced_Motif_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getMotifTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setMotifTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isMotifTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.motifTransaction,
    })

    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.MOTIF) do
        PABAdvancedMotifSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isMotifTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABAdvancedRecipeSubmenuTable()
    PABAdvancedRecipeSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Advanced_Recipe_Enabled,
        tooltip = L.PABMenu_Advanced_Recipe_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getRecipeTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setRecipeTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isRecipeTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.recipeTransaction,
    })

    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.RECIPE) do
        PABAdvancedRecipeSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isRecipeTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- =================================================================================================================

local function createPABAdvancedGlyphsSubmenuTable()
    PABAdvancedGlyphsSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Advanced_Glyphs_Enabled,
        tooltip = L.PABMenu_Advanced_Glyphs_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getGlyphsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setGlyphsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isGlyphsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.glyphsTransaction,
    })

    for _, specializedItemType in pairs(PAC.BANKING_ADVANCED.SPECIALIZED.GLYPHS) do
        PABAdvancedGlyphsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeSpecializedMoveSetting(specializedItemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value) end,
            disabled = PAMenuFunctions.PABanking.isGlyphsTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABAdvancedLiquidsSubmenuTable()
    PABAdvancedLiquidsSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Advanced_Liquids_Enabled,
        tooltip = L.PABMenu_Advanced_Liquids_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getLiquidsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setLiquidsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isLiquidsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.liquidsTransaction,
    })

    for _, specializedItemType in pairs(PAC.BANKING_ADVANCED.SPECIALIZED.LIQUIDS) do
        PABAdvancedLiquidsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeSpecializedMoveSetting(specializedItemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value) end,
            disabled = PAMenuFunctions.PABanking.isLiquidsTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABAdvancedTrophiesSubmenuTable()
    PABAdvancedTrophiesSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Advanced_Trophies_Enabled,
        tooltip = L.PABMenu_Advanced_Trophies_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getTrophiesTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setTrophiesTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isTrophiesTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.trophiesTransaction,
    })

    for _, specializedItemType in pairs(PAC.BANKING_ADVANCED.SPECIALIZED.TROPHIES) do
        PABAdvancedTrophiesSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeSpecializedMoveSetting(specializedItemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value) end,
            disabled = PAMenuFunctions.PABanking.isTrophiesTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- =================================================================================================================

local function createPABIndividualLockpickSubmenuTable()
    PABIndividualLockpickSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Individual_Lockpick_Enabled,
        tooltip = L.PABMenu_Individual_Lockpick_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getLockpickTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setLockpickTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isLockpickTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.lockpickTransaction,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.LOCKPICK) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualLockpickSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedText(L.REL_Operator, itemLink) end,
            tooltip = L.REL_Operator_T,
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualOperator,
        })

        PABIndividualLockpickSubmenuTable:insert({
            type = "editbox",
            name = L.PABMenu_Individual_Keep_in_Backpack,
            tooltip = L.PABMenu_Individual_Keep_in_Backpack_T,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualAmount
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABIndividualSoulGemSubmenuTable()
    PABIndividualSoulGemSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Individual_SoulGem_Enabled,
        tooltip = L.PABMenu_Individual_SoulGem_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getSoulGemTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setSoulGemTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isSoulGemTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.soulGemTransaction,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.SOUL_GEM) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualSoulGemSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedText(L.REL_Operator, itemLink) end,
            tooltip = L.REL_Operator_T,
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualOperator,
        })

        PABIndividualSoulGemSubmenuTable:insert({
            type = "editbox",
            name = L.PABMenu_Individual_Keep_in_Backpack,
            tooltip = L.PABMenu_Individual_Keep_in_Backpack_T,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualAmount
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABIndividualRepairKitSubmenuTable()
    PABIndividualRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Individual_RepairKit_Enabled,
        tooltip = L.PABMenu_Individual_RepairKit_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getRepairKitTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setRepairKitTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isRepairKitTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.repairKitTransaction,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.REPAIR_KIT) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualRepairKitSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedText(L.REL_Operator, itemLink) end,
            tooltip = L.REL_Operator_T,
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualOperator,
        })

        PABIndividualRepairKitSubmenuTable:insert({
            type = "editbox",
            name = L.PABMenu_Individual_Keep_in_Backpack,
            tooltip = L.PABMenu_Individual_Keep_in_Backpack_T,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualAmount
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABIndividualGenericSubmenuTable()
    PABIndividualGenericSubmenuTable:insert({
        type = "checkbox",
        name = L.PABMenu_Individual_Generic_Enabled,
        tooltip = L.PABMenu_Individual_Generic_Enabled_T,
        getFunc = PAMenuFunctions.PABanking.getGenericTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setGenericTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isGenericTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.genericTransaction,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.GENERIC) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualGenericSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedText(L.REL_Operator, itemLink) end,
            tooltip = L.REL_Operator_T,
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isGenericTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualOperator,
        })

        PABIndividualGenericSubmenuTable:insert({
            type = "editbox",
            name = L.PABMenu_Individual_Keep_in_Backpack,
            tooltip = L.PABMenu_Individual_Keep_in_Backpack_T,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isGenericTransactionMenuDisabled,
            default = PAMenuDefaults.PABanking.Individual.individualAmount
        })
    end
end

-- =================================================================================================================

local function createPALHarvestableItemSubMenu()
    PALHarvestableItemSubmenuTable:insert({
        type = "description",
        text = L.PALMenu_HarvestableItemsDesc
    })

    PALHarvestableItemSubmenuTable:insert({
        type = "header",
        name = L.PALMenu_HarvestableItems_Bait_Header
    })

    local baitChoices = PAMenuChoices.choices.PALoot.harvestableBaitLootMode
    local baitChoicesValues = PAMenuChoices.choicesValues.PALoot.harvestableBaitLootMode
    local baitChoicesTooltips = PAMenuChoices.choicesTooltips.PALoot.harvestableBaitLootMode
    if (IsESOPlusSubscriber()) then
        -- Override the values in case of ESO Plus (no option to "destroy" bait, as it directly goes to virtual bag)
        -- Removes the last entry from the dropdowns (option: loot & destroy)
        table.remove(baitChoices)
        table.remove(baitChoicesValues)
        table.remove(baitChoicesTooltips)
    end

    PALHarvestableItemSubmenuTable:insert({
        type = "dropdown",
        name = L.PALMenu_HarvestableItems_Bait,
        tooltip = L.PALMenu_HarvestableItems_Bait_T,
        choices = baitChoices,
        choicesValues = baitChoicesValues,
        choicesTooltips = baitChoicesTooltips,
        getFunc = PAMenuFunctions.PALoot.getHarvestableBaitLootModeSetting,
        setFunc = PAMenuFunctions.PALoot.setHarvestableBaitLootModeSetting,
        disabled = PAMenuFunctions.PALoot.isHarvestableBaitLootModeDisabled,
        default = PAMenuDefaults.PALoot.harvestableBaitLootMode,
    })

    PALHarvestableItemSubmenuTable:insert({
        type = "header",
        name = L.PALMenu_HarvestableItems_Header
    })

    for index, itemType in pairs(PALHarvestableItemTypes) do
        PALHarvestableItemSubmenuTable:insert({
            type = "dropdown",
            name = L[itemType],
            choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
            choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
            width = "half",
            getFunc = function() return PAMenuFunctions.PALoot.getHarvestableItemTypesLootModeSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PALoot.setHarvestableItemTypesLootModeSetting(itemType, value) end,
            disabled = PAMenuFunctions.PALoot.isHarvestableItemTypesLootModeDisabled,
            default = PAMenuDefaults.PALoot.harvestableItemTypesLootMode,
        })
    end

    PALHarvestableItemSubmenuTable:insert({
        type = "button",
        name = L.PALMenu_AutoLootAllButton,
        tooltip = L.PALMenu_AutoLootAllButton_T,
        func = PAMenuFunctions.PALoot.clickAutoLootAllHarvestableButton,
        disabled = PAMenuFunctions.PALoot.isAutoLootAllHarvestableButtonDisabled,
    })

    PALHarvestableItemSubmenuTable:insert({
        type = "button",
        name = L.PALMenu_IgnButton,
        tooltip = L.PALMenu_IgnButton_T,
        func = PAMenuFunctions.PALoot.clickIgnoreAllHarvestableButton,
        disabled = PAMenuFunctions.PALoot.isIgnoreAllHarvestableButtonDisabled,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPALLootableItemSubMenu()
    PALLootableItemSubmenuTable:insert({
        type = "description",
        text = L.PALMenu_LootableItemsDesc
    })

    PALLootableItemSubmenuTable:insert({
        type = "header",
        name = L.PALMenu_LootableItems_Header
    })

    for index, itemType in pairs(PALLootableItemTypes) do
        PALLootableItemSubmenuTable:insert({
            type = "dropdown",
            name = L[itemType],
            choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
            choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
            width = "half",
            getFunc = function() return PAMenuFunctions.PALoot.getLootableItemTypesLootModeSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PALoot.setLootableItemTypesLootModeSetting(itemType, value) end,
            disabled = PAMenuFunctions.PALoot.isLootableItemTypesLootModeDisabled,
            default = PAMenuDefaults.PALoot.lootableItemTypesLootMode,
        })
    end

    PALLootableItemSubmenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PALLootableItemSubmenuTable:insert({
        type = "dropdown",
        name = L.PALMenu_AutoLootLockpicks,
        choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
        choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
        choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
        width = "half",
        getFunc = PAMenuFunctions.PALoot.getLockpickLootModeSetting,
        setFunc = PAMenuFunctions.PALoot.setLockpickLootModeSetting,
        disabled = PAMenuFunctions.PALoot.isLockpickLootModeDisabled,
        default = PAMenuDefaults.PALoot.lockpickLootMode,
    })

    PALLootableItemSubmenuTable:insert({
        type = "dropdown",
        name = L.PALMenu_AutoLootQuestItems,
        choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
        choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
        choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
        width = "half",
        getFunc = PAMenuFunctions.PALoot.getQuestItemsLootModeSetting,
        setFunc = PAMenuFunctions.PALoot.setQuestItemsLootModeSetting,
        disabled = PAMenuFunctions.PALoot.isQuestItemsLootModeDisabled,
        default = PAMenuDefaults.PALoot.questItemsLootMode,
    })

    PALLootableItemSubmenuTable:insert({
        type = "button",
        name = L.PALMenu_AutoLootAllButton,
        tooltip = L.PALMenu_AutoLootAllButton_T,
        func = PAMenuFunctions.PALoot.clickAutoLootAllLootableButton,
        disabled = PAMenuFunctions.PALoot.isAutoLootAllLootableButtonDisabled,
    })

    PALLootableItemSubmenuTable:insert({
        type = "button",
        name = L.PALMenu_IgnButton,
        tooltip = L.PALMenu_IgnButton_T,
        func = PAMenuFunctions.PALoot.clickIgnoreAllLootableButton,
        disabled = PAMenuFunctions.PALoot.isIgnoreAllLootableButtonDisabled,
    })
end

-- =================================================================================================================

local function createOptions()
    -- create submenu for PABanking
    if (PA.Banking) then
        createPABCurrencyGoldSubmenuTable()
        createPABCurrencyAlliancePointsSubmenuTable()
        createPABCurrencyTelVarSubmenuTable()
        createPABCurrencyWritVouchersSubmenuTable()

        createPABCraftingBlacksmithingSubmenuTable()
        createPABCraftingClothingSubmenuTable()
        createPABCraftingWoodworkingSubmenuTable()
        createPABCraftingJewelcraftingSubmenuTable()
        createPABCraftingAlchemySubmenuTable()
        createPABCraftingEnchantingSubmenuTable()
        createPABCraftingProvisioningSubmenuTable()
        createPABCraftingStyleMaterialsSubmenuTable()
        createPABCraftingTraitItemsSubmenuTable()
        createPABCraftingFurnishingSubmenuTable()

        createPABAdvancedMotifSubmenuTable()
        createPABAdvancedRecipeSubmenuTable()

        createPABAdvancedGlyphsSubmenuTable()
        createPABAdvancedLiquidsSubmenuTable()
        createPABAdvancedTrophiesSubmenuTable()

        createPABIndividualLockpickSubmenuTable()
        createPABIndividualSoulGemSubmenuTable()
        createPABIndividualRepairKitSubmenuTable()
        createPABIndividualGenericSubmenuTable()
    end

    -- create submenu for PALoot
    if (PA.Loot) then
        createPALHarvestableItemSubMenu()
        createPALLootableItemSubMenu()
    end

    createPAGeneralMenu()
    if (PA.Repair) then createPARepairMenu() end
    if (PA.Banking) then createPABankingMenu() end
    if (PA.Loot) then createPALootMenu() end
    if (PA.Junk) then createPAJunkMenu() end

    -- and register it
    LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
    LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)
end


-- Export
PA.MainMenu = {
    createOptions = createOptions
}
