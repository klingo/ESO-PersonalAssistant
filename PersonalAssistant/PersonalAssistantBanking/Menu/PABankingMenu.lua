-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
local PAGMenuFunctions = PA.MenuFunctions.PAGeneral
local PABMenuChoices = PA.MenuChoices.choices.PABanking
local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking
local PABMenuDefaults = PA.MenuDefaults.PABanking
local PABMenuFunctions = PA.MenuFunctions.PABanking

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
local PABAdvancedWritsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedGlyphsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedLiquidsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedFoodDrinksSubmenuTable = setmetatable({}, { __index = table })

local PABAdvancedTrophiesSubmenuTable = setmetatable({}, { __index = table })

local PABIndividualLockpickSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualSoulGemSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualGenericSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPABankingMenu()
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
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_ENABLE),
        getFunc = PABMenuFunctions.getCurrenciesEnabledSetting,
        setFunc = PABMenuFunctions.setCurrenciesEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.Currencies.currenciesEnabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER),
        tooltip = GetCurrencyDescription(CURT_MONEY),
        controls = PABCurrencyGoldSubmenuTable,
        disabledLabel = PABMenuFunctions.isGoldTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER),
        tooltip = GetCurrencyDescription(CURT_ALLIANCE_POINTS),
        controls = PABCurrencyAlliancePointsSubmenuTable,
        disabledLabel = PABMenuFunctions.isAlliancePointsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER),
        tooltip = GetCurrencyDescription(CURT_TELVAR_STONES),
        controls = PABCurrencyTelVarSubmenuTable,
        disabledLabel = PABMenuFunctions.isTelVarTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER),
        tooltip = GetCurrencyDescription(CURT_WRIT_VOUCHERS),
        controls = PABCurrencyWritVouchersSubmenuTable,
        disabledLabel = PABMenuFunctions.isWritVouchersTransactionMenuDisabled,
    })

    -- -----------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })


    -- check if player has the addon [Dolgubon's Lazy Writ Crafter]
    if WritCreater then
        -- if yes, add additional option
        PABankingOptionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_BANKING_LWC_COMPATIBILTY),
            tooltip = GetString(SI_PA_MENU_BANKING_LWC_COMPATIBILTY_T),
            getFunc = PABMenuFunctions.getLazyWritCraftingCompatiblitySetting,
            setFunc = PABMenuFunctions.setLazyWritCraftingCompatiblitySetting,
            disabled = PAGMenuFunctions.isNoProfileSelected,
            default = PABMenuDefaults.lazyWritCraftingCompatiblity,
        })

        PABankingOptionsTable:insert({
            type = "divider",
            alpha = 0.5,
        })
    end


    if IsESOPlusSubscriber() then
        -- In case of ESO Plus Subscription, only show a remark that Crafting Material Banking
        -- options are not available (--> Virtual Bag)

        PABankingOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC)
        })

    else
        -- Regular player without ESO Plus Subscription
        PABankingOptionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENABLE),
            tooltip = GetString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T),
            getFunc = PABMenuFunctions.getCraftingItemsEnabledSetting,
            setFunc = PABMenuFunctions.setCraftingItemsEnabledSetting,
            disabled = PAGMenuFunctions.isNoProfileSelected,
            default = PABMenuDefaults.Crafting.craftingItemsEnabled,
        })

        PABankingOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION)
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER),
            controls = PABCraftingBlacksmithingSubmenuTable,
            disabledLabel = PABMenuFunctions.isBlacksmithingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER),
            controls = PABCraftingClothingSubmenuTable,
            disabledLabel = PABMenuFunctions.isClothingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER),
            controls = PABCraftingWoodworkingSubmenuTable,
            disabledLabel = PABMenuFunctions.isWoodworkingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER),
            controls = PABCraftingJewelcraftingSubmenuTable,
            disabledLabel = PABMenuFunctions.isJewelcraftingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER),
            controls = PABCraftingAlchemySubmenuTable,
            disabledLabel = PABMenuFunctions.isAlchemyTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER),
            controls = PABCraftingEnchantingSubmenuTable,
            disabledLabel = PABMenuFunctions.isEnchantingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER),
            controls = PABCraftingProvisioningSubmenuTable,
            disabledLabel = PABMenuFunctions.isProvisioningTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER),
            controls = PABCraftingStyleMaterialsSubmenuTable,
            disabledLabel = PABMenuFunctions.isStyleMaterialsTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER),
            controls = PABCraftingTraitItemsSubmenuTable,
            disabledLabel = PABMenuFunctions.isTraitItemsTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER),
            controls = PABCraftingFurnishingSubmenuTable,
            disabledLabel = PABMenuFunctions.isFurnishingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE),
            tooltip = GetString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemsGlobalMoveModeSetting(value) end,
            disabled = PABMenuFunctions.isCraftingItemsGlobalMoveModeDisabled,
            warning = GetString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W),
            reference = "PERSONALASSISTANT_PAB_CRAFTING_GLOBAL_MOVE_MODE",
        })
    end

    -- ---------------------------------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_ENABLE),
        tooltip = GetString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T),
        getFunc = PABMenuFunctions.getAdvancedItemsEnabledSetting,
        setFunc = PABMenuFunctions.setAdvancedItemsEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.Advanced.advancedItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER),
        controls = PABAdvancedMotifSubmenuTable,
        disabledLabel = PABMenuFunctions.isMotifTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER),
        controls = PABAdvancedRecipeSubmenuTable,
        disabledLabel = PABMenuFunctions.isRecipeTransactionMenuDisabled,
    })
    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_WRITS_HEADER),
        controls = PABAdvancedWritsSubmenuTable,
        disabledLabel = PABMenuFunctions.isWritsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER),
        controls = PABAdvancedGlyphsSubmenuTable,
        disabledLabel = PABMenuFunctions.isGlyphsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER),
        controls = PABAdvancedLiquidsSubmenuTable,
        disabledLabel = PABMenuFunctions.isLiquidsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER),
        controls = PABAdvancedFoodDrinksSubmenuTable,
        disabledLabel = PABMenuFunctions.isFoodDrinksTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER),
        controls = PABAdvancedTrophiesSubmenuTable,
        disabledLabel = PABMenuFunctions.isTrophiesTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE),
        tooltip = GetString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T),
        choices = PABMenuChoices.itemMoveMode,
        choicesValues = PABMenuChoicesValues.itemMoveMode,
        getFunc = function() return end,
        setFunc = function(value) PABMenuFunctions.setAdvancedItemsGlobalMoveModeSetting(value) end,
        disabled = PABMenuFunctions.isAdvancedItemsGlobalMoveModeDisabled,
        warning = GetString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W),
        reference = "PERSONALASSISTANT_PAB_ADVANCED_GLOBAL_MOVE_MODE",
    })

    -- -----------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE),
        tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE_T),
        getFunc = PABMenuFunctions.getIndividualItemsEnabledSetting,
        setFunc = PABMenuFunctions.setIndividualItemsEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.Individual.individualItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER),
        controls = PABIndividualLockpickSubmenuTable,
        disabledLabel = PABMenuFunctions.isLockpickTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER),
        controls = PABIndividualSoulGemSubmenuTable,
        disabledLabel = PABMenuFunctions.isSoulGemTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER),
        controls = PABIndividualRepairKitSubmenuTable,
        disabledLabel = PABMenuFunctions.isRepairKitTransactionMenuDisabled,
    })

    -- check if there are any generic items added; if not skip the menu
    if #PAC.BANKING_INDIVIDUAL.GENERIC > 0 then
        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER),
            controls = PABIndividualGenericSubmenuTable,
            disabledLabel = PABMenuFunctions.isGenericTransactionMenuDisabled,
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
        choices = PABMenuChoices.stackingType,
        choicesValues = PABMenuChoicesValues.stackingType,
        width = "half",
        getFunc = PABMenuFunctions.getTransactionDepositStackingSetting,
        setFunc = PABMenuFunctions.setTransactionDepositStackingSetting,
        disabled = PABMenuFunctions.isTransactionDepositStackingDisabled,
        default = PABMenuDefaults.transactionDepositStacking,
    })

    PABankingOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING),
        tooltip = GetString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T),
        choices = PABMenuChoices.stackingType,
        choicesValues = PABMenuChoicesValues.stackingType,
        width = "half",
        getFunc = PABMenuFunctions.getTransactionWithdrawalStackingSetting,
        setFunc = PABMenuFunctions.setTransactionWithdrawalStackingSetting,
        disabled = PABMenuFunctions.isTransactionWithdrawalStackingDisabled,
        default = PABMenuDefaults.transactionWithdrawalStacking,
    })

    PABankingOptionsTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL),
        tooltip = GetString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T),
        min = 100,
        max = 1000,
        step = 50,
        getFunc = PABMenuFunctions.getTransactionInvervalSetting,
        setFunc = PABMenuFunctions.setTransactionInvervalSetting,
        disabled = PABMenuFunctions.isTransactionInvervalDisabled,
        default = PABMenuDefaults.transactionInterval,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_AUTOSTACKBAGS),
        tooltip = GetString(SI_PA_MENU_BANKING_AUTOSTACKBAGS_T),
        getFunc = PABMenuFunctions.getAutoStackBagsSetting,
        setFunc = PABMenuFunctions.setAutoStackBagsSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.autoStackBags,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PABMenuFunctions.getSilentModeSetting,
        setFunc = PABMenuFunctions.setSilentModeSetting,
        disabled = PABMenuFunctions.isSilentModeDisabled,
        default = PABMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPABCurrencyGoldSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_MONEY)
    PABCurrencyGoldSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getGoldTransactionSetting,
        setFunc = PABMenuFunctions.setGoldTransactionSetting,
        disabled = PABMenuFunctions.isGoldTransactionDisabled,
        default = PABMenuDefaults.Currencies.goldTransaction,
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getGoldMinToKeepSetting,
        setFunc = PABMenuFunctions.setGoldMinToKeepSetting,
        disabled = PABMenuFunctions.isGoldMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.goldMinToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MIN",
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getGoldMaxToKeepSetting,
        setFunc = PABMenuFunctions.setGoldMaxToKeepSetting,
        disabled = PABMenuFunctions.isGoldMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.goldMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCurrencyAlliancePointsSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_ALLIANCE_POINTS)
    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getAlliancePointsTransactionSetting,
        setFunc = PABMenuFunctions.setAlliancePointsTransactionSetting,
        disabled = PABMenuFunctions.isAlliancePointsTransactionDisabled,
        default = PABMenuDefaults.Currencies.alliancePointsTransaction,
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getAlliancePointsMinToKeepSetting,
        setFunc = PABMenuFunctions.setAlliancePointsMinToKeepSetting,
        disabled = PABMenuFunctions.isAlliancePointsMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.alliancePointsMinToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN",
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getAlliancePointsMaxToKeepSetting,
        setFunc = PABMenuFunctions.setAlliancePointsMaxToKeepSetting,
        disabled = PABMenuFunctions.isAlliancePointsMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.alliancePointsMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCurrencyTelVarSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_TELVAR_STONES)
    PABCurrencyTelVarSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getTelVarTransactionSetting,
        setFunc = PABMenuFunctions.setTelVarTransactionSetting,
        disabled = PABMenuFunctions.isTelVarTransactionDisabled,
        default = PABMenuDefaults.Currencies.telVarTransaction,
    })

    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getTelVarMinToKeepSetting,
        setFunc = PABMenuFunctions.setTelVarMinToKeepSetting,
        disabled = PABMenuFunctions.isTelVarMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.telVarMinToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MIN",
    })
    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getTelVarMaxToKeepSetting,
        setFunc = PABMenuFunctions.setTelVarMaxToKeepSetting,
        disabled = PABMenuFunctions.isTelVarMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.telVarMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCurrencyWritVouchersSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_WRIT_VOUCHERS)
    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getWritVouchersTransactionSetting,
        setFunc = PABMenuFunctions.setWritVouchersTransactionSetting,
        disabled = PABMenuFunctions.isWritVouchersTransactionDisabled,
        default = PABMenuDefaults.Currencies.writVouchersTransaction,
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getWritVouchersMinToKeepSetting,
        setFunc = PABMenuFunctions.setWritVouchersMinToKeepSetting,
        disabled = PABMenuFunctions.isWritVouchersMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.writVouchersMinToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN",
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getWritVouchersMaxToKeepSetting,
        setFunc = PABMenuFunctions.setWritVouchersMaxToKeepSetting,
        disabled = PABMenuFunctions.isWritVouchersMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.writVouchersMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX",
    })
end

-- =================================================================================================================

local function _createPABCraftingBlacksmithingSubmenuTable()
    PABCraftingBlacksmithingSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getBlacksmithingTransactionSetting,
        setFunc = PABMenuFunctions.setBlacksmithingTransactionSetting,
        disabled = PABMenuFunctions.isBlacksmithingTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.blacksmithingEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.BLACKSMITHING) do
        PABCraftingBlacksmithingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isBlacksmithingTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingClothingSubmenuTable()
    PABCraftingClothingSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getClothingTransactionSetting,
        setFunc = PABMenuFunctions.setClothingTransactionSetting,
        disabled = PABMenuFunctions.isClothingTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.clothingEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.CLOTHING) do
        PABCraftingClothingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isClothingTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingWoodworkingSubmenuTable()
    PABCraftingWoodworkingSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getWoodworkingTransactionSetting,
        setFunc = PABMenuFunctions.setWoodworkingTransactionSetting,
        disabled = PABMenuFunctions.isWoodworkingTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.woodworkingEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.WOODWORKING) do
        PABCraftingWoodworkingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isWoodworkingTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingJewelcraftingSubmenuTable()
    PABCraftingJewelcraftingSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getJewelcraftingTransactionSetting,
        setFunc = PABMenuFunctions.setJewelcraftingTransactionSetting,
        disabled = PABMenuFunctions.isJewelcraftingTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.jewelcraftingEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.JEWELCRAFTING) do
        PABCraftingJewelcraftingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isJewelcraftingTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingAlchemySubmenuTable()
    PABCraftingAlchemySubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getAlchemyTransactionSetting,
        setFunc = PABMenuFunctions.setAlchemyTransactionSetting,
        disabled = PABMenuFunctions.isAlchemyTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.alchemyEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.ALCHEMY) do
        PABCraftingAlchemySubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isAlchemyTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingEnchantingSubmenuTable()
    PABCraftingEnchantingSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getEnchantingTransactionSetting,
        setFunc = PABMenuFunctions.setEnchantingTransactionSetting,
        disabled = PABMenuFunctions.isEnchantingTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.enchantingEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.ENCHANTING) do
        PABCraftingEnchantingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isEnchantingTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingProvisioningSubmenuTable()
    PABCraftingProvisioningSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getProvisioningTransactionSetting,
        setFunc = PABMenuFunctions.setProvisioningTransactionSetting,
        disabled = PABMenuFunctions.isProvisioningTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.provisioningEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.PROVISIONING) do
        PABCraftingProvisioningSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isProvisioningTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingStyleMaterialsSubmenuTable()
    PABCraftingStyleMaterialsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getStyleMaterialsTransactionSetting,
        setFunc = PABMenuFunctions.setStyleMaterialsTransactionSetting,
        disabled = PABMenuFunctions.isStyleMaterialsTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.styleMaterialsEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.STYLEMATERIALS) do
        PABCraftingStyleMaterialsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isStyleMaterialsTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingTraitItemsSubmenuTable()
    PABCraftingTraitItemsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getTraitItemsTransactionSetting,
        setFunc = PABMenuFunctions.setTraitItemsTransactionSetting,
        disabled = PABMenuFunctions.isTraitItemsTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.traitItemsEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.TRAITITEMS) do
        PABCraftingTraitItemsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isTraitItemsTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingFurnishingSubmenuTable()
    PABCraftingFurnishingSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING_ITEMS_ENABLE),
        getFunc = PABMenuFunctions.getFurnishingTransactionSetting,
        setFunc = PABMenuFunctions.setFurnishingTransactionSetting,
        disabled = PABMenuFunctions.isFurnishingTransactionDisabled,
        default = PABMenuDefaults.Crafting.TransactionSettings.furnishingEnabled,
    })

    for _, itemType in pairs(PAC.BANKING.FURNISHING) do
        PABCraftingFurnishingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = PABMenuFunctions.isFurnishingTransactionMenuDisabled,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType].moveMode,
        })
    end
end

-- =================================================================================================================

local function _createPABAdvancedMotifSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.MOTIF) do
        PABAdvancedMotifSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedRecipeSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.RECIPE) do
        PABAdvancedRecipeSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedWritsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.WRITS) do
        PABAdvancedWritsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- =================================================================================================================

local function _createPABAdvancedGlyphsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.GLYPHS) do
        PABAdvancedGlyphsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedLiquidsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.LIQUIDS) do
        PABAdvancedLiquidsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedFoodDrinksSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.FOOD_DRINKS) do
        PABAdvancedFoodDrinksSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedTrophiesSubmenuTable()
    for _, specializedItemType in pairs(PAC.BANKING_ADVANCED.SPECIALIZED.TROPHIES) do
        PABAdvancedTrophiesSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeSpecializedMoveSetting(specializedItemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.SpecializedItemTypes[specializedItemType],
        })
    end
end

-- =================================================================================================================

local function _createPABIndividualLockpickSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.LOCKPICK) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualLockpickSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualLockpickSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABIndividualSoulGemSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.SOUL_GEM) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualSoulGemSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualSoulGemSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABIndividualRepairKitSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.REPAIR_KIT) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualRepairKitSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualRepairKitSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABIndividualGenericSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.GENERIC) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualGenericSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualGenericSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
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
    _createPABAdvancedWritsSubmenuTable()
    _createPABAdvancedGlyphsSubmenuTable()
    _createPABAdvancedLiquidsSubmenuTable()
    _createPABAdvancedFoodDrinksSubmenuTable()

    _createPABAdvancedTrophiesSubmenuTable()

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
