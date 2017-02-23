--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Functions then
    PAMenu_Functions = {
        func = {
            PABanking = {},
            PALoot = {},
        },
        getFunc = {
            PAGeneral = {},
            PARepair = {},
            PABanking = {},
            PALoot = {},
            PAJunk = {},
        },
        setFunc = {
            PAGeneral = {},
            PARepair = {},
            PABanking = {},
            PALoot = {},
            PAJunk = {},
        },
        disabled = {
            PAGeneral = {},
            PARepair = {},
            PABanking = {},
            PALoot = {},
            PAJunk = {},
        },
    }
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PAGeneral

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.activeProfile()
    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil) then
        return PAG_NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

function PAMenu_Functions.setFunc.PAGeneral.activeProfile(profileNo)
    if (profileNo ~= nil and profileNo ~= PAG_NO_PROFILE_SELECTED_ID) then
        -- get the previously active prefoile first
        local prevProfile = PA.savedVars.Profile.activeProfile
        -- then save the new one
        PA.savedVars.Profile.activeProfile = profileNo
        PA.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if (prevProfile == nil) then
            MenuHelper.reloadProfileList()
        end
        -- also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
    end
end

function PAMenu_Functions.disabled.PAGeneral.noProfileSelected()
    return (PA.activeProfile == nil)
end

--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.activeProfileRename()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.General[PA.activeProfile].name
end

function PAMenu_Functions.setFunc.PAGeneral.activeProfileRename(profileName)
    if (profileName ~= nil and profileName ~= "") then
        PA.savedVars.General[PA.activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        MenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PAGeneral   welcomeMessage
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.welcomeMessage()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.General[PA.activeProfile].welcome
end

function PAMenu_Functions.setFunc.PAGeneral.welcomeMessage(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.General[PA.activeProfile].welcome = value
end

-- =====================================================================================================================
-- =====================================================================================================================

 -- PARepair

--------------------------------------------------------------------------
-- PARepair   enable
---------------------------------
function PAMenu_Functions.getFunc.PARepair.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PARepair.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PARepair   repairEquipped
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairEquipped()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairEquipped
end

function PAMenu_Functions.setFunc.PARepair.repairEquipped(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairEquipped = value
end

function PAMenu_Functions.disabled.PARepair.repairEquipped()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedThreshold
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairEquippedThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairEquippedThreshold
end

function PAMenu_Functions.setFunc.PARepair.repairEquippedThreshold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairEquippedThreshold = value
end

function PAMenu_Functions.disabled.PARepair.repairEquippedThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.activeProfile].enabled and PA.savedVars.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   repairBackpack
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairBackpack()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairBackpack
end

function PAMenu_Functions.setFunc.PARepair.repairBackpack(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairBackpack = value
end

function PAMenu_Functions.disabled.PARepair.repairBackpack()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairBackpackThreshrold
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairBackpackThreshrold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairBackpackThreshrold
end

function PAMenu_Functions.setFunc.PARepair.repairBackpackThreshrold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairBackpackThreshrold = value
end

function PAMenu_Functions.disabled.PARepair.repairBackpackThreshrold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.activeProfile].enabled and PA.savedVars.Repair[PA.activeProfile].repairBackpack)
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedWithKit
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairEquippedWithKit()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairEquippedWithKit
end

function PAMenu_Functions.setFunc.PARepair.repairEquippedWithKit(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairEquippedWithKit = value
end

function PAMenu_Functions.disabled.PARepair.repairEquippedWithKit()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedWithKitThreshold
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairEquippedWithKitThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairEquippedWithKitThreshold
end

function PAMenu_Functions.setFunc.PARepair.repairEquippedWithKitThreshold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairEquippedWithKitThreshold = value
end

function PAMenu_Functions.disabled.PARepair.repairEquippedWithKitThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.activeProfile].enabled and PA.savedVars.Repair[PA.activeProfile].repairEquippedWithKit)
end

--------------------------------------------------------------------------
-- PARepair   repairFullChatMode
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairFullChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairFullChatMode
end

function PAMenu_Functions.setFunc.PARepair.repairFullChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairFullChatMode = value
end

function PAMenu_Functions.disabled.PARepair.repairFullChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.activeProfile].enabled and (PA.savedVars.Repair[PA.activeProfile].repairEquipped or PA.savedVars.Repair[PA.activeProfile].repairBackpack))
end

--------------------------------------------------------------------------
-- PARepair   repairPartialChatMode
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairPartialChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].repairPartialChatMode
end

function PAMenu_Functions.setFunc.PARepair.repairPartialChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].repairPartialChatMode = value
end

function PAMenu_Functions.disabled.PARepair.repairPartialChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.activeProfile].enabled and (PA.savedVars.Repair[PA.activeProfile].repairEquipped or PA.savedVars.Repair[PA.activeProfile].repairBackpack))
end

--------------------------------------------------------------------------
-- PARepair   chargeWeapons
---------------------------------
function PAMenu_Functions.getFunc.PARepair.chargeWeapons()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].chargeWeapons
end

function PAMenu_Functions.setFunc.PARepair.chargeWeapons(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].chargeWeapons = value
end

function PAMenu_Functions.disabled.PARepair.chargeWeapons()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   chargeWeaponsThreshold
---------------------------------
function PAMenu_Functions.getFunc.PARepair.chargeWeaponsThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.activeProfile].chargeWeaponsThreshold
end

function PAMenu_Functions.setFunc.PARepair.chargeWeaponsThreshold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.activeProfile].chargeWeaponsThreshold = value
end

function PAMenu_Functions.disabled.PARepair.chargeWeaponsThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.activeProfile].enabled and PA.savedVars.Repair[PA.activeProfile].chargeWeapons)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking

--------------------------------------------------------------------------
-- PABanking   enable
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PABanking.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   enabledGold
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabledGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].enabledGold
end

function PAMenu_Functions.setFunc.PABanking.enabledGold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].enabledGold = value
end

function PAMenu_Functions.disabled.PABanking.enabledGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Banking[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   goldTransactionStep
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldTransactionStep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
   return PA.savedVars.Banking[PA.activeProfile].goldTransactionStep
end

function PAMenu_Functions.setFunc.PABanking.goldTransactionStep(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].goldTransactionStep = value
end

function PAMenu_Functions.disabled.PABanking.goldTransactionStep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldMinToKeep
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldMinToKeep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].goldMinToKeep
end

function PAMenu_Functions.setFunc.PABanking.goldMinToKeep(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].goldMinToKeep = tonumber(value)
end

function PAMenu_Functions.disabled.PABanking.goldMinToKeep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   withdrawToMinGold
---------------------------------
function PAMenu_Functions.getFunc.PABanking.withdrawToMinGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].withdrawToMinGold
end

function PAMenu_Functions.setFunc.PABanking.withdrawToMinGold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].withdrawToMinGold = value
end

function PAMenu_Functions.disabled.PABanking.withdrawToMinGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   enabledItems
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabledItems()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].enabledItems
end

function PAMenu_Functions.setFunc.PABanking.enabledItems(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].enabledItems = value
end

function PAMenu_Functions.disabled.PABanking.enabledItems()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Banking[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   depositTimerInterval
---------------------------------
function PAMenu_Functions.getFunc.PABanking.depositTimerInterval()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].depositTimerInterval
end

function PAMenu_Functions.setFunc.PABanking.depositTimerInterval(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].depositTimerInterval = value
end

function PAMenu_Functions.disabled.PABanking.depositTimerInterval()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - ItemTypeSubmenu

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemsDepStackType
---------------------------------
function PAMenu_Functions.getFunc.PABanking.itemsDepStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].itemsDepStackType
end

function PAMenu_Functions.setFunc.PABanking.itemsDepStackType(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].itemsDepStackType = value
end

function PAMenu_Functions.disabled.PABanking.itemsDepStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemsWitStackType
---------------------------------
function PAMenu_Functions.getFunc.PABanking.itemsWitStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].itemsWitStackType
end

function PAMenu_Functions.setFunc.PABanking.itemsWitStackType(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].itemsWitStackType = value
end

function PAMenu_Functions.disabled.PABanking.itemsWitStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemTypesMoveMode
---------------------------------
function PAMenu_Functions.getFunc.PABanking.itemTypesMoveMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].ItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PABanking.itemTypesMoveMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].ItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PABanking.itemTypesMoveMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  autoLootAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PABanking.depositAllItemTypesButton()
    for _, itemType in pairs(PABItemTypes) do
        PA.savedVars.Banking[PA.activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_DEPOSIT
    end
end

function PAMenu_Functions.disabled.PABanking.depositAllItemTypesButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  withdrawAllItemTypesButton
---------------------------------
function PAMenu_Functions.func.PABanking.withdrawAllItemTypesButton()
    for _, itemType in pairs(PABItemTypes) do
        PA.savedVars.Banking[PA.activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_WITHDRAWAL
    end
end

function PAMenu_Functions.disabled.PABanking.withdrawAllItemTypesButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  ignoreAllItemTypesButton
---------------------------------
function PAMenu_Functions.func.PABanking.ignoreAllItemTypesButton()
    for _, itemType in pairs(PABItemTypes) do
        PA.savedVars.Banking[PA.activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PABanking.ignoreAllItemTypesButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - AdvancedItemTypeSubmenu

--------------------------------------------------------------------------
-- PABAnking - AdvancedItemTypeSubmenu   advItemTypesOperator
---------------------------------
function PAMenu_Functions.getFunc.PABanking.advItemTypesOperator(advancedItemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].ItemTypesAdvanced[advancedItemType].Operator
end

function PAMenu_Functions.setFunc.PABanking.advItemTypesOperator(advancedItemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].ItemTypesAdvanced[advancedItemType].Operator = value
end

function PAMenu_Functions.disabled.PABanking.advItemTypesOperator()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - AdvancedItemTypeSubmenu   advItemTypesValue
---------------------------------
function PAMenu_Functions.getFunc.PABanking.advItemTypesValue(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.activeProfile].ItemTypesAdvanced[itemType].Value
end

function PAMenu_Functions.setFunc.PABanking.advItemTypesValue(advancedItemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.activeProfile].ItemTypesAdvanced[advancedItemType].Value = value
end

function PAMenu_Functions.disabled.PABanking.advItemTypesValue()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.activeProfile].enabled and PA.savedVars.Banking[PA.activeProfile].enabledItems)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PALoot

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PALoot.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PALoot   lootGoldEnabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].lootGoldEnabled
end

function PAMenu_Functions.setFunc.PALoot.lootGoldEnabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].lootGoldEnabled = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Loot[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootGoldChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].lootGoldChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootGoldChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].lootGoldChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootGoldEnabled)
end

--------------------------------------------------------------------------
-- PALoot   lootItemsEnabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled
end

function PAMenu_Functions.setFunc.PALoot.lootItemsEnabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Loot[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootItemsChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].lootItemsChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootItemsChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].lootItemsChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableBaitLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].harvestableBaitLootMode
end

function PAMenu_Functions.setFunc.PALoot.harvestableBaitLootMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].harvestableBaitLootMode = value
end

function PAMenu_Functions.disabled.PALoot.harvestableBaitLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableItemTypesLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.harvestableItemTypesLootMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].HarvestableItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PALoot.harvestableItemTypesLootMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PALoot.harvestableItemTypesLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu autoLootAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PALoot.autoLootAllHarvestableButton()
        for _, itemType in pairs(PALHarvestableItemTypes) do
        PA.savedVars.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

function PAMenu_Functions.disabled.PALoot.autoLootAllHarvestableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu ignoreAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PALoot.ignoreAllHarvestableButton()
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PA.savedVars.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PALoot.ignoreAllHarvestableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lootableItemTypesLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootableItemTypesLootMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.activeProfile].LootableItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PALoot.lootableItemTypesLootMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.activeProfile].LootableItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PALoot.lootableItemTypesLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu autoLootAllLootableButton
---------------------------------
function PAMenu_Functions.func.PALoot.autoLootAllLootableButton()
    for _, itemType in pairs(PALLootableItemTypes) do
        PA.savedVars.Loot[PA.activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

function PAMenu_Functions.disabled.PALoot.autoLootAllLootableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu ignoreAllLootableButton
---------------------------------
function PAMenu_Functions.func.PALoot.ignoreAllLootableButton()
    for _, itemType in pairs(PALLootableItemTypes) do
        PA.savedVars.Loot[PA.activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PALoot.ignoreAllLootableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.activeProfile].enabled and PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PAJunk

--------------------------------------------------------------------------
-- PAJunk   enabled
---------------------------------
function PAMenu_Functions.getFunc.PAJunk.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Junk[PA.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PAJunk.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Junk[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PAJunk   autoSellJunk
---------------------------------
function PAMenu_Functions.getFunc.PAJunk.autoSellJunk()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Junk[PA.activeProfile].autoSellJunk
end

function PAMenu_Functions.setFunc.PAJunk.autoSellJunk(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Junk[PA.activeProfile].autoSellJunk = value
end

function PAMenu_Functions.disabled.PAJunk.autoSellJunk()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Junk[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PAJunk   autoMarkTrash
---------------------------------
function PAMenu_Functions.getFunc.PAJunk.autoMarkTrash()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Junk[PA.activeProfile].autoMarkTrash
end

function PAMenu_Functions.setFunc.PAJunk.autoMarkTrash(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Junk[PA.activeProfile].autoMarkTrash = value
end

function PAMenu_Functions.disabled.PAJunk.autoMarkTrash()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Junk[PA.activeProfile].enabled
end


-- =====================================================================================================================
-- =====================================================================================================================