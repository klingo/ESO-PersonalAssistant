--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Defaults then
    PAMenu_Defaults = {}
    PAMenu_Defaults.PABanking = {}
    PAMenu_Defaults.PALoot = {}
end

PAMenu_Defaults.defaultSettings = {
    PABanking = {
        enabled = true,
        enabledGold = true,
        goldDepositInterval = 300,
        goldDepositPercentage = 100,
        goldTransactionStep = 1,
        goldMinToKeep = 250,
        withdrawToMinGold = false,
        goldLastDeposit = 0,    -- timestamp to keep track of last gold depost
        enabledItems = false,
        itemsDepStackType = PAB_STACKING_FULL,
        itemsWitStackType = PAB_STACKING_FULL,
        depositTimerInterval = 300,
        itemsJunkSetting = PAC_ITEMTYPE_IGNORE,
        hideNoDepositMsg = false,
        hideAllMsg = false,
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
    },
}