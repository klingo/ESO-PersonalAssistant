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
-- PABanking   activeProfile
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
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if (prevProfile == nil) then
            MenuHelper.reloadProfileList()
        end
    end
end

function PAMenu_Functions.disabled.PAGeneral.noProfileSelected()
    local activeProfile = PA.savedVars.Profile.activeProfile
    return (activeProfile == nil)
end

--------------------------------------------------------------------------
-- PABanking   activeProfileRename
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.activeProfileRename()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.General[PA.savedVars.Profile.activeProfile].name
end

function PAMenu_Functions.setFunc.PAGeneral.activeProfileRename(profileName)
    if (profileName ~= nil and profileName ~= "") then
        PA.savedVars.General[PA.savedVars.Profile.activeProfile].name = profileName
        MenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PABanking   welcomeMessage
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.welcomeMessage()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.General[PA.savedVars.Profile.activeProfile].welcome
end

function PAMenu_Functions.setFunc.PAGeneral.welcomeMessage(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.General[PA.savedVars.Profile.activeProfile].welcome = value
end

-- =====================================================================================================================
-- =====================================================================================================================

 -- PARepair

--------------------------------------------------------------------------
-- PARepair   enable
---------------------------------
function PAMenu_Functions.getFunc.PARepair.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PARepair.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PARepair   repairEquipped
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairEquipped()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquipped
end

function PAMenu_Functions.setFunc.PARepair.repairEquipped(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquipped = value
end

function PAMenu_Functions.disabled.PARepair.repairEquipped()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedThreshold
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairEquippedThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquippedThreshold
end

function PAMenu_Functions.setFunc.PARepair.repairEquippedThreshold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquippedThreshold = value
end

function PAMenu_Functions.disabled.PARepair.repairEquippedThreshold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   repairBackpack
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairBackpack()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpack
end

function PAMenu_Functions.setFunc.PARepair.repairBackpack(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpack = value
end

function PAMenu_Functions.disabled.PARepair.repairBackpack()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairBackpackThreshrold
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairBackpackThreshrold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpackThreshrold
end

function PAMenu_Functions.setFunc.PARepair.repairBackpackThreshrold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpackThreshrold = value
end

function PAMenu_Functions.disabled.PARepair.repairBackpackThreshrold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpack)
end

--------------------------------------------------------------------------
-- PARepair   repairFullChatMode
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairFullChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairFullChatMode
end

function PAMenu_Functions.setFunc.PARepair.repairFullChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairFullChatMode = value
end

function PAMenu_Functions.disabled.PARepair.repairFullChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled and (PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquipped or PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpack))
end

--------------------------------------------------------------------------
-- PARepair   repairPartialChatMode
---------------------------------
function PAMenu_Functions.getFunc.PARepair.repairPartialChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairPartialChatMode
end

function PAMenu_Functions.setFunc.PARepair.repairPartialChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairPartialChatMode = value
end

function PAMenu_Functions.disabled.PARepair.repairPartialChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].enabled and (PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairEquipped or PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairBackpack))
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking

--------------------------------------------------------------------------
-- PABanking   enable
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PABanking.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PABanking   enabledGold
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabledGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold
end

function PAMenu_Functions.setFunc.PABanking.enabledGold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold = value
end

function PAMenu_Functions.disabled.PABanking.enabledGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   goldDepositInterval
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldDepositInterval()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositInterval
end

function PAMenu_Functions.setFunc.PABanking.goldDepositInterval(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositInterval = tonumber(value)
end

function PAMenu_Functions.disabled.PABanking.goldDepositInterval()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldDepositPercentage
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldDepositPercentage()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositPercentage
end

function PAMenu_Functions.setFunc.PABanking.goldDepositPercentage(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositPercentage = value
end

function PAMenu_Functions.disabled.PABanking.goldDepositPercentage()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldTransactionStep
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldTransactionStep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
   return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldTransactionStep
end

function PAMenu_Functions.setFunc.PABanking.goldTransactionStep(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldTransactionStep = value
end

function PAMenu_Functions.disabled.PABanking.goldTransactionStep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldMinToKeep
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldMinToKeep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldMinToKeep
end

function PAMenu_Functions.setFunc.PABanking.goldMinToKeep(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldMinToKeep = tonumber(value)
end

function PAMenu_Functions.disabled.PABanking.goldMinToKeep()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   withdrawToMinGold
---------------------------------
function PAMenu_Functions.getFunc.PABanking.withdrawToMinGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].withdrawToMinGold
end

function PAMenu_Functions.setFunc.PABanking.withdrawToMinGold(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].withdrawToMinGold = value
end

function PAMenu_Functions.disabled.PABanking.withdrawToMinGold()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   enabledItems
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabledItems()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems
end

function PAMenu_Functions.setFunc.PABanking.enabledItems(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems = value
end

function PAMenu_Functions.disabled.PABanking.enabledItems()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   depositTimerInterval
---------------------------------
function PAMenu_Functions.getFunc.PABanking.depositTimerInterval()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].depositTimerInterval
end

function PAMenu_Functions.setFunc.PABanking.depositTimerInterval(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].depositTimerInterval = value
end

function PAMenu_Functions.disabled.PABanking.depositTimerInterval()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - ItemTypeSubmenu

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemsDepStackType
---------------------------------
function PAMenu_Functions.getFunc.PABanking.itemsDepStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].itemsDepStackType
end

function PAMenu_Functions.setFunc.PABanking.itemsDepStackType(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].itemsDepStackType = value
end

function PAMenu_Functions.disabled.PABanking.itemsDepStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemsWitStackType
---------------------------------
function PAMenu_Functions.getFunc.PABanking.itemsWitStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].itemsWitStackType
end

function PAMenu_Functions.setFunc.PABanking.itemsWitStackType(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].itemsWitStackType = value
end

function PAMenu_Functions.disabled.PABanking.itemsWitStackType()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   junkItemsMoveMode
---------------------------------
function PAMenu_Functions.getFunc.PABanking.junkItemsMoveMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].junkItemsMoveMode
end

function PAMenu_Functions.setFunc.PABanking.junkItemsMoveMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].junkItemsMoveMode = value
end

function PAMenu_Functions.disabled.PABanking.junkItemsMoveMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu   itemTypesMoveMode
---------------------------------
function PAMenu_Functions.getFunc.PABanking.itemTypesMoveMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].ItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PABanking.itemTypesMoveMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].ItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PABanking.itemTypesMoveMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  autoLootAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PABanking.depositAllItemTypesButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PABItemTypes) do
        PA.savedVars.Banking[activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_DEPOSIT
    end
end

function PAMenu_Functions.disabled.PABanking.depositAllItemTypesButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  withdrawAllItemTypesButton
---------------------------------
function PAMenu_Functions.func.PABanking.withdrawAllItemTypesButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PABItemTypes) do
        PA.savedVars.Banking[activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_WITHDRAWAL
    end
end

function PAMenu_Functions.disabled.PABanking.withdrawAllItemTypesButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - ItemTypeSubmenu  ignoreAllItemTypesButton
---------------------------------
function PAMenu_Functions.func.PABanking.ignoreAllItemTypesButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PABItemTypes) do
        PA.savedVars.Banking[activeProfile].ItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PABanking.ignoreAllItemTypesButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PABAnking - AdvancedItemTypeSubmenu

--------------------------------------------------------------------------
-- PABAnking - AdvancedItemTypeSubmenu   advItemTypesOperator
---------------------------------
function PAMenu_Functions.getFunc.PABanking.advItemTypesOperator(advancedItemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].ItemTypesAdvanced[advancedItemType].Operator
end

function PAMenu_Functions.setFunc.PABanking.advItemTypesOperator(advancedItemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].ItemTypesAdvanced[advancedItemType].Operator = value
end

function PAMenu_Functions.disabled.PABanking.advItemTypesOperator()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end

--------------------------------------------------------------------------
-- PABAnking - AdvancedItemTypeSubmenu   advItemTypesValue
---------------------------------
function PAMenu_Functions.getFunc.PABanking.advItemTypesValue(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].ItemTypesAdvanced[itemType].Value
end

function PAMenu_Functions.setFunc.PABanking.advItemTypesValue(advancedItemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].ItemTypesAdvanced[advancedItemType].Value = value
end

function PAMenu_Functions.disabled.PABanking.advItemTypesValue()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PALoot

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PALoot.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PALoot   lootGoldEnabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldEnabled
end

function PAMenu_Functions.setFunc.PALoot.lootGoldEnabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldEnabled = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootGoldChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootGoldChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldEnabled)
end

--------------------------------------------------------------------------
-- PALoot   lootItemsEnabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled
end

function PAMenu_Functions.setFunc.PALoot.lootItemsEnabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootItemsChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootItemsChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableBaitLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].harvestableBaitLootMode
end

function PAMenu_Functions.setFunc.PALoot.harvestableBaitLootMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].harvestableBaitLootMode = value
end

function PAMenu_Functions.disabled.PALoot.harvestableBaitLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableItemTypesLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.harvestableItemTypesLootMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].HarvestableItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PALoot.harvestableItemTypesLootMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].HarvestableItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PALoot.harvestableItemTypesLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu autoLootAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PALoot.autoLootAllHarvestableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PA.savedVars.Loot[activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

function PAMenu_Functions.disabled.PALoot.autoLootAllHarvestableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu ignoreAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PALoot.ignoreAllHarvestableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PA.savedVars.Loot[activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PALoot.ignoreAllHarvestableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lootableItemTypesLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootableItemTypesLootMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].LootableItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PALoot.lootableItemTypesLootMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].LootableItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PALoot.lootableItemTypesLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu autoLootAllLootableButton
---------------------------------
function PAMenu_Functions.func.PALoot.autoLootAllLootableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALLootableItemTypes) do
        PA.savedVars.Loot[activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

function PAMenu_Functions.disabled.PALoot.autoLootAllLootableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu ignoreAllLootableButton
---------------------------------
function PAMenu_Functions.func.PALoot.ignoreAllLootableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALLootableItemTypes) do
        PA.savedVars.Loot[activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PALoot.ignoreAllLootableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PAJunk

--------------------------------------------------------------------------
-- PAJunk   enabled
---------------------------------
function PAMenu_Functions.getFunc.PAJunk.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PAJunk.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PAJunk   autoSellJunk
---------------------------------
function PAMenu_Functions.getFunc.PAJunk.autoSellJunk()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].autoSellJunk
end

function PAMenu_Functions.setFunc.PAJunk.autoSellJunk(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].autoSellJunk = value
end

function PAMenu_Functions.disabled.PAJunk.autoSellJunk()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PAJunk   autoMarkTrash
---------------------------------
function PAMenu_Functions.getFunc.PAJunk.autoMarkTrash()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].autoMarkTrash
end

function PAMenu_Functions.setFunc.PAJunk.autoMarkTrash(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].autoMarkTrash = value
end

function PAMenu_Functions.disabled.PAJunk.autoMarkTrash()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Junk[PA.savedVars.Profile.activeProfile].enabled
end


-- =====================================================================================================================
-- =====================================================================================================================