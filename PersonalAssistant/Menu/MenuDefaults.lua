-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- =====================================================================================================================
-- =====================================================================================================================

-- Export
PA.MenuDefaults = {
    PAGeneral = {
        welcomeMessage = true,
    },
    PARepair = {
        enabled = true,
        repairEquipped = true,
        repairEquippedThreshold = 75,
        repairEquippedWithKit = false,
        repairEquippedWithKitThreshold = 50,
        repairFullChatMode = PA_OUTPUT_TYPE_NORMAL,
        repairPartialChatMode = PA_OUTPUT_TYPE_NORMAL,
        chargeWeapons = false,
        chargeWeaponsThreshold = 10,
        chargeWeaponsChatMode = PA_OUTPUT_TYPE_NORMAL,
    },
    PABanking = {
        currenciesEnabled = true,

        goldTransaction = false,
        goldMinToKeep = 1000,
        goldMaxToKeep = 5000,

        alliancePointsTransaction = false,
        alliancePointsMinToKeep = 1000,
        alliancePointsMaxToKeep = 5000,

        telVarTransaction = false,
        telVarMinToKeep = 1000,
        telVarMaxToKeep = 5000,

        writVouchersTransaction = false,
        writVouchersMinToKeep = 10,
        writVouchersMaxToKeep = 100,

        -- ---------------------------------------------

        craftingItemsEnabled = true,
        craftingItemsDepositStacking = PAC.STACKING.FULL,
        craftingItemsWithdrawalStacking = PAC.STACKING.FULL,

        blacksmithingTransaction = false,
        clothingTransaction = false,
        woodworkingTransaction = false,
        jewelcraftingTransaction = false,
        alchemyTransaction = false,
        enchantingTransaction = false,
        provisioningTransaction = false,
        styleMaterialTransaction = false,
        traitItemTransaction = false,
        furnishingTransaction = false,

        CraftingItemTypeMoves = {},

        -- ---------------------------------------------
        itemTransaction = false,
        itemsDepStackType = PAB_STACKING_FULL,
        itemsWitStackType = PAB_STACKING_FULL,
        depositTimerInterval = 300,
        ItemTypesMaterial = {},
        ItemTypes = {},
        ItemTypesAdvanced = {
            advItemTypesValue = 100
        },
    },
    PALoot = {
        enabled = false,
        lootGold = true,
        lootGoldChatMode = PA_OUTPUT_TYPE_NORMAL,
        lootItems = true,
        lootItemsChatMode = PA_OUTPUT_TYPE_FULL,
        lootStolenItems = false,
        HarvestableItemTypes = {},
        LootableItemTypes = {},
        harvestableItemTypesLootMode = PAC_ITEMTYPE_IGNORE,
        lootableItemTypesLootMode = PAC_ITEMTYPE_IGNORE,
        lockpickLootMode = PAC_ITEMTYPE_IGNORE,
        questItemsLootMode = PAC_ITEMTYPE_IGNORE,
        harvestableBaitLootMode = PAC_ITEMTYPE_LOOT,
    },
    PAJunk = {
        enabled = false,
        autoSellJunk = true,
        autoMarkTrash = true,
        autoMarkOrnate = false,
    },
}