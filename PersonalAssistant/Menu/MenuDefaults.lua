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
        autoRepairEnabled = true,

        -- ---------------------------------------------

        RepairEquipped = {
            repairWithGold = true,
            repairWithGoldDurabilityThreshold = 75,
            repairWithGoldChatMode = PAC.CHATMODE.OUTPUT_NORMAL,

            repairWithRepairKit = false,
            repairWithRepairKitThreshold = 75,
            repairWithRepairKitChatMode = PAC.CHATMODE.OUTPUT_NORMAL,

            repairWithCrownRepairKit = false,
            repairWithCrownRepairKitThreshold = 50,
            repairWithCrownRepairKitChatMode = PAC.CHATMODE.OUTPUT_NORMAL,

            lowRepairKitWarning = true,
        },

        -- ---------------------------------------------

        RechargeWeapons = {
            useSoulGems = false,
            chargeWeaponsThreshold = 5,
            chargeWeaponsChatMode = PAC.CHATMODE.OUTPUT_NORMAL,
            lowSoulGemWarning = true,
        },
    },
    PABanking = {
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

            blacksmithingTransaction = true,
            clothingTransaction = true,
            woodworkingTransaction = true,
            jewelcraftingTransaction = true,
            alchemyTransaction = true,
            enchantingTransaction = true,
            provisioningTransaction = true,
            styleMaterialsTransaction = true,
            traitItemsTransaction = true,
            furnishingTransaction = true,

            ItemTypesCrafting = {
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
                [ITEMTYPE_RACIAL_STYLE_MOTIF] = {
                    enabledSetting = "motivesEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
                [ITEMTYPE_RECIPE] = {
                    enabledSetting = "recipesEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
                [ITEMTYPE_GLYPH_ARMOR] = {
                    enabledSetting = "glyphsEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
                [ITEMTYPE_GLYPH_JEWELRY] = {
                    enabledSetting = "glyphsEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
                [ITEMTYPE_GLYPH_WEAPON] = {
                    enabledSetting = "glyphsEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
            },

            SpecializedItemTypes = {
                [SPECIALIZED_ITEMTYPE_POTION] = {
                    enabledSetting = "liquidsEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
                [SPECIALIZED_ITEMTYPE_POISON] = {
                    enabledSetting = "liquidsEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
                [SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP] = {
                    enabledSetting = "trophiesEnabled",
                    moveMode = PAC.MOVE.IGNORE,
                },
            },

            TransactionSettings = {
                motivesEnabled = true,
                recipesEnabled = true,
                glyphsEnabled = true,

                liquidsEnabled = true,
                trophiesEnabled = true,
            },
        },

        -- ---------------------------------------------

        Individual = {
            individualItemsEnabled = true,

            lockpickTransaction = true,
            soulGemTransaction = true,
            repairKitTransaction = true,
            genericTransaction = false,

            ItemIdOperator = {
                [30357] = PAC.OPERATOR.NONE,  -- [Lockpick]

                [33265] = PAC.OPERATOR.NONE,  -- [Soul Gem (Empty)]
                [33271] = PAC.OPERATOR.NONE,  -- [Soul Gem]
                [61080] = PAC.OPERATOR.NONE,  -- [Crown Soul Gem]

                [44879] = PAC.OPERATOR.NONE,  -- [Grand Repair Kit]
                [61079] = PAC.OPERATOR.NONE,  -- [Crown Repair Kit]
            },

            ItemIdBackpackAmount = {
                [30357] = 100,  -- [Lockpick]

                [33265] = 100,  -- [Soul Gem (Empty)]
                [33271] = 100,  -- [Soul Gem]
                [61080] = 100,  -- [Crown Soul Gem]

                [44879] = 100,  -- [Grand Repair Kit]
                [61079] = 100,  -- [Crown Repair Kit]
            },
        },

        -- ---------------------------------------------

        transactionDepositStacking = PAC.STACKING.FULL,
        transactionWithdrawalStacking = PAC.STACKING.FULL,
        transactionInterval = 100,
        autoStackBank = true,

        -- ---------------------------------------------
    },
    PALoot = {
        enabled = false,
        lootGold = true,
        lootGoldChatMode = PAC.CHATMODE.OUTPUT_NORMAL,
        lootItems = true,
        lootItemsChatMode = PAC.CHATMODE.OUTPUT_MAX,
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
        AutoMarkAsJunk = {
            autoMarkAsJunkEnabled = false,
            autoMarkTrash = true,
            autoMarkOrnate = true,
            autoMarkWeaponsQuality = false,
            autoMarkWeaponsQualityThreshold = 0,
            autoMarkArmorQuality = false,
            autoMarkArmorQualityThreshold = 0,
        },
        autoSellJunk = true,
    },
    PAMail = {
        hirelingAutoMailEnabled = false,
        hirelingDeleteEmptyMails = false,
    }
}