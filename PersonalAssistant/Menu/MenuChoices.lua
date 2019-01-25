-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions
local L = PA.Localization

local PAMenuChoices = {
    PARepair = {
        repairFullChatMode = {
            PAHF.getFormattedText(L.PAR_FullRepair_ChatMode_None),
            PAHF.getFormattedText(L.PAR_FullRepair_ChatMode_Min, 115),
            PAHF.getFormattedText(L.PAR_FullRepair_ChatMode_Normal, 115),
            PAHF.getFormattedText(L.PAR_FullRepair_ChatMode_Full, L.NS_Bag_Equipped, 115),
        },
        repairPartialChatMode = {
            PAHF.getFormattedText(L.PAR_PartialRepair_ChatMode_None),
            PAHF.getFormattedText(L.PAR_PartialRepair_ChatMode_Min, 115, 65),
            PAHF.getFormattedText(L.PAR_PartialRepair_ChatMode_Normal, 115, 65),
            PAHF.getFormattedText(L.PAR_PartialRepair_ChatMode_Full, 3, 7, L.NS_Bag_Equipped, 115, 65),
        },
        chargeWeaponsChatMode = {
            PAHF.getFormattedText(L.PAR_ReChargeWeapon_ChatMode_None),
            PAHF.getFormattedText(L.PAR_ReChargeWeapon_ChatMode_Min, PAC_ICON_SOULGEM, PAC_ICON_WEAPON, 15, 100),
            PAHF.getFormattedText(L.PAR_ReChargeWeapon_ChatMode_Normal, PAC_ITEMCODE_WEAPON, 15, 100, PAC_ITEMCODE_SOULGEM),
            PAHF.getFormattedText(L.PAR_ReChargeWeapon_ChatMode_Full, PAC_ICON_WEAPON, PAC_ITEMCODE_WEAPON, 15, 100, PAC_ICON_SOULGEM, PAC_ITEMCODE_SOULGEM),
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
            L.ST_MoveAllFull,
            L.ST_MoveExistingFull,
            L.ST_FillIncompleteOnly
        },
        itemMoveMode = {
            L.PAB_MoveTo_Ignore,
            L.PAB_MoveTo_Bank,
            L.PAB_MoveTo_Backpack
        },
        mathOperator = {
            L.REL_None,
            L.REL_Equal,
            -- L.REL_LessThan,
            L.REL_LessThanEqual,
            -- L.REL_GreaterThan,
            L.REL_GreaterThanEqual
        },
    },
    PALoot = {
        lootGoldChatMode = {
            PAHF.getFormattedText(L.PAL_Gold_ChatMode_None),
            PAHF.getFormattedText(L.PAL_Gold_ChatMode_Min, 123),
            PAHF.getFormattedText(L.PAL_Gold_ChatMode_Normal, 123),
            PAHF.getFormattedText(L.PAL_Gold_ChatMode_Full, 123),
        },
        lootItemsChatMode = {
            PAHF.getFormattedText(L.PAL_Items_ChatMode_None),
            PAHF.getFormattedText(L.PAL_Items_ChatMode_Min, 2, PAC_ICON_BANANAS, ""),
            PAHF.getFormattedText(L.PAL_Items_ChatMode_Normal, 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS, ""),
            PAHF.getFormattedText(L.PAL_Items_ChatMode_Full, 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS, ""),
        },
        itemTypesLootMode = {
            L.PAL_ItemType_Ignore,
            L.PAL_ItemType_AutoLoot
        },
        harvestableBaitLootMode = {
            L.PAL_ItemType_Ignore,
            L.PAL_ItemType_AutoLoot,
            L.PAL_ItemType_LootDestroy
        },
    },
}

local PAMenuChoicesValues = {
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
            -- PAC_OPERATOR_LESSTHAN,
            PAC_OPERATOR_LESSTAHNEQAL,
            -- PAC_OPERATOR_GREATERTHAN,
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

local PAMenuChoicesTooltips = {
    PALoot = {
        itemTypesLootMode = {
            L.PAL_ItemType_Ignore_T,
            L.PAL_ItemType_AutoLoot_T
        },
        harvestableBaitLootMode = {
            L.PAL_ItemType_Ignore_T,
            L.PAL_ItemType_AutoLoot_T,
            L.PAL_ItemType_LootDestroy_T
        },
    }
}

-- Export
PA.MenuChoices = {
    choices = PAMenuChoices,
    choicesValues = PAMenuChoicesValues,
    choicesTooltip = PAMenuChoicesTooltips
}