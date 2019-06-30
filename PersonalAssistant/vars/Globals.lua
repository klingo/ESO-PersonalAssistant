-- PersonalAssistant - Prepare all Global Tables
PersonalAssistant = {}
PersonalAssistant.SavedVars = {}
PersonalAssistant.MenuFunctions = {}
PersonalAssistant.MenuHelper = {}

-- ---------------------------------------------------------------------------------------------------------------------

PersonalAssistant.Constants = {
    ADDON = {
        NAME_RAW = {
            GENERAL = "PersonalAssistant",
            BANKING = "PersonalAssistant Banking",
            JUNK = "PersonalAssistant Junk",
            LOOT = "PersonalAssistant Loot",
            REPAIR = "PersonalAssistant Repair",
        },
        NAME_DISPLAY = {
            GENERAL = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant", "|r"}),
            BANKING = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant ", "|r", "|cFFD700", "B", "|r", "|cFFFFFF", "anking", "|r"}),
            JUNK = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant ", "|r", "|cFFD700", "J", "|r", "|cFFFFFF", "unk", "|r"}),
            LOOT = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant ", "|r", "|cFFD700", "L", "|r", "|cFFFFFF", "oot", "|r"}),
            REPAIR = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant ", "|r", "|cFFD700", "R", "|r", "|cFFFFFF", "epair", "|r"}),
        },
        AUTHOR = "Klingo",
        VERSION_RAW = "{BUILD_NUMBER}",
        VERSION_DISPLAY = "{VERSION_NUMBER}",
        WEBSITE = "http://www.esoui.com/downloads/info381-PersonalAssistant",
        FEEDBACK = "https://www.esoui.com/downloads/info381-PersonalAssistant.html#comments",
        KEYWORDS = {
            GENERAL = "general, profile, house",
            BANKING = "banking, deposit, withdraw, currency, currencies, bank, rules",
            JUNK = "junk, mark, fence, sell, rules",
            LOOT = "loot, unknown, recipe, motif, trait",
            REPAIR = "repair, repairkit, recharge, soulgem",
        },
        SAVED_VARS_VERSION = { -- changing these values cause all settings to be reset!
            MAJOR = {
                GENERAL = 1,
                PROFILE = 1,
                BANKING = 2,
                JUNK = 2,
                LOOT = 2,
                REPAIR = 1,
            },
            MINOR = 020400, -- update this every release!
        },
    },

    GENERAL = {
        MAX_PROFILES = 8,
        NO_PROFILE_SELECTED_ID = 9
    },

    COLOR = {
        LIGHT_BLUE = ZO_ColorDef:New("B0B0FF"),
        ORANGE = ZO_ColorDef:New("FFA500"),
        ORANGE_RED = ZO_ColorDef:New("FF7400"),
        YELLOW = ZO_ColorDef:New("FFD700"),
    },
    COLORS = {
        DEFAULT = "|cFFFF00",
        WHITE = "|cFFFFFF",
        LIGHT_BLUE = "|cB0B0FF",
        GOLD = "|cC5C29E", -- TODO: not used
        GREEN = "|c00FF00",
        YELLOW = "|cFFD700", -- TODO: not used
        ORANGE_RED = "|cFF7400",
        ORANGE = "|cFFA500",
        RED = "|cFF0000",
    },

    COLORED_TEXTS = {
        PA = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant", "|r"}),
        PAG = table.concat({"|cFFD700", "PA G", "|r", "|cFFFFFF", "eneral: ", "|r"}),
        PAB = table.concat({"|cFFD700", "PA B", "|r", "|cFFFFFF", "anking: ", "|r"}),
        PAR = table.concat({"|cFFD700", "PA R", "|r", "|cFFFFFF", "epair: ", "|r"}),
        PAL = table.concat({"|cFFD700", "PA L", "|r", "|cFFFFFF", "oot: ", "|r"}),
        PAM = table.concat({"|cFFD700", "PA M", "|r", "|cFFFFFF", "ail: ", "|r"}),
        PAJ = table.concat({"|cFFD700", "PA J", "|r", "|cFFFFFF", "unk: ", "|r"}),
    },

    COLORED_TEXTS_DEBUG = {
        PA = table.concat({"|cFFFFFF", "PA", "|r", ": "}),
        PAG = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "G", "|r", ": "}),
        PAB = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "B", "|r", ": "}),
        PAR = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "R", "|r", ": "}),
        PAL = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "L", "|r", ": "}),
        PAM = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "M", "|r", ": "}),
        PAJ = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "J", "|r", ": "}),
    },

    ICONS = {
        TEXTURE_COORDS = {
            MEDIUM = {0.125, 0.875, 0.125, 0.875},
            LARGE = {0.15, 0.85, 0.15, 0.85},
        },
        CURRENCY = {
            [CURT_MONEY] = {
                SMALL = table.concat({"|t16:16:", ZO_CURRENCIES_DATA[CURT_MONEY].keyboardTexture, "|t"}),
            },
            [CURT_ALLIANCE_POINTS] = {
                SMALL = table.concat({"|t16:16:", ZO_CURRENCIES_DATA[CURT_ALLIANCE_POINTS].keyboardTexture, "|t"}),
            },
            [CURT_TELVAR_STONES] = {
                SMALL = table.concat({"|t16:16:", ZO_CURRENCIES_DATA[CURT_TELVAR_STONES].keyboardTexture, "|t"}),
            },
            [CURT_WRIT_VOUCHERS] = {
                SMALL = table.concat({"|t16:16:", ZO_CURRENCIES_DATA[CURT_WRIT_VOUCHERS].keyboardTexture, "|t"}),
            }
        },
        CRAFTBAG = {
            BLACKSMITHING = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_blacksmithing_up.dds",
            },
            CLOTHING = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_clothing_up.dds",
            },
            WOODWORKING = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_woodworking_up.dds",
            },
            JEWELCRAFTING = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_jewelrycrafting_up.dds",
            },
            ALCHEMY = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_alchemy_up.dds",
            },
            ENCHANTING = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_enchanting_up.dds",
            },
            PROVISIONING = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_provisioning_up.dds",
            },
            STYLEMATERIALS = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_stylematerial_up.dds",
            },
            TRAITITEMS = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_itemtrait_up.dds",
            },
            FURNISHING = {
                PATH = "/esoui/art/crafting/provisioner_indexicon_furnishings_up.dds",
            },
            COLLECTIBLES = {
                PATH = "/esoui/art/collections/collections_tabicon_collectibles_up.dds",
            },
            MISCELLANEOUS = {
                PATH = "/esoui/art/inventory/inventory_tabicon_misc_up.dds",
            },
            JUNK = {
                PATH = "/esoui/art/inventory/inventory_tabicon_junk_up.dds",
            },
            WEAPON = {
                PATH = "/esoui/art/inventory/inventory_tabicon_weapons_up.dds",
            },
            ARMOR = {
                PATH = "/esoui/art/inventory/inventory_tabicon_armor_up.dds",
            },
            JEWELRY = {
                PATH = "/esoui/art/crafting/jewelry_tabicon_icon_up.dds",
            }
        },
        ITEMS = {
            FOOD = {
                PATH = "/esoui/art/icons/crafting_bowl_002.dds",
            },
            GENERIC_HELP = {
                PATH = "/esoui/art/menubar/menubar_help_up.dds",
            },
            GLYPH_ARMOR_HEALTH = {
                PATH = "/esoui/art/icons/enchantment_armor_healthboost.dds",
            },
            LOCKPICK = { -- TODO: not used
                PATH = "/esoui/art/icons/lockpick.dds",
            },
            MASTER_WRIT = {
                PATH = "/esoui/art/icons/master_writ_woodworking.dds",
            },
            MOTIF = {
                PATH = "/esoui/art/icons/quest_book_001.dds",
            },
            POISON = { -- TODO: not used
                PATH = "/esoui/art/icons/crafting_poison_001_red_005.dds",
            },
            POTION = {
                PATH = "/esoui/art/icons/consumable_potion_001_type_005.dds",
            },
            RECIPE = {
                PATH = "/esoui/art/icons/quest_scroll_001.dds",
            },
            REPAIRKIT = {
                PATH = "/esoui/art/icons/quest_crate_001.dds",
            },
            REPAIRKIT_CROWN = { -- TODO: not used
                PATH = "/esoui/art/icons/store_repairkit_002.dds",
            },
            SOULGEM = {
                PATH = "/esoui/art/icons/soulgem_006_filled.dds",
            },
            SOULGEM_CROWN = { -- TODO: not used
                PATH = "/esoui/art/icons/store_soulgem_001.dds",
            },
            SOULGEM_EMPTY = { -- TODO: not used
                PATH = "/esoui/art/icons/soulgem_006_empty.dds",
            },
            STOLEN = {
                PATH = "/esoui/art/inventory/inventory_stolenitem_icon.dds",
                SMALL = "|t16:16:/esoui/art/inventory/inventory_stolenitem_icon.dds|t",
            },
            TRAITS = {
                INTRICATE = {
                    PATH = "/esoui/art/inventory/inventory_trait_intricate_icon.dds",
                    SMALL = "|t16:16:/esoui/art/inventory/inventory_trait_intricate_icon.dds|t",
                },
                ORNATE = { -- TODO: not used
                    PATH = "/esoui/art/inventory/inventory_trait_ornate_icon.dds",
                },
            },
            TROPHY = {
                PATH = "/esoui/art/icons/quest_daedricembers.dds",
            },
        },
        SIEGE = {
            BALLISTA = {
                PATH = "/esoui/art/icons/ava_siege_weapon_001.dds",
            },
            CATAPULT = {
                PATH = "/esoui/art/icons/ava_siege_ui_003.dds",
            },
            GRAVEYARD = {
                [ALLIANCE_ALDMERI_DOMINION] = {
                    PATH = "/esoui/art/icons/ava_siege_ui_006.dds",
                },
                [ALLIANCE_EBONHEART_PACT] = {
                    PATH = "/esoui/art/icons/ava_siege_ui_008.dds",
                },
                [ALLIANCE_DAGGERFALL_COVENANT] = {
                    PATH = "/esoui/art/icons/ava_siege_ui_007.dds",
                },
            },
            OIL = {
                PATH = "/esoui/art/icons/ava_siege_weapon_002.dds",
            },
            OTHER = {
                PATH = "/esoui/art/icons/rune_a.dds",
            },
            RAM = {
                PATH = "/esoui/art/icons/ava_siege_weapon_004.dds",
            },
            REPAIR = {
                PATH = "/esoui/art/icons/crafting_forester_weapon_component_005.dds",
            },
            TREBUCHET = {
                PATH = "/esoui/art/icons/ava_siege_weapon_005.dds",
            }
        },
        OTHERS = {
            HOME = {
                PATH = "/esoui/art/guild/tabicon_home_up.dds",
                NORMAL = "|t32:32:/esoui/art/guild/tabicon_home_up.dds|t",
            },
            KEY = {
                PATH = "/esoui/art/worldmap/map_indexicon_key_up.dds",
                NORMAL = "|t32:32:/esoui/art/worldmap/map_indexicon_key_up.dds|t",
            },
            KNOWN = {
                PATH = "/esoui/art/campaign/overview_indexicon_bonus_down.dds",
                NORMAL = string.format("|cCACACA%s|r", zo_iconFormatInheritColor("/esoui/art/campaign/overview_indexicon_bonus_down.dds", 32, 32)),
                SMALL = string.format("|cCACACA%s|r", zo_iconFormatInheritColor("/esoui/art/campaign/overview_indexicon_bonus_down.dds", 24, 24)),
            },
            UNKNOWN = {
                PATH = "/esoui/art/campaign/overview_indexicon_bonus_down.dds",
                NORMAL = string.format("|c66FF66%s|r", zo_iconFormatInheritColor("/esoui/art/campaign/overview_indexicon_bonus_down.dds", 32, 32)),
                SMALL = string.format("|c66FF66%s|r", zo_iconFormatInheritColor("/esoui/art/campaign/overview_indexicon_bonus_down.dds", 24, 24)),
            }
        }
    },

    BANKING = {
        BLACKSMITHING = {
            ITEMTYPE_BLACKSMITHING_RAW_MATERIAL,
            ITEMTYPE_BLACKSMITHING_MATERIAL,
            ITEMTYPE_BLACKSMITHING_BOOSTER
        },
        CLOTHING = {
            ITEMTYPE_CLOTHIER_RAW_MATERIAL,
            ITEMTYPE_CLOTHIER_MATERIAL,
            ITEMTYPE_CLOTHIER_BOOSTER
        },
        WOODWORKING = {
            ITEMTYPE_WOODWORKING_RAW_MATERIAL,
            ITEMTYPE_WOODWORKING_MATERIAL,
            ITEMTYPE_WOODWORKING_BOOSTER
        },
        JEWELCRAFTING = {
            ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL,
            ITEMTYPE_JEWELRYCRAFTING_MATERIAL,
            ITEMTYPE_JEWELRYCRAFTING_BOOSTER
        },
        ALCHEMY = {
            ITEMTYPE_REAGENT,
            ITEMTYPE_POISON_BASE,
            ITEMTYPE_POTION_BASE
        },
        ENCHANTING = {
            ITEMTYPE_ENCHANTING_RUNE_ASPECT,
            ITEMTYPE_ENCHANTING_RUNE_ESSENCE,
            ITEMTYPE_ENCHANTING_RUNE_POTENCY
        },
        PROVISIONING = {
            ITEMTYPE_INGREDIENT,
            ITEMTYPE_LURE
        },
        STYLEMATERIALS = {
            ITEMTYPE_RAW_MATERIAL,
            ITEMTYPE_STYLE_MATERIAL
        },
        TRAITITEMS = {
            ITEMTYPE_ARMOR_TRAIT,
            ITEMTYPE_WEAPON_TRAIT,
            ITEMTYPE_JEWELRY_RAW_TRAIT,
            ITEMTYPE_JEWELRY_TRAIT,
        },
        FURNISHING = {
            ITEMTYPE_FURNISHING_MATERIAL
        }
    },

    BANKING_ADVANCED = {
        LEARNABLE = {
            MOTIF = {
                ITEMTYPE_RACIAL_STYLE_MOTIF,                 -- 8
            },
            RECIPE = {
                ITEMTYPE_RECIPE,                            -- 29
            },
        },
        MASTER_WRITS = {
            CRAFTING_TYPE_BLACKSMITHING,                    -- 1
            CRAFTING_TYPE_CLOTHIER,                         -- 2
            CRAFTING_TYPE_ENCHANTING,                       -- 3
            CRAFTING_TYPE_ALCHEMY,                          -- 4
            CRAFTING_TYPE_PROVISIONING,                     -- 5
            CRAFTING_TYPE_WOODWORKING,                      -- 6
            CRAFTING_TYPE_JEWELRYCRAFTING,                  -- 7
            CRAFTING_TYPE_INVALID,                          -- 0
        },
        REGULAR = {
            WRITS = {
                ITEMTYPE_MASTER_WRIT,                        -- 60
            },
            GLYPHS = {
                ITEMTYPE_GLYPH_ARMOR,                       -- 21
                ITEMTYPE_GLYPH_JEWELRY,                     -- 26
                ITEMTYPE_GLYPH_WEAPON,                      -- 20
            },
            LIQUIDS = {
                ITEMTYPE_POTION,                            -- 7
                ITEMTYPE_POISON,                            -- 30
            },
            FOOD_DRINKS = {
                ITEMTYPE_FOOD,                              -- 4
                ITEMTYPE_DRINK,                             -- 12
                ITEMTYPE_FISH,                              -- 54
            },
        },
        SPECIALIZED = {
            TROPHIES = {
                SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP ,  -- 100
                SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT,  -- 101
                SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT,   -- 102
                SPECIALIZED_ITEMTYPE_TROPHY_RECIPE_FRAGMENT,    -- 104
                -- SPECIALIZED_ITEMTYPE_TROPHY_KEY    -- 107    TODO: check
                SPECIALIZED_ITEMTYPE_TROPHY_RUNEBOX_FRAGMENT,   -- 108
                SPECIALIZED_ITEMTYPE_TROPHY_COLLECTIBLE_FRAGMENT,   -- 109
                SPECIALIZED_ITEMTYPE_TROPHY_UPGRADE_FRAGMENT,   -- 110
            },
        },
        TRAIT = {
            INTRICATE = {
                [ITEM_TRAIT_TYPE_WEAPON_INTRICATE] = ITEMFILTERTYPE_WEAPONS,
                [ITEM_TRAIT_TYPE_ARMOR_INTRICATE] = ITEMFILTERTYPE_ARMOR,
                [ITEM_TRAIT_TYPE_JEWELRY_INTRICATE] = ITEMFILTERTYPE_JEWELRY,
            }
        },
    },

    BANKING_AVA = {
        SIEGE = {
            [ALLIANCE_ALDMERI_DOMINION] = {
                BALLISTA = {
                    [1000] = 36567,  -- [Dominion Ballista]
                    [1100] = 27970,  -- [Dominion Fire Ballista]
                    [1200] = 27973,  -- [Dominion Lightning Ballista]
                    [1300] = 64515,  -- [Dominion Cold Fire Ballista]
                },
                CATAPULT = {
                    [2000] = 27964,  -- [Dominion Meatbag Catapult]
                    [2100] = 27967,  -- [Dominion Oil Catapult]
                    [2200] = 44770,  -- [Dominion Scattershot Catapult]
                },
                TREBUCHET = {
                    [3000] = 27105,  -- [Dominion Firepot Trebuchet]
                    [3100] = 44768,  -- [Dominion Iceball Trebuchet]
                    [3200] = 44769,  -- [Dominion Stone Trebuchet]
                    [3300] = 64512,  -- [Dominion Cold Fire Trebuchet]
                    [3400] = 64520,  -- [Dominion Cold Stone Trebuchet]
                },
                RAM = {
                    [4000] = 29534,  -- [Dominion Battering Ram]
                },
                OIL = {
                    [5000] = 30359,  -- [Flaming Oil]        -- same for all alliances!
                },
                GRAVEYARD = {
                    [6000] = 29533,  -- [Dominion Forward Camp]
                },
            },
            [ALLIANCE_EBONHEART_PACT] = {
                BALLISTA = {
                    [1000] = 36568,  -- [Pact Ballista]
                    [1100] = 27971,  -- [Pact Fire Ballista]
                    [1200] = 27974,  -- [Pact Lightning Ballista]
                    [1300] = 64516,  -- [Pact Cold Fire Ballista]
                },
                CATAPULT = {
                    [2000] = 27965,  -- [Pact Meatbag Catapult]
                    [2100] = 27968,  -- [Pact Oil Catapult]
                    [2200] = 44777,  -- [Pact Scattershot Catapult]
                },
                TREBUCHET = {
                    [3000] = 27114,  -- [Pact Firepot Trebuchet]
                    [3100] = 44775,  -- [Pact Iceball Trebuchet]
                    [3200] = 44776,  -- [Pact Stone Trebuchet]
                    [3300] = 64513,  -- [Pact Cold Fire Trebuchet]
                    [3400] = 64519,  -- [Pact Cold Stone Trebuchet]
                },
                RAM = {
                    [4000] = 27850,  -- [Pact Battering Ram]
                },
                OIL = {
                    [5000] = 30359,  -- [Flaming Oil]        -- same for all alliances!
                },
                GRAVEYARD = {
                    [6000] = 29534,  -- [Pact Forward Camp]
                },
            },
            [ALLIANCE_DAGGERFALL_COVENANT] = {
                BALLISTA = {
                    [1000] = 36569,  -- [Covenant Ballista]
                    [1100] = 27972,  -- [Covenant Fire Ballista]
                    [1200] = 27975,  -- [Covenant Lightning Ballista]
                    [1300] = 64517,  -- [Covenant Cold Fire Ballista]
                },
                CATAPULT = {
                    [2000] = 27966,  -- [Covenant Meatbag Catapult]
                    [2100] = 27969,  -- [Covenant Oil Catapult]
                    [2200] = 44773,  -- [Covenant Scattershot Catapult]
                },
                TREBUCHET = {
                    [3000] = 27115,  -- [Covenant Firepot Trebuchet]
                    [3100] = 44771,  -- [Covenant Iceball Trebuchet]
                    [3200] = 44772,  -- [Covenant Stone Trebuchet]
                    [3300] = 64514,  -- [Covenant Cold Fire Trebuchet]
                    [3400] = 64518,  -- [Covenant Cold Stone Trebuchet]
                },
                RAM = {
                    [4000] = 27835,  -- [Covenant Battering Ram]
                },
                OIL = {
                    [5000] = 30359,  -- [Flaming Oil]        -- same for all alliances!
                },
                GRAVEYARD = {
                    [6000] = 29535,  -- [Covenant Forward Camp]
                },
            },
        },
        REPAIR = {
            27962,  -- [Keep Door Woodwork Repair Kit]
            27138,  -- [Keep Wall Masonry Repair Kit]
            27112,  -- [Siege Repair Kit]
        },
        OTHER = {
            141731, -- [Keep Recall Stone]
        }
    },

    JUNK = {
        TRASH_ITEMIDS = {
            NIBBLES_AND_BITS = {
                54381,  -- Trash: Foul Hide
                54382,  -- Trash: Carapace
                54383,  -- Trash: Daedra Husk
            },
            MORSELS_AND_PECKS = {
                54384,  -- Trash: Ectoplasm
                54385,  -- Trash: Elemental Essence
                54388,  -- Trash: Supple Root
            }
        },
    },

    MOVE = {
        IGNORE = 0,
        DEPOSIT = 1,
        WITHDRAW = 2
    },

    STACKING = {
        FULL = 0, -- 0: Full depositing/withdrawal / create new stacks
        INCOMPLETE = 1, -- 1: Fill only incomplete stacks
    },

    OPERATOR = {
        NONE = 0,
        BACKPACK_EQUAL = 1,
        BACKPACK_LESSTHAN = 2,
        BACKPACK_LESSTHANOREQUAL = 3,
        BACKPACK_GREATERTHAN = 4,
        BACKPACK_GREATERTHANOREQUAL = 5,
        BANK_EQUAL = 6,
        BANK_LESSTHAN = 7,
        BANK_LESSTHANOREQUAL = 8,
        BANK_GREATERTHAN = 9,
        BANK_GREATERTHANOREQUAL = 10,
    },

    BACKPACK_AMOUNT = {
        DEFAULT = 100,
    },

    ITEM_QUALITY = {
        DISABLED = -1,
        DISABLED_REVERSE = 99,
    },

    ICON_POSITION = {
        AUTO = -1,
    },
}