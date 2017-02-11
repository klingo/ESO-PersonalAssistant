if PA_SavedVars						== nil then PA_SavedVars					= {} end
if PA_SavedVars.General				== nil then PA_SavedVars.General			= {} end
if PA_SavedVars.Profiles			== nil then PA_SavedVars.Profiles			= {} end
if PA_SavedVars.Repair				== nil then PA_SavedVars.Repair				= {} end
if PA_SavedVars.Banking				== nil then PA_SavedVars.Banking 			= {} end
if PA_SavedVars.Banking.ItemTypes 	== nil then PA_SavedVars.Banking.ItemTypes	= {} end
if PA_SavedVars.Loot				== nil then PA_SavedVars.Loot 			    = {} end
if PA_SavedVars.Junk				== nil then PA_SavedVars.Junk 			    = {} end

-- PersonalAssistant Constants
-- PA Banking
PAC_ITEMTYPE_IGNORE = 0
PAC_ITEMTYPE_DEPOSIT = 1
PAC_ITEMTYPE_WITHDRAWAL = 2
PAC_ITEMTYPE_INHERIT = 3
-- PA Loot
PAC_ITEMTYPE_LOOT = 1

PAC_OPERATOR_NONE = 0
PAC_OPERATOR_EQUAL = 1
-- PAC_OPERATOR_LESSTHAN = 2
PAC_OPERATOR_LESSTAHNEQAL = 3
-- PAC_OPERATOR_GREATERTHAN = 4
PAC_OPERATOR_GREATERTHANEQUAL = 5

-- PersonalAssistant General
PAG_MAX_PROFILES = 5

-- PersonalAssistant Banking
PAB_DEPOSIT_MAX_LOOPS = 3

PAB_STACKING_FULL = 0		-- 0: Full depositing/withdrawl
PAB_STACKING_CONTINUE = 1	-- 1: Continue existing stacks
PAB_STACKING_INCOMPLETE = 2	-- 2: Complete existing stacks

-- PersonalAssistant Colors
PAC_COL_WHITE = "|cFFFFFF"
PAC_COL_DEFAULT = "|cFFFF00"
PAC_COL_YELLOW = "|cFFD700"
PAC_COL_LIGHT_BLUE = "|cB0B0FF"
PAC_COL_ORANGE = "|cFF7400"

-- PersonalAssistant Colored Names
PAC_COLTEXT_PAB = PAC_COL_YELLOW.."PA B"..PAC_COL_WHITE.."anking: "..PAC_COL_DEFAULT
PAC_COLTEXT_PAR = PAC_COL_YELLOW.."PA R"..PAC_COL_WHITE.."epair: "..PAC_COL_DEFAULT
PAC_COLTEXT_PALo = PAC_COL_YELLOW.."PA L"..PAC_COL_WHITE.."oot: "..PAC_COL_DEFAULT
PAC_COLTEXT_PAJ = PAC_COL_YELLOW.."PA J"..PAC_COL_WHITE.."unk: "..PAC_COL_DEFAULT

-- Icons
PAC_ICON_GOLD = "|t16:16:/esoui/art/currency/currency_gold.dds|t"
PAC_ICON_TALVAR = "|t16:16:/esoui/art/currency/currency_telvar.dds|t"
-- PAC_ICON_TALVAR = "|r|c66a8ff|t16:16:/esoui/art/currency/currency_telvar.dds|t"


-- =====================================================================================================================
-- = PA Banking
-- =================================
PAItemTypes = {}
-- PAItemTypes[index] = ItemType   ["" --> disabled itemType]
-- Alchemy
table.insert(PAItemTypes, ITEMTYPE_REAGENT) -- 00
table.insert(PAItemTypes, ITEMTYPE_POISON_BASE) -- 01
table.insert(PAItemTypes, ITEMTYPE_POTION_BASE) -- 02
-- Blacksmithing
table.insert(PAItemTypes, ITEMTYPE_BLACKSMITHING_RAW_MATERIAL) -- 03
table.insert(PAItemTypes, ITEMTYPE_BLACKSMITHING_MATERIAL) -- 04
table.insert(PAItemTypes, ITEMTYPE_BLACKSMITHING_BOOSTER) -- 05
-- Clothing
table.insert(PAItemTypes, ITEMTYPE_CLOTHIER_RAW_MATERIAL) -- 06
table.insert(PAItemTypes, ITEMTYPE_CLOTHIER_MATERIAL) -- 07
table.insert(PAItemTypes, ITEMTYPE_CLOTHIER_BOOSTER) -- 08
-- Woodworking
table.insert(PAItemTypes, ITEMTYPE_WOODWORKING_RAW_MATERIAL) -- 09
table.insert(PAItemTypes, ITEMTYPE_WOODWORKING_MATERIAL) -- 10
table.insert(PAItemTypes, ITEMTYPE_WOODWORKING_BOOSTER) -- 11
-- Enchanting
table.insert(PAItemTypes, ITEMTYPE_ENCHANTING_RUNE_ASPECT) -- 12
table.insert(PAItemTypes, ITEMTYPE_ENCHANTING_RUNE_ESSENCE) -- 13
table.insert(PAItemTypes, ITEMTYPE_ENCHANTING_RUNE_POTENCY) -- 14
table.insert(PAItemTypes, ITEMTYPE_GLYPH_ARMOR) -- 15
table.insert(PAItemTypes, ITEMTYPE_GLYPH_JEWELRY) -- 16
table.insert(PAItemTypes, ITEMTYPE_GLYPH_WEAPON) -- 17
-- Provisioning
table.insert(PAItemTypes, ITEMTYPE_INGREDIENT) -- 18
table.insert(PAItemTypes, ITEMTYPE_RECIPE) -- 19
-- Others
table.insert(PAItemTypes, ITEMTYPE_DRINK) -- 20
table.insert(PAItemTypes, ITEMTYPE_FOOD) -- 21
table.insert(PAItemTypes, ITEMTYPE_POTION) -- 22
table.insert(PAItemTypes, ITEMTYPE_POISON) -- NEW!!!
table.insert(PAItemTypes, ITEMTYPE_ARMOR_TRAIT) -- 23
table.insert(PAItemTypes, ITEMTYPE_WEAPON_TRAIT) -- 24
table.insert(PAItemTypes, ITEMTYPE_STYLE_MATERIAL) -- 25
table.insert(PAItemTypes, ITEMTYPE_RAW_MATERIAL) -- 26

-- PersonalAssistant advanced ItemTypes
PAItemTypesAdvanced = {}
PAItemTypesAdvanced[0] = 30357	-- Lockpick
-- Can't use ITEMTYPE_LOCKPICK or SPECIALIZED_ITEMTYPE_LOCKPICK since the actual lockpicks are categorized as ITEMTYPE_TOOL (as of APIVersion 100018)

-- =====================================================================================================================
-- = PA Loot
-- =================================
-- PersonalAssistant Loot ItemTypes
PALoItemTypes = {}
-- Alchemy
table.insert(PALoItemTypes, ITEMTYPE_REAGENT)
table.insert(PALoItemTypes, ITEMTYPE_POTION_BASE)
-- Blacksmithing
table.insert(PALoItemTypes, ITEMTYPE_BLACKSMITHING_RAW_MATERIAL)
-- Clothing
table.insert(PALoItemTypes, ITEMTYPE_CLOTHIER_RAW_MATERIAL)
-- Woodworking
table.insert(PALoItemTypes, ITEMTYPE_WOODWORKING_RAW_MATERIAL)
-- Enchanting
table.insert(PALoItemTypes, ITEMTYPE_ENCHANTING_RUNE_ASPECT)
table.insert(PALoItemTypes, ITEMTYPE_ENCHANTING_RUNE_ESSENCE)
table.insert(PALoItemTypes, ITEMTYPE_ENCHANTING_RUNE_POTENCY)
-- Provisioning
table.insert(PALoItemTypes, ITEMTYPE_INGREDIENT)
-- Fishing
table.insert(PALoItemTypes, ITEMTYPE_FISH)

-- =====================================================================================================================
-- = PA Junk
-- =================================
-- PersonalAssistant Junk ItemTypes
PAJItemTypes = {}