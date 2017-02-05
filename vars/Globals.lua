if PA_SavedVars						== nil then PA_SavedVars					= {} end
if PA_SavedVars.General				== nil then PA_SavedVars.General			= {} end
if PA_SavedVars.Profiles			== nil then PA_SavedVars.Profiles			= {} end
if PA_SavedVars.Repair				== nil then PA_SavedVars.Repair				= {} end
if PA_SavedVars.Banking				== nil then PA_SavedVars.Banking 			= {} end
if PA_SavedVars.Banking.ItemTypes 	== nil then PA_SavedVars.Banking.ItemTypes	= {} end

-- PersonalAssistant Constants
PAC_ITEMTYPE_IGNORE = 0
PAC_ITEMTYPE_DEPOSIT = 1
PAC_ITEMTYPE_WITHDRAWAL = 2
PAC_ITEMTYPE_INHERIT = 3

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
PAC_COL_YELLOW = "|cFFFF00"
PAC_COL_LIGHT_BLUE = "|cB0B0FF"

PAItemTypes = {}
-- PAItemTypes[index] = ItemType   ["" --> disabled itemType]
-- Alchemy
PAItemTypes[00] = ITEMTYPE_REAGENT
PAItemTypes[01] = ITEMTYPE_POISON_BASE                  -- (replaced ITEMTYPE_ALCHEMY_BASE with APIVersion 100015)
PAItemTypes[02] = ITEMTYPE_POTION_BASE                  -- (replaced ITEMTYPE_ALCHEMY_BASE with APIVersion 100015)
-- Blacksmithing
PAItemTypes[03] = ITEMTYPE_BLACKSMITHING_RAW_MATERIAL
PAItemTypes[04] = ITEMTYPE_BLACKSMITHING_MATERIAL
PAItemTypes[05] = ITEMTYPE_BLACKSMITHING_BOOSTER
-- Clothing
PAItemTypes[06] = ITEMTYPE_CLOTHIER_RAW_MATERIAL
PAItemTypes[07] = ITEMTYPE_CLOTHIER_MATERIAL
PAItemTypes[08] = ITEMTYPE_CLOTHIER_BOOSTER
-- Woodworking
PAItemTypes[09] = ITEMTYPE_WOODWORKING_RAW_MATERIAL
PAItemTypes[10] = ITEMTYPE_WOODWORKING_MATERIAL
PAItemTypes[11] = ITEMTYPE_WOODWORKING_BOOSTER
-- Enchanting
PAItemTypes[12] = ITEMTYPE_ENCHANTING_RUNE_ASPECT
PAItemTypes[13] = ITEMTYPE_ENCHANTING_RUNE_ESSENCE
PAItemTypes[14] = ITEMTYPE_ENCHANTING_RUNE_POTENCY
PAItemTypes[15] = ITEMTYPE_GLYPH_ARMOR
PAItemTypes[16] = ITEMTYPE_GLYPH_JEWELRY
PAItemTypes[17] = ITEMTYPE_GLYPH_WEAPON
-- Provisioning
PAItemTypes[18] = ITEMTYPE_INGREDIENT
PAItemTypes[19] = ITEMTYPE_RECIPE
-- Others
PAItemTypes[20] = ITEMTYPE_DRINK
PAItemTypes[21] = ITEMTYPE_FOOD
PAItemTypes[22] = ITEMTYPE_POTION
PAItemTypes[23] = ITEMTYPE_ARMOR_TRAIT
PAItemTypes[24] = ITEMTYPE_WEAPON_TRAIT
PAItemTypes[25] = ITEMTYPE_STYLE_MATERIAL

-- PAItemTypes[0] = "" -- ITEMTYPE_ADDITIVE
-- PAItemTypes[2] = "" -- ITEMTYPE_ARMOR
-- PAItemTypes[3] = "" -- ITEMTYPE_ARMOR_BOOSTER
-- PAItemTypes[5] = "" -- ITEMTYPE_AVA_REPAIR
-- PAItemTypes[12] = "" -- ITEMTYPE_COLLECTIBLE
-- PAItemTypes[13] = "" -- ITEMTYPE_CONTAINER
-- PAItemTypes[14] = "" -- ITEMTYPE_COSTUME
-- PAItemTypes[15] = "" -- ITEMTYPE_DISGUISE
-- PAItemTypes[17] = "" -- ITEMTYPE_ENCHANTING_RUNE	        (removed with patch 1.2.3)
-- PAItemTypes[18] = "" -- ITEMTYPE_ENCHANTMENT_BOOSTER
-- PAItemTypes[19] = "" -- ITEMTYPE_FLAVORING
-- PAItemTypes[25] = "" -- ITEMTYPE_LOCKPICK
-- PAItemTypes[26] = "" -- ITEMTYPE_LURE
-- PAItemTypes[27] = "" -- ITEMTYPE_NONE
-- PAItemTypes[28] = "" -- ITEMTYPE_PLUG
-- PAItemTypes[29] = "" -- ITEMTYPE_POISON
-- PAItemTypes[31] = "" -- ITEMTYPE_RAW_MATERIAL
-- PAItemTypes[34] = "" -- ITEMTYPE_RACIAL_STYLE_MOTIF		(replaced ITEMTYPE_SCROLL with patch 1.2.3)
-- PAItemTypes[35] = "" -- ITEMTYPE_SIEGE
-- PAItemTypes[36] = "" -- ITEMTYPE_SOUL_GEM
-- PAItemTypes[37] = "" -- ITEMTYPE_SPICE
-- PAItemTypes[39] = "" -- ITEMTYPE_TABARD
-- PAItemTypes[40] = "" -- ITEMTYPE_TOOL
-- PAItemTypes[41] = "" -- ITEMTYPE_TRASH
-- PAItemTypes[42] = "" -- ITEMTYPE_TROPHY
-- PAItemTypes[43] = "" -- ITEMTYPE_WEAPON
-- PAItemTypes[44] = "" -- ITEMTYPE_WEAPON_BOOSTER
-- PAItemTypes[52] = "" -- ITEMTYPE_CROWN_ITEM
-- PAItemTypes[53] = "" -- ITEMTYPE_CROWN_REPAIR
-- PAItemTypes[54] = "" -- ITEMTYPE_DEPRECATED
-- PAItemTypes[55] = "" -- ITEMTYPE_FISH
-- PAItemTypes[56] = "" -- ITEMTYPE_MASTER_WRIT
-- PAItemTypes[57] = "" -- ITEMTYPE_MAX_VALUE
-- PAItemTypes[58] = "" -- ITEMTYPE_MIN_VALUE
-- PAItemTypes[59] = "" -- ITEMTYPE_MOUNT
-- PAItemTypes[62] = "" -- ITEMTYPE_SPELLCRAFTING_TABLET
-- PAItemTypes[63] = "" -- ITEMTYPE_TREASURE


-- PersonalAssistant advanced ItemTypes
PAItemTypesAdvanced = {}
PAItemTypesAdvanced[0] = 30357	-- Lockpick