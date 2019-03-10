-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAEM = PA.EventManager
local PAMD = PA.MenuDefaults
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local isDisabledPAGeneralNoProfileSelected = PAMF.isDisabledPAGeneralNoProfileSelected
local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

--------------------------------------------------------------------------
-- PABanking   Currencies       [dynamic]   generic function to update min Currency values
---------------------------------
local function setPABankingCurrencyMinToKeepSetting(PA_LAM_REF_TO_CHANGE, PA_LAM_REF_OTHER, variableToChangeName, variableOtherName, value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PA_LAM_REF_TO_CHANGE:UpdateValue()
    else
        local currencyToKeep = tonumber(getValue(PASV.Banking, {"Currencies", variableOtherName}) or PAMD.PABanking.Currencies[variableOtherName])
        setValue(PASV.Banking, intValue, {"Currencies", variableToChangeName})
        if (intValue > currencyToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", variableOtherName})
            PA_LAM_REF_OTHER:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       [dynamic]   generic function to update max Currency values
---------------------------------
local function setPABankingCurrencyMaxToKeepSetting(PA_LAM_REF_TO_CHANGE, PA_LAM_REF_OTHER, variableToChangeName, variableOtherName, value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PA_LAM_REF_TO_CHANGE:UpdateValue()
    else
        local currencyToKeep = tonumber(getValue(PASV.Banking, {"Currencies", variableOtherName}) or PAMD.PABanking.Currencies[variableOtherName])
        setValue(PASV.Banking, intValue, {"Currencies", variableToChangeName})
        if (intValue < currencyToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", variableOtherName})
            PA_LAM_REF_OTHER:UpdateValue()
        end
    end
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PABanking   Currencies       currenciesEnabled
---------------------------------
local function setPABankingCurrenciesEnabledSetting(value)
    setValue(PASV.Banking, value, {"Currencies", "currenciesEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Currencies       goldMinToKeep
---------------------------------
local function setPABAnkingGoldMinToKeepSetting(value)
    setPABankingCurrencyMinToKeepSetting(PERSONALASSISTANT_PAB_GOLD_MIN, PERSONALASSISTANT_PAB_GOLD_MAX, "goldMinToKeep", "goldMaxToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       goldMaxToKeep
---------------------------------
local function setPABAnkingGoldMaxToKeepSetting(value)
    setPABankingCurrencyMaxToKeepSetting(PERSONALASSISTANT_PAB_GOLD_MAX, PERSONALASSISTANT_PAB_GOLD_MIN, "goldMaxToKeep", "goldMinToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       alliancePointsMinToKeep
---------------------------------
local function setPABAnkingAlliancePointsMinToKeepSetting(value)
    setPABankingCurrencyMinToKeepSetting(PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN, PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX, "alliancePointsMinToKeep", "alliancePointsMaxToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       alliancePointsMaxToKeep
---------------------------------
local function setPABAnkingAlliancePointsMaxToKeepSetting(value)
    setPABankingCurrencyMaxToKeepSetting(PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX, PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN, "alliancePointsMaxToKeep", "alliancePointsMinToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       telVarMinToKeep
---------------------------------
local function setPABAnkingTelVarMinToKeepSetting(value)
    setPABankingCurrencyMinToKeepSetting(PERSONALASSISTANT_PAB_TELVAR_MIN, PERSONALASSISTANT_PAB_TELVAR_MAX, "telVarMinToKeep", "telVarMaxToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       telVarMaxToKeep
---------------------------------
local function setPABAnkingTelVarMaxToKeepSetting(value)
    setPABankingCurrencyMaxToKeepSetting(PERSONALASSISTANT_PAB_TELVAR_MAX, PERSONALASSISTANT_PAB_TELVAR_MIN, "telVarMaxToKeep", "telVarMinToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       writVouchersMinToKeep
---------------------------------
local function setPABAnkingWritVouchersMinToKeepSetting(value)
    setPABankingCurrencyMinToKeepSetting(PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN, PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX, "writVouchersMinToKeep", "writVouchersMaxToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Currencies       writVouchersMaxToKeep
---------------------------------
local function setPABAnkingWritVouchersMaxToKeepSetting(value)
    setPABankingCurrencyMaxToKeepSetting(PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX, PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN, "writVouchersMaxToKeep", "writVouchersMinToKeep", value)
end

--------------------------------------------------------------------------
-- PABanking   Crafting         craftingItemsEnabled
---------------------------------
local function setPABankingCraftingItemsEnabledSetting(value)
    setValue(PASV.Banking, value, {"Crafting", "craftingItemsEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Crafting.ItemTypes         craftingItemTypeMoveSetting
---------------------------------
local function getPABankingCraftingItemTypeMoveSetting(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].Crafting.ItemTypes[itemType].moveMode
end

local function setPABankingCraftingItemTypeMoveSetting(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Crafting.ItemTypes[itemType].moveMode = value
end

local function setPABankingCraftingItemTypeMoveAllSettings(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    for itemType, _ in pairs(PASV.Banking[PA.activeProfile].Crafting.ItemTypes) do
        PASV.Banking[PA.activeProfile].Crafting.ItemTypes[itemType].moveMode = value
    end
    PERSONALASSISTANT_PAB_CRAFTING_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   Advanced      advancedItemsEnabled
---------------------------------
local function setPABankingAdvancedItemsEnabledSetting(value)
    setValue(PASV.Banking, value, {"Advanced", "advancedItemsEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTypes         moveMode
---------------------------------
local function getPABankingAdvancedItemTypeMoveSetting(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].Advanced.ItemTypes[itemType].moveMode
end

local function setPABankingAdvancedItemTypeMoveSetting(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Advanced.ItemTypes[itemType].moveMode = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes         advancedItemTypeSpecializedMoveSetting
---------------------------------
local function getPABankingAdvancedItemTypeSpecializedMoveSetting(specializedItemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].Advanced.SpecializedItemTypes[specializedItemType].moveMode
end

local function setPABankingAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Advanced.SpecializedItemTypes[specializedItemType].moveMode = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced         advancedItemTypeMoveSetting + advancedItemTypeSpecializedMoveSetting
---------------------------------
local function setPABankingAdvancedItemTypeMoveAllSettings(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    for itemType, _ in pairs(PASV.Banking[PA.activeProfile].Advanced.ItemTypes) do
        PASV.Banking[PA.activeProfile].Advanced.ItemTypes[itemType].moveMode = value
    end
    for specializedItemType, _ in pairs(PASV.Banking[PA.activeProfile].Advanced.SpecializedItemTypes) do
        PASV.Banking[PA.activeProfile].Advanced.SpecializedItemTypes[specializedItemType].moveMode = value
    end
    PERSONALASSISTANT_PAB_ADVANCED_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualItemsEnabled
---------------------------------
local function setPABankingIndividualItemsEnabledSetting(value)
    setValue(PASV.Banking, value, {"Individual", "individualItemsEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualMathOperator
---------------------------------
local function getPABankingIndividualItemIdMathOperatorSetting(individualItemId)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    local value = PASV.Banking[PA.activeProfile].Individual.ItemIds[individualItemId].operator
    -- in case a new GENERIC individual item is added, return "-" by default
    if (value) then return value else return tonumber(PAC.OPERATOR.NONE) end
end

local function setPABankingIndividualItemIdMathOperatorSetting(individualItemId, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Individual.ItemIds[individualItemId].operator = value
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualBackpackAmount
---------------------------------
local function getPABankingIndividualItemIdBackpackAmountSetting(individualItemId)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    local value = PASV.Banking[PA.activeProfile].Individual.ItemIds[individualItemId].backpackAmount
    -- in case a new GENERIC individual item is added, return "100" by default
    if (value) then return value else return 100 end
end

local function setPABankingIndividualItemIdBackpackAmountSetting(individualItemId, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    local intValue = tonumber(value)
    if intValue and intValue >= 0 then
        PASV.Banking[PA.activeProfile].Individual.ItemIds[individualItemId].backpackAmount = intValue
    end
end

--------------------------------------------------------------------------
-- PABanking   transactionDepositStacking
---------------------------------
local function isPABankingTransactionDepositStackingDisabled()
    if (not isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"})) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionWithdrawalStacking
---------------------------------
local function isPABankingTransactionWithdrawalStackingDisabled()
    if (not isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"})) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionInterval
---------------------------------
local function isPABankingTransactionIntervalDisabled()
    if (not isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"})) then return false end
    return true
end

-- =================================================================================================================

local PABankingMenuFunctions = {
    isChatOutputDisabled = false, -- always enabled
    getChatOutputSetting = function() return getValue(PASV.Banking, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PASV.Banking, value, {"chatOutput"}) end,

    -- -----------------------------------------------------------------------------------
    -- CURRENCIES
    -- -----------------------------
    getCurrenciesEnabledSetting = function() return getValue(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
    setCurrenciesEnabledSetting = setPABankingCurrenciesEnabledSetting,

    isGoldTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
    isGoldTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
    getGoldTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "goldTransaction"}) end,
    setGoldTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "goldTransaction"}) end,

    isGoldMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
    getGoldMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "goldMinToKeep"}) end,
    setGoldMinToKeepSetting =  setPABAnkingGoldMinToKeepSetting,

    isGoldMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
    getGoldMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "goldMaxToKeep"}) end,
    setGoldMaxToKeepSetting =  setPABAnkingGoldMaxToKeepSetting,

    isAlliancePointsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
    isAlliancePointsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
    getAlliancePointsTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "alliancePointsTransaction"}) end,
    setAlliancePointsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "alliancePointsTransaction"}) end,

    isAlliancePointsMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
    getAlliancePointsMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "alliancePointsMinToKeep"}) end,
    setAlliancePointsMinToKeepSetting = setPABAnkingAlliancePointsMinToKeepSetting,

    isAlliancePointsMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
    getAlliancePointsMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "alliancePointsMaxToKeep"}) end,
    setAlliancePointsMaxToKeepSetting = setPABAnkingAlliancePointsMaxToKeepSetting,

    isTelVarTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
    isTelVarTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
    getTelVarTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "telVarTransaction"}) end,
    setTelVarTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "telVarTransaction"}) end,

    isTelVarMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
    getTelVarMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "telVarMinToKeep"}) end,
    setTelVarMinToKeepSetting = setPABAnkingTelVarMinToKeepSetting,

    isTelVarMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
    getTelVarMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "telVarMaxToKeep"}) end,
    setTelVarMaxToKeepSetting = setPABAnkingTelVarMaxToKeepSetting,

    isWritVouchersTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
    isWritVouchersTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
    getWritVouchersTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "writVouchersTransaction"}) end,
    setWritVouchersTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "writVouchersTransaction"}) end,

    isWritVouchersMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
    getWritVouchersMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "writVouchersMinToKeep"}) end,
    setWritVouchersMinToKeepSetting = setPABAnkingWritVouchersMinToKeepSetting,

    isWritVouchersMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
    getWritVouchersMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "writVouchersMaxToKeep"}) end,
    setWritVouchersMaxToKeepSetting = setPABAnkingWritVouchersMaxToKeepSetting,

    -- -----------------------------------------------------------------------------------
    -- CRAFTING ITEMS
    -- -----------------------------
    getCraftingItemsEnabledSetting = function() return getValue(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    setCraftingItemsEnabledSetting = setPABankingCraftingItemsEnabledSetting,

    isCraftingItemsGlobalMoveModeDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    setCraftingItemsGlobalMoveModeSetting = function(value) setPABankingCraftingItemTypeMoveAllSettings(value) end,

    getCraftingItemTypeMoveSetting = getPABankingCraftingItemTypeMoveSetting,
    setCraftingItemTypeMoveSetting = setPABankingCraftingItemTypeMoveSetting,

    isBlacksmithingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "blacksmithingEnabled"}) end,
    isBlacksmithingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getBlacksmithingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "blacksmithingEnabled"}) end,
    setBlacksmithingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "blacksmithingEnabled"}) end,

    isClothingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "clothingEnabled"}) end,
    isClothingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getClothingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "clothingEnabled"}) end,
    setClothingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "clothingEnabled"}) end,

    isWoodworkingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "woodworkingEnabled"}) end,
    isWoodworkingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getWoodworkingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "woodworkingEnabled"}) end,
    setWoodworkingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "woodworkingEnabled"}) end,

    isJewelcraftingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "jewelcraftingEnabled"}) end,
    isJewelcraftingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getJewelcraftingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "jewelcraftingEnabled"}) end,
    setJewelcraftingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "jewelcraftingEnabled"}) end,

    isAlchemyTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "alchemyEnabled"}) end,
    isAlchemyTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getAlchemyTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "alchemyEnabled"}) end,
    setAlchemyTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "alchemyEnabled"}) end,

    isEnchantingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "enchantingEnabled"}) end,
    isEnchantingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getEnchantingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "enchantingEnabled"}) end,
    setEnchantingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "enchantingEnabled"}) end,

    isProvisioningTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "provisioningEnabled"}) end,
    isProvisioningTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getProvisioningTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "provisioningEnabled"}) end,
    setProvisioningTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "provisioningEnabled"}) end,

    isStyleMaterialsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "styleMaterialsEnabled"}) end,
    isStyleMaterialsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getStyleMaterialsTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "styleMaterialsEnabled"}) end,
    setStyleMaterialsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "styleMaterialsEnabled"}) end,

    isTraitItemsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "traitItemsEnabled"}) end,
    isTraitItemsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getTraitItemsTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "traitItemsEnabled"}) end,
    setTraitItemsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "traitItemsEnabled"}) end,

    isFurnishingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "furnishingEnabled"}) end,
    isFurnishingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
    getFurnishingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "TransactionSettings", "furnishingEnabled"}) end,
    setFurnishingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "TransactionSettings", "furnishingEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- ADVANCED ITEMS
    -- -----------------------------
    getAdvancedItemsEnabledSetting = function() return getValue(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    setAdvancedItemsEnabledSetting = setPABankingAdvancedItemsEnabledSetting,

    getAdvancedItemTypeMoveSetting = getPABankingAdvancedItemTypeMoveSetting,
    setAdvancedItemTypeMoveSetting = setPABankingAdvancedItemTypeMoveSetting,

    isAdvancedItemsGlobalMoveModeDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    setAdvancedItemsGlobalMoveModeSetting = function(value) setPABankingAdvancedItemTypeMoveAllSettings(value) end,

    getAdvancedItemTypeSpecializedMoveSetting = getPABankingAdvancedItemTypeSpecializedMoveSetting,
    setAdvancedItemTypeSpecializedMoveSetting = setPABankingAdvancedItemTypeSpecializedMoveSetting,

    isMotifTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "motivesEnabled"}) end,
    isMotifTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    getMotifTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "motivesEnabled"}) end,
    setMotifTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "motivesEnabled"}) end,

    isRecipeTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "recipesEnabled"}) end,
    isRecipeTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    getRecipeTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "recipesEnabled"}) end,
    setRecipeTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "recipesEnabled"}) end,

    isGlyphsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "glyphsEnabled"}) end,
    isGlyphsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    getGlyphsTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "glyphsEnabled"}) end,
    setGlyphsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "glyphsEnabled"}) end,

    isLiquidsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "liquidsEnabled"}) end,
    isLiquidsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    getLiquidsTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "liquidsEnabled"}) end,
    setLiquidsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "liquidsEnabled"}) end,

    isFoodDrinksTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "foodDrinksEnabled"}) end,
    isFoodDrinksTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    getFoodDrinksTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "foodDrinksEnabled"}) end,
    setFoodDrinksTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "foodDrinksEnabled"}) end,

    isPapersTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "papersEnabled"}) end,
    isPapersTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
    getPapersTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "papersEnabled"}) end,
    setPapersTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "papersEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- INDIVIDUAL ITEMS
    -- -----------------------------
    getIndividualItemsEnabledSetting = function() return getValue(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
    setIndividualItemsEnabledSetting = setPABankingIndividualItemsEnabledSetting,

    isLockpickTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "TransactionSettings", "lockpicksEnabled"}) end,
    isLockpickTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
    getLockpickTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "TransactionSettings", "lockpicksEnabled"}) end,
    setLockpickTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "TransactionSettings", "lockpicksEnabled"}) end,

    isSoulGemTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "TransactionSettings", "soulGemsEnabled"}) end,
    isSoulGemTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
    getSoulGemTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "TransactionSettings", "soulGemsEnabled"}) end,
    setSoulGemTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "TransactionSettings", "soulGemsEnabled"}) end,

    isRepairKitTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "TransactionSettings", "repairKitsEnabled"}) end,
    isRepairKitTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
    getRepairKitTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "TransactionSettings", "repairKitsEnabled"}) end,
    setRepairKitTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "TransactionSettings", "repairKitsEnabled"}) end,

    isGenericTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "TransactionSettings", "genericsEnabled"}) end,
    isGenericTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
    getGenericTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "TransactionSettings", "genericsEnabled"}) end,
    setGenericTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "TransactionSettings", "genericsEnabled"}) end,

    getIndividualItemIdMathOperatorSetting = getPABankingIndividualItemIdMathOperatorSetting,
    setIndividualItemIdMathOperatorSetting = setPABankingIndividualItemIdMathOperatorSetting,
    getIndividualItemIdAmountSetting = getPABankingIndividualItemIdBackpackAmountSetting,
    setIndividualItemIdAmountSetting = setPABankingIndividualItemIdBackpackAmountSetting,

    -- ----------------------------------------------------------------------------------
    -- TRANSACTION SETTINGS
    -- -----------------------------
    isTransactionDepositStackingDisabled = isPABankingTransactionDepositStackingDisabled,
    getTransactionDepositStackingSetting = function() return getValue(PASV.Banking, {"transactionDepositStacking"}) end,
    setTransactionDepositStackingSetting = function(value) setValue(PASV.Banking, value, {"transactionDepositStacking"}) end,

    isTransactionWithdrawalStackingDisabled = isPABankingTransactionWithdrawalStackingDisabled,
    getTransactionWithdrawalStackingSetting = function() return getValue(PASV.Banking, {"transactionWithdrawalStacking"}) end,
    setTransactionWithdrawalStackingSetting = function(value) setValue(PASV.Banking, value, {"transactionWithdrawalStacking"}) end,

    isTransactionInvervalDisabled = isPABankingTransactionIntervalDisabled,
    getTransactionInvervalSetting = function() return getValue(PASV.Banking, {"transactionInterval"}) end,
    setTransactionInvervalSetting = function(value) setValue(PASV.Banking, value, {"transactionInterval"}) end,

    getAutoStackBagsSetting = function() return getValue(PASV.Banking, {"autoStackBags"}) end,
    setAutoStackBagsSetting = function(value) setValue(PASV.Banking, value, {"autoStackBags"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PABanking = PABankingMenuFunctions