-- PersonalAssistant - Prepare all Global Tables
PersonalAssistant = {}
PersonalAssistant.SavedVars = {}
PersonalAssistant.MenuFunctions = {}
PersonalAssistant.MenuHelper = {}

-- ---------------------------------------------------------------------------------------------------------------------

PersonalAssistant.Constants = {
    GENERAL = {
        MAX_PROFILES = 5,
        NO_PROFILE_SELECTED_ID = 6
    },

    COLORS = {
        DEFAULT = "|cFFFF00",
        WHITE = "|cFFFFFF",
        LIGHT_BLUE = "|cB0B0FF",
        GOLD = "|cC5C29E",
        GREEN = "|c00FF00",
        YELLOW = "|cFFD700",
        ORANGE_RED = "|cFF7400",
        ORANGE = "|cFFA500",
        RED = "|cFF0000",
    },

    COLORED_TEXTS = {
        PA = table.concat({"|cFFD700", "P", "|cFFFFFF", "rersonal", "|cFFD700", "A", "|cFFFFFF", "ssistant"}),
        PAG = table.concat({"|cFFD700", "PA G", "|cFFFFFF", "eneral: ", "|cFFFF00"}),
        PAB = table.concat({"|cFFD700", "PA B", "|cFFFFFF", "anking: ", "|cFFFF00"}),
        PAR = table.concat({"|cFFD700", "PA R", "|cFFFFFF", "epair: ", "|cFFFF00"}),
        PAL = table.concat({"|cFFD700", "PA L", "|cFFFFFF", "oot: ", "|cFFFF00"}),
        PAM = table.concat({"|cFFD700", "PA M", "|cFFFFFF", "ail: ", "|cFFFF00"}),
        PAJ = table.concat({"|cFFD700", "PA J", "|cFFFFFF", "unk: ", "|cFFFF00"}),
    },

    ICONS = {
        CURRENCY = {
            [CURT_MONEY] = {
                SMALL = "|t16:16:/esoui/art/currency/currency_gold.dds|t",
                NORMAL = "|t32:32:/esoui/art/currency/currency_gold_32.dds|t",
            },
            [CURT_ALLIANCE_POINTS] = {
                SMALL = "|t16:16:/esoui/art/currency/alliancepoints.dds|t",
                NORMAL = "|t32:32:/esoui/art/currency/alliancepoints_32.dds|t"
            },
            [CURT_TELVAR_STONES] = {
                SMALL = "|t16:16:/esoui/art/currency/currency_telvar.dds|t",
                NORMAL = "|t32:32:/esoui/art/currency/currency_telvar_32.dds|t",
            },
            [CURT_WRIT_VOUCHERS] = {
                SMALL = "|160:16:/esoui/art/currency/currency_writvoucher.dds|t",
                NORMAL = "|t32:32:/esoui/art/currency/currency_writvoucher_64.dds|t" -- currently no 32x32 version available
            }
        },
        CRAFTBAG = {
            BLACKSMITHING = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_blacksmithing_up.dds|t",
            },
            CLOTHING = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_clothing_up.dds|t",
            },
            WOODWORKING = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_woodworking_up.dds|t",
            },
            JEWELCRAFTING = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_jewelrycrafting_up.dds|t",
            },
            ALCHEMY = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_alchemy_up.dds|t",
            },
            ENCHANTING = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_enchanting_up.dds|t",
            },
            PROVISIONING = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_provisioning_up.dds|t",
            },
            STYLEMATERIALS = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_stylematerial_up.dds|t",
            },
            TRAITITEMS = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_craftbag_itemtrait_up.dds|t",
            },
            FURNISHING = {
                LARGE = "|t48:48:/esoui/art/crafting/provisioner_indexicon_furnishings_up.dds|t",
            },
            JUNK = {
                LARGE = "|t48:48:/esoui/art/inventory/inventory_tabicon_junk_up.dds|t",
            }
        },
        ITEMS = {
            BANANAS = "|t20:20:/esoui/art/icons/crafting_bananas.dds|t",
            FOOD = {
                NORMAL = "|t32:32:/esoui/art/icons/crafting_bowl_002.dds|t"
            },
            GENERIC_HELP = {
                NORMAL = "|t32:32:/esoui/art/menubar/menubar_help_up.dds|t"
            },
            GLYPH_ARMOR_HEALTH = {
                NORMAL = "|t32:32:/esoui/art/icons/enchantment_armor_healthboost.dds|t"
            },
            LOCKPICK = {
                NORMAL = "|t32:32:/esoui/art/icons/lockpick.dds|t"
            },
            MOTIF = {
                NORMAL = "|t32:32:/esoui/art/icons/quest_book_001.dds|t"
            },
            POISON = {
                NORMAL = "|t32:32:/esoui/art/icons/crafting_poison_001_red_005.dds|t"
            },
            POTION = {
                NORMAL = "|t32:32:/esoui/art/icons/consumable_potion_001_type_005.dds|t"
            },
            RECIPE = {
                NORMAL = "|t32:32:/esoui/art/icons/quest_scroll_001.dds|t" -- TODO: check; since duplicate with treasure map
            },
            REPAIRKIT = {
                NORMAL = "|t32:32:/esoui/art/icons/quest_crate_001.dds|t"
            },
            REPAIRKIT_CROWN = {
                NORMAL = "|t32:32:/esoui/art/icons/store_repairkit_002.dds|t"
            },
            SOULGEM = {
                SMALL = "|t20:20:/esoui/art/icons/soulgem_006_filled.dds|t",
                NORMAL = "|t32:32:/esoui/art/icons/soulgem_006_filled.dds|t",
            },
            SOULGEM_CROWN = {
                NORMAL = "|t32:32:/esoui/art/icons/store_soulgem_001.dds|t",
            },
            SOULGEM_EMPTY = {
                NORMAL = "|t32:32:/esoui/art/icons/soulgem_006_empty.dds|t",
            },
            TREASURE_MAP = {
                NORMAL = "|t32:32:/esoui/art/icons/quest_scroll_001.dds|t"
            },
            WEAPON = "|t20:20:/esoui/art/icons/gear_nord_1hsword_d.dds|t",
        },
    },

    ITEMLINKS = {
        BANANAS = "|H1:item:33755:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", -- Bananas, Normal Level 1
        SOULGEM = "|H1:item:33271:1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h", -- Grand Soul Gem, Fine Level 50
        WEAPON = "|H1:item:84607:361:50:0:0:0:0:0:0:0:0:0:0:0:0:5:0:0:0:0:0|h|h", -- Sword of the Dragon, Epic Level 50 CP160
    },

    REPAIR = {
        WEAPON_SLOTS = {
            EQUIP_SLOT_MAIN_HAND,
            EQUIP_SLOT_OFF_HAND,
            EQUIP_SLOT_BACKUP_MAIN,
            EQUIP_SLOT_BACKUP_OFF,
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
            ITEMTYPE_WEAPON_TRAIT
        },
        FURNISHING = {
            ITEMTYPE_FURNISHING_MATERIAL
        }
    },

    BANKING_ADVANCED = {
        REGULAR = {
            MOTIF = {
                ITEMTYPE_RACIAL_STYLE_MOTIF,                 -- 8
            },
            RECIPE = {
                ITEMTYPE_RECIPE,                            -- 29
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
            },
        },
        SPECIALIZED = {
            TROPHIES = {
                SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP    -- 100
            },
        }
    },

    BANKING_INDIVIDUAL = {
        LOCKPICK = {
            30357,  -- [Lockpick]
        },
        SOUL_GEM = {
            33265,  -- [Soul Gem (Empty)]
            33271,  -- [Soul Gem]
            61080,  -- [Crown Soul Gem]
        },
        REPAIR_KIT = {
            44879,  -- [Grand Repair Kit]
            61079,  -- [Crown Repair Kit]
        },
        GENERIC = {
            -- Generic container where any itemID can just be added and it will work out of the box
        }
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
        EQUAL = 1,
--        LESSTHAN = 2,
        LESSTHANOREQUAL = 3,
--        GREATERTHAN = 4,
        GREATERTHANOREQUAL = 5
    },

    CHATMODE = {
        OUTPUT_NONE = 0,
        OUTPUT_MIN = 1,
        OUTPUT_NORMAL = 2,
        OUTPUT_MAX = 3,
    },
}