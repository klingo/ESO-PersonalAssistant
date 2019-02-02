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
        GREEN = "|c00FF00",
        YELLOW = "|cFFD700",
        ORANGE = "|cFF7400",
        RED = "|cFF0000",
    },

    COLORED_TEXTS = {
        PA = table.concat({"|cFFD700", "P", "|cFFFFFF", "rersonal", "|cFFD700", "A", "|cFFFFFF", "ssistant"}),
        PAG = table.concat({"|cFFD700", "PA G", "|cFFFFFF", "eneral: ", "|cFFFF00"}),
        PAB = table.concat({"|cFFD700", "PA B", "|cFFFFFF", "anking: ", "|cFFFF00"}),
        PAR = table.concat({"|cFFD700", "PA R", "|cFFFFFF", "epair: ", "|cFFFF00"}),
        PAL = table.concat({"|cFFD700", "PA L", "|cFFFFFF", "oot: ", "|cFFFF00"}),
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
                NORMAL = "|t32:32:/esoui/art/currency/currency_writvoucher_64.dds|t" -- currentnly no 32x32 version available
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
            }
        },
        ITEMS = {
            BANANAS = "|t20:20:/esoui/art/icons/crafting_bananas.dds|t",
            SOULGEM = "|t20:20:/esoui/art/icons/soulgem_006_filled.dds|t",
            WEAPON = "|t20:20:/esoui/art/icons/gear_nord_1hsword_d.dds|t",
        },
    },

    ITEMLINKS = {
        BANANAS = "|H0:item:33755:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h[Bananas]|h", -- Bananas, Normal Level 1
        SOULGEM = "|H0:item:33271:1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h[Grand Soul Gem]|h", -- Grand Soul Gem, Fine Level 50
        WEAPON = "|H0:item:84607:361:50:0:0:0:0:0:0:0:0:0:0:0:0:5:0:0:0:0:0|h[Sword of the Dragon]|h", -- Sword of the Dragon, Epic Level 50 CP160
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

    BANKING_SPECIAL = {
        GLYPHS = {
            SPECIALIZED_ITEMTYPE_GLYPH_ARMOR,
            SPECIALIZED_ITEMTYPE_GLYPH_JEWELRY,
            SPECIALIZED_ITEMTYPE_GLYPH_WEAPON
        },
        LIQUIDS = {
            SPECIALIZED_ITEMTYPE_POTION,
            SPECIALIZED_ITEMTYPE_POISON
        },
        TROPHIES = {
            SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP
        }

        -- ITEMTYPE_RECIPE
        -- SPECIALIZED_ITEMTYPE_FISH
        -- SPECIALIZED_ITEMTYPE_FLAVORING exists?
        -- ITEMTYPE_FOOD exists?
        -- ITEMTYPE_DRINK exists?
        -- TEMTYPE_TREASURE
        -- ITEMTYPE_TROPHY
    },

    BANKING_ADVANCED = {
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
            -- generic container where any itemID can just be added and it will work out of the box
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
    }
}



-- PA Banking
PAC_ITEMTYPE_IGNORE = 0
PAC_ITEMTYPE_DEPOSIT = 1
PAC_ITEMTYPE_WITHDRAWAL = 2
PAC_ITEMTYPE_INHERIT = 3

-- PA Loot
PAC_ITEMTYPE_LOOT = 1
PAC_ITEMTYPE_DESTROY = 2

PAC_OPERATOR_NONE = 0
PAC_OPERATOR_EQUAL = 1
-- PAC_OPERATOR_LESSTHAN = 2
PAC_OPERATOR_LESSTHANOREQUAL = 3
-- PAC_OPERATOR_GREATERTHAN = 4
PAC_OPERATOR_GREATERTHANOREQUAL = 5

-- PersonalAssistant Banking
PAB_DEPOSIT_MAX_LOOPS = 3

-- PerstonalAssistant Banking - Stacking Types
PAB_STACKING_FULL = 0 -- 0: Full depositing/withdrawl
PAB_STACKING_CONTINUE = 1 -- 1: Continue existing stacks
PAB_STACKING_INCOMPLETE = 2 -- 2: Complete existing stacks

-- PerstonalAssistant Banking - Move Mode
PAB_MOVETO_IGNORE = 0
PAB_MOVETO_BANK = 1
PAB_MOVETO_BACKPACK = 2

-- PersonalAssistant Loot
PAL_TYPE_LOOT = 0
PAL_TYPE_HARVEST = 1

-- PersonalAssistant Chat Output Types
PA_OUTPUT_TYPE_NONE = 0
PA_OUTPUT_TYPE_MIN = 1
PA_OUTPUT_TYPE_NORMAL = 2
PA_OUTPUT_TYPE_FULL = 3

-- Icon Paths
PAC_ICON_LOCKPICK_PATH = "/esoui/art/icons/lockpick.dds"

-- Custom Item ID
PAC_ITEMID_LOCKPICK = 30357


-- =====================================================================================================================
-- = PA Repair
-- =================================
-- PersonalAssistant Repair WeaponSlots
PARWeaponSlots = setmetatable({}, { __index = table })
PARWeaponSlots:insert(EQUIP_SLOT_MAIN_HAND)
PARWeaponSlots:insert(EQUIP_SLOT_OFF_HAND)
PARWeaponSlots:insert(EQUIP_SLOT_BACKUP_MAIN)
PARWeaponSlots:insert(EQUIP_SLOT_BACKUP_OFF)

-- =====================================================================================================================
-- = PA Banking
-- =================================
-- PersonalAssistant Banking MateriaItemTypes
PABItemTypesMaterial = setmetatable({}, { __index = table })
-- Alchemy
PABItemTypesMaterial:insert(ITEMTYPE_REAGENT)
PABItemTypesMaterial:insert(ITEMTYPE_POISON_BASE)
PABItemTypesMaterial:insert(ITEMTYPE_POTION_BASE)
-- Blacksmithing
PABItemTypesMaterial:insert(ITEMTYPE_BLACKSMITHING_RAW_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_BLACKSMITHING_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_BLACKSMITHING_BOOSTER)
-- Clothing
PABItemTypesMaterial:insert(ITEMTYPE_CLOTHIER_RAW_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_CLOTHIER_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_CLOTHIER_BOOSTER)
-- Woodworking
PABItemTypesMaterial:insert(ITEMTYPE_WOODWORKING_RAW_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_WOODWORKING_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_WOODWORKING_BOOSTER)
-- Enchanting
PABItemTypesMaterial:insert(ITEMTYPE_ENCHANTING_RUNE_ASPECT)
PABItemTypesMaterial:insert(ITEMTYPE_ENCHANTING_RUNE_ESSENCE)
PABItemTypesMaterial:insert(ITEMTYPE_ENCHANTING_RUNE_POTENCY)
-- Provisioning
PABItemTypesMaterial:insert(ITEMTYPE_INGREDIENT)
-- Others
PABItemTypesMaterial:insert(ITEMTYPE_ARMOR_TRAIT)
PABItemTypesMaterial:insert(ITEMTYPE_WEAPON_TRAIT)
PABItemTypesMaterial:insert(ITEMTYPE_STYLE_MATERIAL)
PABItemTypesMaterial:insert(ITEMTYPE_RAW_MATERIAL)

-- ---------------------------------------------------------------------------------------------------------------------
-- PersonalAssistant Banking ItemTypes
PABItemTypes = setmetatable({}, { __index = table })
-- Enchanting
PABItemTypes:insert(ITEMTYPE_GLYPH_ARMOR)
PABItemTypes:insert(ITEMTYPE_GLYPH_JEWELRY)
PABItemTypes:insert(ITEMTYPE_GLYPH_WEAPON)
-- Provisioning
PABItemTypes:insert(ITEMTYPE_RECIPE)
-- Others
PABItemTypes:insert(ITEMTYPE_POTION)
PABItemTypes:insert(ITEMTYPE_POISON)

-- ---------------------------------------------------------------------------------------------------------------------
-- PersonalAssistant Banking Advanced ItemTypes
PABItemTypesAdvanced = setmetatable({}, { __index = table })
-- Lockpick
PABItemTypesAdvanced:insert(PAC_ITEMID_LOCKPICK)
-- Can't use ITEMTYPE_LOCKPICK or SPECIALIZED_ITEMTYPE_LOCKPICK
-- since the actual lockpicks are categorized as ITEMTYPE_TOOL (as of APIVersion 100018)

-- =====================================================================================================================
-- = PA Loot
-- =================================
-- PersonalAssistant Loot Harvestable ItemTypes
PALHarvestableItemTypes = setmetatable({}, { __index = table })
-- Alchemy
PALHarvestableItemTypes:insert(ITEMTYPE_REAGENT)
PALHarvestableItemTypes:insert(ITEMTYPE_POTION_BASE)
PALHarvestableItemTypes:insert(ITEMTYPE_FURNISHING_MATERIAL)
-- Blacksmithing
PALHarvestableItemTypes:insert(ITEMTYPE_BLACKSMITHING_RAW_MATERIAL)
-- Clothing
PALHarvestableItemTypes:insert(ITEMTYPE_CLOTHIER_RAW_MATERIAL)
-- Woodworking
PALHarvestableItemTypes:insert(ITEMTYPE_WOODWORKING_RAW_MATERIAL)
-- Enchanting
PALHarvestableItemTypes:insert(ITEMTYPE_ENCHANTING_RUNE_ASPECT)
PALHarvestableItemTypes:insert(ITEMTYPE_ENCHANTING_RUNE_ESSENCE)
PALHarvestableItemTypes:insert(ITEMTYPE_ENCHANTING_RUNE_POTENCY)
-- Provisioning
PALHarvestableItemTypes:insert(ITEMTYPE_INGREDIENT)
-- Fishing
PALHarvestableItemTypes:insert(ITEMTYPE_FISH)

-- ---------------------------------------------------------------------------------------------------------------------
-- PersonalAssistant Loot Lootable ItemTypes
PALLootableItemTypes = setmetatable({}, { __index = table })
-- Alchemy
PALLootableItemTypes:insert(ITEMTYPE_POISON_BASE)
-- Clothing
-- Enchanting
PALLootableItemTypes:insert(ITEMTYPE_GLYPH_ARMOR)
PALLootableItemTypes:insert(ITEMTYPE_GLYPH_JEWELRY)
PALLootableItemTypes:insert(ITEMTYPE_GLYPH_WEAPON)
-- Provisioning
PALLootableItemTypes:insert(ITEMTYPE_RECIPE)
-- Fishing
PALLootableItemTypes:insert(ITEMTYPE_LURE)
-- Others
PALLootableItemTypes:insert(ITEMTYPE_STYLE_MATERIAL)
PALLootableItemTypes:insert(ITEMTYPE_RAW_MATERIAL)
PALLootableItemTypes:insert(ITEMTYPE_TRASH)


-- =====================================================================================================================
-- = PA Junk
-- =================================
-- PersonalAssistant Junk ItemTypes
-- PAJItemTypes = {}