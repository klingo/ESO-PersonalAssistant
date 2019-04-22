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
        NAME_DISPLAY = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant", "|r"}),
        AUTHOR = "Klingo",
        VERSION_DISPLAY = "2.0.2",
        VERSION_RAW = "020002",
        WEBSITE = "http://www.esoui.com/downloads/info381-PersonalAssistant",
        FEEDBACK = "https://www.esoui.com/downloads/info381-PersonalAssistant.html#comments",
        KEYWORDS = {
            GENERAL = "general, profile, house",
            BANKING = "banking, deposit, withdraw, currency, currencies, bank",
            JUNK = "junk, mark, fence, sell",
            LOOT = "loot, unknown, recipe, motif, trait",
            REPAIR = "repair, repairkit, recharge, soulgem",
        },
        SAVED_VARS_VERSION = { -- changing these values cause all settings to be reset!
            GENERAL = 1,
            ACTIVE_PROFILE = 1,
            BANKING = 3,
            JUNK = 2,
            LOOT = 1,
            REPAIR = 1,
        },
    },

    GENERAL = {
        MAX_PROFILES = 5,
        NO_PROFILE_SELECTED_ID = 6
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
            LOCKPICK = {
                PATH = "/esoui/art/icons/lockpick.dds",
            },
            MASTER_WRIT = {
                PATH = "/esoui/art/icons/master_writ_woodworking.dds",
            },
            MOTIF = {
                PATH = "/esoui/art/icons/quest_book_001.dds",
            },
            ORNATE = { -- TODO: not used
                PATH = "/esoui/art/inventory/inventory_trait_ornate_icon.dds",
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
            TROPHY = {
                PATH = "/esoui/art/icons/quest_daedricembers.dds",
            },
        },
        OTHERS = {
            HOME = {
                PATH = "/esoui/art/guild/tabicon_home_up.dds",
                NORMAL = "|t32:32:/esoui/art/guild/tabicon_home_up.dds|t"
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
                SPECIALIZED_ITEMTYPE_TROPHY_RUNEBOX_FRAGMENT,   -- 108
                SPECIALIZED_ITEMTYPE_TROPHY_COLLECTIBLE_FRAGMENT,   -- 109
                -- TODO:  check:
                -- SPECIALIZED_ITEMTYPE_TROPHY_KEY    -- 107
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
            -- remember to also update PABankingMenuDefaults: Crafting.Individual.ItemIds (generic section)
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

    ITEM_QUALITY = {
        DISABLED = -1,
    }
}