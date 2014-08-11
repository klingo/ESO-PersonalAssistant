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
PAG_MAX_PROFILES = 3

-- PersonalAssistant Banking
PAB_MAX_DEPOSIT_LOOPS = 3

-- PersonalAssistant Colors
PAC_COL_WHITE = "|cFFFFFF"
PAC_COL_YELLOW = "|cFFFF00"
PAC_COL_LIGHT_BLUE = "|cB0B0FF"

PAItemTypes = {}
-- PAItemTypes[index] = ItemType   ["" --> disabled itemType]
-- currently contains 52 entries (0 - 51)
PAItemTypes[0] = "" -- ITEMTYPE_ADDITIVE
PAItemTypes[1] = ITEMTYPE_ALCHEMY_BASE
PAItemTypes[2] = "" -- ITEMTYPE_ARMOR
PAItemTypes[3] = "" -- ITEMTYPE_ARMOR_BOOSTER
PAItemTypes[4] = ITEMTYPE_ARMOR_TRAIT
PAItemTypes[5] = "" -- ITEMTYPE_AVA_REPAIR
PAItemTypes[6] = ITEMTYPE_BLACKSMITHING_BOOSTER
PAItemTypes[7] = ITEMTYPE_BLACKSMITHING_MATERIAL
PAItemTypes[8] = ITEMTYPE_BLACKSMITHING_RAW_MATERIAL
PAItemTypes[9] = ITEMTYPE_CLOTHIER_BOOSTER
PAItemTypes[10] = ITEMTYPE_CLOTHIER_MATERIAL
PAItemTypes[11] = ITEMTYPE_CLOTHIER_RAW_MATERIAL
PAItemTypes[12] = "" -- ITEMTYPE_COLLECTIBLE
PAItemTypes[13] = "" -- ITEMTYPE_CONTAINER
PAItemTypes[14] = "" -- ITEMTYPE_COSTUME
PAItemTypes[15] = "" -- ITEMTYPE_DISGUISE
PAItemTypes[16] = ITEMTYPE_DRINK
PAItemTypes[17] = "" -- ITEMTYPE_ENCHANTING_RUNE	(removed with patch 1.2.3)
PAItemTypes[49] = ITEMTYPE_ENCHANTING_RUNE_ASPECT
PAItemTypes[50] = ITEMTYPE_ENCHANTING_RUNE_ESSENCE
PAItemTypes[51] = ITEMTYPE_ENCHANTING_RUNE_POTENCY
PAItemTypes[18] = "" -- ITEMTYPE_ENCHANTMENT_BOOSTER
PAItemTypes[19] = "" -- ITEMTYPE_FLAVORING
PAItemTypes[20] = ITEMTYPE_FOOD
PAItemTypes[21] = ITEMTYPE_GLYPH_ARMOR
PAItemTypes[22] = ITEMTYPE_GLYPH_JEWELRY
PAItemTypes[23] = ITEMTYPE_GLYPH_WEAPON
PAItemTypes[24] = ITEMTYPE_INGREDIENT
PAItemTypes[25] = "" -- ITEMTYPE_LOCKPICK
PAItemTypes[26] = "" -- ITEMTYPE_LURE
PAItemTypes[27] = "" -- ITEMTYPE_NONE
PAItemTypes[28] = "" -- ITEMTYPE_PLUG
PAItemTypes[29] = "" -- ITEMTYPE_POISON
PAItemTypes[30] = ITEMTYPE_POTION
PAItemTypes[31] = "" -- ITEMTYPE_RAW_MATERIAL
PAItemTypes[32] = ITEMTYPE_REAGENT
PAItemTypes[33] = ITEMTYPE_RECIPE
PAItemTypes[34] = "" -- ITEMTYPE_RACIAL_STYLE_MOTIF		(replaced ITEMTYPE_SCROLL with patch 1.2.3)
PAItemTypes[35] = "" -- ITEMTYPE_SIEGE
PAItemTypes[36] = "" -- ITEMTYPE_SOUL_GEM
PAItemTypes[37] = "" -- ITEMTYPE_SPICE
PAItemTypes[38] = ITEMTYPE_STYLE_MATERIAL
PAItemTypes[39] = "" -- ITEMTYPE_TABARD
PAItemTypes[40] = "" -- ITEMTYPE_TOOL
PAItemTypes[41] = "" -- ITEMTYPE_TRASH
PAItemTypes[42] = "" -- ITEMTYPE_TROPHY
PAItemTypes[43] = "" -- ITEMTYPE_WEAPON
PAItemTypes[44] = "" -- ITEMTYPE_WEAPON_BOOSTER
PAItemTypes[45] = ITEMTYPE_WEAPON_TRAIT
PAItemTypes[46] = ITEMTYPE_WOODWORKING_BOOSTER
PAItemTypes[47] = ITEMTYPE_WOODWORKING_MATERIAL
PAItemTypes[48] = ITEMTYPE_WOODWORKING_RAW_MATERIAL 

-- PersonalAssistant advanced ItemTypes
PAItemTypesAdvanced = {}
PAItemTypesAdvanced[0] = 30357	-- Lockpick