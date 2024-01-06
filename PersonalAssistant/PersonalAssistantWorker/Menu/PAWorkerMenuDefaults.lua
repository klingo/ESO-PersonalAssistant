-- Local instances of Global tables --
local PA = PersonalAssistant

-- =====================================================================================================================

    -- ---------------------------------------------
	-- Auto research trait defaults
	
	
local function createTheseCraftingSkillDefaults(craftingSkill, AutoResearchTrait)
		
	local craftingSkillName = GetString("SI_TRADESKILLTYPE", craftingSkill) 
		  AutoResearchTrait[craftingSkillName] = AutoResearchTrait[craftingSkillName] or {}
		
	local numResearchLines = GetNumSmithingResearchLines(craftingSkill)

	for i=1, numResearchLines do
		local name, icon, numTraits, timeRequiredForNextResearchSecs = GetSmithingResearchLineInfo(craftingSkill, i)  
		AutoResearchTrait[craftingSkillName][name] = AutoResearchTrait[craftingSkillName][name] or {}
		
		for t=1, numTraits do
			local traitType, traitDescription, known = GetSmithingResearchLineTraitInfo(craftingSkill, i, t)
			local traitName = GetString("SI_ITEMTRAITTYPE",traitType) 
			 AutoResearchTrait[craftingSkillName][name][traitName] = false			
		end

	end
	return AutoResearchTrait
end
	
local function AutoResearchTraitDefaults()
	local AutoResearchTrait = {}
	AutoResearchTrait = createTheseCraftingSkillDefaults(CRAFTING_TYPE_BLACKSMITHING, AutoResearchTrait)
	AutoResearchTrait = createTheseCraftingSkillDefaults(CRAFTING_TYPE_CLOTHIER, AutoResearchTrait)
	AutoResearchTrait = createTheseCraftingSkillDefaults(CRAFTING_TYPE_WOODWORKING, AutoResearchTrait)
	AutoResearchTrait = createTheseCraftingSkillDefaults(CRAFTING_TYPE_JEWELRYCRAFTING, AutoResearchTrait)
	return AutoResearchTrait
end

	-- ---------------------------------------------

local PAWorkerMenuDefaults = {
    name = table.concat({GetString(SI_PA_PROFILE), " ", 1}),

	
	autoDeconstructEnabled = false,
	ProtectBank = true,
	ProtectUncollectedSetItems = true,
	
	CheckMeticulousDisassembly = false,
	
	Weapons = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkKnownTraits = true,
        autoMarkUnknownTraits = false,
    },
    Armor = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkKnownTraits = true,
        autoMarkUnknownTraits = false,
    },
    Jewelry = {
        autoMarkOrnate = false,
        autoMarkQualityThreshold = -1,
        autoMarkIncludingSets = false,
        autoMarkIntricateTrait = false,
        autoMarkKnownTraits = true,
        autoMarkUnknownTraits = false,
    },
    Miscellaneous = {
        autoMarkGlyphQualityThreshold = -1,
    },
	
	
	-- ---------------------------------------------
	
    autoRefineEnabled = false,
	checkExtraction = false,
	
	-- THIS WORKS! \0/
	["MaterialsToRefine"] = { 
	    ["808"] = true, 
		["5820"] = true,
		["23103"] = true,
		["23104"] = true,
		["23105"] = true,
		["4482"] = true,
		["23133"] = true,
		["23134"] = true,
		["23135"] = true,
		["71198"] = true,
		
		["812"] = true,
		["4464"] = true,
		["23129"] = true,
		["23130"] = true,
		["23131"] = true,
		["33217"] = true,
		["33218"] = true,
		["33219"] = true,
		["33220"] = true,
		["71200"] = true,
		
		["793"] = true, 
		["4448"] = true, 
		["23095"] = true, 
		["6020"] = true, 
		["23097"] = true, 
		["23142"] = true, 
		["23143"] = true, 
		["800"] = true, 
		["4478"] = true, 
		["71239"] = true,
		
		["802"] = true, 
		["521"] = true, 
		["23117"] = true, 
		["23118"] = true, 
		["23119"] = true, 
		["818"] = true, 
		["4439"] = true, 
		["23137"] = true, 
		["23138"] = true, 
		["71199"] = true,

		["135137"] = true, 
		["135139"] = true, 
		["135141"] = true, 
		["135143"] = true, 
		["135145"] = true,
		
		["135151"] = false, -- removed grains
		["135152"] = false, -- removed grains
		["135153"] = false, -- removed grains 
		["135154"] = false, -- removed grains

		["135160"] = true, 		
		["135158"] = true, 		
		["135159"] = true, 		
		["139420"] = true, 		
		["139419"] = true, 		
		["139417"] = true, 		
		["139415"] = true, 		
		["139416"] = true, 		
		["139418"] = true,	

		["64688"] = true, 
		["57665"] = true, 
		["64690"] = true, 
		["121523"] = true, 
		["130062"] = true, 
		["130058"] = true, 
		["121521"] = true, 
		["121522"] = true, 
		["69556"] = true, 
		["59923"] = true, 
		["75371"] = true, 
		["81995"] = true, 
		["81997"] = true, 
		["76911"] = true,	
	},
	
    -- THIS WORKS! \0/
	["AutoResearchTrait"] = AutoResearchTraitDefaults(),
	
	
	-- ---------------------------------------------
	autoResearchTraitEnabled = false,

	
	-- ---------------------------------------------

    -- ---------------------------------------------
    silentMode = false,
}


-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAWorker = PAWorkerMenuDefaults
