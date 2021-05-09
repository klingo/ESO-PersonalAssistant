-- PersonalAssistant - Prepare all Global Tables
PersonalAssistant = {}
PersonalAssistant.ZO_SavedVars = {}
PersonalAssistant.SavedVars = {}
PersonalAssistant.SavedVarsPatcher = {}
PersonalAssistant.MenuFunctions = {}
PersonalAssistant.MenuHelper = {}
PersonalAssistant.ProfileManager = {}


-- ---------------------------------------------------------------------------------------------------------------------

PersonalAssistant.Constants = {
    ADDON = {
        NAME_RAW = {
            GENERAL = "PersonalAssistant",
            BANKING = "PersonalAssistant Banking",
            INTEGRATION = "PersonalAssistant Integration",
            JUNK = "PersonalAssistant Junk",
            LOOT = "PersonalAssistant Loot",
            REPAIR = "PersonalAssistant Repair",
        },
        NAME_DISPLAY = {
            GENERAL = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant", "|r"}),
            BANKING = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant ", "|r", "|cFFD700", "B", "|r", "|cFFFFFF", "anking", "|r"}),
            INTEGRATION = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant ", "|r", "|cFFD700", "I", "|r", "|cFFFFFF", "ntegration", "|r"}),
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
            INTEGRATION = "integration, compatibility, support",
            JUNK = "junk, mark, fence, sell, rules",
            LOOT = "loot, unknown, recipe, motif, trait",
            REPAIR = "repair, repairkit, recharge, soulgem",
        },
        SAVED_VARS_VERSION = { -- changing these values cause all settings to be reset!
            MAJOR = {
                GENERAL = 1,
                PROFILE = 1,
                BANKING = 2,
                INTEGRATION = 1,
                JUNK = 2,
                LOOT = 2,
                REPAIR = 1,
            },
            MINOR = 020517, -- update this every release!
        },
    },

    GENERAL = {
        MAX_PROFILES = 20,
        NO_PROFILE_SELECTED_ID = 0
    },

    COLOR = {
        GREEN = ZO_ColorDef:New("00FF00"),
        LIGHT_BLUE = ZO_ColorDef:New("B0B0FF"),
        ORANGE = ZO_ColorDef:New("FFA500"),
        ORANGE_RED = ZO_ColorDef:New("FF7400"),
        RED = ZO_ColorDef:New("FF0000"),
        WHITE = ZO_ColorDef:New("FFFFFF"),
        YELLOW = ZO_ColorDef:New("FFD700"),
        CURRENCIES = {
            [CURT_MONEY] = ZO_ColorDef:New(GetCurrencyKeyboardColor(CURT_MONEY)),
            [CURT_ALLIANCE_POINTS] = ZO_ColorDef:New(GetCurrencyKeyboardColor(CURT_ALLIANCE_POINTS)),
            [CURT_TELVAR_STONES] = ZO_ColorDef:New(GetCurrencyKeyboardColor(CURT_TELVAR_STONES)),
            [CURT_WRIT_VOUCHERS] = ZO_ColorDef:New(GetCurrencyKeyboardColor(CURT_WRIT_VOUCHERS)),
        }
    },
    COLORS = {
        DEFAULT = "|cFFFF00",
        WHITE = "|cFFFFFF",
        LIGHT_BLUE = "|cB0B0FF",
        GOLD = "|cC5C29E", -- NOTE: not used
        GREEN = "|c00FF00",
        YELLOW = "|cFFD700", -- NOTE: not used
        ORANGE_RED = "|cFF7400",
        ORANGE = "|cFFA500",
        RED = "|cFF0000",
    },

    COLORED_TEXTS = {
        PA = table.concat({"|cFFD700", "P", "|r", "|cFFFFFF", "ersonal", "|r", "|cFFD700", "A", "|r", "|cFFFFFF", "ssistant", "|r"}),
        PAG = table.concat({"|cFFD700", "PA G", "|r", "|cFFFFFF", "eneral", "|r"}),
        PAB = table.concat({"|cFFD700", "PA B", "|r", "|cFFFFFF", "anking", "|r"}),
        PAI = table.concat({"|cFFD700", "PA I", "|r", "|cFFFFFF", "ntegration", "|r"}),
        PAR = table.concat({"|cFFD700", "PA R", "|r", "|cFFFFFF", "epair", "|r"}),
        PAL = table.concat({"|cFFD700", "PA L", "|r", "|cFFFFFF", "oot", "|r"}),
        PAM = table.concat({"|cFFD700", "PA M", "|r", "|cFFFFFF", "ail", "|r"}),
        PAJ = table.concat({"|cFFD700", "PA J", "|r", "|cFFFFFF", "unk", "|r"}),
    },

    COLORED_TEXTS_DEBUG = {
        PA = table.concat({"|cFFFFFF", "PA", "|r"}),
        PAG = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "G", "|r"}),
        PAB = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "B", "|r"}),
        PAI = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "I", "|r"}),
        PAR = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "R", "|r"}),
        PAL = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "L", "|r"}),
        PAM = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "M", "|r"}),
        PAJ = table.concat({"|cFFFFFF", "PA", "|r", "|cFFD700", "J", "|r"}),
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
            LOCKPICK = { -- NOTE: not used
                PATH = "/esoui/art/icons/lockpick.dds",
            },
            MASTER_WRIT = {
                PATH = "/esoui/art/icons/master_writ_woodworking.dds",
            },
            HOLIDAY_WRIT = {
                PATH = "/esoui/art/icons/master_writ_witchesfestival.dds",
            },
            MOTIF = {
                PATH = "/esoui/art/icons/quest_book_001.dds",
            },
            POISON = { -- NOTE: not used
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
            REPAIRKIT_CROWN = { -- NOTE: not used
                PATH = "/esoui/art/icons/store_repairkit_002.dds",
            },
            SOULGEM = {
                PATH = "/esoui/art/icons/soulgem_006_filled.dds",
            },
            SOULGEM_CROWN = { -- NOTE: not used
                PATH = "/esoui/art/icons/store_soulgem_001.dds",
            },
            SOULGEM_EMPTY = { -- NOTE: not used
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
                ORNATE = { -- NOTE: not used
                    PATH = "/esoui/art/inventory/inventory_trait_ornate_icon.dds",
                },
            },
            TROPHY = {
                PATH = "/esoui/art/icons/quest_daedricembers.dds",
            },
        },
        ITEMFILTERTYPE = {
            [ITEMFILTERTYPE_ALCHEMY] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_alchemy_up.dds",
            },
            [ITEMFILTERTYPE_ARMOR] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_armor_up.dds",
            },
            [ITEMFILTERTYPE_BLACKSMITHING] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_blacksmithing_up.dds",
            },
            [ITEMFILTERTYPE_CLOTHING] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_clothing_up.dds",
            },
            [ITEMFILTERTYPE_COLLECTIBLE] = {
                PATH = "/esoui/art/collections/collections_tabicon_collectibles_up.dds",
            },
            [ITEMFILTERTYPE_CONSUMABLE] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_consumables_up.dds",
            },
            [ITEMFILTERTYPE_CRAFTING] = {
                PATH = "/esoui/art/tutorial/inventory_tabicon_crafting_up.dds",
            },
            [ITEMFILTERTYPE_ENCHANTING] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_enchanting_up.dds",
            },
            [ITEMFILTERTYPE_FURNISHING] = {
                PATH = "/esoui/art/treeicons/collection_indexicon_furnishings_up.dds",
            },
            [ITEMFILTERTYPE_JEWELRY] = {
                PATH = "/esoui/art/crafting/jewelry_tabicon_icon_up.dds",
            },
            [ITEMFILTERTYPE_JEWELRYCRAFTING] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_jewelrycrafting_up.dds",
            },
            [ITEMFILTERTYPE_MISCELLANEOUS] = {
                PATH = "/esoui/art/tutorial/inventory_tabicon_misc_up.dds",
            },
            [ITEMFILTERTYPE_PROVISIONING] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_provisioning_up.dds",
            },
            [ITEMFILTERTYPE_STYLE_MATERIALS] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_stylematerial_up.dds",
            },
            [ITEMFILTERTYPE_TRAIT_ITEMS] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_itemtrait_up.dds",
            },
            [ITEMFILTERTYPE_WOODWORKING] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_weapons_up.dds",
            },
            [ITEMFILTERTYPE_WEAPONS] = {
                PATH = "/esoui/art/inventory/inventory_tabicon_craftbag_woodworking_up.dds",
            },
            UNKNOWN = {
                PATH = "/esoui/art/icons/u26_unknown_antiquity_questionmark.dds"
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
        FCOIS = {
            DECONSTRUCTION = {
                PATH = "/esoui/art/crafting/enchantment_tabicon_deconstruction_disabled.dds",
            },
            IMPROVEMENT = {
                PATH = "/esoui/art/crafting/smithing_tabicon_improve_disabled.dds",
            },
            INTRICATE = {
                PATH = "/esoui/art/progression/progression_indexicon_guilds_up.dds",
            },
            LOCKED = {
                PATH = "/esoui/art/campaign/campaignbrowser_fullpop.dds",
                LARGE = ZO_ColorDef:New(1, 0, 0, 1):Colorize(zo_iconFormatInheritColor("/esoui/art/campaign/campaignbrowser_fullpop.dds", 48, 48)),
            },
            RESEARCH = {
                PATH = "/esoui/art/crafting/smithing_tabicon_research_disabled.dds",
            },
            SELL = {
                PATH = "/esoui/art/tradinghouse/tradinghouse_sell_tabicon_disabled.dds",
                LARGE = ZO_ColorDef:New(1, 1, 0, 1):Colorize(zo_iconFormatInheritColor("/esoui/art/tradinghouse/tradinghouse_sell_tabicon_disabled.dds", 48, 48)),
            },
            SELL_AT_GUILDSTORE = {
                LARGE = ZO_ColorDef:New(1, 1, 0, 1):Colorize(zo_iconFormatInheritColor(ZO_CURRENCIES_DATA[CURT_MONEY].keyboardTexture, 32, 32)),
            }
        },
        OTHERS = {
            CLOCKWORK_CITY = {
                PATH = "/esoui/art/treeicons/tutorial_idexicon_cwc_up.dds",
            },
            THIEVES_GUILD = {
                PATH = "/esoui/art/treeicons/tutorial_idexicon_thievesguild_up.dds"
            },
            EVENTS = {
                PATH = "/esoui/art/treeicons/achievements_indexicon_events_up.dds"
            },
            FENCE = {
                PATH = "/esoui/art/vendor/vendor_tabicon_fence_up.dds",
            },
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
            },
            UNCOLLECTED = {
                PATH = "/esoui/art/campaign/overview_indexicon_bonus_down.dds",
                NORMAL = string.format("|c66ECFF%s|r", zo_iconFormatInheritColor("/esoui/art/campaign/overview_indexicon_bonus_down.dds", 32, 32)),
                SMALL = string.format("|c66ECFF%s|r", zo_iconFormatInheritColor("/esoui/art/campaign/overview_indexicon_bonus_down.dds", 24, 24)),
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
            ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER,
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
        },
        HOLIDAY_WRITS = {
            SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT,              -- 2760
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
            FURNISHINGS = {
                ITEMTYPE_FURNISHING,                        -- 61
            }
        },
        SPECIALIZED = {
            TROPHIES = {
                TREASURE_MAPS = {
                    SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP ,  -- 100
                },
                FRAGMENTS = {
                    SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT,   -- 102
                    SPECIALIZED_ITEMTYPE_TROPHY_RECIPE_FRAGMENT,    -- 104
                    SPECIALIZED_ITEMTYPE_TROPHY_RUNEBOX_FRAGMENT,   -- 108
                    SPECIALIZED_ITEMTYPE_TROPHY_COLLECTIBLE_FRAGMENT,   -- 109
                    SPECIALIZED_ITEMTYPE_TROPHY_UPGRADE_FRAGMENT,   -- 110
                }
                -- SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT,  -- 101 | handled separately
                -- SPECIALIZED_ITEMTYPE_TROPHY_KEY    -- 107    TODO: check
            },
            SURVEY_REPORTS = {  -- https://esoitem.uesp.net/viewlog.php?search=Survey%3A
                [ITEMFILTERTYPE_BLACKSMITHING] = {
                    57687,  -- Blacksmith Survey: Auridon
                    57747,  -- Blacksmith Survey: Grahtwood
                    57788,  -- Blacksmith Survey: Greenshade
                    57791,  -- Blacksmith Survey: Malabal Tor
                    57793,  -- Blacksmith Survey: Reaper's March
                    57737,  -- Blacksmith Survey: Stonefalls
                    57748,  -- Blacksmith Survey: Deshaan
                    57789,  -- Blacksmith Survey: Shadowfen
                    57801,  -- Blacksmith Survey: Eastmarch
                    57794,  -- Blacksmith Survey: The Rift
                    57736,  -- Blacksmith Survey: Glenumbra
                    57749,  -- Blacksmith Survey: Stormhaven
                    57790,  -- Blacksmith Survey: Rivenspire
                    57792,  -- Blacksmith Survey: Alik'r
                    57795,  -- Blacksmith Survey: Bangkorai
                    57796,  -- Blacksmith Survey: Coldharbour I
                    57797,  -- Blacksmith Survey: Coldharbour II
                    57798,  -- Blacksmith Survey: Craglorn I
                    57799,  -- Blacksmith Survey: Craglorn II
                    57800,  -- Blacksmith Survey: Craglorn III
                    71065,  -- Blacksmith Survey: Wrothgar I
                    71066,  -- Blacksmith Survey: Wrothgar II
                    71067,  -- Blacksmith Survey: Wrothgar III
                    126110, -- Blacksmith Survey: Vvardenfell
                    151598, -- Blacksmith Survey: Northern Elsweyr
                    166460, -- Blacksmith Survey: Western Skyrim
                    178464, -- Blacksmith Survey: Blackwood
                },
                [ITEMFILTERTYPE_ENCHANTING] = {
                    57733,  -- Enchanter Survey: Auridon
                    57750,  -- Enchanter Survey: Grahtwood
                    57802,  -- Enchanter Survey: Greenshade
                    57805,  -- Enchanter Survey: Malabal Tor
                    57808,  -- Enchanter Survey: Reaper's March
                    57735,  -- Enchanter Survey: Stonefalls
                    57751,  -- Enchanter Survey: Deshaan
                    57803,  -- Enchanter Survey: Shadowfen
                    57807,  -- Enchanter Survey: Eastmarch
                    57809,  -- Enchanter Survey: The Rift
                    57734,  -- Enchanter Survey: Glenumbra
                    57752,  -- Enchanter Survey: Stormhaven
                    57804,  -- Enchanter Survey: Rivenspire
                    57806,  -- Enchanter Survey: Alik'r
                    57810,  -- Enchanter Survey: Bangkorai
                    57811,  -- Enchanter Survey: Coldharbour I
                    57812,  -- Enchanter Survey: Coldharbour II
                    57813,  -- Enchanter Survey: Craglorn I
                    57814,  -- Enchanter Survey: Craglorn II
                    57815,  -- Enchanter Survey: Craglorn III
                    71086,  -- Enchanter Survey: Wrothgar I
                    71087,  -- Enchanter Survey: Wrothgar II
                    71088,  -- Enchanter Survey: Wrothgar III
                    126122, -- Enchanter Survey: Vvardenfell
                    151602, -- Enchanter Survey: Northern Elsweyr
                    166462, -- Enchanter Survey: Western Skyrim
                    178468, -- Enchanter Survey: Blackwood
                },
                [ITEMFILTERTYPE_CLOTHING] = {
                    57738,  -- Clothier Survey: Auridon
                    57754,  -- Clothier Survey: Grahtwood
                    57757,  -- Clothier Survey: Greenshade
                    57760,  -- Clothier Survey: Malabal Tor
                    57763,  -- Clothier Survey: Reaper's March
                    57740,  -- Clothier Survey: Stonefalls
                    57755,  -- Clothier Survey: Deshaan
                    57758,  -- Clothier Survey: Shadowfen
                    57761,  -- Clothier Survey: Eastmarch
                    57765,  -- Clothier Survey: The Rift
                    57739,  -- Clothier Survey: Glenumbra
                    57756,  -- Clothier Survey: Stormhaven
                    57759,  -- Clothier Survey: Rivenspire
                    57762,  -- Clothier Survey: Alik'r
                    57764,  -- Clothier Survey: Bangkorai
                    57766,  -- Clothier Survey: Coldharbour I
                    57767,  -- Clothier Survey: Coldharbour II
                    57768,  -- Clothier Survey: Craglorn I
                    57769,  -- Clothier Survey: Craglorn II
                    57770,  -- Clothier Survey: Craglorn III
                    71068,  -- Clothier Survey: Wrothgar I
                    71069,  -- Clothier Survey: Wrothgar II
                    71070,  -- Clothier Survey: Wrothgar III
                    126111, -- Clothier Survey: Vvardenfell
                    151599, -- Clothier Survey: Northern Elsweyr
                    166461, -- Clothier Survey: Western Skyrim
                    178467, -- Clothier Survey: Blackwood
                },
                [ITEMFILTERTYPE_ALCHEMY] = {
                    57744,  -- Alchemist Survey: Auridon
                    57771,  -- Alchemist Survey: Grahtwood
                    57774,  -- Alchemist Survey: Greenshade
                    57777,  -- Alchemist Survey: Malabal Tor
                    57780,  -- Alchemist Survey: Reaper's March
                    57746,  -- Alchemist Survey: Stonefalls
                    57772,  -- Alchemist Survey: Deshaan
                    57775,  -- Alchemist Survey: Shadowfen
                    57778,  -- Alchemist Survey: Eastmarch
                    57782,  -- Alchemist Survey: The Rift
                    57745,  -- Alchemist Survey: Glenumbra
                    57773,  -- Alchemist Survey: Stormhaven
                    57776,  -- Alchemist Survey: Rivenspire
                    57779,  -- Alchemist Survey: Alik'r
                    57781,  -- Alchemist Survey: Bangkorai
                    57783,  -- Alchemist Survey: Coldharbour I
                    57784,  -- Alchemist Survey: Coldharbour II
                    57785,  -- Alchemist Survey: Craglorn I
                    57786,  -- Alchemist Survey: Craglorn II
                    57787,  -- Alchemist Survey: Craglorn III
                    71083,  -- Alchemist Survey: Wrothgar I
                    71084,  -- Alchemist Survey: Wrothgar II
                    71085,  -- Alchemist Survey: Wrothgar III
                    126113, -- Alchemist Survey: Vvardenfell
                    151601, -- Alchemist Survey: Northern Elsweyr
                    166459, -- Alchemist Survey: Western Skyrim
                    178469, -- Alchemist Survey: Blackwood
                },
                [ITEMFILTERTYPE_WOODWORKING] = {
                    57741,  -- Woodworker Survey: Auridon
                    57816,  -- Woodworker Survey: Grahtwood
                    57819,  -- Woodworker Survey: Greenshade
                    57822,  -- Woodworker Survey: Malabal Tor
                    57825,  -- Woodworker Survey: Reaper's March
                    57743,  -- Woodworker Survey: Stonefalls
                    57817,  -- Woodworker Survey: Deshaan
                    57820,  -- Woodworker Survey: Shadowfen
                    57823,  -- Woodworker Survey: Eastmarch
                    57826,  -- Woodworker Survey: The Rift
                    57742,  -- Woodworker Survey: Glenumbra
                    57818,  -- Woodworker Survey: Stormhaven
                    57821,  -- Woodworker Survey: Rivenspire
                    57824,  -- Woodworker Survey: Alik'r
                    57827,  -- Woodworker Survey: Bangkorai
                    57828,  -- Woodworker Survey: Coldharbour I
                    57829,  -- Woodworker Survey: Coldharbour II
                    57830,  -- Woodworker Survey: Craglorn I
                    57831,  -- Woodworker Survey: Craglorn II
                    57832,  -- Woodworker Survey: Craglorn III
                    71080,  -- Woodworker Survey: Wrothgar I
                    71081,  -- Woodworker Survey: Wrothgar II
                    71082,  -- Woodworker Survey: Wrothgar III
                    126112, -- Woodworker Survey: Vvardenfell
                    151600, -- Woodworker Survey: Northern Elsweyr
                    166465, -- Woodworker Survey: Western Skyrim
                    178465, -- Woodworker Survey: Blackwood
                },
                [ITEMFILTERTYPE_JEWELRYCRAFTING] = {
                    139422, -- Jewelry Crafting Survey: Auridon
                    139425, -- Jewelry Crafting Survey: Grahtwood
                    139427, -- Jewelry Crafting Survey: Greenshade
                    139430, -- Jewelry Crafting Survey: Malabal Tor
                    139432, -- Jewelry Crafting Survey: Reaper's March
                    139424, -- Jewelry Crafting Survey: Stonefalls
                    139426, -- Jewelry Crafting Survey: Deshaan
                    139428, -- Jewelry Crafting Survey: Shadowfen
                    139440, -- Jewelry Crafting Survey: Eastmarch
                    139433, -- Jewelry Crafting Survey: The Rift
                    139423, -- Jewelry Crafting Survey: Glenumbra
                    139408, -- Jewelry Crafting Survey: Stormhaven
                    139429, -- Jewelry Crafting Survey: Rivenspire
                    139431, -- Jewelry Crafting Survey: Alik'r
                    139434, -- Jewelry Crafting Survey: Bangkorai
                    139435, -- Jewelry Crafting Survey: Coldharbour I
                    139436, -- Jewelry Crafting Survey: Coldharbour II
                    139437, -- Jewelry Crafting Survey: Craglorn I
                    139438, -- Jewelry Crafting Survey: Craglorn II
                    139439, -- Jewelry Crafting Survey: Craglorn III
                    139441, -- Jewelry Crafting Survey: Wrothgar I
                    139442, -- Jewelry Crafting Survey: Wrothgar II
                    139443, -- Jewelry Crafting Survey: Wrothgar III
                    139444, -- Jewelry Crafting Survey: Vvardenfell
                    151603, -- Jewelry Crafting Survey: Northern Elsweyr
                    166464, -- Jewelry Crafting Survey: Western Skyrim
                    178466, -- Jewelry Crafting Survey: Blackwood
                },
            }
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
                    [4000] = 27136,  -- [Dominion Battering Ram]
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
            142133, -- [Bridge and Milegate Repair Kit]
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

    ITEM_ACTION = {
        NOTHING = 0,
        DEPOSIT = 1, -- not used so far - might replace "MOVE" later on?
        WITHDRAW = 2, -- not used so far - might replace "MOVE" later on?
        LAUNDER = 5, -- not used so far
        MARK_AS_JUNK = 6,
        JUNK_DESTROY_WORTHLESS = 8,
        DESTROY_ALWAYS = 9,
    },

    LEARNABLE = {
        KNOWN = 1,
        UNKNOWN = 0,
    }
}