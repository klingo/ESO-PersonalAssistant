-- PersonalAssistant Constants
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
PAC_OPERATOR_LESSTAHNEQAL = 3
-- PAC_OPERATOR_GREATERTHAN = 4
PAC_OPERATOR_GREATERTHANEQUAL = 5

-- PersonalAssistant General
PAG_MAX_PROFILES = 5
PAG_NO_PROFILE_SELECTED_ID = PAG_MAX_PROFILES + 1

-- PersonalAssistant Banking
PAB_DEPOSIT_MAX_LOOPS = 3

-- PerstonalAssistant Banking - Stacking Types
PAB_STACKING_FULL = 0		-- 0: Full depositing/withdrawl
PAB_STACKING_CONTINUE = 1	-- 1: Continue existing stacks
PAB_STACKING_INCOMPLETE = 2	-- 2: Complete existing stacks

-- PersonalAssistant Loot
PAL_TYPE_LOOT = 0
PAL_TYPE_HARVEST = 1

-- PersonalAssistant Chat Output Types
PA_OUTPUT_TYPE_NONE = 0
PA_OUTPUT_TYPE_MIN = 1
PA_OUTPUT_TYPE_NORMAL = 2
PA_OUTPUT_TYPE_FULL = 3

-- PersonalAssistant Colors
PAC_COL_DEFAULT = "|cFFFF00"
PAC_COL_WHITE = "|cFFFFFF"
PAC_COL_LIGHT_BLUE = "|cB0B0FF"
PAC_COL_YELLOW = "|cFFD700"
PAC_COL_ORANGE = "|cFF7400"
PAC_COL_RED = "|cFF0000"

-- PersonalAssistant Colored Names
PAC_COLTEXT_PA = PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."rersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"
PAC_COLTEXT_PAG = PAC_COL_YELLOW.."PA G"..PAC_COL_WHITE.."eneral: "..PAC_COL_DEFAULT
PAC_COLTEXT_PAB = PAC_COL_YELLOW.."PA B"..PAC_COL_WHITE.."anking: "..PAC_COL_DEFAULT
PAC_COLTEXT_PAR = PAC_COL_YELLOW.."PA R"..PAC_COL_WHITE.."epair: "..PAC_COL_DEFAULT
PAC_COLTEXT_PAL = PAC_COL_YELLOW.."PA L"..PAC_COL_WHITE.."oot: "..PAC_COL_DEFAULT
PAC_COLTEXT_PAJ = PAC_COL_YELLOW.."PA J"..PAC_COL_WHITE.."unk: "..PAC_COL_DEFAULT

-- Icons
PAC_ICON_GOLD = "|t16:16:/esoui/art/currency/currency_gold.dds|t"
PAC_ICON_TALVAR = "|t16:16:/esoui/art/currency/currency_telvar.dds|t"
-- PAC_ICON_TALVAR = "|r|c66a8ff|t16:16:/esoui/art/currency/currency_telvar.dds|t"

PAC_ICON_BANANAS = "|t20:20:/esoui/art/icons/crafting_bananas.dds|t"
PAC_ITEMCODE_BANANAS = "|H1:item:33755:317:50:0:0:0:0:0:0:0:0:0:0:0:0:0:10:0:0:0:0:0|h[Bananas]|h"

-- Custom Item ID
PAC_ITEMID_LOCKPICK = 30357


-- =====================================================================================================================
-- = PA Banking
-- =================================
-- PersonalAssistant Banking ItemTypes
PABItemTypes = setmetatable({}, { __index = table })
-- Alchemy
PABItemTypes:insert(ITEMTYPE_REAGENT)
PABItemTypes:insert(ITEMTYPE_POISON_BASE)
PABItemTypes:insert(ITEMTYPE_POTION_BASE)
-- Blacksmithing
PABItemTypes:insert(ITEMTYPE_BLACKSMITHING_RAW_MATERIAL)
PABItemTypes:insert(ITEMTYPE_BLACKSMITHING_MATERIAL)
PABItemTypes:insert(ITEMTYPE_BLACKSMITHING_BOOSTER)
-- Clothing
PABItemTypes:insert(ITEMTYPE_CLOTHIER_RAW_MATERIAL)
PABItemTypes:insert(ITEMTYPE_CLOTHIER_MATERIAL)
PABItemTypes:insert(ITEMTYPE_CLOTHIER_BOOSTER)
-- Woodworking
PABItemTypes:insert(ITEMTYPE_WOODWORKING_RAW_MATERIAL)
PABItemTypes:insert(ITEMTYPE_WOODWORKING_MATERIAL)
PABItemTypes:insert(ITEMTYPE_WOODWORKING_BOOSTER)
-- Enchanting
PABItemTypes:insert(ITEMTYPE_ENCHANTING_RUNE_ASPECT)
PABItemTypes:insert(ITEMTYPE_ENCHANTING_RUNE_ESSENCE)
PABItemTypes:insert(ITEMTYPE_ENCHANTING_RUNE_POTENCY)
PABItemTypes:insert(ITEMTYPE_GLYPH_ARMOR)
PABItemTypes:insert(ITEMTYPE_GLYPH_JEWELRY)
PABItemTypes:insert(ITEMTYPE_GLYPH_WEAPON)
-- Provisioning
PABItemTypes:insert(ITEMTYPE_INGREDIENT)
PABItemTypes:insert(ITEMTYPE_RECIPE)
-- Others
PABItemTypes:insert(ITEMTYPE_POTION)
PABItemTypes:insert(ITEMTYPE_POISON)
PABItemTypes:insert(ITEMTYPE_ARMOR_TRAIT)
PABItemTypes:insert(ITEMTYPE_WEAPON_TRAIT)
PABItemTypes:insert(ITEMTYPE_STYLE_MATERIAL)
PABItemTypes:insert(ITEMTYPE_RAW_MATERIAL)

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

-- PersonalAssistant Loot Harvestable ItemTypes
PALLootableItemTypes = setmetatable({}, { __index = table })
-- Clothing
PALLootableItemTypes:insert(ITEMTYPE_CLOTHIER_RAW_MATERIAL)
-- Provisioning
PALLootableItemTypes:insert(ITEMTYPE_INGREDIENT)
-- Fishing
PALLootableItemTypes:insert(ITEMTYPE_LURE)


-- =====================================================================================================================
-- = PA Junk
-- =================================
-- PersonalAssistant Junk ItemTypes
PAJItemTypes = {}