-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAB = PA.Banking
local PAMD = PA.MenuDefaults
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local isDisabledPAGeneralNoProfileSelected = PAMF.isDisabledPAGeneralNoProfileSelected

local function getValue(...)
    return PAMF.getValue(PAB.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAB.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    PAMF.setValueAndRefreshEvents(PAB.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAB.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PABanking   Currencies       [dynamic]   generic function to update min Currency values
---------------------------------
local function setPABankingCurrencyMinToKeepSetting(PA_LAM_REF_TO_CHANGE, PA_LAM_REF_OTHER, variableToChangeName, variableOtherName, value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PA_LAM_REF_TO_CHANGE:UpdateValue()
    else
        local currencyToKeep = tonumber(getValue({"Currencies", variableOtherName}) or PAMD.PABanking.Currencies[variableOtherName])
        setValue(intValue, {"Currencies", variableToChangeName})
        if intValue > currencyToKeep then
            setValue(intValue, {"Currencies", variableOtherName})
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
        local currencyToKeep = tonumber(getValue({"Currencies", variableOtherName}) or PAMD.PABanking.Currencies[variableOtherName])
        setValue(intValue, {"Currencies", variableToChangeName})
        if intValue < currencyToKeep then
            setValue(intValue, {"Currencies", variableOtherName})
            PA_LAM_REF_OTHER:UpdateValue()
        end
    end
end

-- =================================================================================================================

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
-- PABanking   Crafting.ItemTypes         craftingItemTypeMoveSetting
---------------------------------
local function getPABankingCraftingItemTypeMoveSetting(itemType)
    if isDisabledPAGeneralNoProfileSelected() then return end
    return PAB.SavedVars.Crafting.ItemTypes[itemType].moveMode
end

local function setPABankingCraftingItemTypeMoveSetting(itemType, value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    PAB.SavedVars.Crafting.ItemTypes[itemType].moveMode = value
end

local function setPABankingCraftingItemTypeMoveAllSettings(value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    for itemType, _ in pairs(PAB.SavedVars.Crafting.ItemTypes) do
        PAB.SavedVars.Crafting.ItemTypes[itemType].moveMode = value
    end
    PERSONALASSISTANT_PAB_CRAFTING_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTypes         moveMode
---------------------------------
local function getPABankingAdvancedItemTypeMoveSetting(itemType)
    if isDisabledPAGeneralNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.ItemTypes[itemType]
end

local function setPABankingAdvancedItemTypeMoveSetting(itemType, value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    PAB.SavedVars.Advanced.ItemTypes[itemType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes         advancedItemTypeSpecializedMoveSetting
---------------------------------
local function getPABankingAdvancedItemTypeSpecializedMoveSetting(specializedItemType)
    if isDisabledPAGeneralNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType]
end

local function setPABankingAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType] = value
end


--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTypes         moveMode
---------------------------------
local function isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(...)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    -- if savedVarsArgs is not disabled, check the itemTypes
    local args = { ... }
    for _, itemType in ipairs(args) do
        if PAB.SavedVars.Advanced.ItemTypes[itemType] ~= PAC.MOVE.IGNORE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes         moveMode
---------------------------------
local function isAdvancedItemsDisabledOrAllISpecializedtemTypesMoveModeIgnore(...)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    -- if savedVarsArgs is not disabled, check the itemTypes
    local args = { ... }
    for _, specializedItemType in ipairs(args) do
        if PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType] ~= PAC.MOVE.IGNORE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced         advancedItemTypeMoveSetting + advancedItemTypeSpecializedMoveSetting
---------------------------------
local function setPABankingAdvancedItemTypeMoveAllSettings(value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    for itemType, _ in pairs(PAB.SavedVars.Advanced.ItemTypes) do
        PAB.SavedVars.Advanced.ItemTypes[itemType] = value
    end
    for specializedItemType, _ in pairs(PAB.SavedVars.Advanced.SpecializedItemTypes) do
        PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType] = value
    end
    PERSONALASSISTANT_PAB_ADVANCED_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   Individual.ItemIds         operator
---------------------------------
local function isIndividualItemsDisabledOrAllItemIdsOperatorNone(itemIdList)
    if isDisabled({"Individual", "individualItemsEnabled"}) then return true end

    -- if savedVarsArgs is not disabled, check the itemTypes
    for _, individualItemId in ipairs(itemIdList) do
        if PAB.SavedVars.Individual.ItemIds[individualItemId].operator ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualMathOperator
---------------------------------
local function getPABankingIndividualItemIdMathOperatorSetting(individualItemId)
    if isDisabledPAGeneralNoProfileSelected() then return end
    local value = PAB.SavedVars.Individual.ItemIds[individualItemId].operator
    -- in case a new GENERIC individual item is added, return "-" by default
    if value then return value else return tonumber(PAC.OPERATOR.NONE) end
end

local function setPABankingIndividualItemIdMathOperatorSetting(individualItemId, value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    PAB.SavedVars.Individual.ItemIds[individualItemId].operator = value
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualBackpackAmount
---------------------------------
local function getPABankingIndividualItemIdBackpackAmountSetting(individualItemId)
    if isDisabledPAGeneralNoProfileSelected() then return end
    local value = PAB.SavedVars.Individual.ItemIds[individualItemId].backpackAmount
    -- in case a new GENERIC individual item is added, return "100" by default
    if value then return value else return 100 end
end

local function setPABankingIndividualItemIdBackpackAmountSetting(individualItemId, value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    local intValue = tonumber(value)
    if intValue and intValue >= 0 then
        PAB.SavedVars.Individual.ItemIds[individualItemId].backpackAmount = intValue
    end
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualBackpackAmountDisabled
---------------------------------
local function isIndividualItemsDisabledOrItemIdOperatorNone(individualItemId)
    if isDisabledPAGeneralNoProfileSelected() then return end
    if isDisabled({"Individual", "individualItemsEnabled"}) then return true end
    if PAB.SavedVars.Individual.ItemIds[individualItemId].operator ~= PAC.OPERATOR.NONE then return false end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionDepositStacking
---------------------------------
local function isPABankingTransactionDepositStackingDisabled()
    if not isDisabled({"Crafting", "craftingItemsEnabled"}) then return false end
    if not isDisabled({"Advanced", "advancedItemsEnabled"}) then return false end
    if not isDisabled({"Individual", "individualItemsEnabled"}) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionWithdrawalStacking
---------------------------------
local function isPABankingTransactionWithdrawalStackingDisabled()
    if not isDisabled({"Crafting", "craftingItemsEnabled"}) then return false end
    if not isDisabled({"Advanced", "advancedItemsEnabled"}) then return false end
    if not isDisabled({"Individual", "individualItemsEnabled"}) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionInterval
---------------------------------
local function isPABankingTransactionIntervalDisabled()
    if not isDisabled({"Crafting", "craftingItemsEnabled"}) then return false end
    if not isDisabled({"Advanced", "advancedItemsEnabled"}) then return false end
    if not isDisabled({"Individual", "individualItemsEnabled"}) then return false end
    return true
end

-- =================================================================================================================
local PABankingMenuFunctions = {
    -- -----------------------------------------------------------------------------------
    -- CURRENCIES
    -- -----------------------------
    getCurrenciesEnabledSetting = function() return getValue({"Currencies", "currenciesEnabled"}) end,
    setCurrenciesEnabledSetting = function(value) setValueAndRefreshEvents(value, {"Currencies", "currenciesEnabled"}) end,

    isGoldTransactionMenuDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
    isGoldTransactionDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}) end,
    getGoldTransactionSetting = function() return getValue({"Currencies", "goldTransaction"}) end,
    setGoldTransactionSetting = function(value) setValue(value, {"Currencies", "goldTransaction"}) end,

    isGoldMinToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
    getGoldMinToKeepSetting = function() return getValue({"Currencies", "goldMinToKeep"}) end,
    setGoldMinToKeepSetting = setPABAnkingGoldMinToKeepSetting,

    isGoldMaxToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
    getGoldMaxToKeepSetting = function() return getValue({"Currencies", "goldMaxToKeep"}) end,
    setGoldMaxToKeepSetting = setPABAnkingGoldMaxToKeepSetting,

    isAlliancePointsTransactionMenuDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
    isAlliancePointsTransactionDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}) end,
    getAlliancePointsTransactionSetting = function() return getValue({"Currencies", "alliancePointsTransaction"}) end,
    setAlliancePointsTransactionSetting = function(value) setValue(value, {"Currencies", "alliancePointsTransaction"}) end,

    isAlliancePointsMinToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
    getAlliancePointsMinToKeepSetting = function() return getValue({"Currencies", "alliancePointsMinToKeep"}) end,
    setAlliancePointsMinToKeepSetting = setPABAnkingAlliancePointsMinToKeepSetting,

    isAlliancePointsMaxToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
    getAlliancePointsMaxToKeepSetting = function() return getValue({"Currencies", "alliancePointsMaxToKeep"}) end,
    setAlliancePointsMaxToKeepSetting = setPABAnkingAlliancePointsMaxToKeepSetting,

    isTelVarTransactionMenuDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
    isTelVarTransactionDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}) end,
    getTelVarTransactionSetting = function() return getValue({"Currencies", "telVarTransaction"}) end,
    setTelVarTransactionSetting = function(value) setValue(value, {"Currencies", "telVarTransaction"}) end,

    isTelVarMinToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
    getTelVarMinToKeepSetting = function() return getValue({"Currencies", "telVarMinToKeep"}) end,
    setTelVarMinToKeepSetting = setPABAnkingTelVarMinToKeepSetting,

    isTelVarMaxToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
    getTelVarMaxToKeepSetting = function() return getValue({"Currencies", "telVarMaxToKeep"}) end,
    setTelVarMaxToKeepSetting = setPABAnkingTelVarMaxToKeepSetting,

    isWritVouchersTransactionMenuDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
    isWritVouchersTransactionDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}) end,
    getWritVouchersTransactionSetting = function() return getValue({"Currencies", "writVouchersTransaction"}) end,
    setWritVouchersTransactionSetting = function(value) setValue(value, {"Currencies", "writVouchersTransaction"}) end,

    isWritVouchersMinToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
    getWritVouchersMinToKeepSetting = function() return getValue({"Currencies", "writVouchersMinToKeep"}) end,
    setWritVouchersMinToKeepSetting = setPABAnkingWritVouchersMinToKeepSetting,

    isWritVouchersMaxToKeepDisabled = function() return isDisabled({"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
    getWritVouchersMaxToKeepSetting = function() return getValue({"Currencies", "writVouchersMaxToKeep"}) end,
    setWritVouchersMaxToKeepSetting = setPABAnkingWritVouchersMaxToKeepSetting,

    -- -----------------------------------------------------------------------------------
    -- CRAFTING ITEMS
    -- -----------------------------
    getCraftingItemsEnabledSetting = function() return getValue({"Crafting", "craftingItemsEnabled"}) end,
    setCraftingItemsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"Crafting", "craftingItemsEnabled"}) end,

    isCraftingItemsGlobalMoveModeDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    setCraftingItemsGlobalMoveModeSetting = function(value) setPABankingCraftingItemTypeMoveAllSettings(value) end,

    getCraftingItemTypeMoveSetting = getPABankingCraftingItemTypeMoveSetting,
    setCraftingItemTypeMoveSetting = setPABankingCraftingItemTypeMoveSetting,

    isBlacksmithingTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "blacksmithingEnabled"}) end,
    isBlacksmithingTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getBlacksmithingTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "blacksmithingEnabled"}) end,
    setBlacksmithingTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "blacksmithingEnabled"}) end,

    isClothingTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "clothingEnabled"}) end,
    isClothingTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getClothingTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "clothingEnabled"}) end,
    setClothingTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "clothingEnabled"}) end,

    isWoodworkingTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "woodworkingEnabled"}) end,
    isWoodworkingTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getWoodworkingTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "woodworkingEnabled"}) end,
    setWoodworkingTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "woodworkingEnabled"}) end,

    isJewelcraftingTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "jewelcraftingEnabled"}) end,
    isJewelcraftingTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getJewelcraftingTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "jewelcraftingEnabled"}) end,
    setJewelcraftingTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "jewelcraftingEnabled"}) end,

    isAlchemyTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "alchemyEnabled"}) end,
    isAlchemyTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getAlchemyTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "alchemyEnabled"}) end,
    setAlchemyTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "alchemyEnabled"}) end,

    isEnchantingTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "enchantingEnabled"}) end,
    isEnchantingTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getEnchantingTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "enchantingEnabled"}) end,
    setEnchantingTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "enchantingEnabled"}) end,

    isProvisioningTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "provisioningEnabled"}) end,
    isProvisioningTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getProvisioningTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "provisioningEnabled"}) end,
    setProvisioningTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "provisioningEnabled"}) end,

    isStyleMaterialsTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "styleMaterialsEnabled"}) end,
    isStyleMaterialsTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getStyleMaterialsTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "styleMaterialsEnabled"}) end,
    setStyleMaterialsTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "styleMaterialsEnabled"}) end,

    isTraitItemsTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "traitItemsEnabled"}) end,
    isTraitItemsTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getTraitItemsTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "traitItemsEnabled"}) end,
    setTraitItemsTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "traitItemsEnabled"}) end,

    isFurnishingTransactionMenuDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}, {"Crafting", "TransactionSettings", "furnishingEnabled"}) end,
    isFurnishingTransactionDisabled = function() return isDisabled({"Crafting", "craftingItemsEnabled"}) end,
    getFurnishingTransactionSetting = function() return getValue({"Crafting", "TransactionSettings", "furnishingEnabled"}) end,
    setFurnishingTransactionSetting = function(value) setValue(value, {"Crafting", "TransactionSettings", "furnishingEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- ADVANCED ITEMS
    -- -----------------------------
    getAdvancedItemsEnabledSetting = function() return getValue({"Advanced", "advancedItemsEnabled"}) end,
    setAdvancedItemsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"Advanced", "advancedItemsEnabled"}) end,

    getAdvancedItemTypeMoveSetting = getPABankingAdvancedItemTypeMoveSetting,
    setAdvancedItemTypeMoveSetting = setPABankingAdvancedItemTypeMoveSetting,

    isAdvancedItemsGlobalMoveModeDisabled = function() return isDisabled({"Advanced", "advancedItemsEnabled"}) end,
    setAdvancedItemsGlobalMoveModeSetting = function(value) setPABankingAdvancedItemTypeMoveAllSettings(value) end,

    getAdvancedItemTypeSpecializedMoveSetting = getPABankingAdvancedItemTypeSpecializedMoveSetting,
    setAdvancedItemTypeSpecializedMoveSetting = setPABankingAdvancedItemTypeSpecializedMoveSetting,

    isMotifTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(ITEMTYPE_RACIAL_STYLE_MOTIF) end,
    isRecipeTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(ITEMTYPE_RECIPE) end,
    isWritsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(ITEMTYPE_MASTER_WRIT) end,
    isGlyphsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(ITEMTYPE_GLYPH_ARMOR, ITEMTYPE_GLYPH_JEWELRY, ITEMTYPE_GLYPH_WEAPON) end,
    isLiquidsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(ITEMTYPE_POTION, ITEMTYPE_POISON) end,
    isFoodDrinksTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(ITEMTYPE_FOOD, ITEMTYPE_DRINK) end,
    isTrophiesTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllISpecializedtemTypesMoveModeIgnore(SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP, SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT, SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT) end,


    -- ----------------------------------------------------------------------------------
    -- INDIVIDUAL ITEMS
    -- -----------------------------
    getIndividualItemsEnabledSetting = function() return getValue({"Individual", "individualItemsEnabled"}) end,
    setIndividualItemsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"Individual", "individualItemsEnabled"}) end,

    isLockpickTransactionMenuDisabled = function() return isIndividualItemsDisabledOrAllItemIdsOperatorNone(PAC.BANKING_INDIVIDUAL.LOCKPICK) end,
    isSoulGemTransactionMenuDisabled = function() return isIndividualItemsDisabledOrAllItemIdsOperatorNone(PAC.BANKING_INDIVIDUAL.SOUL_GEM) end,
    isRepairKitTransactionMenuDisabled = function() return isIndividualItemsDisabledOrAllItemIdsOperatorNone(PAC.BANKING_INDIVIDUAL.REPAIR_KIT) end,
    isGenericTransactionMenuDisabled = function() return isIndividualItemsDisabledOrAllItemIdsOperatorNone(PAC.BANKING_INDIVIDUAL.GENERIC) end,

    getIndividualItemIdMathOperatorSetting = getPABankingIndividualItemIdMathOperatorSetting,
    setIndividualItemIdMathOperatorSetting = setPABankingIndividualItemIdMathOperatorSetting,
    getIndividualItemIdAmountSetting = getPABankingIndividualItemIdBackpackAmountSetting,
    setIndividualItemIdAmountSetting = setPABankingIndividualItemIdBackpackAmountSetting,

    isIndividualItemIdAmountDisabled = function(itemId) return isIndividualItemsDisabledOrItemIdOperatorNone(itemId) end,

    -- ----------------------------------------------------------------------------------
    -- TRANSACTION SETTINGS
    -- -----------------------------
    isTransactionDepositStackingDisabled = isPABankingTransactionDepositStackingDisabled,
    getTransactionDepositStackingSetting = function() return getValue({"transactionDepositStacking"}) end,
    setTransactionDepositStackingSetting = function(value) setValue(value, {"transactionDepositStacking"}) end,

    isTransactionWithdrawalStackingDisabled = isPABankingTransactionWithdrawalStackingDisabled,
    getTransactionWithdrawalStackingSetting = function() return getValue({"transactionWithdrawalStacking"}) end,
    setTransactionWithdrawalStackingSetting = function(value) setValue(value, {"transactionWithdrawalStacking"}) end,

    isTransactionInvervalDisabled = isPABankingTransactionIntervalDisabled,
    getTransactionInvervalSetting = function() return getValue({"transactionInterval"}) end,
    setTransactionInvervalSetting = function(value) setValue(value, {"transactionInterval"}) end,

    getAutoStackBagsSetting = function() return getValue({"autoStackBags"}) end,
    setAutoStackBagsSetting = function(value) setValue(value, {"autoStackBags"}) end,

    -- ----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return false end, -- currently always enabled
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PABanking = PABankingMenuFunctions