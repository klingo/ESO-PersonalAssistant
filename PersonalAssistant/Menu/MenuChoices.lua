-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

local PAMenuChoices = {
    PARepair = {
        repairChatMode = {
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHATMODE_NONE)),
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHATMODE_MIN), 115, 65),
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHATMODE_NORMAL), 115, 65),
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHATMODE_MAX)),
        },
        chargeWeaponsChatMode = {
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_NONE)),
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_MIN), PAC.ICONS.ITEMS.SOULGEM.SMALL, PAC.ICONS.ITEMS.WEAPON, 15, 100),
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_NORMAL), PAC.ITEMLINKS.WEAPON, 15, 100, PAC.ITEMLINKS.SOULGEM),
            PAHF.getFormattedText(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_MAX), PAC.ICONS.ITEMS.WEAPON, PAC.ITEMLINKS.WEAPON, 15, 100, PAC.ICONS.ITEMS.SOULGEM.SMALL, PAC.ITEMLINKS.SOULGEM),
        }
    },
    PABanking = {
        transactionStep = {
            "1",
            "10",
            "100",
            "1000",
            "10000",
        },
        stackingType = {
            GetString(SI_PA_ST_MOVE_FULL),
            GetString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY)
        },
        itemMoveMode = {
            GetString(SI_PA_BANKING_MOVE_MODE_DONOTHING),
            GetString(SI_PA_BANKING_MOVE_MODE_TOBANK),
            GetString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK)
        },
        mathOperator = {
            GetString(SI_PA_REL_NONE),
            GetString(SI_PA_REL_EQUAL),
            -- GetString(SI_PA_REL_LESSTHAN),
            GetString(SI_PA_REL_LESSTHANEQUAL),
            -- GetString(SI_PA_REL_GREATERTHAN),
            GetString(SI_PA_REL_GREATERTHANEQUAL)
        },
    },
    PALoot = {
        lootGoldChatMode = {
            PAHF.getFormattedText(GetString(SI_PA_LOOT_GOLD_CHATMODE_NONE)),
            PAHF.getFormattedText(GetString(SI_PA_LOOT_GOLD_CHATMODE_MIN), 123),
            PAHF.getFormattedText(GetString(SI_PA_LOOT_GOLD_CHATMODE_NORMAL), 123),
            PAHF.getFormattedText(GetString(SI_PA_LOOT_GOLD_CHATMODE_MAX), 123),
        },
        lootItemsChatMode = {
            PAHF.getFormattedText(GetString(SI_PA_LOOT_ITEMS_CHATMODE_NONE)),
            PAHF.getFormattedText(GetString(SI_PA_LOOT_ITEMS_CHATMODE_MIN), 2, PAC.ICONS.ITEMS.BANANAS, ""),
            PAHF.getFormattedText(GetString(SI_PA_LOOT_ITEMS_CHATMODE_NORMAL), 2, PAC.ITEMLINKS.BANANAS, PAC.ICONS.ITEMS.BANANAS, ""),
            PAHF.getFormattedText(GetString(SI_PA_LOOT_ITEMS_CHATMODE_MAX), 2, PAC.ITEMLINKS.BANANAS, PAC.ICONS.ITEMS.BANANAS, ""),
        },
        itemTypesLootMode = {
            GetString(SI_PA_LOOT_LOOT_MODE_IGNORE),
            GetString(SI_PA_LOOT_LOOT_MODE_AUTOLOOT)
        },
        harvestableBaitLootMode = {
            GetString(SI_PA_LOOT_LOOT_MODE_IGNORE),
            GetString(SI_PA_LOOT_LOOT_MODE_AUTOLOOT),
            GetString(SI_PA_LOOT_LOOT_MODE_LOOTDESTROY)
        },
    },
    PAJunk = {
        qualityLevel = {
            GetString(SI_PA_QUALITY_TRASH),
            GetString(SI_PA_QUALITY_NORMAL),
            GetString(SI_PA_QUALITY_FINE),
            GetString(SI_PA_QUALITY_SUPERIOR),
            GetString(SI_PA_QUALITY_EPIC),
            GetString(SI_PA_QUALITY_LEGENDARY),
        }
    }
}

local PAMenuChoicesValues = {
    PARepair = {
        repairChatMode = {
            PAC.CHATMODE.OUTPUT_NONE,
            PAC.CHATMODE.OUTPUT_MIN,
            PAC.CHATMODE.OUTPUT_NORMAL,
            PAC.CHATMODE.OUTPUT_MAX,
        },
        chargeWeaponsChatMode = {
            PAC.CHATMODE.OUTPUT_NONE,
            PAC.CHATMODE.OUTPUT_MIN,
            PAC.CHATMODE.OUTPUT_NORMAL,
            PAC.CHATMODE.OUTPUT_MAX,
        }
    },
    PABanking = {
        transactionStep = {
            1,
            10,
            100,
            1000,
            10000,
        },
        stackingType = {
            PAC.STACKING.FULL,
            PAC.STACKING.INCOMPLETE
        },
        itemMoveMode = {
            PAC.MOVE.IGNORE,
            PAC.MOVE.DEPOSIT,
            PAC.MOVE.WITHDRAW,
        },
        mathOperator = {
            PAC.OPERATOR.NONE,
            PAC.OPERATOR.EQUAL,
            -- PAC.OPERATOR.LESSTHAN,
            PAC.OPERATOR.LESSTHANOREQUAL,
            -- PAC.OPERATOR.GREATERTHAN,
            PAC.OPERATOR.GREATERTHANOREQUAL,
        },
    },
    PALoot = {
        lootGoldChatMode = {
            PAC.CHATMODE.OUTPUT_NONE,
            PAC.CHATMODE.OUTPUT_MIN,
            PAC.CHATMODE.OUTPUT_NORMAL,
            PAC.CHATMODE.OUTPUT_MAX,
        },
        lootItemsChatMode = {
            PAC.CHATMODE.OUTPUT_NONE,
            PAC.CHATMODE.OUTPUT_MIN,
            PAC.CHATMODE.OUTPUT_NORMAL,
            PAC.CHATMODE.OUTPUT_MAX,
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
    PAJunk = {
        qualityLevel = {
            ITEM_QUALITY_TRASH,     -- 0
            ITEM_QUALITY_NORMAL,    -- 1
            ITEM_QUALITY_MAGIC,     -- 2
            ITEM_QUALITY_ARCANE,    -- 3
            ITEM_QUALITY_ARTIFACT,  -- 4
            ITEM_QUALITY_LEGENDARY, -- 5
        }
    }
}

local PAMenuChoicesTooltips = {
    PALoot = {
        itemTypesLootMode = {
            GetString(SI_PA_LOOT_LOOT_MODE_IGNORE_T),
            GetString(SI_PA_LOOT_LOOT_MODE_AUTOLOOT_T)
        },
        harvestableBaitLootMode = {
            GetString(SI_PA_LOOT_LOOT_MODE_IGNORE_T),
            GetString(SI_PA_LOOT_LOOT_MODE_AUTOLOOT_T),
            GetString(SI_PA_LOOT_LOOT_MODE_LOOTDESTROY_T)
        },
    }
}

-- Export
PA.MenuChoices = {
    choices = PAMenuChoices,
    choicesValues = PAMenuChoicesValues,
    choicesTooltips = PAMenuChoicesTooltips
}