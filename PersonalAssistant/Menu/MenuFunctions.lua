-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAEM = PA.EventManager
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

-- PAGeneral

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PASV.Profile.activeProfile
    if (activeProfile == nil) then
        return PAG_NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

local function setPAGeneralActiveProfile(profileNo)
    if (profileNo ~= nil and profileNo ~= PAG_NO_PROFILE_SELECTED_ID) then
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
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    local args = { ... }
    for _, v in ipairs(args) do
        -- return true when ANY setting is OFF
        if (not savedVarsTable[PA.activeProfile][v]) then return true end
    end
    -- return false when ALL settings are ON
    return false
end

local function getValue(savedVarsTable, attribute)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return savedVarsTable[PA.activeProfile][attribute]
end

local function setValue(savedVarsTable, attribute, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    savedVarsTable[PA.activeProfile][attribute] = value
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
-- PARepair   enable
---------------------------------
local function getPARepairEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
--    return PersonalAssistant.SavedVars.Repair[PersonalAssistant.SavedVars.Profile.activeProfile].enabled
    return PASV.Repair[PA.activeProfile].enabled
end

local function setPARepairEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PARepair   repairEquipped
---------------------------------
local function getPARepairRepairEquipped()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquipped
end

local function setPARepairRepairEquipped(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquipped = value
end

local function isDisabledPARepairRepairEquipped()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedThreshold
---------------------------------
local function getPARepairRepairEquippedThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquippedThreshold
end

local function setPARepairRepairEquippedThreshold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquippedThreshold = value
end

local function isDisabledPARepairRepairEquippedThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedWithKit
---------------------------------
local function getPARepairRepairEquippedWithKit()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquippedWithKit
end

local function setPARepairRepairEquippedWithKit(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquippedWithKit = value
end

local function isDisabledPARepairRepairEquippedWithKit()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedWithKitThreshold
---------------------------------
local function getPARepairRepairEquippedWithKitThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquippedWithKitThreshold
end

local function setPARepairRepairEquippedWithKitThreshold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquippedWithKitThreshold = value
end

local function isDisabledPARepairRepairEquippedWithKitThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquippedWithKit)
end

--------------------------------------------------------------------------
-- PARepair   repairFullChatMode
---------------------------------
local function getPARepairRepairFullChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairFullChatMode
end

local function setPARepairRepairFullChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairFullChatMode = value
end

local function isDisabledPARepairRepairFullChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   repairPartialChatMode
---------------------------------
local function getPARepairRepairPartialChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairPartialChatMode
end

local function setPARepairRepairPartialChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairPartialChatMode = value
end

local function isDisabledPARepairRepairPartialChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   chargeWeapons
---------------------------------
local function getPARepairChargeWeapons()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].chargeWeapons
end

local function setPARepairChargeWeapons(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].chargeWeapons = value
end

local function isDisabledPARepairChargeWeapons()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   chargeWeaponsThreshold
---------------------------------
local function getPARepairChargeWeaponsThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].chargeWeaponsThreshold
end

local function setPARepairChargeWeaponsThreshold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].chargeWeaponsThreshold = value
end

local function isDisabledPARepairChargeWeaponsThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].chargeWeapons)
end

--------------------------------------------------------------------------
-- PARepair   chargeWeaponsChatMode
---------------------------------
local function getPARepairChargeWeaponsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].chargeWeaponsChatMode
end

local function setPARepairChargeWeaponsChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].chargeWeaponsChatMode = value
end

local function isDisabledPARepairChargeWeaponsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].chargeWeapons)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking

--------------------------------------------------------------------------
-- PABanking   enable
---------------------------------
local function getPABankingEenabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].enabled
end

local function setPABankingEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   goldMinToKeep
---------------------------------
local function setPABAnkingGoldMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
    else
        local goldMaxToKeep = tonumber(getValue(PASV.Banking, "goldMaxToKeep"))
        if (intValue <= goldMaxToKeep) then
            setValue(PASV.Banking, "goldMinToKeep", value)
        else
            setValue(PASV.Banking, "goldMinToKeep", goldMaxToKeep)
            PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   goldMaxToKeep
---------------------------------
local function setPABAnkingGoldMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
    else
        local goldMinToKeep = tonumber(getValue(PASV.Banking, "goldMinToKeep"))
        if (intValue >= goldMinToKeep) then
            setValue(PASV.Banking, "goldMaxToKeep", value)
        else
            setValue(PASV.Banking, "goldMaxToKeep", goldMinToKeep)
            PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   alliancePointsMinToKeep
---------------------------------
local function setPABAnkingAlliancePointsMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
    else
        local alliancePointsMaxToKeep = tonumber(getValue(PASV.Banking, "alliancePointsMaxToKeep"))
        if (intValue <= alliancePointsMaxToKeep) then
            setValue(PASV.Banking, "alliancePointsMinToKeep", value)
        else
            setValue(PASV.Banking, "alliancePointsMinToKeep", alliancePointsMaxToKeep)
            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   alliancePointsMaxToKeep
---------------------------------
local function setPABAnkingAlliancePointsMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
    else
        local alliancePointsMinToKeep = tonumber(getValue(PASV.Banking, "alliancePointsMinToKeep"))
        if (intValue >= alliancePointsMinToKeep) then
            setValue(PASV.Banking, "alliancePointsMaxToKeep", value)
        else
            setValue(PASV.Banking, "alliancePointsMaxToKeep", alliancePointsMinToKeep)
            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   telVarMinToKeep
---------------------------------
local function setPABAnkingTelVarMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
    else
        local telVarMaxToKeep = tonumber(getValue(PASV.Banking, "telVarMaxToKeep"))
        if (intValue <= telVarMaxToKeep) then
            setValue(PASV.Banking, "telVarMinToKeep", value)
        else
            setValue(PASV.Banking, "telVarMinToKeep", telVarMaxToKeep)
            PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   telVarMaxToKeep
---------------------------------
local function setPABAnkingTelVarMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
    else
        local telVarMinToKeep = tonumber(getValue(PASV.Banking, "telVarMinToKeep"))
        if (intValue >= telVarMinToKeep) then
            setValue(PASV.Banking, "telVarMaxToKeep", value)
        else
            setValue(PASV.Banking, "telVarMaxToKeep", telVarMinToKeep)
            PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   writVouchersMinToKeep
---------------------------------
local function setPABAnkingWritVouchersMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
    else
        local writVouchersMaxToKeep = tonumber(getValue(PASV.Banking, "writVouchersMaxToKeep"))
        if (intValue <= writVouchersMaxToKeep) then
            setValue(PASV.Banking, "writVouchersMinToKeep", value)
        else
            setValue(PASV.Banking, "writVouchersMinToKeep", writVouchersMaxToKeep)
            PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   writVouchersMaxToKeep
---------------------------------
local function setPABAnkingWritVouchersMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue then
        PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
    else
        local writVouchersMinToKeep = tonumber(getValue(PASV.Banking, "writVouchersMinToKeep"))
        if (intValue >= writVouchersMinToKeep) then
            setValue(PASV.Banking, "writVouchersMaxToKeep", value)
        else
            setValue(PASV.Banking, "writVouchersMaxToKeep", writVouchersMinToKeep)
            PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   itemTransaction
---------------------------------
local function getPABankingItemTransaction()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].itemTransaction
end

local function setPABankingItemTransaction(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].itemTransaction = value
end

local function isDisabledPABankingItemTransaction()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Banking[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   depositTimerInterval
---------------------------------
local function getPABankingDepositTimerInterval()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].depositTimerInterval
end

local function setPABankingDepositTimerInterval(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].depositTimerInterval = value
end

local function isDisabledPABankingDepositTimerInterval()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - ItemTypeMaterialSubmenu

--------------------------------------------------------------------------
-- PABAnking - ItemTypeMaterialSubmenu   itemTypesMaterialMoveMode
---------------------------------
local function getPABankingItemTypesMaterialMoveMode(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].ItemTypesMaterial[itemType]
end

local function setPABankingItemTypesMaterialMoveMode(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].ItemTypesMaterial[itemType] = value
end

local function isDisabledPABankingItemTypesMaterialMoveMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - ItemTypeSubmenu

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemsDepStackType
---------------------------------
local function getPABankingItemsDepStackType()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].itemsDepStackType
end

local function setPABankingItemsDepStackType(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].itemsDepStackType = value
end

local function isDisabledPABankingItemsDepStackType()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemsWitStackType
---------------------------------
local function getPABankingItemsWitStackType()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].itemsWitStackType
end

local function setPABankingItemsWitStackType(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].itemsWitStackType = value
end

local function isDisabledPABankingItemsWitStackType()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemTypesMoveMode
---------------------------------
local function getPABankingItemTypesMoveMode(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].ItemTypes[itemType]
end

local function setPABankingItemTypesMoveMode(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].ItemTypes[itemType] = value
end

local function isDisabledPABankingItemTypesMoveMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  autoLootAllHarvestableButton
---------------------------------
local function PABankingDepositAllItemTypesButton()
    for _, itemType in pairs(PABItemTypes) do
        PASV.Banking[PA.activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_DEPOSIT
    end
end

local function isDisabledPABankingDepositAllItemTypesButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  withdrawAllItemTypesButton
---------------------------------
local function PABankingWithdrawAllItemTypesButton()
    for _, itemType in pairs(PABItemTypes) do
        PASV.Banking[PA.activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_WITHDRAWAL
    end
end

local function isDisabledPABankingWithdrawAllItemTypesButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  ignoreAllItemTypesButton
---------------------------------
local function PABankingIgnoreAllItemTypesButton()
    for _, itemType in pairs(PABItemTypes) do
        PASV.Banking[PA.activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

local function isDisabledPABankingIgnoreAllItemTypesButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - AdvancedItemTypeSubmenu

--------------------------------------------------------------------------
-- PABAnking - AdvancedItemTypeSubmenu   advItemTypesOperator
---------------------------------
local function getPABankingAdvItemTypesOperator(advancedItemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].ItemTypesAdvanced[advancedItemType].Operator
end

local function setPABankingAdvItemTypesOperator(advancedItemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].ItemTypesAdvanced[advancedItemType].Operator = value
end

local function isDisabledPABankingAdvItemTypesOperator()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end

--------------------------------------------------------------------------
-- PABAnking - AdvancedItemTypeSubmenu   advItemTypesValue
---------------------------------
local function getPABankingAdvItemTypesValue(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].ItemTypesAdvanced[itemType].Value
end

local function setPABankingAdvItemTypesValue(advancedItemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].ItemTypesAdvanced[advancedItemType].Value = value
end

local function isDisabledPABankingAdvItemTypesValue()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].itemTransaction)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PALoot

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
local function getPALootEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].enabled
end

local function setPALootEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PALoot   lootGold
---------------------------------
local function getPALootLootGold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootGold
end

local function setPALootLootGold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootGold = value
end

local function isDisabledPALootLootGold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Loot[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootGoldChatMode
---------------------------------
local function getPALootLootGoldChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootGoldChatMode
end

local function setPALootLootGoldChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootGoldChatMode = value
end

local function isDisabledPALootLootGoldChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootGold)
end

--------------------------------------------------------------------------
-- PALoot   lootItems
---------------------------------
local function getPALootLootItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootItems
end

local function setPALootLootItems(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootItems = value
end

local function isDisabledPALootLootItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Loot[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootItemsChatMode
---------------------------------
local function getPALootLootItemsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootItemsChatMode
end

local function setPALootLootItemsChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootItemsChatMode = value
end

local function isDisabledPALootLootItemsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   lootStolenItems
---------------------------------
local function getPALootLootStolenItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootStolenItems
end

local function setPALootLootStolenItems(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootStolenItems = value
end

local function isDisabledPALootLootStolenItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableBaitLootMode
---------------------------------
local function getPALootHarvestableBaitLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].harvestableBaitLootMode
end

local function setPALootHarvestableBaitLootMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].harvestableBaitLootMode = value
end

local function isDisabledPALootHarvestableBaitLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableItemTypesLootMode
---------------------------------
local function getPALootHarvestableItemTypesLootMode(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType]
end

local function setPALootHarvestableItemTypesLootMode(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = value
end

local function isDisabledPALootHarvestableItemTypesLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu autoLootAllHarvestableButton
---------------------------------
local function PALootAutoLootAllHarvestableButton()
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

local function isDisabledPALootAutoLootAllHarvestableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu ignoreAllHarvestableButton
---------------------------------
local function PALootIgnoreAllHarvestableButton()
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

local function isDisabledPALootIgnoreAllHarvestableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lootableItemTypesLootMode
---------------------------------
local function getPALootLootableItemTypesLootMode(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].LootableItemTypes[itemType]
end

local function setPALootLootableItemTypesLootMode(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].LootableItemTypes[itemType] = value
end

local function isDisabledPALootLootableItemTypesLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lockpickLootMode
---------------------------------
local function getPALootLockpickLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lockpickLootMode
end

local function setPALootLockpickLootMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lockpickLootMode = value
end

local function isDisabledPALootLockpickLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu questItemsLootMode
---------------------------------
local function getPALootQuestItemsLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].questItemsLootMode
end

local function setPALootQuestItemsLootMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].questItemsLootMode = value
end

local function isDisabledPALootQuestItemsLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu autoLootAllLootableButton
---------------------------------
local function PALootAutoLootAllLootableButton()
    for _, itemType in pairs(PALLootableItemTypes) do
        PASV.Loot[PA.activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
        PASV.Loot[PA.activeProfile].lockpickLootMode = PAC_ITEMTYPE_LOOT
        PASV.Loot[PA.activeProfile].questItemsLootMode = PAC_ITEMTYPE_LOOT
    end
end

local function isDisabledPALootAutoLootAllLootableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu ignoreAllLootableButton
---------------------------------
local function PALootIgnoreAllLootableButton()
    for _, itemType in pairs(PALLootableItemTypes) do
        PASV.Loot[PA.activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
        PASV.Loot[PA.activeProfile].lockpickLootMode = PAC_ITEMTYPE_IGNORE
        PASV.Loot[PA.activeProfile].questItemsLootMode = PAC_ITEMTYPE_IGNORE
    end
end

local function isDisabledPALootIgnoreAllLootableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PAJunk

--------------------------------------------------------------------------
-- PAJunk   enabled
---------------------------------
local function getPAJunkEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].enabled
end

local function setPAJunkEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PAJunk   autoSellJunk
---------------------------------
local function getPAJunkAutoSellJunk()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].autoSellJunk
end

local function setPAJunkAutoSellJunk(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].autoSellJunk = value
end

local function isDisabledPAJunkAutoSellJunk()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Junk[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PAJunk   autoMarkTrash
---------------------------------
local function getPAJunkAutoMarkTrash()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].autoMarkTrash
end

local function setPAJunkAutoMarkTrash(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].autoMarkTrash = value
end

local function isDisabledPAJunkAutoMarkTrash()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Junk[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PAJunk   autoMarkOrnate
---------------------------------
local function getPAJunkAutoMarkOrnate()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].autoMarkOrnate
end

local function setPAJunkAutoMarkOrnate(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].autoMarkOrnate = value
end

local function isDisabledPAJunkAutoMarkOrnate()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Junk[PA.activeProfile].enabled
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
        isEnabled = getPARepairEnabled,
        setIsEnabled = setPARepairEnabled,

        isRepairEquippedDisabled = isDisabledPARepairRepairEquipped,
        getRepairEquippedSetting = getPARepairRepairEquipped,
        setRepairEquippedSetting = setPARepairRepairEquipped,

        isRepairEquippedThresholdDisabled = isDisabledPARepairRepairEquippedThreshold,
        getRepairEquippedThresholdSetting = getPARepairRepairEquippedThreshold,
        setRepairEquippedThresholdSetting = setPARepairRepairEquippedThreshold,

        isRepairEquippedWithKitDisabled = isDisabledPARepairRepairEquippedWithKit,
        getRepairEquippedWithKitSetting = getPARepairRepairEquippedWithKit,
        setRepairEquippedWithKitSetting = setPARepairRepairEquippedWithKit,

        isRepairEquippedWithKitThresholdDisabled = isDisabledPARepairRepairEquippedWithKitThreshold,
        getRepairEquippedWithKitThresholdSetting = getPARepairRepairEquippedWithKitThreshold,
        setRepairEquippedWithKitThresholdSetting = setPARepairRepairEquippedWithKitThreshold,

        isRepairFullChatModeDisabled = isDisabledPARepairRepairFullChatMode,
        getRepairFullChatModeSetting = getPARepairRepairFullChatMode,
        setRepairFullChatModeSetting = setPARepairRepairFullChatMode,

        isRepairPartialChatModeDisabled = isDisabledPARepairRepairPartialChatMode,
        getRepairPartialChatModeSetting = getPARepairRepairPartialChatMode,
        setRepairPartialChatModeSetting = setPARepairRepairPartialChatMode,

        isChargeWeaponsDisabled = isDisabledPARepairChargeWeapons,
        getChargeWeaponsSetting = getPARepairChargeWeapons,
        setChargeWeaponsSetting = setPARepairChargeWeapons,

        isChargeWeaponsThresholdDisabled = isDisabledPARepairChargeWeaponsThreshold,
        getChargeWeaponsThresholdSetting = getPARepairChargeWeaponsThreshold,
        setChargeWeaponsThresholdSetting = setPARepairChargeWeaponsThreshold,

        isChargeWeaponsChatModeDisabled = isDisabledPARepairChargeWeaponsChatMode,
        getChargeWeaponsChatModeSetting = getPARepairChargeWeaponsChatMode,
        setChargeWeaponsChatModeSetting = setPARepairChargeWeaponsChatMode,
    },
    PABanking = {
        isEnabled = getPABankingEenabled,
        setIsEnabled = setPABankingEnabled,

        -- -----------------------------------------------------------------------------------

        isGoldTransactionMenuDisabled = function() return isDisabled(PASV.Banking, "enabled", "goldTransaction") end,
        isGoldTransactionDisabled = function() return isDisabled(PASV.Banking, "enabled") end,
        getGoldTransactionSetting = function() return getValue(PASV.Banking, "goldTransaction") end,
        setGoldTransactionSetting = function(value) setValue(PASV.Banking, "goldTransaction", value) end,

        isGoldMinToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "goldTransaction") end,
        getGoldMinToKeepSetting = function() return getValue(PASV.Banking, "goldMinToKeep") end,
        setGoldMinToKeepSetting =  setPABAnkingGoldMinToKeepSetting,

        isGoldMaxToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "goldTransaction") end,
        getGoldMaxToKeepSetting = function() return getValue(PASV.Banking, "goldMaxToKeep") end,
        setGoldMaxToKeepSetting =  setPABAnkingGoldMaxToKeepSetting,

        -- -----------------------------------------------------------------------------------

        isAlliancePointsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, "enabled", "alliancePointsTransaction") end,
        isAlliancePointsTransactionDisabled = function() return isDisabled(PASV.Banking, "enabled") end,
        getAlliancePointsTransactionSetting = function() return getValue(PASV.Banking, "alliancePointsTransaction") end,
        setAlliancePointsTransactionSetting = function(value) setValue(PASV.Banking, "alliancePointsTransaction", value) end,

        isAlliancePointsMinToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "alliancePointsTransaction") end,
        getAlliancePointsMinToKeepSetting = function() return getValue(PASV.Banking, "alliancePointsMinToKeep") end,
        setAlliancePointsMinToKeepSetting = setPABAnkingAlliancePointsMinToKeepSetting,

        isAlliancePointsMaxToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "alliancePointsTransaction") end,
        getAlliancePointsMaxToKeepSetting = function() return getValue(PASV.Banking, "alliancePointsMaxToKeep") end,
        setAlliancePointsMaxToKeepSetting = setPABAnkingAlliancePointsMaxToKeepSetting,

        -- -----------------------------------------------------------------------------------

        isTelVarTransactionMenuDisabled = function() return isDisabled(PASV.Banking, "enabled", "telVarTransaction") end,
        isTelVarTransactionDisabled = function() return isDisabled(PASV.Banking, "enabled") end,
        getTelVarTransactionSetting = function() return getValue(PASV.Banking, "telVarTransaction") end,
        setTelVarTransactionSetting = function(value) setValue(PASV.Banking, "telVarTransaction", value) end,

        isTelVarMinToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "telVarTransaction") end,
        getTelVarMinToKeepSetting = function() return getValue(PASV.Banking, "telVarMinToKeep") end,
        setTelVarMinToKeepSetting = setPABAnkingTelVarMinToKeepSetting,

        isTelVarMaxToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "telVarTransaction") end,
        getTelVarMaxToKeepSetting = function() return getValue(PASV.Banking, "telVarMaxToKeep") end,
        setTelVarMaxToKeepSetting = setPABAnkingTelVarMaxToKeepSetting,

        -- -----------------------------------------------------------------------------------

        isWritVouchersTransactionMenuDisabled = function() return isDisabled(PASV.Banking, "enabled", "writVouchersTransaction") end,
        isWritVouchersTransactionDisabled = function() return isDisabled(PASV.Banking, "enabled") end,
        getWritVouchersTransactionSetting = function() return getValue(PASV.Banking, "writVouchersTransaction") end,
        setWritVouchersTransactionSetting = function(value) setValue(PASV.Banking, "writVouchersTransaction", value) end,

        isWritVouchersMinToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "writVouchersTransaction") end,
        getWritVouchersMinToKeepSetting = function() return getValue(PASV.Banking, "writVouchersMinToKeep") end,
        setWritVouchersMinToKeepSetting = setPABAnkingWritVouchersMinToKeepSetting,

        isWritVouchersMaxToKeepDisabled = function() return isDisabled(PASV.Banking, "enabled", "writVouchersTransaction") end,
        getWritVouchersMaxToKeepSetting = function() return getValue(PASV.Banking, "writVouchersMaxToKeep") end,
        setWritVouchersMaxToKeepSetting = setPABAnkingWritVouchersMaxToKeepSetting,

        -- -----------------------------------------------------------------------------------

        isItemTransactionDisabled = isDisabledPABankingItemTransaction,
        getItemTransactionSetting = getPABankingItemTransaction,
        setItemTransactionSetting = setPABankingItemTransaction,

        isDepositTimerIntervalDisabled = isDisabledPABankingDepositTimerInterval,
        getDepositTimerIntervalSetting = getPABankingDepositTimerInterval,
        setDepositTimerIntervalSetting = setPABankingDepositTimerInterval,

        isItemTypesMaterialMoveModeDisabled = isDisabledPABankingItemTypesMaterialMoveMode,
        getItemTypesMaterialMoveModeSetting = getPABankingItemTypesMaterialMoveMode,
        setItemTypesMaterialMoveModeSetting = setPABankingItemTypesMaterialMoveMode,

        isItemsDepStackTypeDisabled = isDisabledPABankingItemsDepStackType,
        getItemsDepStackTypeSetting = getPABankingItemsDepStackType,
        setItemsDepStackTypeSetting = setPABankingItemsDepStackType,

        isItemsWitStackTypeDisabled = isDisabledPABankingItemsWitStackType,
        getItemsWitStackTypeSetting = getPABankingItemsWitStackType,
        setItemsWitStackTypeSetting = setPABankingItemsWitStackType,

        isItemTypesMoveModeDisabled = isDisabledPABankingItemTypesMoveMode,
        getItemTypesMoveModeSetting = getPABankingItemTypesMoveMode,
        setItemTypesMoveModeSetting = setPABankingItemTypesMoveMode,

        isDepositAllItemTypesButtonDisabled = isDisabledPABankingDepositAllItemTypesButton,
        clickDepositAllItemTypesButton = PABankingDepositAllItemTypesButton,

        isWithdrawAllItemTypesButtonDisabled = isDisabledPABankingWithdrawAllItemTypesButton,
        clickWithdrawAllItemTypesButton = PABankingWithdrawAllItemTypesButton,

        isIgnoreAllItemTypesButtonDisabled = isDisabledPABankingIgnoreAllItemTypesButton,
        clickIgnoreAllItemTypesButton = PABankingIgnoreAllItemTypesButton,

        isAdvItemTypesOperatorDisabled = isDisabledPABankingAdvItemTypesOperator,
        getAdvItemTypesOperatorSetting = getPABankingAdvItemTypesOperator,
        setAdvItemTypesOperatorSetting = setPABankingAdvItemTypesOperator,

        isAdvItemTypesValueDisabled = isDisabledPABankingAdvItemTypesValue,
        getAdvItemTypesValueSetting = getPABankingAdvItemTypesValue,
        setAdvItemTypesValueSetting = setPABankingAdvItemTypesValue,
    },
    PALoot = {
        isEnabled = getPALootEnabled,
        setIsEnabled = setPALootEnabled,

        isLootGoldDisabled = isDisabledPALootLootGold,
        getLootGoldSetting = getPALootLootGold,
        setLootGoldSetting = setPALootLootGold,

        isLootGoldChatModeDisabled = isDisabledPALootLootGoldChatMode,
        getLootGoldChatModeSetting = getPALootLootGoldChatMode,
        setLootGoldChatModeSetting = setPALootLootGoldChatMode,

        isLootItemsDisabled = isDisabledPALootLootItems,
        getLootItemsSetting = getPALootLootItems,
        setLootItemsSetting = setPALootLootItems,

        isLootItemsChatModeDisabled = isDisabledPALootLootItemsChatMode,
        getLootItemsChatModeSetting = getPALootLootItemsChatMode,
        setLootItemsChatModeSetting = setPALootLootItemsChatMode,

        isLootStolenItemsSettingDisabled = isDisabledPALootLootStolenItems,
        getLootStolenItemsSetting = getPALootLootStolenItems,
        setLootStolenItemsSetting = setPALootLootStolenItems,

        isHarvestableBaitLootModeDisabled = isDisabledPALootHarvestableBaitLootMode,
        getHarvestableBaitLootModeSetting = getPALootHarvestableBaitLootMode,
        setHarvestableBaitLootModeSetting = setPALootHarvestableBaitLootMode,

        isHarvestableItemTypesLootModeDisabled = isDisabledPALootHarvestableItemTypesLootMode,
        getHarvestableItemTypesLootModeSetting = getPALootHarvestableItemTypesLootMode,
        setHarvestableItemTypesLootModeSetting = setPALootHarvestableItemTypesLootMode,

        isAutoLootAllHarvestableButtonDisabled = isDisabledPALootAutoLootAllHarvestableButton,
        clickAutoLootAllHarvestableButton = PALootAutoLootAllHarvestableButton,

        isIgnoreAllHarvestableButtonDisabled = isDisabledPALootIgnoreAllHarvestableButton,
        clickIgnoreAllHarvestableButton = PALootIgnoreAllHarvestableButton,

        isLootableItemTypesLootModeDisabled = isDisabledPALootLootableItemTypesLootMode,
        getLootableItemTypesLootModeSetting = getPALootLootableItemTypesLootMode,
        setLootableItemTypesLootModeSetting = setPALootLootableItemTypesLootMode,

        isLockpickLootModeDisabled = isDisabledPALootLockpickLootMode,
        getLockpickLootModeSetting = getPALootLockpickLootMode,
        setLockpickLootModeSetting = setPALootLockpickLootMode,

        isQuestItemsLootModeDisabled = isDisabledPALootQuestItemsLootMode,
        getQuestItemsLootModeSetting = getPALootQuestItemsLootMode,
        setQuestItemsLootModeSetting = setPALootQuestItemsLootMode,

        isAutoLootAllLootableButtonDisabled = isDisabledPALootAutoLootAllLootableButton,
        clickAutoLootAllLootableButton = PALootAutoLootAllLootableButton,

        isIgnoreAllLootableButtonDisabled = isDisabledPALootIgnoreAllLootableButton,
        clickIgnoreAllLootableButton = PALootIgnoreAllLootableButton,
        
    },
    PAJunk = {
        isEnabled = getPAJunkEnabled,
        setIsEnabled = setPAJunkEnabled,

        isAutoSellJunkDisabled = isDisabledPAJunkAutoSellJunk,
        getAutoSellJunkSetting = getPAJunkAutoSellJunk,
        setAutoSellJunkSetting = setPAJunkAutoSellJunk,

        isAutoMarkTrashDisabled = isDisabledPAJunkAutoMarkTrash,
        getAutoMarkTrashSetting = getPAJunkAutoMarkTrash,
        setAutoMarkTrashSetting = setPAJunkAutoMarkTrash,

        isAutoMarkOrnateDisabled = isDisabledPAJunkAutoMarkOrnate,
        getAutoMarkOrnateSetting = getPAJunkAutoMarkOrnate,
        setAutoMarkOrnateSetting = setPAJunkAutoMarkOrnate,
    }
}











