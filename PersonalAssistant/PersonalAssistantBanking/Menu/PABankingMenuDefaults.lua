-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local PABankingMenuDefaults = {
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

            [ITEMTYPE_FURNISHING_MATERIAL] = PAC.MOVE.IGNORE,
        },
    },

    -- ---------------------------------------------
    Advanced = {
        advancedItemsEnabled = true,

        ItemTypes = {
            [ITEMTYPE_RACIAL_STYLE_MOTIF] = PAC.MOVE.IGNORE,
            [ITEMTYPE_RECIPE] = PAC.MOVE.IGNORE,
            [ITEMTYPE_MASTER_WRIT] = PAC.MOVE.IGNORE,
            [ITEMTYPE_GLYPH_ARMOR] = PAC.MOVE.IGNORE,
            [ITEMTYPE_GLYPH_JEWELRY] = PAC.MOVE.IGNORE,
            [ITEMTYPE_GLYPH_WEAPON] = PAC.MOVE.IGNORE,
            [ITEMTYPE_POTION] = PAC.MOVE.IGNORE,
            [ITEMTYPE_POISON] = PAC.MOVE.IGNORE,
            [ITEMTYPE_FOOD] = PAC.MOVE.IGNORE,
            [ITEMTYPE_DRINK] = PAC.MOVE.IGNORE,
            [ITEMTYPE_FISH] = PAC.MOVE.IGNORE,
        },

        SpecializedItemTypes = {
            [SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT] = PAC.MOVE.IGNORE,
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

    Individual = {
        individualItemsEnabled = true,

        ItemIds = {
            [30357] = {     -- [Lockpick]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            },

            [33265] = {     -- [Soul Gem (Empty)]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            },
            [33271] = {     -- [Soul Gem]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            },
            [61080] = {     -- [Crown Soul Gem]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            },

            [44879] = {     -- [Grand Repair Kit]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            },
            [61079] = {     -- [Crown Repair Kit]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            },

            -- [custom] itemIds to be entered here and following
            --[[----------------------------------------------------------------------
            [custom] = {
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 100,
            }
            --]]----------------------------------------------------------------------
            -- remember to also update Globals: BANKING_INDIVIDUAl.GENERIC

        },
    },

    AvA = {
        avaItemsEnabled = false,

        CrossAllianceItemIds = {
            [1000] = {     -- [<Alliance> Ballista]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [1100] = {     -- [<Alliance> Fire Ballista]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [1200] = {     -- [<Alliance> Lightning Ballista]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [1300] = {     -- [<Alliance> Cold Fire Ballista]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [2000] = {     -- [<Alliance> Meatbag Catapult]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [2100] = {     -- [<Alliance> Oil Catapult]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [2200] = {     -- [<Alliance> Scattershot Catapult]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [3000] = {     -- [<Alliance> Firepot Trebuchet]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [3100] = {     -- [<Alliance> Iceball Trebuchet]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [3200] = {     -- [<Alliance> Stone Trebuchet]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [3300] = {     -- [<Alliance> Cold Fire Trebuchet]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [3400] = {     -- [<Alliance> Cold Stone Trebuchet]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [4000] = {     -- [<Alliance> Battering Ram]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [5000] = {     -- [Flaming Oil]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [6000] = {     -- [<Alliance> Forward Camp]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
        },

        ItemIds = {
            [27962] = {     -- [Keep Door Woodwork Repair Kit]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [27138] = {     -- [Keep Wall Masonry Repair Kit]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [27112] = {     -- [Siege Repair Kit]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
            [141731] = {     -- [Keep Recall Stone]
                operator = PAC.OPERATOR.NONE,
                backpackAmount = 20,
            },
        },
    },

    -- ---------------------------------------------

    lazyWritCraftingCompatiblity = true,

    transactionDepositStacking = PAC.STACKING.FULL,
    transactionWithdrawalStacking = PAC.STACKING.FULL,
    autoStackBags = true,

    -- ---------------------------------------------

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PABanking = PABankingMenuDefaults