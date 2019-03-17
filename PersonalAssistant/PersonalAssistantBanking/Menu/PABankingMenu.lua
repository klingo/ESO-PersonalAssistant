-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults
local PAMenuChoices = PA.MenuChoices

local LAM2 = LibStub("LibAddonMenu-2.0")

local PABankingPanelData = {
    type = "panel",
    name = "PersonalAssistant Banking",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pab",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PABankingOptionsTable = setmetatable({}, { __index = table })

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
local PABAdvancedFoodDrinksSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedPapersSubmenuTable = setmetatable({}, { __index = table })

local PABIndividualLockpickSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualSoulGemSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualGenericSubmenuTable = setmetatable({}, { __index = table })


-- =================================================================================================================

local function _createPABankingMenu()
    local _groupName = GetString(SI_PA_MENU_BANKING_CURRENCY)

    PABankingOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_BANKING_HEADER)
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_DESCRIPTION),
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ENABLE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ENABLE_T, _groupName),
        getFunc = PAMenuFunctions.PABanking.getCurrenciesEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setCurrenciesEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Currencies.currenciesEnabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER),
        tooltip = GetCurrencyDescription(CURT_MONEY),
        controls = PABCurrencyGoldSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isGoldTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER),
        tooltip = GetCurrencyDescription(CURT_ALLIANCE_POINTS),
        controls = PABCurrencyAlliancePointsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isAlliancePointsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER),
        tooltip = GetCurrencyDescription(CURT_TELVAR_STONES),
        controls = PABCurrencyTelVarSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isTelVarTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER),
        tooltip = GetCurrencyDescription(CURT_WRIT_VOUCHERS),
        controls = PABCurrencyWritVouchersSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isWritVouchersTransactionMenuDisabled,
    })

    -- -----------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    if (IsESOPlusSubscriber()) then
        -- In case of ESO Plus Subscription, only show a remark that Crafting Material Banking
        -- options are not available (--> Virtual Bag)

        PABankingOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC)
        })

    else
        local _groupName = GetString(SI_PA_MENU_BANKING_CRAFTING)
        -- Regular player without ESO Plus Subscription
        PABankingOptionsTable:insert({
            type = "checkbox",
            name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, _groupName),
            tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, _groupName),
            getFunc = PAMenuFunctions.PABanking.getCraftingItemsEnabledSetting,
            setFunc = PAMenuFunctions.PABanking.setCraftingItemsEnabledSetting,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PABanking.Crafting.craftingItemsEnabled,
        })

        PABankingOptionsTable:insert({
            type = "description",
            text = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_DESCRIPTION, _groupName)
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER),
            controls = PABCraftingBlacksmithingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isBlacksmithingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER),
            controls = PABCraftingClothingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isClothingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER),
            controls = PABCraftingWoodworkingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isWoodworkingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER),
            controls = PABCraftingJewelcraftingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isJewelcraftingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER),
            controls = PABCraftingAlchemySubmenuTable,
            disabled = PAMenuFunctions.PABanking.isAlchemyTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER),
            controls = PABCraftingEnchantingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isEnchantingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER),
            controls = PABCraftingProvisioningSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isProvisioningTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER),
            controls = PABCraftingStyleMaterialsSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isStyleMaterialsTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER),
            controls = PABCraftingTraitItemsSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isTraitItemsTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER),
            controls = PABCraftingFurnishingSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isFurnishingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
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

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, _groupName),
        getFunc = PAMenuFunctions.PABanking.getAdvancedItemsEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setAdvancedItemsEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Advanced.advancedItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_DESCRIPTION, _groupName)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER),
        controls = PABAdvancedMotifSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isMotifTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER),
        controls = PABAdvancedRecipeSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isRecipeTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER),
        controls = PABAdvancedGlyphsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isGlyphsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER),
        controls = PABAdvancedLiquidsSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isLiquidsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER),
        controls = PABAdvancedFoodDrinksSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isFoodDrinksTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_PAPERS_HEADER),
        controls = PABAdvancedPapersSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isPapersTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
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

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, _groupName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, _groupName),
        getFunc = PAMenuFunctions.PABanking.getIndividualItemsEnabledSetting,
        setFunc = PAMenuFunctions.PABanking.setIndividualItemsEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.Individual.individualItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_DESCRIPTION, _groupName)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER),
        controls = PABIndividualLockpickSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isLockpickTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER),
        controls = PABIndividualSoulGemSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isSoulGemTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER),
        controls = PABIndividualRepairKitSubmenuTable,
        disabled = PAMenuFunctions.PABanking.isRepairKitTransactionMenuDisabled,
    })

    -- check if there are any generic items added; if not skip the menu
    if (#PAC.BANKING_INDIVIDUAL.GENERIC > 0) then
        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER),
            controls = PABIndividualGenericSubmenuTable,
            disabled = PAMenuFunctions.PABanking.isGenericTransactionMenuDisabled,
        })
    end


    -- ---------------------------------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
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

    PABankingOptionsTable:insert({
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

    PABankingOptionsTable:insert({
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

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_AUTOSTACKBAGS),
        tooltip = GetString(SI_PA_MENU_BANKING_AUTOSTACKBAGS_T),
        getFunc = PAMenuFunctions.PABanking.getAutoStackBagsSetting,
        setFunc = PAMenuFunctions.PABanking.setAutoStackBagsSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PABanking.autoStackBags,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        tooltip = GetString(SI_PA_MENU_SILENT_MODE_T),
        getFunc = PAMenuFunctions.PABanking.getSilentModeSetting,
        setFunc = PAMenuFunctions.PABanking.setSilentModeSetting,
        disabled = PAMenuFunctions.PABanking.isSilentModeDisabled,
        default = PAMenuDefaults.PABanking.silentMode,
    })
end

-- =================================================================================================================

local function _createPABCurrencyGoldSubmenuTable()
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

local function _createPABCurrencyAlliancePointsSubmenuTable()
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

local function _createPABCurrencyTelVarSubmenuTable()
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

local function _createPABCurrencyWritVouchersSubmenuTable()
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

local function _createPABCraftingBlacksmithingSubmenuTable()
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

local function _createPABCraftingClothingSubmenuTable()
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

local function _createPABCraftingWoodworkingSubmenuTable()
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

local function _createPABCraftingJewelcraftingSubmenuTable()
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

local function _createPABCraftingAlchemySubmenuTable()
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

local function _createPABCraftingEnchantingSubmenuTable()
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

local function _createPABCraftingProvisioningSubmenuTable()
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

local function _createPABCraftingStyleMaterialsSubmenuTable()
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

local function _createPABCraftingTraitItemsSubmenuTable()
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

local function _createPABCraftingFurnishingSubmenuTable()
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

local function _createPABAdvancedMotifSubmenuTable()
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

local function _createPABAdvancedRecipeSubmenuTable()
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

local function _createPABAdvancedGlyphsSubmenuTable()
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

local function _createPABAdvancedLiquidsSubmenuTable()
    local _craftingName = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_POTION)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_POISON))
    PABAdvancedLiquidsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getLiquidsTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setLiquidsTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isLiquidsTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.liquidsEnabled,
    })

    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.LIQUIDS) do
        PABAdvancedLiquidsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isLiquidsTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedFoodDrinksSubmenuTable()
    local _craftingName = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_FOOD)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_DRINK))
    PABAdvancedFoodDrinksSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getFoodDrinksTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setFoodDrinksTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isFoodDrinksTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.foodDrinksEnabled,
    })

    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.FOOD_DRINKS) do
        PABAdvancedFoodDrinksSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = PAMenuFunctions.PABanking.isFoodDrinksTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedPapersSubmenuTable()
    local _craftingName = GetString("SI_ITEMTYPE", ITEMTYPE_TROPHY)
    PABAdvancedPapersSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, _craftingName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T, _craftingName),
        getFunc = PAMenuFunctions.PABanking.getPapersTransactionSetting,
        setFunc = PAMenuFunctions.PABanking.setPapersTransactionSetting,
        disabled = PAMenuFunctions.PABanking.isPapersTransactionDisabled,
        default = PAMenuDefaults.PABanking.Advanced.TransactionSettings.papersEnabled,
    })

    for _, specializedItemType in pairs(PAC.BANKING_ADVANCED.SPECIALIZED.PAPERS) do
        PABAdvancedPapersSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType),
            choices = PAMenuChoices.choices.PABanking.itemMoveMode,
            choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
            -- TODO: choicesTooltips
            getFunc = function() return PAMenuFunctions.PABanking.getAdvancedItemTypeSpecializedMoveSetting(specializedItemType) end,
            setFunc = function(value) PAMenuFunctions.PABanking.setAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value) end,
            disabled = PAMenuFunctions.PABanking.isPapersTransactionMenuDisabled,
            default = PAC.MOVE.IGNORE,
        })
    end
end

-- =================================================================================================================

local function _createPABIndividualLockpickSubmenuTable()
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

local function _createPABIndividualSoulGemSubmenuTable()
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

local function _createPABIndividualRepairKitSubmenuTable()
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

local function _createPABIndividualGenericSubmenuTable()
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

local function createOptions()
    _createPABankingMenu()

    _createPABCurrencyGoldSubmenuTable()
    _createPABCurrencyAlliancePointsSubmenuTable()
    _createPABCurrencyTelVarSubmenuTable()
    _createPABCurrencyWritVouchersSubmenuTable()

    if not IsESOPlusSubscriber() then
        _createPABCraftingBlacksmithingSubmenuTable()
        _createPABCraftingClothingSubmenuTable()
        _createPABCraftingWoodworkingSubmenuTable()
        _createPABCraftingJewelcraftingSubmenuTable()
        _createPABCraftingAlchemySubmenuTable()
        _createPABCraftingEnchantingSubmenuTable()
        _createPABCraftingProvisioningSubmenuTable()
        _createPABCraftingStyleMaterialsSubmenuTable()
        _createPABCraftingTraitItemsSubmenuTable()
        _createPABCraftingFurnishingSubmenuTable()
    end

    _createPABAdvancedMotifSubmenuTable()
    _createPABAdvancedRecipeSubmenuTable()

    _createPABAdvancedGlyphsSubmenuTable()
    _createPABAdvancedLiquidsSubmenuTable()
    _createPABAdvancedFoodDrinksSubmenuTable()
    _createPABAdvancedPapersSubmenuTable()

    _createPABIndividualLockpickSubmenuTable()
    _createPABIndividualSoulGemSubmenuTable()
    _createPABIndividualRepairKitSubmenuTable()
    _createPABIndividualGenericSubmenuTable()

    LAM2:RegisterAddonPanel("PersonalAssistantBankingAddonOptions", PABankingPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantBankingAddonOptions", PABankingOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.createOptions = createOptions
