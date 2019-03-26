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
            [ITEMTYPE_BLACKSMITHING_RAW_MATERIAL] = {
                enabledSetting = "blacksmithingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_BLACKSMITHING_MATERIAL] = {
                enabledSetting = "blacksmithingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_BLACKSMITHING_BOOSTER] = {
                enabledSetting = "blacksmithingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_CLOTHIER_RAW_MATERIAL] = {
                enabledSetting = "clothingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_CLOTHIER_MATERIAL] = {
                enabledSetting = "clothingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_CLOTHIER_BOOSTER] = {
                enabledSetting = "clothingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_WOODWORKING_RAW_MATERIAL] = {
                enabledSetting = "woodworkingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_WOODWORKING_MATERIAL] = {
                enabledSetting = "woodworkingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_WOODWORKING_BOOSTER] = {
                enabledSetting = "woodworkingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = {
                enabledSetting = "jewelcraftingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_JEWELRYCRAFTING_MATERIAL] = {
                enabledSetting = "jewelcraftingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_JEWELRYCRAFTING_BOOSTER] = {
                enabledSetting = "jewelcraftingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_REAGENT] = {
                enabledSetting = "alchemyEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_POISON_BASE] = {
                enabledSetting = "alchemyEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_POTION_BASE] = {
                enabledSetting = "alchemyEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_ENCHANTING_RUNE_ASPECT] = {
                enabledSetting = "enchantingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = {
                enabledSetting = "enchantingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_ENCHANTING_RUNE_POTENCY] = {
                enabledSetting = "enchantingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_INGREDIENT] = {
                enabledSetting = "provisioningEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_LURE] = {
                enabledSetting = "provisioningEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_RAW_MATERIAL] = {
                enabledSetting = "styleMaterialsEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_STYLE_MATERIAL] = {
                enabledSetting = "styleMaterialsEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_ARMOR_TRAIT] = {
                enabledSetting = "traitItemsEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
            [ITEMTYPE_WEAPON_TRAIT] = {
                enabledSetting = "traitItemsEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },

            [ITEMTYPE_FURNISHING_MATERIAL] = {
                enabledSetting = "furnishingEnabled",
                moveMode = PAC.MOVE.IGNORE,
            },
        },

        TransactionSettings = {
            blacksmithingEnabled = true,
            clothingEnabled = true,
            woodworkingEnabled = true,
            jewelcraftingEnabled = true,
            alchemyEnabled = true,
            enchantingEnabled = true,
            provisioningEnabled = true,
            styleMaterialsEnabled = true,
            traitItemsEnabled = true,
            furnishingEnabled = true,
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
        },

        SpecializedItemTypes = {
            [SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT] = PAC.MOVE.IGNORE,
            [SPECIALIZED_ITEMTYPE_TROPHY_COLLECTIBLE_FRAGMENT] = PAC.MOVE.IGNORE,
        },
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

    -- ---------------------------------------------

    transactionDepositStacking = PAC.STACKING.FULL,
    transactionWithdrawalStacking = PAC.STACKING.FULL,
    transactionInterval = 100,
    autoStackBags = true,

    -- ---------------------------------------------

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PABanking = PABankingMenuDefaults