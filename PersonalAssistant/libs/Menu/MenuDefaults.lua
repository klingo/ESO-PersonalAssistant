--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Defaults then
    PAMenu_Defaults = {}
end

PAMenu_Defaults.defaultSettings = {
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
        enabled = true,
        enabledGold = true,
        goldTransactionStep = 1,
        goldMinToKeep = 250,
        withdrawToMinGold = false,
        goldLastDeposit = 0,    -- timestamp to keep track of last gold depost
        enabledItems = false,
        itemsDepStackType = PAB_STACKING_FULL,
        itemsWitStackType = PAB_STACKING_FULL,
        depositTimerInterval = 300,
        ItemTypesMaterial = {},
        ItemTypes = {},
        ItemTypesAdvanced = {},
    },
    PALoot = {
        enabled = false,
        lootGoldEnabled = true,
        lootGoldChatMode = PA_OUTPUT_TYPE_NORMAL,
        lootItemsEnabled = true,
        lootItemsChatMode = PA_OUTPUT_TYPE_FULL,
        HarvestableItemTypes = {},
        LootableItemTypes = {},
        harvestableItemTypesLootMode = PAC_ITEMTYPE_IGNORE,
        lootableItemTypesLootMode = PAC_ITEMTYPE_IGNORE,
        harvestableBaitLootMode = PAC_ITEMTYPE_LOOT,
    },
    PAJunk = {
        enabled = false,
        autoSellJunk = true,
        autoMarkTrash = true,
        autoMarkOrnate = false,
    },
    PAWorker = {
    },
}