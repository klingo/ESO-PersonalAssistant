-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAEM = PA.EventManager
local PAMenuHelper = PA.MenuHelper
local L = PA.Localization

-- =====================================================================================================================
-- =====================================================================================================================

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
            PAMenuHelper.reloadProfileList()
        end
        -- also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
    end
end

local function isDisabledPAGeneralNoProfileSelected()
    return (PA.activeProfile == nil)
end

--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
local function getPAGeneralActiveProfileRename()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].name
end

local function setPAGeneralActiveProfileRename(profileName)
    local PAMenuHelper = PA.MenuHelper
    if (profileName ~= nil and profileName ~= "") then
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
-- PABanking   goldTransaction
---------------------------------
local function getPABankingGoldTransaction()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].goldTransaction
end

local function setPABankingGoldTransaction(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].goldTransaction = value
end

local function isDisabledPABankingGoldTransaction()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Banking[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   goldTransactionStep
---------------------------------
local function getPABankingGoldTransactionStep()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].goldTransactionStep
end

local function setPABankingGoldTransactionStep(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].goldTransactionStep = value
end

local function isDisabledPABankingGoldTransactionStep()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].goldTransaction)
end

--------------------------------------------------------------------------
-- PABanking   goldMinToKeep
---------------------------------
local function getPABankingGoldMinToKeep()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].goldMinToKeep
end

local function setPABankingGoldMinToKeep(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].goldMinToKeep = tonumber(value)
end

local function isDisabledPABankingGoldMinToKeep()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].goldTransaction)
end

--------------------------------------------------------------------------
-- PABanking   withdrawToMinGold
---------------------------------
local function getPABankingWithdrawToMinGold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].withdrawToMinGold
end

local function setPABankingWithdrawToMinGold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].withdrawToMinGold = value
end

local function isDisabledPABankingWithdrawToMinGold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Banking[PA.activeProfile].enabled and PASV.Banking[PA.activeProfile].goldTransaction)
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
        getIsNoProfileSelected = isDisabledPAGeneralNoProfileSelected,

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

        getIsRepairEquippedEnabled = isDisabledPARepairRepairEquipped,
        getRepairEquippedSetting = getPARepairRepairEquipped,
        setRepairEquippedSetting = setPARepairRepairEquipped,

        getIsRepairEquippedThresholdEnabled = isDisabledPARepairRepairEquippedThreshold,
        getRepairEquippedThresholdSetting = getPARepairRepairEquippedThreshold,
        setRepairEquippedThresholdSetting = setPARepairRepairEquippedThreshold,

        getIsRepairEquippedWithKitEnabled = isDisabledPARepairRepairEquippedWithKit,
        getRepairEquippedWithKitSetting = getPARepairRepairEquippedWithKit,
        setRepairEquippedWithKitSetting = setPARepairRepairEquippedWithKit,

        getIsRepairEquippedWithKitThresholdEnabled = isDisabledPARepairRepairEquippedWithKitThreshold,
        getRepairEquippedWithKitThresholdSetting = getPARepairRepairEquippedWithKitThreshold,
        setRepairEquippedWithKitThresholdSetting = setPARepairRepairEquippedWithKitThreshold,

        getIsRepairFullChatModeEnabled = isDisabledPARepairRepairFullChatMode,
        getRepairFullChatModeSetting = getPARepairRepairFullChatMode,
        setRepairFullChatModeSetting = setPARepairRepairFullChatMode,

        getIsRepairPartialChatModeEnabled = isDisabledPARepairRepairPartialChatMode,
        getRepairPartialChatModeSetting = getPARepairRepairPartialChatMode,
        setRepairPartialChatModeSetting = setPARepairRepairPartialChatMode,

        getIsChargeWeaponsEnabled = isDisabledPARepairChargeWeapons,
        getChargeWeaponsSetting = getPARepairChargeWeapons,
        setChargeWeaponsSetting = setPARepairChargeWeapons,

        getIsChargeWeaponsThresholdEnabled = isDisabledPARepairChargeWeaponsThreshold,
        getChargeWeaponsThresholdSetting = getPARepairChargeWeaponsThreshold,
        setChargeWeaponsThresholdSetting = setPARepairChargeWeaponsThreshold,

        getIsChargeWeaponsChatModEnabled = isDisabledPARepairChargeWeaponsChatMode,
        getChargeWeaponsChatModSetting = getPARepairChargeWeaponsChatMode,
        setChargeWeaponsChatModSetting = setPARepairChargeWeaponsChatMode,
    },
    PABanking = {
        isEnabled = getPABankingEenabled,
        setIsEnabled = setPABankingEnabled,

        getIsGoldTransactionEnabled = isDisabledPABankingGoldTransaction,
        getGoldTransactionSetting = getPABankingGoldTransaction,
        setGoldTransactionSetting = setPABankingGoldTransaction,

        getIsGoldTransactionStepEnabled = isDisabledPABankingGoldTransactionStep,
        getGoldTransactionStepSetting = getPABankingGoldTransactionStep,
        setGoldTransactionStepSetting = setPABankingGoldTransactionStep,

        getIsGoldMinToKeepEnabled = isDisabledPABankingGoldMinToKeep,
        getGoldMinToKeepSetting = getPABankingGoldMinToKeep,
        setGoldMinToKeepSetting =  setPABankingGoldMinToKeep,

        getIsWithdrawToMinGoldEnabled = isDisabledPABankingWithdrawToMinGold,
        getWithdrawToMinGoldSetting = getPABankingWithdrawToMinGold,
        setWithdrawToMinGoldSetting = setPABankingWithdrawToMinGold,

        getIsItemTransactionEnabled = isDisabledPABankingItemTransaction,
        getItemTransactionSetting = getPABankingItemTransaction,
        setItemTransactionSetting = setPABankingItemTransaction,

        getIsDepositTimerIntervalEnabled = isDisabledPABankingDepositTimerInterval,
        getDepositTimerIntervalSetting = getPABankingDepositTimerInterval,
        setDepositTimerIntervalSetting = setPABankingDepositTimerInterval,

        getIsItemTypesMaterialMoveModeEnabled = isDisabledPABankingItemTypesMaterialMoveMode,
        getItemTypesMaterialMoveModeSetting = getPABankingItemTypesMaterialMoveMode,
        setItemTypesMaterialMoveModeSetting = setPABankingItemTypesMaterialMoveMode,

        getIsItemsDepStackTypeEnabled = isDisabledPABankingItemsDepStackType,
        getItemsDepStackTypeSetting = getPABankingItemsDepStackType,
        setItemsDepStackTypeSetting = setPABankingItemsDepStackType,

        getIsItemsWitStackTypeEnabled = isDisabledPABankingItemsWitStackType,
        getItemsWitStackTypeSetting = getPABankingItemsWitStackType,
        setItemsWitStackTypeSetting = setPABankingItemsWitStackType,

        getIsItemTypesMoveModeEnabled = isDisabledPABankingItemTypesMoveMode,
        getItemTypesMoveModeSetting = getPABankingItemTypesMoveMode,
        setItemTypesMoveModeSetting = setPABankingItemTypesMoveMode,

        getIsDepositAllItemTypesButtonEnabled = isDisabledPABankingDepositAllItemTypesButton,
        clickDepositAllItemTypesButton = PABankingDepositAllItemTypesButton,

        getIsWithdrawAllItemTypesButtonEnabled = isDisabledPABankingWithdrawAllItemTypesButton,
        clickWithdrawAllItemTypesButton = PABankingWithdrawAllItemTypesButton,

        getIsIgnoreAllItemTypesButtonEnabled = isDisabledPABankingIgnoreAllItemTypesButton,
        clickIgnoreAllItemTypesButton = PABankingIgnoreAllItemTypesButton,

        getIsAdvItemTypesOperatorEnabled = isDisabledPABankingAdvItemTypesOperator,
        getAdvItemTypesOperatorSetting = getPABankingAdvItemTypesOperator,
        setAdvItemTypesOperatorSetting = setPABankingAdvItemTypesOperator,

        getIsAdvItemTypesValueEnabled = isDisabledPABankingAdvItemTypesValue,
        getAdvItemTypesValueSetting = getPABankingAdvItemTypesValue,
        setAdvItemTypesValueSetting = setPABankingAdvItemTypesValue,
    },
    PALoot = {
        isEnabled = getPALootEnabled,
        setIsEnabled = setPALootEnabled,

        getIsLootGoldEnabled = isDisabledPALootLootGold,
        getLootGoldSetting = getPALootLootGold,
        setLootGoldSetting = setPALootLootGold,

        getIsLootGoldChatModeEnabled = isDisabledPALootLootGoldChatMode,
        getLootGoldChatModeSetting = getPALootLootGoldChatMode,
        setLootGoldChatModeSetting = setPALootLootGoldChatMode,

        getIsLootItemsEnabled = isDisabledPALootLootItems,
        getLootItemsSetting = getPALootLootItems,
        setLootItemsSetting = setPALootLootItems,

        getIsLootItemsChatModeEnabled = isDisabledPALootLootItemsChatMode,
        getLootItemsChatModeSetting = getPALootLootItemsChatMode,
        setLootItemsChatModeSetting = setPALootLootItemsChatMode,

        getIsLootStolenItemsSettingEnabled = isDisabledPALootLootStolenItems,
        getLootStolenItemsSetting = getPALootLootStolenItems,
        setLootStolenItemsSetting = setPALootLootStolenItems,

        getIsHarvestableBaitLootModeEnabled = isDisabledPALootHarvestableBaitLootMode,
        getHarvestableBaitLootModeSetting = getPALootHarvestableBaitLootMode,
        setHarvestableBaitLootModeSetting = setPALootHarvestableBaitLootMode,

        getIsHarvestableItemTypesLootModeEnabled = isDisabledPALootHarvestableItemTypesLootMode,
        getHarvestableItemTypesLootModeSetting = getPALootHarvestableItemTypesLootMode,
        setHarvestableItemTypesLootModeSetting = setPALootHarvestableItemTypesLootMode,

        getIsAutoLootAllHarvestableButtonEnabled = isDisabledPALootAutoLootAllHarvestableButton,
        clickAutoLootAllHarvestableButton = PALootAutoLootAllHarvestableButton,

        getIsIgnoreAllHarvestableButtonEnabled = isDisabledPALootIgnoreAllHarvestableButton,
        clickIgnoreAllHarvestableButton = PALootIgnoreAllHarvestableButton,

        getIsLootableItemTypesLootModeEnabled = isDisabledPALootLootableItemTypesLootMode,
        getLootableItemTypesLootModeSetting = getPALootLootableItemTypesLootMode,
        setLootableItemTypesLootModeSetting = setPALootLootableItemTypesLootMode,

        getIsLockpickLootModeEnabled = isDisabledPALootLockpickLootMode,
        getLockpickLootModeSetting = getPALootLockpickLootMode,
        setLockpickLootModeSetting = setPALootLockpickLootMode,

        getIsQuestItemsLootModeEnabled = isDisabledPALootQuestItemsLootMode,
        getQuestItemsLootModeSetting = getPALootQuestItemsLootMode,
        setQuestItemsLootModeSetting = setPALootQuestItemsLootMode,

        getIsAutoLootAllLootableButtonEnabled = isDisabledPALootAutoLootAllLootableButton,
        clickAutoLootAllLootableButton = PALootAutoLootAllLootableButton,

        getIsIgnoreAllLootableButtonEnabled = isDisabledPALootIgnoreAllLootableButton,
        clickIgnoreAllLootableButton = PALootIgnoreAllLootableButton,
        
    },
    PAJunk = {
        isEnabled = getPAJunkEnabled,
        setIsEnabled = setPAJunkEnabled,

        getIsAutoSellJunkEnabled = isDisabledPAJunkAutoSellJunk,
        getAutoSellJunkSetting = getPAJunkAutoSellJunk,
        setAutoSellJunkSetting = setPAJunkAutoSellJunk,

        getIsAutoMarkTrashEnabled = isDisabledPAJunkAutoMarkTrash,
        getAutoMarkTrashSetting = getPAJunkAutoMarkTrash,
        setAutoMarkTrashSetting = setPAJunkAutoMarkTrash,

        getIsAutoMarkOrnateEnabled = isDisabledPAJunkAutoMarkOrnate,
        getAutoMarkOrnateSetting = getPAJunkAutoMarkOrnate,
        setAutoMarkOrnateSetting = setPAJunkAutoMarkOrnate,
    }
}











