-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMD = PA.MenuDefaults
local PASV = PA.SavedVars
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

-- PAGeneral

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PASV.Profile.activeProfile
    if (activeProfile == nil) then
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

local function setPAGeneralActiveProfile(profileNo)
    if (profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID) then
        -- get the previously active prefoile first
        local prevProfile = PASV.Profile.activeProfile
        -- then save the new one
        PASV.Profile.activeProfile = profileNo
        PA.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if (prevProfile == nil) then
            local PAMenuHelper = PA.MenuHelper
            PAMenuHelper.reloadProfileList()
        end
        -- also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
    end
end

local function isDisabledPAGeneralNoProfileSelected()
    return (PA.activeProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function isDisabled(savedVarsTable, ...)
    -- TODO: optimize this?
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    local args = { ... }
    for _, tbl in ipairs(args) do
        -- return true when ANY setting is OFF
        if (#tbl == 1) then
            local attributeLevelOne = tbl[1]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne]) then return true end
        elseif (#tbl == 2) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]) then return true end
        elseif (#tbl == 3) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            local attributeLevelThree = tbl[3]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree]) then return true end
        else
            -- if either no table was sent, or more than 3; always return true (i.e. disabled)
            return true
        end
    end
    -- return false when ALL settings are ON
    return false
end


local function isDisabledDebug(savedVarsTable, ...)
    -- TODO: optimize this?
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    local args = { ... }
    for _, tbl in ipairs(args) do
        -- return true when ANY setting is OFF
        if (#tbl == 1) then
            local attributeLevelOne = tbl[1]
            d(tostring(attributeLevelOne).."="..tostring(savedVarsTable[PA.activeProfile][attributeLevelOne]))
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne]) then return true end
        elseif (#tbl == 2) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            d(tostring(attributeLevelOne).."."..tostring(attributeLevelTwo).."="..tostring(savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]))
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]) then return true end
        elseif (#tbl == 3) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            local attributeLevelThree = tbl[3]
            d(tostring(attributeLevelOne).."."..tostring(attributeLevelTwo).."."..tostring(attributeLevelThree).."="..tostring(savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree]))
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree]) then return true end
        else
            -- if either no table was sent, or more than 3; always return true (i.e. disabled)
            d("return true")
            return true
        end
    end
    -- return false when ALL settings are ON
    d("return false")
    return false
end


local function getValue(savedVarsTable, attributeTbl)
    if isDisabledPAGeneralNoProfileSelected() then return end
    if #attributeTbl > 0 then
        local newTableLevel = savedVarsTable[PA.activeProfile]
        for _, attribute in ipairs(attributeTbl) do
            newTableLevel = newTableLevel[attribute]
        end
        return newTableLevel
    else return end
end

local function setValue(savedVarsTable, value, attributeTbl)
    -- TODO: optimize this somehow to make it more dynmimc
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    if (#attributeTbl == 1) then
        local attributeLevelOne = attributeTbl[1]
        savedVarsTable[PA.activeProfile][attributeLevelOne] = value
    elseif (#attributeTbl == 2) then
        local attributeLevelOne = attributeTbl[1]
        local attributeLevelTwo = attributeTbl[2]
        savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo] = value
    elseif (#attributeTbl == 3) then
        local attributeLevelOne = attributeTbl[1]
        local attributeLevelTwo = attributeTbl[2]
        local attributeLevelThree = attributeTbl[3]
        savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree] = value
    else return end
end

--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
local function getPAGeneralActiveProfileRename()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].name
end

local function setPAGeneralActiveProfileRename(profileName)
    if (profileName ~= nil and profileName ~= "") then
        local PAMenuHelper = PA.MenuHelper
        PASV.General[PA.activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        PAMenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PAGeneral   welcomeMessage
---------------------------------
local function getPAGeneralWelcomeMessage()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].welcome
end

local function setPAGeneralWelcomeMessage(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.General[PA.activeProfile].welcome = value
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PARepair

--------------------------------------------------------------------------
-- PARepair   autoRepairEnabled
---------------------------------
local function setPARepairEnabled(value)
    setValue(PASV.Repair, value, {"autoRepairEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking

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
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
    else
        local goldMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "goldMaxToKeep"}) or PAMD.PABanking.Currencies.goldMaxToKeep)

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= goldMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "goldMinToKeep"})
--        else
--            setValue(PASV.Banking, goldMaxToKeep, {"Currencies", "goldMinToKeep"})
--            PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "goldMinToKeep"})
        if (intValue > goldMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "goldMaxToKeep"})
            PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       goldMaxToKeep
---------------------------------
local function setPABAnkingGoldMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
    else
        local goldMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "goldMinToKeep"}) or PAMD.PABanking.Currencies.goldMinToKeep)

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= goldMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "goldMaxToKeep"})
--        else
--            setValue(PASV.Banking, goldMinToKeep, {"Currencies", "goldMaxToKeep"})
--            PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "goldMaxToKeep"})
        if (intValue < goldMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "goldMinToKeep"})
            PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       alliancePointsMinToKeep
---------------------------------
local function setPABAnkingAlliancePointsMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
    else
        local alliancePointsMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "alliancePointsMaxToKeep"}) or PAMD.PABanking.Currencies.alliancePointsMaxToKeep)

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= alliancePointsMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMinToKeep"})
--        else
--            setValue(PASV.Banking, alliancePointsMaxToKeep, {"Currencies", "alliancePointsMinToKeep"})
--            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMinToKeep"})
        if (intValue > alliancePointsMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMaxToKeep"})
            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       alliancePointsMaxToKeep
---------------------------------
local function setPABAnkingAlliancePointsMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
    else
        local alliancePointsMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "alliancePointsMinToKeep"}) or PAMD.PABanking.Currencies.alliancePointsMinToKeep)

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= alliancePointsMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMaxToKeep"})
--        else
--            setValue(PASV.Banking, alliancePointsMinToKeep, {"Currencies", "alliancePointsMaxToKeep"})
--            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMaxToKeep"})
        if (intValue < alliancePointsMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMinToKeep"})
            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       telVarMinToKeep
---------------------------------
local function setPABAnkingTelVarMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
    else
        local telVarMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "telVarMaxToKeep"}) or PAMD.PABanking.Currencies.telVarMaxToKeep)

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= telVarMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "telVarMinToKeep"})
--        else
--            setValue(PASV.Banking, telVarMaxToKeep, {"Currencies", "telVarMinToKeep"})
--            PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "telVarMinToKeep"})
        if (intValue > telVarMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "telVarMaxToKeep"})
            PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       telVarMaxToKeep
---------------------------------
local function setPABAnkingTelVarMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
    else
        local telVarMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "telVarMinToKeep"}) or PAMD.PABanking.Currencies.telVarMinToKeep)

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= telVarMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "telVarMaxToKeep"})
--        else
--            setValue(PASV.Banking, telVarMinToKeep, {"Currencies", "telVarMaxToKeep"})
--            PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "telVarMaxToKeep"})
        if (intValue < telVarMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "telVarMinToKeep"})
            PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       writVouchersMinToKeep
---------------------------------
local function setPABAnkingWritVouchersMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
    else
        local writVouchersMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "writVouchersMaxToKeep"}) or PAMD.PABanking.Currencies.writVouchersMaxToKeep)

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= writVouchersMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"writVouchersMinToKeep"})
--        else
--            setValue(PASV.Banking, writVouchersMaxToKeep, {"Currencies", "writVouchersMinToKeep"})
--            PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMinToKeep"})
        if (intValue > writVouchersMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMaxToKeep"})
            PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       writVouchersMaxToKeep
---------------------------------
local function setPABAnkingWritVouchersMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
    else
        local writVouchersMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "writVouchersMinToKeep"}) or PAMD.PABanking.Currencies.writVouchersMinToKeep)

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= writVouchersMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMaxToKeep"})
--        else
--            setValue(PASV.Banking, writVouchersMinToKeep, {"Currencies", "writVouchersMaxToKeep"})
--            PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMaxToKeep"})
        if (intValue < writVouchersMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMinToKeep"})
            PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
        end
    end
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

-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking - Transaction Setting

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


-- =====================================================================================================================
-- =====================================================================================================================

-- PALoot

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
local function getPALootEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
--    return (PASV.Loot[PA.activeProfile].enabled and not (GetSetting_Bool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)))
    return PASV.Loot[PA.activeProfile].enabled
end

local function setPALootEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PAJunk

--------------------------------------------------------------------------
-- PAJunk   autoMarkAsJunkEnabled
---------------------------------
local function setPAJunkAutoMarkAsJunkEnabledSetting(value)
    setValue(PASV.Junk, value, {"autoMarkAsJunkEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =====================================================================================================================
-- =====================================================================================================================

-- Export
PA.MenuFunctions = {
    PAGeneral = {
        isNoProfileSelected = isDisabledPAGeneralNoProfileSelected,

        getActiveProfile = getPAGeneralActiveProfile,
        setActiveProfile = setPAGeneralActiveProfile,

        getActiveProfileRename = getPAGeneralActiveProfileRename,
        setActiveProfileRename = setPAGeneralActiveProfileRename,

        getWelcomeMessageSetting = getPAGeneralWelcomeMessage,
        setWelcomeMessageSetting = setPAGeneralWelcomeMessage
    },
    PARepair = {
        getAutoRepairEnabledSetting = function() return getValue(PASV.Repair, {"autoRepairEnabled"}) end,
        setAutoRepairEnabledSetting = setPARepairEnabled,

        -- -----------------------------------------------------------------------------------
        -- REPAIR WITH GOLD
        -- -----------------------------
        isRepairWithGoldMenuDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
        isRepairWithGoldDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
        getRepairWithGoldSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithGold"}) end,
        setRepairWithGoldSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithGold"}) end,

        isRepairWithGoldDurabilityThresholdDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
        getRepairWithGoldDurabilityThresholdSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,
        setRepairWithGoldDurabilityThresholdSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,

        isRepairWithGoldChatModeDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
        getRepairWithGoldChatModeSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithGoldChatMode"}) end,
        setRepairWithGoldChatModeSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithGoldChatMode"}) end,

        -- -----------------------------------------------------------------------------------
        -- REPAIR WITH REPAIR KITS
        -- -----------------------------
        isRepairWithRepairKitMenuDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
        isRepairWithRepairKitDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
        getRepairWithRepairKitSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithRepairKit"}) end,
        setRepairWithRepairKitSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithRepairKit"}) end,

        -- TODO: Use Regular Repair Kits

        -- TODO: Threshold

        -- TODO: Use Crown Repair Kits

        -- TODO: Threshold

        -- TODO: Low Repair Kit Warning

        -- TODO: Chat Mode

        -- -----------------------------------------------------------------------------------
        -- RECHARGE WITH SOUL GEMS
        -- -----------------------------
        isRechargeWithSoulGemMenuDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
        isRechargeWithSoulGemDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
        getRechargeWithSoulGemSetting = function() return getValue(PASV.Repair, {"RechargeWeapons", "useSoulGems"}) end,
        setRechargeWithSoulGemSetting = function(value) setValue(PASV.Repair, value, {"RechargeWeapons", "useSoulGems"}) end,

        isChargeWeaponsThresholdDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
        getChargeWeaponsThresholdSetting = function() return getValue(PASV.Repair, {"RechargeWeapons", "chargeWeaponsThreshold"}) end,
        setChargeWeaponsThresholdSetting = function(value) setValue(PASV.Repair, value, {"RechargeWeapons", "chargeWeaponsThreshold"}) end,

        isChargeWeaponsChatModeDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
        getChargeWeaponsChatModeSetting = function() return getValue(PASV.Repair, {"RechargeWeapons", "chargeWeaponsChatMode"}) end,
        setChargeWeaponsChatModeSetting = function(value) setValue(PASV.Repair, value, {"RechargeWeapons", "chargeWeaponsChatMode"}) end,

        isLowSoulGemWarningDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
        getLowSoulGemWarningSetting = function() return getValue(PASV.Repair, {"RechargeWeapons", "lowSoulGemWarning"}) end,
        setLowSoulGemWarningSetting = function(value) setValue(PASV.Repair, value, {"RechargeWeapons", "lowSoulGemWarning"}) end,

    },
    PABanking = {
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

        isTrophiesTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "TransactionSettings", "trophiesEnabled"}) end,
        isTrophiesTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        getTrophiesTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "TransactionSettings", "trophiesEnabled"}) end,
        setTrophiesTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "TransactionSettings", "trophiesEnabled"}) end,

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
    },
    PALoot = {
        isEnabled = getPALootEnabled,
        setIsEnabled = setPALootEnabled,

        -- ----------------------------------------------------------------------------------
        -- RECIPES SETTINGS
        -- -----------------------------
        isLootRecipesMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootRecipes", "enabled"}) end,
        isLootRecipesDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
        getLootRecipesSetting = function() return getValue(PASV.Loot, {"LootRecipes", "enabled"}) end,
        setLootRecipesSetting = function(value) setValue(PASV.Loot, value, {"LootRecipes", "enabled"}) end,

        isUnknownRecipeMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootRecipes", "enabled"}) end,
        getUnknownRecipeMsgSetting = function() return getValue(PASV.Loot, {"LootRecipes", "unknownRecipeMsg"}) end,
        setUnknownRecipeMsgSetting = function(value) setValue(PASV.Loot, value, {"LootRecipes", "unknownRecipeMsg"}) end,

        -- ----------------------------------------------------------------------------------
        -- MOTIFS SETTINGS
        -- -----------------------------
        isLootMotifsMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootMotifs", "enabled"}) end,
        isLootMotifsDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
        getLootMotifsSetting = function() return getValue(PASV.Loot, {"LootMotifs", "enabled"}) end,
        setLootMotifsSetting = function(value) setValue(PASV.Loot, value, {"LootMotifs", "enabled"}) end,

        isUnknownMotifMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootMotifs", "enabled"}) end,
        getUnknownMotifMsgSetting = function() return getValue(PASV.Loot, {"LootMotifs", "unknownMotifMsg"}) end,
        setUnknownMotifMsgSetting = function(value) setValue(PASV.Loot, value, {"LootMotifs", "unknownMotifMsg"}) end,

        -- ----------------------------------------------------------------------------------
        -- APPAREL WEAPONS SETTINGS
        -- -----------------------------
        isLootApparelWeaponsMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootApparelWeapons", "enabled"}) end,
        isLootApparelWeaponsDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
        getLootApparelWeaponsSetting = function() return getValue(PASV.Loot, {"LootApparelWeapons", "enabled"}) end,
        setLootApparelWeaponsSetting = function(value) setValue(PASV.Loot, value, {"LootApparelWeapons", "enabled"}) end,

        isUnknownTraitMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootApparelWeapons", "enabled"}) end,
        getUnknownTraitMsgSetting = function() return getValue(PASV.Loot, {"LootApparelWeapons", "unknownTraitMsg"}) end,
        setUnknownTraitMsgSetting = function(value) setValue(PASV.Loot, value, {"LootApparelWeapons", "unknownTraitMsg"}) end,

    },
    PAJunk = {
        getAutoMarkAsJunkEnabledSetting = function() return getValue(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        setAutoMarkAsJunkEnabledSetting = setPAJunkAutoMarkAsJunkEnabledSetting,

        -- ----------------------------------------------------------------------------------
        -- AUTO MARK JUNK
        -- -----------------------------
        isAutoMarkAsJunkMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,

        isTrashMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Trash", "autoMarkTrash"}) end,  -- TODO: to extend
        isTrashAutoMarkDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        getTrashAutoMarkSetting = function() return getValue(PASV.Junk, {"Trash", "autoMarkTrash"}) end,
        setTrashAutoMarkSetting = function(value) setValue(PASV.Junk, value, {"Trash", "autoMarkTrash"}) end,

        isWeaponsMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Weapons", "autoMarkQuality"}) end, -- TODO: to extend
        isWeaponsAutoMarkQualityDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        getWeaponsAutoMarkQualitySetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkQuality"}) end,
        setWeaponsAutoMarkQualitySetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkQuality"}) end,
        isWeaponsAutoMarkQualityThresholdDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Weapons", "autoMarkQuality"}) end,
        getWeaponsAutoMarkQualityThresholdSetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkQualityThreshold"}) end,
        setWeaponsAutoMarkQualityThresholdSetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkQualityThreshold"}) end,

        isArmorMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Armor", "autoMarkQuality"}) end, -- TODO: to extend
        isArmorAutoMarkQualityDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        getArmorAutoMarkQualitySetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkQuality"}) end,
        setArmorAutoMarkQualitySetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkQuality"}) end,
        isArmorAutoMarkQualityThresholdDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Armor", "autoMarkQuality"}) end,
        getArmorAutoMarkQualityThresholdSetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkQualityThreshold"}) end,
        setArmorAutoMarkQualityThresholdSetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkQualityThreshold"}) end,

        isJewelryMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Jewelry", "autoMarkQuality"}) end, -- TODO: to extend
        isJewelryAutoMarkQualityDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        getJewelryAutoMarkQualitySetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkQuality"}) end,
        setJewelryAutoMarkQualitySetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkQuality"}) end,
        isJewelryAutoMarkQualityThresholdDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Jewelry", "autoMarkQuality"}) end,
        getJewelryAutoMarkQualityThresholdSetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkQualityThreshold"}) end,
        setJewelryAutoMarkQualityThresholdSetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkQualityThreshold"}) end,








        isAutoMarkOrnateDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        getAutoMarkOrnateSetting = function() return getValue(PASV.Junk, {"AutoMarkAsJunk", "autoMarkOrnate"}) end,
        setAutoMarkOrnateSetting = function(value) setValue(PASV.Junk, value, {"AutoMarkAsJunk", "autoMarkOrnate"}) end,

        isIncludeSetItemsDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
        getIncludeSetItemsSetting = function() return getValue(PASV.Junk, {"AutoMarkAsJunk", "includeSetItems"}) end,
        setIncludeSetItemsSetting = function(value) setValue(PASV.Junk, value, {"AutoMarkAsJunk", "includeSetItems"}) end,

        -- ----------------------------------------------------------------------------------
        -- AUTO SELL JUNK
        -- -----------------------------
        isAutoSellJunkDisabled = function() return false end, -- TODO: currently always enabled
        getAutoSellJunkSetting = function() return getValue(PASV.Junk, {"autoSellJunk"}) end,
        setAutoSellJunkSetting = function(value) setValue(PASV.Junk, value, {"autoSellJunk"}) end,
    },
    PAMail = {
        -- -----------------------------------------------------------------------------------
        -- HIRELINGS
        -- -----------------------------
        getHirelingAutoMailEnabledSetting = function() return getValue(PASV.Mail, {"hirelingAutoMailEnabled"}) end,
        setHirelingAutoMailEnabledSetting = function(value) setValue(PASV.Mail, value, {"hirelingAutoMailEnabled"}) end,

        isHirelingDeleteEmptyMailsDisabled = function() return isDisabled(PASV.Mail, {"hirelingAutoMailEnabled"}) end,
        getHirelingDeleteEmptyMailsSetting = function() return getValue(PASV.Mail, {"hirelingDeleteEmptyMails"}) end,
        setHirelingDeleteEmptyMailsSetting = function(value) setValue(PASV.Mail, value, {"hirelingDeleteEmptyMails"}) end,
    }
}











