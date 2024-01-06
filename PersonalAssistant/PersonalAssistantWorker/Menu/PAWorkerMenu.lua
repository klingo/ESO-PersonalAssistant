-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAWMenuChoices = PA.MenuChoices.choices.PAWorker
local PAWMenuChoicesValues = PA.MenuChoices.choicesValues.PAWorker
local PAWProfileManager = PA.ProfileManager.PAWorker
local PAWMenuDefaults = PA.MenuDefaults.PAWorker
local PAWMenuFunctions = PA.MenuFunctions.PAWorker
local PAHF = PA.HelperFunctions
local PASavedVars = PA.SavedVars

-- =====================================================================================================================
local refinableMaterials = {}
      refinableMaterials.blacksmithing = {808, 5820, 23103, 23104, 23105, 4482, 23133, 23134, 23135, 71198}
      refinableMaterials.clothing = {}
	  refinableMaterials.clothing.light = {812, 4464, 23129, 23130, 23131, 33217, 33218, 33219, 33220, 71200}
      refinableMaterials.clothing.medium = {793, 4448, 23095, 6020, 23097, 23142, 23143, 800, 4478, 71239}
      refinableMaterials.woodworking = {802, 521, 23117, 23118, 23119, 818, 4439, 23137, 23138, 71199}
      refinableMaterials.jewelry = {}
	  refinableMaterials.jewelry.dust = {135137, 135139, 135141, 135143, 135145}
	  --refinableMaterials.jewelry.grains = {135151, 135152, 135153, 135154}
	  refinableMaterials.jewelry.traits = {135160, 135158, 135159, 139420, 139419, 139417, 139415, 139416, 139418}
	  refinableMaterials.styleMaterials = {64688, 57665, 64690, 121523, 130062, 130058, 121521, 121522, 69556, 59923, 75371, 81995, 81997, 76911}

	
-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2

local PAWorkerPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.WORKER,
    displayName = PACAddon.NAME_DISPLAY.WORKER,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.WORKER,
    slashCommand = "/paw",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAWorkerOptionsTable = setmetatable({}, { __index = table })
local PAWorkerProfileSubMenuTable = setmetatable({}, { __index = table })
local PAWWeaponsSubMenu = setmetatable({}, { __index = table })
local PAWArmorSubMenu = setmetatable({}, { __index = table })
local PAWJewelrySubMenu = setmetatable({}, { __index = table })
local PAWGlyphsSubMenu = setmetatable({}, { __index = table })
local PAWBlacksmithingSubMenu = setmetatable({}, { __index = table })
local PAWLightClothingSubMenu  = setmetatable({}, { __index = table })
local PAWMediumClothingSubMenu = setmetatable({}, { __index = table })
local PAWWoodworkingSubMenu = setmetatable({}, { __index = table })
local PAWJewelryDustSubMenu = setmetatable({}, { __index = table })
local PAWJewelryTraitsSubMenu = setmetatable({}, { __index = table })
local PAWStyleMaterialsSubMenu = setmetatable({}, { __index = table })

local PAWBlacksmithingResearchTraitSubMenu = setmetatable({}, { __index = table })
local PAWClothingResearchTraitSubMenu  = setmetatable({}, { __index = table })
local PAWWoodworkingResearchTraitSubMenu = setmetatable({}, { __index = table })
local PAWJewelryResearchTraitSubMenu = setmetatable({}, { __index = table })

-- =================================================================================================================
local function KillTheRubbish(String)
  return  LocalizeString('<<1>>', String)
end 

local function insertTheseMatsSettings(Table, Submenu)
    for key, itemId in ipairs(Table) do  -- keep ipairs to respect the order 
        local itemIdText = tostring(itemId)    	
        local itemLink = "|H0:item:"..itemIdText..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
        local icon = zo_iconTextFormatNoSpace(GetItemLinkIcon(itemLink),32,32,"")
        local flavorText = GetItemLinkFlavorText(itemLink)
		local formatedValue = {}
		      table.insert(formatedValue, "MaterialsToRefine")
			  table.insert(formatedValue, itemIdText)
			  
       
	   Submenu:insert({
			type = "checkbox",
			name = icon.." "..PAHF.getFormattedText(KillTheRubbish(GetItemLinkName(itemLink)), _typeName),
			tooltip = flavorText,
			getFunc = function() return PAWMenuFunctions.getRefinableMaterialSetting(formatedValue) end,
			setFunc = function(value) PAWMenuFunctions.setRefinableMaterialSetting(value,formatedValue) end,
			disabled = PAWMenuFunctions.isRefinableMaterialDisabled,
			default = PAWMenuDefaults["MaterialsToRefine"][itemIdText],
			width = "half",
        })
   end
end	

local function insertTheseResearchTraitSettings(craftingSkill, Submenu)
    local craftingSkillName = GetString("SI_TRADESKILLTYPE", craftingSkill)

	local numResearchLines = GetNumSmithingResearchLines(craftingSkill)

	for i=1, numResearchLines do
		local name, icon, numTraits, timeRequiredForNextResearchSecs = GetSmithingResearchLineInfo(craftingSkill, i) 
		icon = zo_iconTextFormatNoSpace(icon,32,32,"")
		
		for t=1, numTraits do
			local traitType, traitDescription, known = GetSmithingResearchLineTraitInfo(craftingSkill, i, t)
			local traitName = GetString("SI_ITEMTRAITTYPE",traitType)
			local _, _, traitIcon, _, _, _, _ = GetSmithingTraitItemInfo(traitType+1)
			traitIcon = zo_iconTextFormatNoSpace(traitIcon,32,32,"")
            local formatedValue = {}
		    table.insert(formatedValue, "AutoResearchTrait")
			table.insert(formatedValue, craftingSkillName)
            table.insert(formatedValue, name)
			table.insert(formatedValue, traitName) 
			
		    Submenu:insert({
				type = "checkbox",
				name = icon.." "..PAHF.getFormattedText(KillTheRubbish(name), _typeName).." "..traitIcon.." "..PAHF.getFormattedText(KillTheRubbish(traitName), _typeName),
				getFunc = function() return PAWMenuFunctions.getTraitSetting(formatedValue) end,
				setFunc = function(value) PAWMenuFunctions.setTraitSetting(value,formatedValue) end,
				disabled = PAWMenuFunctions.isTraitDisabled,
				default = PAWMenuDefaults["AutoResearchTrait"][craftingSkillName][name][traitName],
				width = "half",
			})	
		end
	end
end

-- =================================================================================================================

local function _createPAWorkerMenu()
    PAWorkerOptionsTable:insert({
        type = "submenu",
        name = PAWProfileManager.getProfileSubMenuHeader,
        controls = PAWorkerProfileSubMenuTable
    })

    PAWorkerOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_WORKER_DESCRIPTION),
    })
	
	PAWorkerOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })
	
	PAWorkerOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE_T, _typeName),
        getFunc = PAWMenuFunctions.getCheckExtractionSetting,
        setFunc = PAWMenuFunctions.setCheckExtractionSetting,
        disabled = PAWMenuFunctions.isCheckExtractionDisabled,
        default = PAWMenuDefaults.checkExtraction,
    })
	
	PAWorkerOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_METICULOUS_ENABLE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_METICULOUS_ENABLE_T, _typeName),
        getFunc = PAWMenuFunctions.getMeticulousDisassemblySetting,
        setFunc = PAWMenuFunctions.setMeticulousDisassemblySetting,
        disabled = PAWProfileManager.isNoProfileSelected,
        default = PAWMenuDefaults.CheckMeticulousDisassembly,
    })
	
    -- ---------------------------------------------------------------------------------------------------------
	-- AUTO DECONSTRUCT
    PAWorkerOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_WORKER_AUTODECONSTRUCT_HEADER))
    })

    PAWorkerOptionsTable:insert({ 
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE)),
		tooltip = GetString(SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE_T),
        getFunc = PAWMenuFunctions.getAutoDeconstructSetting,
        setFunc = PAWMenuFunctions.setAutoDeconstructSetting,
        disabled = PAWProfileManager.isNoProfileSelected,
        default = PAWMenuDefaults.autoDeconstructEnabled,
		
	})
	PAWorkerOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE_T, _typeName),
        getFunc = PAWMenuFunctions.getProtectBankSetting,
        setFunc = PAWMenuFunctions.setProtectBankSetting,
        disabled = PAWMenuFunctions.isProtectBankDisabled,
        default = PAWMenuDefaults.ProtectBank,
    })
	PAWorkerOptionsTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_PROTECT_UNCOLLECTED_SET_ITEMS_ENABLE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_PROTECT_UNCOLLECTED_SET_ITEMS_ENABLE_T, _typeName),
        getFunc = PAWMenuFunctions.getProtectUncollectedSetItemsSetting,
        setFunc = PAWMenuFunctions.setProtectUncollectedSetItemsSetting,
        disabled = PAWMenuFunctions.isProtectUncollectedSetItemsDisabled,
        default = PAWMenuDefaults.ProtectUncollectedSetItems,
    })
    PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_HEADER),
        icon = PAC.ICONS.CRAFTBAG.WEAPON.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWWeaponsSubMenu,
        disabledLabel = PAWMenuFunctions.isWeaponsMenuDisabled,
    })
    PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_HEADER),
        icon = PAC.ICONS.CRAFTBAG.ARMOR.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWArmorSubMenu,
        disabledLabel = PAWMenuFunctions.isArmorMenuDisabled,
    })

    PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_HEADER),
        icon = PAC.ICONS.CRAFTBAG.JEWELRY.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWJewelrySubMenu,
        disabledLabel = PAWMenuFunctions.isJewelryMenuDisabled,
    })
	
    PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS),
        icon = PAC.ICONS.CRAFTBAG.ENCHANTING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWGlyphsSubMenu,
        disabledLabel = PAWMenuFunctions.isGlyphMenuDisabled,
    })
	
    -- ---------------------------------------------------------------------------------------------------------	
	-- AUTO REFINE

    PAWorkerOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_WORKER_AUTOREFINE_HEADER))
    })

    PAWorkerOptionsTable:insert({ 
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_WORKER_AUTOREFINE_ENABLE)),  
		tooltip = GetString(SI_PA_MENU_WORKER_AUTOREFINE_ENABLE_T),
        getFunc = PAWMenuFunctions.getAutoRefineSetting,
        setFunc = PAWMenuFunctions.setAutoRefineSetting,
        disabled = PAWProfileManager.isNoProfileSelected,
        default = PAWMenuDefaults.autoRefineEnabled,
    })
	
	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE13).." "..GetString(SI_ITEMFILTERTYPE4),   
        icon = PAC.ICONS.CRAFTBAG.BLACKSMITHING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWBlacksmithingSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })
	

	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE14).." "..GetString(SI_ITEMFILTERTYPE4).." ("..GetString(SI_ARMORTYPE1)..")",   
        icon = PAC.ICONS.CRAFTBAG.CLOTHING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWLightClothingSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })
	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE14).." "..GetString(SI_ITEMFILTERTYPE4).." ("..GetString(SI_ARMORTYPE2)..")",   
        icon = PAC.ICONS.CRAFTBAG.CLOTHING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWMediumClothingSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })

	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE15).." "..GetString(SI_ITEMFILTERTYPE4),   
        icon = PAC.ICONS.CRAFTBAG.WOODWORKING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWWoodworkingSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })	
	
	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE24).." "..GetString(SI_ITEMFILTERTYPE4),   
        icon = PAC.ICONS.CRAFTBAG.JEWELCRAFTING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWJewelryDustSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })		

	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE24).." "..GetString(SI_ITEMFILTERTYPE4).." ("..GetString(SI_CRAFTING_COMPONENT_TOOLTIP_TRAITS)..")",   
        icon = PAC.ICONS.CRAFTBAG.JEWELCRAFTING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWJewelryTraitsSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })

	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMTYPEDISPLAYCATEGORY17),   
        icon = PAC.ICONS.CRAFTBAG.STYLEMATERIALS.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWStyleMaterialsSubMenu,
        disabledLabel = PAWMenuFunctions.AreRefineSubmenusDisabled,
    })	  
  
     -- ---------------------------------------------------------------------------------------------------------	
	-- AUTO RESEARCH TRAIT 
  
      PAWorkerOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_HEADER))
    })
  
    
    PAWorkerOptionsTable:insert({ 
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE)),  
		tooltip = GetString(SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE_T),
        getFunc = PAWMenuFunctions.getAutoResearchTraitSetting,
        setFunc = PAWMenuFunctions.setAutoResearchTraitSetting,
        disabled = PAWProfileManager.isNoProfileSelected,
        default = PAWMenuDefaults.autoResearchTraitEnabled,
    })


	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE13),   
        icon = PAC.ICONS.CRAFTBAG.BLACKSMITHING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWBlacksmithingResearchTraitSubMenu,
        disabledLabel = PAWMenuFunctions.AreTraitSubmenusDisabled,
    })
	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE14),   
        icon = PAC.ICONS.CRAFTBAG.CLOTHING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWClothingResearchTraitSubMenu,
        disabledLabel = PAWMenuFunctions.AreTraitSubmenusDisabled,
    })
	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE15),   
        icon = PAC.ICONS.CRAFTBAG.WOODWORKING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWWoodworkingResearchTraitSubMenu,
        disabledLabel = PAWMenuFunctions.AreTraitSubmenusDisabled,
    })
	
	PAWorkerOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_ITEMFILTERTYPE24),   
        icon = PAC.ICONS.CRAFTBAG.JEWELCRAFTING.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAWJewelryResearchTraitSubMenu,
        disabledLabel = PAWMenuFunctions.AreTraitSubmenusDisabled,
    })

    -- ---------------------------------------------------------------------------------------------------------

    PAWorkerOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_OTHER_SETTINGS_HEADER))
    })

    PAWorkerOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PAWMenuFunctions.getSilentModeSetting,
        setFunc = PAWMenuFunctions.setSilentModeSetting,
        disabled = PAWMenuFunctions.isSilentModeDisabled,
        default = PAWMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPAWorkerProfileSubMenuTable()
    PAWorkerProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PAWProfileManager.getProfileList(),
        choicesValues = PAWProfileManager.getProfileListValues(),
        width = "half",
        getFunc = PAWProfileManager.getActiveProfile,
        setFunc = PAWProfileManager.setActiveProfile,
        reference = "PERSONALASSISTANT_WORKER_PROFILEDROPDOWN"
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        maxChars = 40,
        width = "half",
        getFunc = PAWProfileManager.getActiveProfileName,
        setFunc = PAWProfileManager.setActiveProfileName,
        disabled = PAWProfileManager.isNoProfileSelected
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PAWProfileManager.createNewProfile,
        disabled = PAWProfileManager.hasMaxProfileCountReached
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = function() return not PAWProfileManager.hasMaxProfileCountReached() end
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PAWProfileManager.hasOnlyOneProfile() or PAWProfileManager.isNoProfileSelected() end,
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PAWProfileManager.getInactiveProfileList(),
        choicesValues = PAWProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Worker.selectedCopyProfile end,
        setFunc = function(value) PA.Worker.selectedCopyProfile = value end,
        disabled = function() return PAWProfileManager.hasOnlyOneProfile() or PAWProfileManager.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_WORKER_PROFILEDROPDOWN_COPY"
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PAWProfileManager.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PAWProfileManager.isNoCopyProfileSelected
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PAWProfileManager.hasOnlyOneProfile
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PAWProfileManager.getInactiveProfileList(),
        choicesValues = PAWProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Worker.selectedDeleteProfile end,
        setFunc = function(value) PA.Worker.selectedDeleteProfile = value end,
        disabled = PAWProfileManager.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_WORKER_PROFILEDROPDOWN_DELETE"
    })

    PAWorkerProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PAWProfileManager.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PAWProfileManager.isNoDeleteProfileSelected
    })
end

-- =================================================================================================================


local function _createPAWWeaponsSubMenu()
    local _typeName = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS))
	
	PAWWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INTRICATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INTRICATE_T, _typeName),
        getFunc = PAWMenuFunctions.getWeaponsIncludeIntricateTraitSetting,
        setFunc = PAWMenuFunctions.setWeaponsIncludeIntricateTraitSetting,
        disabled = PAWMenuFunctions.isWeaponsIncludeIntricateTraitDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkIntricateTrait,
    })
	
	PAWWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_ORNATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_ORNATE_T, _typeName),
        getFunc = PAWMenuFunctions.getWeaponsAutoMarkOrnateSetting,
        setFunc = PAWMenuFunctions.setWeaponsAutoMarkOrnateSetting,
        disabled = PAWMenuFunctions.isWeaponsAutoMarkOrnateDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkOrnate,
    })
	
	PAWWeaponsSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })
	
    PAWWeaponsSubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T, _typeName),
        choices = PAWMenuChoices.qualityLevel,
        choicesValues = PAWMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAWMenuFunctions.getWeaponsAutoMarkQualityThresholdSetting,
        setFunc = PAWMenuFunctions.setWeaponsAutoMarkQualityThresholdSetting,
        disabled = PAWMenuFunctions.isWeaponsAutoMarkQualityThresholdDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkQualityThreshold,
    })
	
    PAWWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS_T, _typeName),
        getFunc = PAWMenuFunctions.getWeaponsIncludeSetItemsSetting,
        setFunc = PAWMenuFunctions.setWeaponsIncludeSetItemsSetting,
        disabled = PAWMenuFunctions.isWeaponsIncludeSetItemsDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkIncludingSets,
    })


    PAWWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS_T, _typeName),
        getFunc = PAWMenuFunctions.getWeaponsIncludeKnownTraitsSetting,
        setFunc = PAWMenuFunctions.setWeaponsIncludeKnownTraitsSetting,
        disabled = PAWMenuFunctions.isWeaponsIncludeKnownTraitsDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkKnownTraits,
    })

    PAWWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, _typeName),
        getFunc = PAWMenuFunctions.getWeaponsIncludeUnknownTraitsSetting,
        setFunc = PAWMenuFunctions.setWeaponsIncludeUnknownTraitsSetting,
        disabled = PAWMenuFunctions.isWeaponsIncludeUnknownTraitsDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkUnknownTraits,
    })
end
-- -----------------------------------------------------------------------------------------------------------------

local function _createPAWArmorSubMenu()
    local _typeName = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR))
	
	PAWArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INTRICATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INTRICATE_T, _typeName),
        getFunc = PAWMenuFunctions.getArmorIncludeIntricateTraitSetting,
        setFunc = PAWMenuFunctions.setArmorIncludeIntricateTraitSetting,
        disabled = PAWMenuFunctions.isArmorIncludeIntricateTraitDisabled,
        default = PAWMenuDefaults.Armor.autoMarkIntricateTrait,
    })
	
    PAWArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_ORNATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_ORNATE_T, _typeName),
        getFunc = PAWMenuFunctions.getArmorAutoMarkOrnateSetting,
        setFunc = PAWMenuFunctions.setArmorAutoMarkOrnateSetting,
        disabled = PAWMenuFunctions.isArmorAutoMarkOrnateDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkOrnate,
    })
	
    PAWArmorSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAWArmorSubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T, _typeName),
        choices = PAWMenuChoices.qualityLevel,
        choicesValues = PAWMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAWMenuFunctions.getArmorAutoMarkQualityThresholdSetting,
        setFunc = PAWMenuFunctions.setArmorAutoMarkQualityThresholdSetting,
        disabled = PAWMenuFunctions.isArmorAutoMarkQualityThresholdDisabled,
        default = PAWMenuDefaults.Armor.autoMarkQualityThreshold,
    })
	


    PAWArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS_T, _typeName),
        getFunc = PAWMenuFunctions.getArmorIncludeSetItemsSetting,
        setFunc = PAWMenuFunctions.setArmorIncludeSetItemsSetting,
        disabled = PAWMenuFunctions.isArmorIncludeSetItemsDisabled,
        default = PAWMenuDefaults.Armor.autoMarkIncludingSets,
    })

    PAWArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS_T, _typeName),
        getFunc = PAWMenuFunctions.getArmorIncludeKnownTraitsSetting,
        setFunc = PAWMenuFunctions.setArmorIncludeKnownTraitsSetting,
        disabled = PAWMenuFunctions.isArmorIncludeKnownTraitsDisabled,
        default = PAWMenuDefaults.Armor.autoMarkKnownTraits,
    })

    PAWArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, _typeName),
        getFunc = PAWMenuFunctions.getArmorIncludeUnknownTraitsSetting,
        setFunc = PAWMenuFunctions.setArmorIncludeUnknownTraitsSetting,
        disabled = PAWMenuFunctions.isArmorIncludeUnknownTraitsDisabled,
        default = PAWMenuDefaults.Armor.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAWJewelrySubMenu()
    local _typeName = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))
	
	PAWJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INTRICATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INTRICATE_T, _typeName),
        getFunc = PAWMenuFunctions.getJewelryIncludeIntricateTraitSetting,
        setFunc = PAWMenuFunctions.setJewelryIncludeIntricateTraitSetting,
        disabled = PAWMenuFunctions.isJewelryIncludeIntricateTraitDisabled,
        default = PAWMenuDefaults.Jewelry.autoMarkIntricateTrait,
    })
	
	PAWJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_ORNATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_ORNATE_T, _typeName),
        getFunc = PAWMenuFunctions.getJewelryAutoMarkOrnateSetting,
        setFunc = PAWMenuFunctions.setJewelryAutoMarkOrnateSetting,
        disabled = PAWMenuFunctions.isJewelryAutoMarkOrnateDisabled,
        default = PAWMenuDefaults.Weapons.autoMarkOrnate,
    })
	
    PAWJewelrySubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })
	
	PAWJewelrySubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T, _typeName),
        choices = PAWMenuChoices.qualityLevel,
        choicesValues = PAWMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAWMenuFunctions.getJewelryAutoMarkQualityThresholdSetting,
        setFunc = PAWMenuFunctions.setJewelryAutoMarkQualityThresholdSetting,
        disabled = PAWMenuFunctions.isJewelryAutoMarkQualityThresholdDisabled,
        default = PAWMenuDefaults.Jewelry.autoMarkQualityThreshold,
    })

    PAWJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS_T, _typeName),
        getFunc = PAWMenuFunctions.getJewelryIncludeSetItemsSetting,
        setFunc = PAWMenuFunctions.setJewelryIncludeSetItemsSetting,
        disabled = PAWMenuFunctions.isJewelryIncludeSetItemsDisabled,
        default = PAWMenuDefaults.Jewelry.autoMarkIncludingSets,
    })

    PAWJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS_T, _typeName),
        getFunc = PAWMenuFunctions.getJewelryIncludeKnownTraitsSetting,
        setFunc = PAWMenuFunctions.setJewelryIncludeKnownTraitsSetting,
        disabled = PAWMenuFunctions.isJewelryIncludeKnownTraitsDisabled,
        default = PAWMenuDefaults.Jewelry.autoMarkKnownTraits,
    })

    PAWJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, _typeName),
        getFunc = PAWMenuFunctions.getJewelryIncludeUnknownTraitsSetting,
        setFunc = PAWMenuFunctions.setJewelryIncludeUnknownTraitsSetting,
        disabled = PAWMenuFunctions.isJewelryIncludeUnknownTraitsDisabled,
        default = PAWMenuDefaults.Jewelry.autoMarkUnknownTraits,
    })
end





-- -----------------------------------------------------------------------------------------------------------------

local function _createPAWGlyphsSubMenu()

    PAWGlyphsSubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD, GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T, GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)),
        choices = PAWMenuChoices.qualityLevel,
        choicesValues = PAWMenuChoicesValues.qualityLevel,
        getFunc = PAWMenuFunctions.getGlyphsAutoMarkQualityTresholdSetting,
        setFunc = PAWMenuFunctions.setGlyphsAutoMarkQualityTresholdSetting,
        disabled = PAWMenuFunctions.isGlyphsAutoMarkQualityTresholdDisabled,
        default = PAWMenuDefaults.Miscellaneous.autoMarkGlyphQualityThreshold,
    })

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAWBlacksmithingSubMenu() 
    insertTheseMatsSettings(refinableMaterials.blacksmithing, PAWBlacksmithingSubMenu) 
end

local function _createPAWLightClothingSubMenu() 
    insertTheseMatsSettings(refinableMaterials.clothing.light, PAWLightClothingSubMenu) 
end 

local function _createPAWMediumClothingSubMenu() 
    insertTheseMatsSettings(refinableMaterials.clothing.medium, PAWMediumClothingSubMenu) 
end 

local function _createPAWWoodworkingSubMenu() 
    insertTheseMatsSettings(refinableMaterials.woodworking, PAWWoodworkingSubMenu) 
end 

local function _createPAWJewelryDustSubMenu() 
    insertTheseMatsSettings(refinableMaterials.jewelry.dust, PAWJewelryDustSubMenu) 
end

local function _createPAWJewelryTraitsSubMenu() 
    insertTheseMatsSettings(refinableMaterials.jewelry.traits, PAWJewelryTraitsSubMenu) 
end

local function _createPAWStyleMaterialsSubMenu() 
    insertTheseMatsSettings(refinableMaterials.styleMaterials, PAWStyleMaterialsSubMenu) 
end





local function _createPAWBlacksmithingResearchTraitSubMenu() 
    insertTheseResearchTraitSettings(CRAFTING_TYPE_BLACKSMITHING, PAWBlacksmithingResearchTraitSubMenu) 
end

local function _createPAWClothingResearchTraitSubMenu() 
    insertTheseResearchTraitSettings(CRAFTING_TYPE_CLOTHIER, PAWClothingResearchTraitSubMenu) 
end 

local function _createPAWWoodworkingResearchTraitSubMenu() 
    insertTheseResearchTraitSettings(CRAFTING_TYPE_WOODWORKING, PAWWoodworkingResearchTraitSubMenu) 
end 

local function _createPAWJewelryResearchTraitSubMenu() 
    insertTheseResearchTraitSettings(CRAFTING_TYPE_JEWELRYCRAFTING, PAWJewelryResearchTraitSubMenu) 
end

-- -----------------------------------------------------------------------------------------------------------------

local function createOptions()
    _createPAWorkerMenu()
	
    _createPAWWeaponsSubMenu()
    _createPAWArmorSubMenu()
    _createPAWJewelrySubMenu()
    _createPAWGlyphsSubMenu()
	
	_createPAWBlacksmithingSubMenu()
	_createPAWLightClothingSubMenu()
	_createPAWMediumClothingSubMenu()
	_createPAWWoodworkingSubMenu()
    _createPAWJewelryDustSubMenu()
	_createPAWJewelryTraitsSubMenu()
	_createPAWStyleMaterialsSubMenu()
	
	_createPAWBlacksmithingResearchTraitSubMenu()
	_createPAWClothingResearchTraitSubMenu()
	_createPAWWoodworkingResearchTraitSubMenu()
	_createPAWJewelryResearchTraitSubMenu()

    _createPAWorkerProfileSubMenuTable()


    PA.LAM2:RegisterAddonPanel("PersonalAssistantWorkerAddonOptions", PAWorkerPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantWorkerAddonOptions", PAWorkerOptionsTable)
end

-- =====================================================================================================================
-- Export
PA.Worker = PA.Worker or {}
PA.Worker.createOptions = createOptions
