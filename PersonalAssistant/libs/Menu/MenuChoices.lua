--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Choices then
    PAMenu_Choices = {}
end

PAMenu_Choices.choices = {
    PABanking = {
        goldTransactionStep = {
            "1",
            "10",
            "100",
            "1000",
            "10000",
        },
    },
    PALoot = {
        lootGoldChatMode = {
            PAHF.getFormattedKey("PAL_Gold_ChatMode_None"),
            PAHF.getFormattedKey("PAL_Gold_ChatMode_Min", 123),
            PAHF.getFormattedKey("PAL_Gold_ChatMode_Normal", 123),
            PAHF.getFormattedKey("PAL_Gold_ChatMode_Full", 123),
        },
        lootItemsChatMode = {
            PAHF.getFormattedKey("PAL_Items_ChatMode_None"),
            PAHF.getFormattedKey("PAL_Items_ChatMode_Min", 2, PAC_ICON_BANANAS),
            PAHF.getFormattedKey("PAL_Items_ChatMode_Normal", 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS),
            PAHF.getFormattedKey("PAL_Items_ChatMode_Full", 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS),
        },
        itemTypesLootMode = {
            PALocale.getResourceMessage("PAL_ItemType_Ignore"),
            PALocale.getResourceMessage("PAL_ItemType_AutoLoot"),
        },
        harvestableBaitLootMode = {
            PALocale.getResourceMessage("PAL_ItemType_Ignore"),
            PALocale.getResourceMessage("PAL_ItemType_AutoLoot"),
            PALocale.getResourceMessage("PAL_ItemType_LootDestroy"),
        },
    },
}

PAMenu_Choices.choicesValues = {
    PABanking = {
        goldTransactionStep = {
            1,
            10,
            100,
            1000,
            10000,
        },
    },
    PALoot = {
        lootGoldChatMode = {
            PA_OUTPUT_TYPE_NONE,
            PA_OUTPUT_TYPE_MIN,
            PA_OUTPUT_TYPE_NORMAL,
            PA_OUTPUT_TYPE_FULL,
        },
        lootItemsChatMode = {
            PA_OUTPUT_TYPE_NONE,
            PA_OUTPUT_TYPE_MIN,
            PA_OUTPUT_TYPE_NORMAL,
            PA_OUTPUT_TYPE_FULL,
        },
        itemTypesLootMode = {
            PAC_ITEMTYPE_IGNORE,
            PAC_ITEMTYPE_LOOT,
        },
        harvestableBaitLootMode = {
            PAC_ITEMTYPE_IGNORE,
            PAC_ITEMTYPE_LOOT,
            PAC_ITEMTYPE_DESTROY,
        },
    },
}

PAMenu_Choices.choicesTooltips = {
    PALoot = {
        itemTypesLootMode = {
            PALocale.getResourceMessage("PAL_ItemType_Ignore_T"),
            PALocale.getResourceMessage("PAL_ItemType_AutoLoot_T"),
        },
        harvestableBaitLootMode = {
            PALocale.getResourceMessage("PAL_ItemType_Ignore_T"),
            PALocale.getResourceMessage("PAL_ItemType_AutoLoot_T"),
            PALocale.getResourceMessage("PAL_ItemType_LootDestroy_T"),
        },
    }
}