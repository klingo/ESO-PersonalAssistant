-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults
local PAMenuChoices = PA.MenuChoices

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
    type = "panel",
    name = "PersonalAssistant",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PA.AddonVersion,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pa",
    registerForRefresh = true,
    registerForDefaults = true,
}

local optionsTable = setmetatable({}, { __index = table })

local PARGoldSubmenuTable = setmetatable({}, { __index = table })
local PARRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PARRechargeSubmenuTable = setmetatable({}, { __index = table })

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

local PAJAutoMarkAsJunkSubMenu = setmetatable({}, { __index = table })

-- =================================================================================================================

local function createPAGeneralMenu()
    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_GENERAL_HEADER)
    })

    optionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE),
        tooltip = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T),
        choices = PAMenuHelper.getProfileList(),
        choicesValues = PAMenuHelper.getProfileListValues(),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfile,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfile,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN",
    })

    optionsTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME),
        tooltip = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfileRename,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfileRename,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME),
        tooltip = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME_T),
        getFunc = PAMenuFunctions.PAGeneral.getWelcomeMessageSetting,
        setFunc = PAMenuFunctions.PAGeneral.setWelcomeMessageSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAGeneral.welcomeMessage,
    })
end

local function createPARepairMenu()
    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_REPAIR_HEADER)
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_ENABLE),
        getFunc = PAMenuFunctions.PARepair.getAutoRepairEnabledSetting,
        setFunc = PAMenuFunctions.PARepair.setAutoRepairEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PARepair.autoRepairEnabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_HEADER),
        controls = PARGoldSubmenuTable,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER),
        controls = PARRepairKitSubmenuTable,
        disabled = PAMenuFunctions.PARepair.isRepairWithRepairKitMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_HEADER),
        controls = PARRechargeSubmenuTable,
        disabled = PAMenuFunctions.PARepair.isRechargeWithSoulGemMenuDisabled,
    })

    -- TODO: clean up below settings (will be replaced!)

--    optionsTable:insert({
--        type = "checkbox",
--        name = GetString(SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN),
--        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN_T),
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairEquippedSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairEquippedSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairEquippedDisabled,
--        default = PAMenuDefaults.PARepair.repairEquipped,
--    })
--
--    optionsTable:insert({
--        type = "slider",
--        name = GetString(SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN_DURABILITY),
--        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN_DURABILITY_T),
--        min = 0,
--        max = 99,
--        step = 1,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairEquippedThresholdSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairEquippedThresholdSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairEquippedThresholdDisabled,
--        default = PAMenuDefaults.PARepair.repairEquippedThreshold,
--    })
--
--    optionsTable:insert({
--        type = "checkbox",
--        name = GetString(SI_PA_MENU_REPAIR_KIT_REPAIR_WORN),
--        tooltip = GetString(SI_PA_MENU_REPAIR_KIT_REPAIR_WORN_T),
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairEquippedWithKitSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairEquippedWithKitSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairEquippedWithKitDisabled,
--        default = PAMenuDefaults.PARepair.repairEquippedWithKit,
--    })
--
--    optionsTable:insert({
--        type = "slider",
--        name = GetString(SI_PA_MENU_REPAIR_KIT_REPAIR_WORN_DURABILITY),
--        tooltip = GetString(SI_PA_MENU_REPAIR_KIT_REPAIR_WORN_DURABILITY_T),
--        min = 0,
--        max = 99,
--        step = 1,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairEquippedWithKitThresholdSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairEquippedWithKitThresholdSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairEquippedWithKitThresholdDisabled,
--        default = PAMenuDefaults.PARepair.repairEquippedWithKitThreshold,
--    })
--
--    optionsTable:insert({
--        type = "dropdown",
--        name = GetString(SI_PA_MENU_REPAIR_REPAIR_CHATMODE_FULL),
--        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIR_CHATMODE_FULL_T),
--        choices = PAMenuChoices.choices.PARepair.repairFullChatMode,
--        choicesValues = PAMenuChoices.choicesValues.PARepair.repairFullChatMode,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairFullChatModeSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairFullChatModeSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairFullChatModeDisabled,
--        default = PAMenuDefaults.PARepair.repairFullChatMode,
--    })
--
--    optionsTable:insert({
--        type = "dropdown",
--        name = GetString(SI_PA_MENU_REPAIR_REPAIR_CHATMODE_PARTIAL),
--        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIR_CHATMODE_PARTIAL_T),
--        choices = PAMenuChoices.choices.PARepair.repairPartialChatMode,
--        choicesValues = PAMenuChoices.choicesValues.PARepair.repairPartialChatMode,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairPartialChatModeSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairPartialChatModeSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairPartialChatModeDisabled,
--        default = PAMenuDefaults.PARepair.repairPartialChatMode,
--    })
--
--    optionsTable:insert({
--        type = "divider",
--        alpha = 0.5,
--    })
--
--    optionsTable:insert({
--        type = "checkbox",
--        name = GetString(SI_PA_MENU_REPAIR_CHARGE_WEAPONS),
--        tooltip = GetString(SI_PA_MENU_REPAIR_CHARGE_WEAPONS_T),
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsSetting,
--        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsSetting,
--        disabled = PAMenuFunctions.PARepair.isChargeWeaponsDisabled,
--        default = PAMenuDefaults.PARepair.chargeWeapons,
--    })
--
--    optionsTable:insert({
--        type = "slider",
--        name = GetString(SI_PA_MENU_REPAIR_CHARGE_WEAPONS_DURABILITY),
--        tooltip = GetString(SI_PA_MENU_REPAIR_CHARGE_WEAPONS_DURABILITY_T),
--        min = 0,
--        max = 99,
--        step = 1,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsThresholdSetting,
--        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsThresholdSetting,
--        disabled = PAMenuFunctions.PARepair.isChargeWeaponsThresholdDisabled,
--        default = PAMenuDefaults.PARepair.chargeWeaponsThreshold,
--    })
--
--    -- chargin output-mode
--    optionsTable:insert({
--        type = "dropdown",
--        name = GetString(SI_PA_MENU_REPAIR_CHARGE_CHATMODE),
--        tooltip = GetString(SI_PA_MENU_REPAIR_CHARGE_CHATMODE_T),
--        choices = PAMenuChoices.choices.PARepair.chargeWeaponsChatMode,
--        choicesValues = PAMenuChoices.choicesValues.PARepair.chargeWeaponsChatMode,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsChatModeSetting,
--        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsChatModeSetting,
--        disabled = PAMenuFunctions.PARepair.isChargeWeaponsChatModeDisabled,
--        default = PAMenuDefaults.PARepair.chargeWeaponsChatMode,
--    })

    -- soul gem alert

    -- soul gem amount for alert
end

local function createPABankingMenu()
    local _groupName = GetString(SI_PA_MENU_BANKING_CURRENCY)

    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_BANKING_HEADER)
    })

    optionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ENABLE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ENABLE_T, _groupName),
        getFunc = PAMenuFunctions.PABanking.getCurrenciesEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setCurrenciesEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Currencies.currenciesEnabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER),
        tooltip = GetCurrencyDescription(CURT_MONEY),
        controls = PABCurrencyGoldSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isGoldTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER),
        tooltip = GetCurrencyDescription(CURT_ALLIANCE_POINTS),
        controls = PABCurrencyAlliancePointsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER),
        tooltip = GetCurrencyDescription(CURT_TELVAR_STONES),
        controls = PABCurrencyTelVarSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isTelVarTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER),
        tooltip = GetCurrencyDescription(CURT_WRIT_VOUCHERS),
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
            text = GetString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC)
        })

    else
        local _groupName = GetString(SI_PA_MENU_BANKING_CRAFTING)
        -- Regular player without ESO Plus Subscription
        optionsTable:insert({
            type = "checkbox",
            name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, _groupName),
            tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, _groupName),
            getFunc = PAMenuFunctions.PABanking.getCraftingItemsEnabledSetting,
            setFunc = PAMenuFunctions.PABanking.setCraftingItemsEnabledSetting,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PABanking.Crafting.craftingItemsEnabled,
        })

        optionsTable:insert({
            type = "description",
            text = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_DESCRIPTION, _groupName)
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER),
            controls = PABCraftingBlacksmithingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isBlacksmithingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER),
            controls = PABCraftingClothingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isClothingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER),
            controls = PABCraftingWoodworkingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isWoodworkingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER),
            controls = PABCraftingJewelcraftingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isJewelcraftingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER),
            controls = PABCraftingAlchemySubmenuTable,
            disabled = PAMenuFunctions.PABanking.isAlchemyTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER),
            controls = PABCraftingEnchantingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isEnchantingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER),
            controls = PABCraftingProvisioningSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isProvisioningTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER),
            controls = PABCraftingStyleMaterialsSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isStyleMaterialsTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER),
            controls = PABCraftingTraitItemsSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isTraitItemsTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER),
            controls = PABCraftingFurnishingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isFurnishingTransactionMenuDisabled,
        })

        optionsTable:insert({
            type = "dropdown",
            name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE, _groupName),
            tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_T, _groupName),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            getFunc = function() return end,
            setFunc = function(value) PAMenuFunctions.PABanking.setCraftingItemsGlobalMoveModeSetting(value) end,
            disabled = PAMenuFunctions.PABanking.isCraftingItemsGlobalMoveModeDisabled,
            warning = GetString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W),
            reference = "PERSONALASSISTANT_PAB_CRAFTING_GLOBAL_MOVE_MODE",
        })
    end

    -- ---------------------------------------------------------------------------------------------------------

    local _groupName = GetString(SI_PA_MENU_BANKING_ADVANCED)

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    optionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, _groupName),
        getFunc = PAMenuFunctions.PABanking.getAdvancedItemsEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setAdvancedItemsEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Advanced.advancedItemsEnabled,
    })

    optionsTable:insert({
        type = "description",
        text = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_DESCRIPTION, _groupName)
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER),
        controls = PABAdvancedMotifSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isMotifTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER),
        controls = PABAdvancedRecipeSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isRecipeTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER),
        controls = PABAdvancedGlyphsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isGlyphsTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER),
        controls = PABAdvancedLiquidsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isLiquidsTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER),
        controls = PABAdvancedTrophiesSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isTrophiesTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_T, _groupName),
        choices = PAMenuChoices.choices.PABanking.itemMoveMode,
        choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
        getFunc = function() return end,
        setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemsGlobalMoveModeSetting(value) end,
        disabled = PAMenuFunctions.PABanking.isAdvancedItemsGlobalMoveModeDisabled,
        warning = GetString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W),
        reference = "PERSONALASSISTANT_PAB_ADVANCED_GLOBAL_MOVE_MODE",
    })

    -- -----------------------------------------------------------------------------------

    local _groupName = GetString(SI_PA_MENU_BANKING_INDIVIDUAL)

    optionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    optionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, _groupName),
        getFunc = PAMenuFunctions.PABanking.getIndividualItemsEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setIndividualItemsEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Individual.individualItemsEnabled,
    })

    optionsTable:insert({
        type = "description",
        text = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_DESCRIPTION, _groupName)
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER),
        controls = PABIndividualLockpickSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER),
        controls = PABIndividualSoulGemSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER),
        controls = PABIndividualRepairKitSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
    })

    -- check if there are any generic items added; if not skip the menu
    if (#PAC.BANKING_INDIVIDUAL.GENERIC > 0) then
        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER),
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
        name = GetString(SI_PA_MENU_BANKING_DEPOSIT_STACKING),
        tooltip = GetString(SI_PA_MENU_BANKING_DEPOSIT_STACKING_T),
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
        name = GetString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING),
        tooltip = GetString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T),
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
        name = GetString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL),
        tooltip = GetString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T),
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
        name = GetString(SI_PA_MENU_BANKING_AUTOSTACKBANK),
        tooltip = GetString(SI_PA_MENU_BANKING_AUTOSTACKBANK_T),
        getFunc = PAMenuFunctions.PABanking.getAutoStackBankSetting,
        setFunc = PAMenuFunctions.PABanking.setAutoStackBankSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.autoStackBank,
    })
end

local function createPALootMenu()
    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_LOOT_HEADER)
    })

    if (GetSetting_Bool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)) then
        -- In case of ESO Auto Loot is enabled, only show a remark that PALoot options are not available
        optionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_LOOT_ESO_AUTOLOOT_DESCRIPTION)
        })

    else
        -- ESO Auto Loot disabled
        optionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_LOOT_ENABLE),
            tooltip = GetString(SI_PA_MENU_LOOT_ENABLE_T),
            getFunc = PAMenuFunctions.PALoot.isEnabled,
            setFunc = PAMenuFunctions.PALoot.setIsEnabled,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PALoot.enabled,
        })

        optionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_LOOT_LOOT_GOLD),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_GOLD_T),
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootGoldSetting,
            setFunc = PAMenuFunctions.PALoot.setLootGoldSetting,
            disabled = PAMenuFunctions.PALoot.isLootGoldDisabled,
            default = PAMenuDefaults.PALoot.lootGold,
        })

        optionsTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_LOOT_LOOT_GOLD_CHATMODE),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_GOLD_CHATMODE_T),
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
            name = GetString(SI_PA_MENU_LOOT_LOOT_ITEMS),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_ITEMS_T),
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootItemsSetting,
            setFunc = PAMenuFunctions.PALoot.setLootItemsSetting,
            disabled = PAMenuFunctions.PALoot.isLootItemsDisabled,
            default = PAMenuDefaults.PALoot.lootItems,
        })

        optionsTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_LOOT_LOOT_ITEMS_CHATMODE),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_ITEMS_CHATMODE_T),
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
            name = GetString(SI_PA_MENU_LOOT_LOOT_STOLENITEMS),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_STOLENITEMS_T),
            width = "half",
            getFunc = PAMenuFunctions.PALoot.getLootStolenItemsSetting,
            setFunc = PAMenuFunctions.PALoot.setLootStolenItemsSetting,
            disabled = PAMenuFunctions.PALoot.isLootStolenItemsSettingDisabled,
            default = PAMenuDefaults.PALoot.lootStolenItems,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_T),
            controls = PALHarvestableItemSubmenuTable,
        })

        optionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS),
            tooltip = GetString(SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS_T),
            controls = PALLootableItemSubmenuTable,
        })
    end
end

local function createPAJunkMenu()
    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_JUNK_HEADER)
    })

    optionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_ITEMTYPE_DESCRIPTION),
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkAsJunkEnabledSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkAsJunkEnabledSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkAsJunkDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkAsJunkEnabled,
    })

    optionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_HEADER),
        controls = PAJAutoMarkAsJunkSubMenu,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkAsJunkMenuDisabled,
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoSellJunkSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoSellJunkSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoSellJunkDisabled,
        default = PAMenuDefaults.PAJunk.autoSellJunk,
    })
end

local function createPAMailMenu()
    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_MAIL_HEADER)
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE_T),
        getFunc = PAMenuFunctions.PAMail.getHirelingAutoMailEnabledSetting,
        setFunc = PAMenuFunctions.PAMail.setHirelingAutoMailEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAMail.hirelingAutoMailEnabled,
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T),
        getFunc = PAMenuFunctions.PAMail.getHirelingDeleteEmptyMailsSetting,
        setFunc = PAMenuFunctions.PAMail.setHirelingDeleteEmptyMailsSetting,
        disabled = PAMenuFunctions.PAMail.isHirelingDeleteEmptyMailsDisabled,
        default = PAMenuDefaults.PAMail.hirelingDeleteEmptyMails,
    })
end

-- =================================================================================================================

local function createPARGoldSubmenuTable()
    PARGoldSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getRepairWithGoldSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithGoldSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithGold,
    })

    PARGoldSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
--        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairWithGoldDurabilityThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithGoldDurabilityThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldDurabilityThresholdDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithGoldDurabilityThreshold,
    })

    PARGoldSubmenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_REPAIR_CHATMODE),
        tooltip = GetString(SI_PA_MENU_REPAIR_CHATMODE_T),
        choices = PAMenuChoices.choices.PARepair.repairChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.repairChatMode,
--            width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairWithGoldChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithGoldChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldChatModeDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithGoldChatMode,
    })

end

-- -----------------------------------------------------------------------------------------------------------------

local function createPARRepairKitSubmenuTable()
    PARRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getRepairWithRepairKitSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithRepairKitSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithRepairKitDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithRepairKit,
    })

    PARRepairKitSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_NOT_YET_IMPLEMENTED)
    })

    -- TODO: Use Regular Repair Kits

    -- TODO: Threshold

    -- TODO: Use Crown Repair Kits

    -- TODO: Threshold

    -- TODO: Low Repair Kit Warning

    -- TODO: Chat Mode
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPARRechargeSubmenuTable()
    PARRechargeSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getRechargeWithSoulGemSetting,
        setFunc = PAMenuFunctions.PARepair.setRechargeWithSoulGemSetting,
        disabled = PAMenuFunctions.PARepair.isRechargeWithSoulGemDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.useSoulGems,
    })

    PARRechargeSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isChargeWeaponsThresholdDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.chargeWeaponsThreshold,
    })

    PARRechargeSubmenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T),
        choices = PAMenuChoices.choices.PARepair.chargeWeaponsChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.chargeWeaponsChatMode,
        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isChargeWeaponsChatModeDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.chargeWeaponsChatMode,
    })

    PARRechargeSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T),
        getFunc = PAMenuFunctions.PARepair.getLowSoulGemWarningSetting,
        setFunc = PAMenuFunctions.PARepair.setLowSoulGemWarningSetting,
        disabled = PAMenuFunctions.PARepair.isLowSoulGemWarningDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.lowSoulGemWarning,
    })
end


-- =================================================================================================================

local function createPABCurrencyGoldSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_MONEY)
    PABCurrencyGoldSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _currencyName),
        getFunc = PAMenuFunctions.PABanking.getGoldTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setGoldTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isGoldTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.goldTransaction,
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getGoldMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setGoldMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isGoldMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.goldMinToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MIN",
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
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
    local _currencyName = GetCurrencyName(CURT_ALLIANCE_POINTS)
    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _currencyName),
        getFunc = PAMenuFunctions.PABanking.getAlliancePointsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setAlliancePointsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.alliancePointsTransaction,
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getAlliancePointsMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setAlliancePointsMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.alliancePointsMinToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN",
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
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
    local _currencyName = GetCurrencyName(CURT_TELVAR_STONES)
    PABCurrencyTelVarSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _currencyName),
        getFunc = PAMenuFunctions.PABanking.getTelVarTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setTelVarTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isTelVarTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.telVarTransaction,
    })

    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getTelVarMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setTelVarMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isTelVarMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.telVarMinToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MIN",
    })
    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
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
    local _currencyName = GetCurrencyName(CURT_WRIT_VOUCHERS)
    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _currencyName),
        getFunc = PAMenuFunctions.PABanking.getWritVouchersTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setWritVouchersTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isWritVouchersTransactionDisabled,
        default = PAMenuDefaults.PABanking.Currencies.writVouchersTransaction,
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PAMenuFunctions.PABanking.getWritVouchersMinToKeepSetting,
        setFunc = PAMenuFunctions.PABanking.setWritVouchersMinToKeepSetting,
        disabled = PAMenuFunctions.PABanking.isWritVouchersMinToKeepDisabled,
        default = PAMenuDefaults.PABanking.Currencies.writVouchersMinToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN",
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_BLACKSMITHING)
    PABCraftingBlacksmithingSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getBlacksmithingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setBlacksmithingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isBlacksmithingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.blacksmithingEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_CLOTHING)
    PABCraftingClothingSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getClothingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setClothingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isClothingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.clothingEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WOODWORKING)
    PABCraftingWoodworkingSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getWoodworkingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setWoodworkingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isWoodworkingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.woodworkingEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRYCRAFTING)
    PABCraftingJewelcraftingSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getJewelcraftingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setJewelcraftingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isJewelcraftingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.jewelcraftingEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALCHEMY)
    PABCraftingAlchemySubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getAlchemyTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setAlchemyTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isAlchemyTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.alchemyEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ENCHANTING)
    PABCraftingEnchantingSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getEnchantingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setEnchantingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isEnchantingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.enchantingEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_PROVISIONING)
    PABCraftingProvisioningSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getProvisioningTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setProvisioningTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isProvisioningTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.provisioningEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_STYLE_MATERIALS)
    PABCraftingStyleMaterialsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getStyleMaterialsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setStyleMaterialsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isStyleMaterialsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.styleMaterialsEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_TRAIT_ITEMS)
    PABCraftingTraitItemsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getTraitItemsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setTraitItemsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isTraitItemsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.traitItemsEnabled,
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
    local _craftingName = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_FURNISHING)
    PABCraftingFurnishingSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getFurnishingTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setFurnishingTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isFurnishingTransactionDisabled,
        default = PAMenuDefaults.PABanking.Crafting.TransactionSettings.furnishingEnabled,
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
    local _craftingName = GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF)
    PABAdvancedMotifSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getMotifTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setMotifTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isMotifTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.motivesEnabled,
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
    local _craftingName = GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE)
    PABAdvancedRecipeSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getRecipeTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setRecipeTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isRecipeTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.recipesEnabled,
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
    local _craftingName = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)
    PABAdvancedGlyphsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getGlyphsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setGlyphsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isGlyphsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.glyphsEnabled,
    })

    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.GLYPHS) do
        PABAdvancedGlyphsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isGlyphsTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABAdvancedLiquidsSubmenuTable()
    local _craftingName = GetString(SI_PA_MENU_BANKING_ADVANCED_LIQUIDS)
    PABAdvancedLiquidsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getLiquidsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setLiquidsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isLiquidsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.liquidsEnabled,
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
    local _craftingName = GetString("SI_ITEMTYPE", ITEMTYPE_TROPHY)
    PABAdvancedTrophiesSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getTrophiesTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setTrophiesTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isTrophiesTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.trophiesEnabled,
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
    local _craftingName = GetString("SI_ITEMTYPE", ITEMTYPE_LOCKPICK)
    PABIndividualLockpickSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getLockpickTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setLockpickTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isLockpickTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.TransactionSettings.lockpicksEnabled,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.LOCKPICK) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualLockpickSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
            default = PAC.OPERATOR.NONE,
        })

        PABIndividualLockpickSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
            default = 100
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABIndividualSoulGemSubmenuTable()
    local _craftingName = GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)
    PABIndividualSoulGemSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getSoulGemTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setSoulGemTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isSoulGemTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.TransactionSettings.soulGemsEnabled,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.SOUL_GEM) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualSoulGemSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
            default = PAC.OPERATOR.NONE,
        })

        PABIndividualSoulGemSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
            default = 100
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABIndividualRepairKitSubmenuTable()
    local _craftingName = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)
    PABIndividualRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getRepairKitTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setRepairKitTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isRepairKitTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.TransactionSettings.repairKitsEnabled,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.REPAIR_KIT) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualRepairKitSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
            default = PAC.OPERATOR.NONE,
        })

        PABIndividualRepairKitSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
            default = 100
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPABIndividualGenericSubmenuTable()
    local _craftingName = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC)
    PABIndividualGenericSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CRAFTING_ANY_ITEMS__ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getGenericTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setGenericTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isGenericTransactionDisabled,
        default = PAMenuDefaults.PABanking.Individual.TransactionSettings.genericsEnabled,
    })

    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.GENERIC) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualGenericSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PAMenuChoices.choices.PABanking.mathOperator,
            choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isGenericTransactionMenuDisabled,
            default = PAC.OPERATOR.NONE,
        })

        PABIndividualGenericSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PAMenuFunctions.PABanking.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = PAMenuFunctions.PABanking.isGenericTransactionMenuDisabled,
            default = 100
        })
    end
end

-- =================================================================================================================

local function createPALHarvestableItemSubMenu()
    PALHarvestableItemSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_DESCRIPTION)
    })

    PALHarvestableItemSubmenuTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_BAIT_HEADER)
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
        name = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_BAIT),
        tooltip = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_BAIT_T),
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
        name = GetString(SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_HEADER)
    })

    for index, itemType in pairs(PALHarvestableItemTypes) do
        PALHarvestableItemSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
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
        name = GetString(SI_PA_MENU_LOOT_AUTOLOOT_ALL_BUTTON),
        tooltip = GetString(SI_PA_MENU_LOOT_AUTOLOOT_ALL_BUTTON_T),
        func = PAMenuFunctions.PALoot.clickAutoLootAllHarvestableButton,
        disabled = PAMenuFunctions.PALoot.isAutoLootAllHarvestableButtonDisabled,
    })

    PALHarvestableItemSubmenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_LOOT_IGNORE_ALL_BUTTON),
        tooltip = GetString(SI_PA_MENU_LOOT_IGNORE_ALL_BUTTON_T),
        func = PAMenuFunctions.PALoot.clickIgnoreAllHarvestableButton,
        disabled = PAMenuFunctions.PALoot.isIgnoreAllHarvestableButtonDisabled,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPALLootableItemSubMenu()
    PALLootableItemSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS_DESCRIPTION)
    })

    PALLootableItemSubmenuTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS_HEADER)
    })

    for index, itemType in pairs(PALLootableItemTypes) do
        PALLootableItemSubmenuTable:insert({
            type = "dropdown",
            name = Getstring("SI_ITEMTYPE", itemType),
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
        name = GetString(SI_PA_MENU_LOOT_AUTOLOOT_LOCKPICKS),
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
        name = GetString(SI_PA_MENU_LOOT_AUTOLOOT_QUESTITEMS),
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
        name = GetString(SI_PA_MENU_LOOT_AUTOLOOT_ALL_BUTTON),
        tooltip = GetString(SI_PA_MENU_LOOT_AUTOLOOT_ALL_BUTTON_T),
        func = PAMenuFunctions.PALoot.clickAutoLootAllLootableButton,
        disabled = PAMenuFunctions.PALoot.isAutoLootAllLootableButtonDisabled,
    })

    PALLootableItemSubmenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_LOOT_IGNORE_ALL_BUTTON),
        tooltip = GetString(SI_PA_MENU_LOOT_IGNORE_ALL_BUTTON_T),
        func = PAMenuFunctions.PALoot.clickIgnoreAllLootableButton,
        disabled = PAMenuFunctions.PALoot.isIgnoreAllLootableButtonDisabled,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPAJAutoMarkAsJunkSubMenu()
    PAJAutoMarkAsJunkSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_TRASH),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_TRASH_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkTrashSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkTrashSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkTrashDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkTrash,
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkOrnate,
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkWeaponsQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkWeaponsQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkWeaponsQualityDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkWeaponsQuality,
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkWeaponsQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkWeaponsQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkWeaponsQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkWeaponsQualityThreshold,
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "description",
        text = GetString(SI_PA_MENU_NOT_YET_IMPLEMENTED)
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkArmorQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkArmorQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkArmorQualityDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkArmorQuality,
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkArmorQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkArmorQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkArmorQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.AutoMarkAsJunk.autoMarkArmorQualityThreshold,
    })

    PAJAutoMarkAsJunkSubMenu:insert({
        type = "description",
        text = GetString(SI_PA_MENU_NOT_YET_IMPLEMENTED)
    })
end

-- =================================================================================================================

local function createOptions()
    -- create submenu for PARepair
    if PA.Repair then
        createPARGoldSubmenuTable()
        createPARRepairKitSubmenuTable()
        createPARRechargeSubmenuTable()
    end


    -- create submenu for PABanking
    if (PA.Banking) then
        createPABCurrencyGoldSubmenuTable()
        createPABCurrencyAlliancePointsSubmenuTable()
        createPABCurrencyTelVarSubmenuTable()
        createPABCurrencyWritVouchersSubmenuTable()

        if not IsESOPlusSubscriber() then
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
        end

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
    if PA.Loot then
        createPALHarvestableItemSubMenu()
        createPALLootableItemSubMenu()
    end

    -- create submenu for PAJunk
    if PA.Junk then
        createPAJAutoMarkAsJunkSubMenu()
    end

    createPAGeneralMenu()
    if PA.Repair then createPARepairMenu() end
    if PA.Banking then createPABankingMenu() end
    if PA.Loot then createPALootMenu() end
    if PA.Junk then createPAJunkMenu() end
    if PA.Mail then createPAMailMenu() end

    -- and register it
    LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
    LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)
end


-- Export
PA.MainMenu = {
    createOptions = createOptions
}
