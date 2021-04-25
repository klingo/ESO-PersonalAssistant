-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- =====================================================================================================================

local PABankingMenuDefaults = {
    name = table.concat({GetString(SI_PA_PROFILE), " ", 1}),

    -- ---------------------------------------------
    Currencies = {
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
    },

    -- ---------------------------------------------
    Crafting = {
        craftingItemsEnabled = true,

        ItemTypes = {
            [ITEMTYPE_BLACKSMITHING_RAW_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_BLACKSMITHING_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_BLACKSMITHING_BOOSTER] = PAC.MOVE.IGNORE,

            [ITEMTYPE_CLOTHIER_RAW_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_CLOTHIER_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_CLOTHIER_BOOSTER] = PAC.MOVE.IGNORE,

            [ITEMTYPE_WOODWORKING_RAW_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_WOODWORKING_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_WOODWORKING_BOOSTER] = PAC.MOVE.IGNORE,

            [ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_JEWELRYCRAFTING_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER] = PAC.MOVE.IGNORE,
            [ITEMTYPE_JEWELRYCRAFTING_BOOSTER] = PAC.MOVE.IGNORE,

            [ITEMTYPE_REAGENT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_POISON_BASE] = PAC.MOVE.IGNORE,
            [ITEMTYPE_POTION_BASE] = PAC.MOVE.IGNORE,

            [ITEMTYPE_ENCHANTING_RUNE_ASPECT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = PAC.MOVE.IGNORE,
            [ITEMTYPE_ENCHANTING_RUNE_POTENCY] = PAC.MOVE.IGNORE,

            [ITEMTYPE_INGREDIENT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_LURE] = PAC.MOVE.IGNORE,

            [ITEMTYPE_RAW_MATERIAL] = PAC.MOVE.IGNORE,
            [ITEMTYPE_STYLE_MATERIAL] = PAC.MOVE.IGNORE,

            [ITEMTYPE_ARMOR_TRAIT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_WEAPON_TRAIT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_JEWELRY_RAW_TRAIT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_JEWELRY_TRAIT] = PAC.MOVE.IGNORE,

            [ITEMTYPE_FURNISHING_MATERIAL] = PAC.MOVE.IGNORE,
        },
    },

    -- ---------------------------------------------
    Advanced = {
        advancedItemsEnabled = true,

        LearnableItemTypes = {
            [ITEMTYPE_RACIAL_STYLE_MOTIF] = {
                Known = PAC.MOVE.IGNORE,
                Unknown = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_RECIPE] = {
                Known = PAC.MOVE.IGNORE,
                Unknown = PAC.MOVE.IGNORE,
            },
        },

        MasterWritCraftingTypes = {
            [CRAFTING_TYPE_BLACKSMITHING] = PAC.MOVE.IGNORE,
            [CRAFTING_TYPE_CLOTHIER] = PAC.MOVE.IGNORE,
            [CRAFTING_TYPE_ENCHANTING] = PAC.MOVE.IGNORE,
            [CRAFTING_TYPE_ALCHEMY] = PAC.MOVE.IGNORE,
            [CRAFTING_TYPE_PROVISIONING] = PAC.MOVE.IGNORE,
            [CRAFTING_TYPE_WOODWORKING] = PAC.MOVE.IGNORE,
            [CRAFTING_TYPE_JEWELRYCRAFTING] = PAC.MOVE.IGNORE,
        },

        HolidayWrits = {
            [SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT] = PAC.MOVE.IGNORE,
        },

        ItemTypes = {
            [ITEMTYPE_GLYPH_ARMOR] = PAC.MOVE.IGNORE,
            [ITEMTYPE_GLYPH_JEWELRY] = PAC.MOVE.IGNORE,
            [ITEMTYPE_GLYPH_WEAPON] = PAC.MOVE.IGNORE,
            [ITEMTYPE_POTION] = PAC.MOVE.IGNORE,
            [ITEMTYPE_POISON] = PAC.MOVE.IGNORE,
            [ITEMTYPE_FOOD] = PAC.MOVE.IGNORE,
            [ITEMTYPE_DRINK] = PAC.MOVE.IGNORE,
            [ITEMTYPE_FISH] = PAC.MOVE.IGNORE,
            [ITEMTYPE_FURNISHING] = PAC.MOVE.IGNORE,
        },

        SpecializedItemTypes = {
            [SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT] = {
                [ITEMFILTERTYPE_BLACKSMITHING] = PAC.MOVE.IGNORE,
                [ITEMFILTERTYPE_CLOTHING] = PAC.MOVE.IGNORE,
                [ITEMFILTERTYPE_ENCHANTING] = PAC.MOVE.IGNORE,
                [ITEMFILTERTYPE_ALCHEMY] = PAC.MOVE.IGNORE,
                [ITEMFILTERTYPE_WOODWORKING] = PAC.MOVE.IGNORE,
                [ITEMFILTERTYPE_JEWELRYCRAFTING] = PAC.MOVE.IGNORE,
            },
            [SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_RECIPE_FRAGMENT] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_RUNEBOX_FRAGMENT] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_COLLECTIBLE_FRAGMENT] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_UPGRADE_FRAGMENT] = PAC.MOVE.IGNORE,
        },

        ItemTraitTypes = {
            [ITEM_TRAIT_TYPE_WEAPON_INTRICATE] = PAC.MOVE.IGNORE,
            [ITEM_TRAIT_TYPE_ARMOR_INTRICATE] = PAC.MOVE.IGNORE,
            [ITEM_TRAIT_TYPE_JEWELRY_INTRICATE] = PAC.MOVE.IGNORE,
        }
    },

    -- ---------------------------------------------
    AvA = {
        avaItemsEnabled = false,

        CrossAllianceItemIds = {
            [1000] = {     -- [<Alliance> Ballista]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [1100] = {     -- [<Alliance> Fire Ballista]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [1200] = {     -- [<Alliance> Lightning Ballista]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [1300] = {     -- [<Alliance> Cold Fire Ballista]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [2000] = {     -- [<Alliance> Meatbag Catapult]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [2100] = {     -- [<Alliance> Oil Catapult]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [2200] = {     -- [<Alliance> Scattershot Catapult]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [3000] = {     -- [<Alliance> Firepot Trebuchet]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [3100] = {     -- [<Alliance> Iceball Trebuchet]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [3200] = {     -- [<Alliance> Stone Trebuchet]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [3300] = {     -- [<Alliance> Cold Fire Trebuchet]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [3400] = {     -- [<Alliance> Cold Stone Trebuchet]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [4000] = {     -- [<Alliance> Battering Ram]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [5000] = {     -- [Flaming Oil]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [6000] = {     -- [<Alliance> Forward Camp]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
        },

        ItemIds = {
            [27962] = {     -- [Keep Door Woodwork Repair Kit]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [27138] = {     -- [Keep Wall Masonry Repair Kit]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [27112] = {     -- [Siege Repair Kit]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [142133] = {    -- [Bridge and Milegate Repair Kit]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
            [141731] = {     -- [Keep Recall Stone]
                operator = PAC.OPERATOR.NONE,
                bagAmount = 0,
            },
        },
    },

    -- ---------------------------------------------
    Custom = {
        customItemsEnabled = true,
        PAItemIds = {
        }
    },

    -- ---------------------------------------------
    autoExecuteItemTransfers = true,
    transactionDepositStacking = PAC.STACKING.FULL,
    transactionWithdrawalStacking = PAC.STACKING.FULL,
    excludeJunk = true,
    autoStackBags = true,

    -- ---------------------------------------------

    silentMode = false,
}

-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PABanking = PABankingMenuDefaults