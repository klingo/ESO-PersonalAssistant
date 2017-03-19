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
    PARepair = {
        repairFullChatMode = {
            PAHF.getFormattedKey("PAR_FullRepair_ChatMode_None"),
            PAHF.getFormattedKey("PAR_FullRepair_ChatMode_Min", 115),
            PAHF.getFormattedKey("PAR_FullRepair_ChatMode_Normal", 115),
            PAHF.getFormattedKey("PAR_FullRepair_ChatMode_Full", "equipped", 115),
        },
        repairPartialChatMode = {
            PAHF.getFormattedKey("PAR_PartialRepair_ChatMode_None"),
            PAHF.getFormattedKey("PAR_PartialRepair_ChatMode_Min", 115, 65),
            PAHF.getFormattedKey("PAR_PartialRepair_ChatMode_Normal", 115, 65),
            PAHF.getFormattedKey("PAR_PartialRepair_ChatMode_Full", 3, 7, "equipped", 115, 65),
        },
        chargeWeaponsChatMode = {
            PAHF.getFormattedKey("PAR_ReChargeWeapon_ChatMode_None"),
            PAHF.getFormattedKey("PAR_ReChargeWeapon_ChatMode_Min", PAC_ICON_SOULGEM, PAC_ICON_WEAPON, 15, 100),
            PAHF.getFormattedKey("PAR_ReChargeWeapon_ChatMode_Normal", PAC_ITEMCODE_WEAPON, 15, 100, PAC_ITEMCODE_SOULGEM),
            PAHF.getFormattedKey("PAR_ReChargeWeapon_ChatMode_Full", PAC_ICON_WEAPON, PAC_ITEMCODE_WEAPON, 15, 100, PAC_ICON_SOULGEM, PAC_ITEMCODE_SOULGEM),
        }
    },
    PABanking = {
        goldTransactionStep = {
            "1",
            "10",
            "100",
            "1000",
            "10000",
        },
        stackingType = {
            PALocale.getResourceMessage("ST_MoveAllFull"),
            PALocale.getResourceMessage("ST_MoveExistingFull"),
            PALocale.getResourceMessage("ST_FillIncompleteOnly"),
        },
        itemMoveMode = {
            ResourceBundle.en["PAB_MoveTo_Ignore"],
            ResourceBundle.en["PAB_MoveTo_Bank"],
            ResourceBundle.en["PAB_MoveTo_Backpack"],
        },
        mathOperator = {
            PALocale.getResourceMessage("REL_None"),
            PALocale.getResourceMessage("REL_Equal"),
--            PALocale.getResourceMessage("REL_LessThan"),
            PALocale.getResourceMessage("REL_LessThanEqual"),
--            PALocale.getResourceMessage("REL_GreaterThan"),
            PALocale.getResourceMessage("REL_GreaterThanEqual")
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
            PAHF.getFormattedKey("PAL_Items_ChatMode_Min", 2, PAC_ICON_BANANAS, ""),
            PAHF.getFormattedKey("PAL_Items_ChatMode_Normal", 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS, ""),
            PAHF.getFormattedKey("PAL_Items_ChatMode_Full", 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS, ""),
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
    PARepair = {
        repairFullChatMode = {
            PA_OUTPUT_TYPE_NONE,
            PA_OUTPUT_TYPE_MIN,
            PA_OUTPUT_TYPE_NORMAL,
            PA_OUTPUT_TYPE_FULL,
        },
        repairPartialChatMode = {
            PA_OUTPUT_TYPE_NONE,
            PA_OUTPUT_TYPE_MIN,
            PA_OUTPUT_TYPE_NORMAL,
            PA_OUTPUT_TYPE_FULL,
        },
        chargeWeaponsChatMode = {
            PA_OUTPUT_TYPE_NONE,
            PA_OUTPUT_TYPE_MIN,
            PA_OUTPUT_TYPE_NORMAL,
            PA_OUTPUT_TYPE_FULL,
        }
    },
    PABanking = {
        goldTransactionStep = {
            1,
            10,
            100,
            1000,
            10000,
        },
        stackingType = {
            PAB_STACKING_FULL,
            PAB_STACKING_CONTINUE,
            PAB_STACKING_INCOMPLETE,
        },
        itemMoveMode = {
            PAB_MOVETO_IGNORE,
            PAB_MOVETO_BANK,
            PAB_MOVETO_BACKPACK,
        },
        mathOperator = {
            PAC_OPERATOR_NONE,
            PAC_OPERATOR_EQUAL,
--            PAC_OPERATOR_LESSTHAN,
            PAC_OPERATOR_LESSTAHNEQAL,
--            PAC_OPERATOR_GREATERTHAN,
            PAC_OPERATOR_GREATERTHANEQUAL,
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