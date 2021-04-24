-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAB = PA.Banking
local PAMD = PA.MenuDefaults
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PABProfileManager = PA.ProfileManager.PABanking

-- =====================================================================================================================

local isNoProfileSelected = PABProfileManager.isNoProfileSelected

local function getValue(...)
    if isNoProfileSelected() then return end
    return PAMF.getValue(PAB.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return end
    PAMF.setValue(PAB.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    setValue(value, ...)
    PAEM.RefreshEventRegistration.PABanking()
end

local function isDisabled(...)
    if isNoProfileSelected() then return true end
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
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Crafting.ItemTypes[itemType]
end

local function setPABankingCraftingItemTypeMoveSetting(itemType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Crafting.ItemTypes[itemType] = value
end

local function setPABankingCraftingItemTypeMoveAllSettings(value)
    if isNoProfileSelected() then return end
    for itemType, _ in pairs(PAB.SavedVars.Crafting.ItemTypes) do
        PAB.SavedVars.Crafting.ItemTypes[itemType] = value
    end
    PERSONALASSISTANT_PAB_CRAFTING_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   Crafting.ItemTypes         moveMode
---------------------------------
local function isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(itemTypeList)
    if isDisabled({"Crafting", "craftingItemsEnabled"}) then return true end

    for _, itemType in ipairs(itemTypeList) do
        if PAB.SavedVars.Crafting.ItemTypes[itemType] ~= PAC.MOVE.IGNORE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.LearnableItemTypes      moveMode
---------------------------------
local function getPABankingAdvancedLearnableItemTypeMoveSetting(itemType, isKnown)
    if isNoProfileSelected() then return end
    if isKnown then
        return PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Known
    else
        return PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Unknown
    end
end

local function setPABankingAdvancedLearnableItemTypeMoveSetting(itemType, value, isKnown)
    if isNoProfileSelected() then return end
    if isKnown then
        PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Known = value
    else
        PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Unknown = value
    end
end

--------------------------------------------------------------------------
-- PABanking   Advanced.MasterWritCraftingTypes      moveMode
---------------------------------
local function getPABankingAdvancedMasterWritCraftingTypeMoveSetting(craftingType)
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.MasterWritCraftingTypes[craftingType]
end

local function setPABankingAdvancedMasterWritCraftingTypeMoveSetting(craftingType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Advanced.MasterWritCraftingTypes[craftingType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.HolidayWrits                moveMode
---------------------------------
local function getPABankingAdvancedHolidayWritsMoveSetting(specializedItemType)
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.HolidayWrits[specializedItemType]
end

local function setPABankingAdvancedHolidayWritsMoveSetting(specializedItemType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Advanced.HolidayWrits[specializedItemType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTypes         moveMode
---------------------------------
local function getPABankingAdvancedItemTypeMoveSetting(itemType)
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.ItemTypes[itemType]
end

local function setPABankingAdvancedItemTypeMoveSetting(itemType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Advanced.ItemTypes[itemType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTraitTypes      moveMode
---------------------------------
local function getPABankingAdvancedItemTraitTypeMoveSetting(itemTraitType)
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.ItemTraitTypes[itemTraitType]
end

local function setPABankingAdvancedItemTraitTypeMoveSetting(itemTraitType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Advanced.ItemTraitTypes[itemTraitType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes         advancedItemTypeSpecializedMoveSetting
---------------------------------
local function getPABankingAdvancedItemTypeSpecializedMoveSetting(specializedItemType)
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType]
end

local function setPABankingAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes         advancedItemTypeSurveyMapMoveSetting
---------------------------------
local function getPABankingAdvancedItemTypeSurveyMapMoveSetting(itemFilterType)
    if isNoProfileSelected() then return end
    return PAB.SavedVars.Advanced.SpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT][itemFilterType]
end

local function setPABankingAdvancedItemTypeSurveyMapMoveSetting(itemFilterType, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.Advanced.SpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT][itemFilterType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced.LearnableItemTypes         moveMode
---------------------------------
local function isAdvancedLearnableItemsDisabledOrAllLearnableItemTypesMoveModeIgnore(itemTypeList)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    for _, itemType in ipairs(itemTypeList) do
        if PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Known ~= PAC.OPERATOR.NONE then return false end
        if PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Unknown ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.MasterWritCraftingTypes         moveMode
---------------------------------
local function isAdvancedMasterWritCraftingTypesDisabledOrAllMasterWritCraftingTypesMoveModeIgnore(craftingTypeList)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    for _, craftingType in ipairs(craftingTypeList) do
        if PAB.SavedVars.Advanced.MasterWritCraftingTypes[craftingType] ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.HolidayWrits                    moveMode
---------------------------------
local function isAdvancedHolidayWritCraftingTypesDisabledOrAllHolidayWritsMoveModeIgnore()
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    for _, specializedItemType in ipairs(PAC.BANKING_ADVANCED.HOLIDAY_WRITS) do
        if PAB.SavedVars.Advanced.HolidayWrits[specializedItemType] ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTypes         moveMode
---------------------------------
local function isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(itemTypeList)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    for _, itemType in ipairs(itemTypeList) do
        if PAB.SavedVars.Advanced.ItemTypes[itemType] ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes         moveMode
---------------------------------
local function isAdvancedItemsDisabledOrAllSpecializedtemTypesMoveModeIgnore(specializedItemTypeList)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    for _, specializedItemType in ipairs(specializedItemTypeList) do
        if PAB.SavedVars.Advanced.SpecializedItemTypes[specializedItemType] ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.SpecializedItemTypes.TrophySurveyReports         moveMode
---------------------------------
local function isAdvancedItemsDisabledOrAllSpecializedTropySurveyReportsMoveModeIgnore()
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    local surveyReports = PAB.SavedVars.Advanced.SpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT]
    for _, moveMode in pairs(surveyReports) do
        if moveMode ~= PAC.OPERATOR.NONE then return false end
    end
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced.ItemTraitTypes              moveMode
---------------------------------
local function isAdvancedItemsDisabledOrAllItemTraitTypesMoveModeIgnore(itemTraitTypeList)
    if isDisabled({"Advanced", "advancedItemsEnabled"}) then return true end

    for itemTraitType in pairs(itemTraitTypeList) do
        if PAB.SavedVars.Advanced.ItemTraitTypes[itemTraitType] ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   Advanced         advancedItemTypeMoveSetting + advancedItemTypeSpecializedMoveSetting
---------------------------------
local function setPABankingAdvancedItemTypeMoveAllSettings(value)
    if isNoProfileSelected() then return end
    for itemType, _ in pairs(PAB.SavedVars.Advanced.LearnableItemTypes) do
        PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Known = value
        PAB.SavedVars.Advanced.LearnableItemTypes[itemType].Unknown = value
    end
    for craftingType, _ in pairs(PAB.SavedVars.Advanced.MasterWritCraftingTypes) do
        PAB.SavedVars.Advanced.MasterWritCraftingTypes[craftingType] = value
    end
    for specializedItemType, _ in pairs(PAB.SavedVars.Advanced.HolidayWrits) do
        PAB.SavedVars.Advanced.HolidayWrits[specializedItemType] = value
    end
    for itemType, _ in pairs(PAB.SavedVars.Advanced.ItemTypes) do
        PAB.SavedVars.Advanced.ItemTypes[itemType] = value
    end
    local PASVSpecializedItemTypes = PAB.SavedVars.Advanced.SpecializedItemTypes
    for specializedItemType, _ in pairs(PASVSpecializedItemTypes) do
        if specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT then
            for itemFilterType, _ in pairs(PASVSpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT]) do
                PASVSpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT][itemFilterType] = value
            end
        else
            PASVSpecializedItemTypes[specializedItemType] = value
        end
    end
    for itemTraitType, _ in pairs(PAB.SavedVars.Advanced.ItemTraitTypes) do
        PAB.SavedVars.Advanced.ItemTraitTypes[itemTraitType] = value
    end
    PERSONALASSISTANT_PAB_ADVANCED_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   AvA.CrossAllianceItemIds         operator
---------------------------------
local function isAvACrossAllianceItemsDisabledOrAllOperatorNone(crossAllianceItemIdList)
    if isDisabled({"AvA", "avaItemsEnabled"}) then return true end
    -- if savedVarsArgs is not disabled, check the itemTypes
    for crossAllianceItemId, _ in pairs(crossAllianceItemIdList) do
        if PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId].operator ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   AvA                  crossAllianceMathOperator
---------------------------------
local function getPABankingAvaCrossAllianceItemIdMathOperatorSetting(crossAllianceItemId)
    if isNoProfileSelected() then return end
    local value = PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId].operator
    -- in case a new GENERIC individual item is added, return "-" by default
    if value then return value else return tonumber(PAC.OPERATOR.NONE) end
end

local function setPABankingAvaCrossAllianceItemIdMathOperatorSetting(crossAllianceItemId, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId].operator = value
end

--------------------------------------------------------------------------
-- PABanking   AvA                  crossAllianceBagAmount
---------------------------------
local function getPABankingAvaCrossAllianceItemIdBagAmountSetting(crossAllianceItemId)
    if isNoProfileSelected() then return end
    local value = PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId].bagAmount
    -- in case a new GENERIC individual item is added, return the default value
    if value then return value else return PAC.BACKPACK_AMOUNT.DEFAULT end
end

local function setPABankingAvaCrossAllianceItemIdBagAmountSetting(crossAllianceItemId, value)
    if isNoProfileSelected() then return end
    local intValue = tonumber(value)
    if intValue and intValue >= 0 then
        PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId].bagAmount = intValue
    end
end

--------------------------------------------------------------------------
-- PABanking   AvA                  crossAllianceBagAmountDisabled
---------------------------------
local function isAvACrossAllianceItemDisabledOrOperatorNone(crossAllianceItemId)
    if isNoProfileSelected() then return true end
    if isDisabled({"AvA", "avaItemsEnabled"}) then return true end
    if PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId].operator ~= PAC.OPERATOR.NONE then return false end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   AvA.ItemIds          operator
---------------------------------
local function isAvAItemsDisabledOrAllOperatorNone(itemIdList)
    if isDisabled({"AvA", "avaItemsEnabled"}) then return true end

    -- if savedVarsArgs is not disabled, check the itemTypes
    for _, itemId in pairs(itemIdList) do
        if PAB.SavedVars.AvA.ItemIds[itemId].operator ~= PAC.OPERATOR.NONE then return false end
    end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   AvA                  mathOperator
---------------------------------
local function getPABankingtAvAItemIdMathOperatorSetting(itemId)
    if isNoProfileSelected() then return end
    local value = PAB.SavedVars.AvA.ItemIds[itemId].operator
    -- in case a new GENERIC individual item is added, return "-" by default
    if value then return value else return tonumber(PAC.OPERATOR.NONE) end
end

local function setPABankingtAvAItemIdMathOperatorSetting(itemId, value)
    if isNoProfileSelected() then return end
    PAB.SavedVars.AvA.ItemIds[itemId].operator = value
end

--------------------------------------------------------------------------
-- PABanking   AvA                  bagAmount
---------------------------------
local function getPABankingtAvAItemIdBagAmountSetting(itemId)
    if isNoProfileSelected() then return end
    local value = PAB.SavedVars.AvA.ItemIds[itemId].bagAmount
    -- in case a new GENERIC individual item is added, return the default value
    if value then return value else return PAC.BACKPACK_AMOUNT.DEFAULT end
end

local function setPABankingtAvAItemIdBagAmountSetting(itemId, value)
    if isNoProfileSelected() then return end
    local intValue = tonumber(value)
    if intValue and intValue >= 0 then
        PAB.SavedVars.AvA.ItemIds[itemId].bagAmount = intValue
    end
end

--------------------------------------------------------------------------
-- PABanking   AvA                  bagAmountDisabled
---------------------------------
local function isAvAItemDisabledOrOperatorNone(itemId)
    if isNoProfileSelected() then return true end
    if isDisabled({"AvA", "avaItemsEnabled"}) then return true end
    if PAB.SavedVars.AvA.ItemIds[itemId].operator ~= PAC.OPERATOR.NONE then return false end
    -- if there was no 'false' returned until here; then return true
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionDepositStacking
---------------------------------
local function isPABankingTransactionDepositStackingDisabled()
    if not isDisabled({"Crafting", "craftingItemsEnabled"}) then return false end
    if not isDisabled({"Advanced", "advancedItemsEnabled"}) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionWithdrawalStacking
---------------------------------
local function isPABankingTransactionWithdrawalStackingDisabled()
    if not isDisabled({"Crafting", "craftingItemsEnabled"}) then return false end
    if not isDisabled({"Advanced", "advancedItemsEnabled"}) then return false end
    return true
end

-- =====================================================================================================================
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

    isBlacksmithingTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.BLACKSMITHING) end,
    isClothingTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.CLOTHING) end,
    isWoodworkingTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.WOODWORKING) end,
    isJewelcraftingTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.JEWELCRAFTING) end,
    isAlchemyTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.ALCHEMY) end,
    isEnchantingTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.ENCHANTING) end,
    isProvisioningTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.PROVISIONING) end,
    isStyleMaterialsTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.STYLEMATERIALS) end,
    isTraitItemsTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.TRAITITEMS) end,
    isFurnishingTransactionMenuDisabled = function() return isCraftingItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING.FURNISHING) end,

    -- ----------------------------------------------------------------------------------
    -- ADVANCED ITEMS
    -- -----------------------------
    getAdvancedItemsEnabledSetting = function() return getValue({"Advanced", "advancedItemsEnabled"}) end,
    setAdvancedItemsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"Advanced", "advancedItemsEnabled"}) end,
    isAdvancedItemsDisabled = function() return isNoProfileSelected() end,

    getAdvancedLearnableItemTypeMoveSetting = getPABankingAdvancedLearnableItemTypeMoveSetting,
    setAdvancedLearnableItemTypeMoveSetting = setPABankingAdvancedLearnableItemTypeMoveSetting,

    getAdvancedMasterWritCraftingTypeMoveSetting = getPABankingAdvancedMasterWritCraftingTypeMoveSetting,
    setAdvancedMasterWritCraftingTypeMoveSetting = setPABankingAdvancedMasterWritCraftingTypeMoveSetting,

    getAdvancedHolidayWritsMoveSetting = getPABankingAdvancedHolidayWritsMoveSetting,
    setAdvancedHolidayWritsMoveSetting = setPABankingAdvancedHolidayWritsMoveSetting,

    getAdvancedItemTypeMoveSetting = getPABankingAdvancedItemTypeMoveSetting,
    setAdvancedItemTypeMoveSetting = setPABankingAdvancedItemTypeMoveSetting,

    getAdvancedItemTraitTypeMoveSetting = getPABankingAdvancedItemTraitTypeMoveSetting,
    setAdvancedItemTraitTypeMoveSetting = setPABankingAdvancedItemTraitTypeMoveSetting,

    isAdvancedItemsGlobalMoveModeDisabled = function() return isDisabled({"Advanced", "advancedItemsEnabled"}) end,
    setAdvancedItemsGlobalMoveModeSetting = function(value) setPABankingAdvancedItemTypeMoveAllSettings(value) end,

    getAdvancedItemTypeSpecializedMoveSetting = getPABankingAdvancedItemTypeSpecializedMoveSetting,
    setAdvancedItemTypeSpecializedMoveSetting = setPABankingAdvancedItemTypeSpecializedMoveSetting,

    getAdvancedItemTypeSurveyMapMoveSetting = getPABankingAdvancedItemTypeSurveyMapMoveSetting,
    setAdvancedItemTypeSurveyMapMoveSetting = setPABankingAdvancedItemTypeSurveyMapMoveSetting,

    isMotifTransactionMenuDisabled = function() return isAdvancedLearnableItemsDisabledOrAllLearnableItemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.LEARNABLE.MOTIF) end,
    isRecipeTransactionMenuDisabled = function() return isAdvancedLearnableItemsDisabledOrAllLearnableItemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.LEARNABLE.RECIPE) end,
    isMasterWritsTransactionMenuDisabled = function() return isAdvancedMasterWritCraftingTypesDisabledOrAllMasterWritCraftingTypesMoveModeIgnore(PAC.BANKING_ADVANCED.MASTER_WRITS) end,
    isHolidayWritsTransactionMenuDisabled = function() return isAdvancedHolidayWritCraftingTypesDisabledOrAllHolidayWritsMoveModeIgnore(PAC.BANKING_ADVANCED.HOLIDAY_WRITS) end,
    isGlyphsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.REGULAR.GLYPHS) end,
    isLiquidsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.REGULAR.LIQUIDS) end,
    isFoodDrinksTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.REGULAR.FOOD_DRINKS) end,
    isTrophiesTreasureMapsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllSpecializedtemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.SPECIALIZED.TROPHIES.TREASURE_MAPS) end,
    isTrophiesFragmentsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllSpecializedtemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.SPECIALIZED.TROPHIES.FRAGMENTS) end,
    isTrophiesSurveyReportsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllSpecializedTropySurveyReportsMoveModeIgnore() end,
    isIntricateItemsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTraitTypesMoveModeIgnore(PAC.BANKING_ADVANCED.TRAIT.INTRICATE) end,
    isFurnishingItemsTransactionMenuDisabled = function() return isAdvancedItemsDisabledOrAllItemTypesMoveModeIgnore(PAC.BANKING_ADVANCED.REGULAR.FURNISHINGS) end,


    -- ----------------------------------------------------------------------------------
    -- ALLIANCE VERSUS ALLAINCE ITEMS
    -- -----------------------------
    getAvAItemsEnabledSetting = function() return getValue({"AvA", "avaItemsEnabled"}) end,
    setAvAItemsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"AvA", "avaItemsEnabled"}) end,
    isAvAItemsMenuDisabled = function() return isDisabled({"AvA", "avaItemsEnabled"}) end,

    isAvASiegeBallistaTransactionMenuDisabled = function() return isAvACrossAllianceItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.SIEGE[PA.alliance].BALLISTA) end,
    isAvASiegeCatapultTransactionMenuDisabled = function() return isAvACrossAllianceItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.SIEGE[PA.alliance].CATAPULT) end,
    isAvASiegeTrebuchetTransactionMenuDisabled = function() return isAvACrossAllianceItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.SIEGE[PA.alliance].TREBUCHET) end,
    isAvASiegeRamTransactionMenuDisabled = function() return isAvACrossAllianceItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.SIEGE[PA.alliance].RAM) end,
    isAvASiegeOilTransactionMenuDisabled = function() return isAvACrossAllianceItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.SIEGE[PA.alliance].OIL) end,
    isAvASiegeGraveyardTransactionMenuDisabled = function() return isAvACrossAllianceItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.SIEGE[PA.alliance].GRAVEYARD) end,

    isAvARepairTransactionMenuDisabled = function() return isAvAItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.REPAIR) end,
    isAvAOtherTransactionMenuDisabled = function() return isAvAItemsDisabledOrAllOperatorNone(PAC.BANKING_AVA.OTHER) end,

    getAvACrossAlianceItemIdMathOperatorSetting = getPABankingAvaCrossAllianceItemIdMathOperatorSetting,
    setAvACrossAlianceItemIdMathOperatorSetting = setPABankingAvaCrossAllianceItemIdMathOperatorSetting,
    getAvACrossAlianceItemIdAmountSetting = getPABankingAvaCrossAllianceItemIdBagAmountSetting,
    setAvACrossAlianceItemIdAmountSetting = setPABankingAvaCrossAllianceItemIdBagAmountSetting,

    isAvACrossAlianceItemIdAmountDisabled = function(crossAllianceItemId) return isAvACrossAllianceItemDisabledOrOperatorNone(crossAllianceItemId) end,

    getAvAItemIdMathOperatorSetting = getPABankingtAvAItemIdMathOperatorSetting,
    setAvAItemIdMathOperatorSetting = setPABankingtAvAItemIdMathOperatorSetting,
    getAvAItemIdAmountSetting = getPABankingtAvAItemIdBagAmountSetting,
    setAvAItemIdAmountSetting = setPABankingtAvAItemIdBagAmountSetting,

    isAvAItemIdAmountDisabled = function(itemId) return isAvAItemDisabledOrOperatorNone(itemId) end,


    -- ----------------------------------------------------------------------------------
    -- TRANSACTION SETTINGS
    -- -----------------------------
    getAutoExecuteItemTransfersSetting = function() return getValue({"autoExecuteItemTransfers"}) end,
    setAutoExecuteItemTransfersSetting = function(value) setValue(value, {"autoExecuteItemTransfers"}) end,

    isTransactionDepositStackingDisabled = isPABankingTransactionDepositStackingDisabled,
    getTransactionDepositStackingSetting = function() return getValue({"transactionDepositStacking"}) end,
    setTransactionDepositStackingSetting = function(value) setValue(value, {"transactionDepositStacking"}) end,

    isTransactionWithdrawalStackingDisabled = isPABankingTransactionWithdrawalStackingDisabled,
    getTransactionWithdrawalStackingSetting = function() return getValue({"transactionWithdrawalStacking"}) end,
    setTransactionWithdrawalStackingSetting = function(value) setValue(value, {"transactionWithdrawalStacking"}) end,

    getExcludeJunkSetting = function() return getValue({"excludeJunk"}) end,
    setExcludeJunkSetting = function(value) setValue(value, {"excludeJunk"}) end,

    getAutoStackBagsSetting = function() return getValue({"autoStackBags"}) end,
    setAutoStackBagsSetting = function(value) setValue(value, {"autoStackBags"}) end,

    -- ----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return isDisabled() end, -- currently always enabled
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- =====================================================================================================================
-- Export
PAMF.PABanking = PABankingMenuFunctions