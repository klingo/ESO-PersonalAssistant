-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PACOMenuChoices = PA.MenuChoices.choices.PAConsume
local PACOMenuChoicesValues = PA.MenuChoices.choicesValues.PAConsume
local PACOProfileManager = PA.ProfileManager.PAConsume
local PACOMenuDefaults = PA.MenuDefaults.PAConsume
local PACOMenuFunctions = PA.MenuFunctions.PAConsume
local PAHF = PA.HelperFunctions
local PASavedVars = PA.SavedVars

-- =====================================================================================================================

-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2

local PAConsumePanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.CONSUME,
    displayName = PACAddon.NAME_DISPLAY.CONSUME,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.CONSUME,
    slashCommand = "/paco",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAConsumeOptionsTable = setmetatable({}, { __index = table })

local PAConsumePoisonOptionsTable = setmetatable({}, { __index = table })
-- local PAConsumeProfileSubMenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPAConsumeMenu()
    -- PAConsumeOptionsTable:insert({
        -- type = "submenu",
        -- name = PACOProfileManager.getProfileSubMenuHeader,
        -- controls = PAConsumeProfileSubMenuTable
    -- })

    PAConsumeOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_CONSUME_DESCRIPTION),
    })

    PAConsumeOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_CONSUME_POISON_HEADER))
    })

    PAConsumeOptionsTable:insert({ 
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_CONSUME_POISON_ENABLE)),
		tooltip = GetString(SI_PA_MENU_CONSUME_POISON_ENABLE_T),
        getFunc = PACOMenuFunctions.getAutoConsumePoisonSetting,
        setFunc = PACOMenuFunctions.setAutoConsumePoisonSetting,
        disabled = PACOProfileManager.isNoProfileSelected,
        default = PACOMenuDefaults.autoConsumePoisonEnabled,
    })
	
    -- ---------------------------------------------------------------------------------------------------------
    PAConsumeOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_CONSUME_FOOD_HEADER))
    })
		
		
    
	PAConsumeOptionsTable:insert({
        type = "description",
        text = function()
		local foodLink = PASavedVars.ConsumeCharacter.foodLink
		local foodBuffIcon = ""
		local foodStacks = ""
		if PASavedVars.ConsumeCharacter.foodLink and PASavedVars.ConsumeCharacter.foodLink ~= "" then 
		     foodBuffIcon = zo_iconTextFormatNoSpace(GetItemLinkIcon(PASavedVars.ConsumeCharacter.foodLink),32,32,"")
             foodStacks = " x"..PA.Consume.GetBackpackInventory(PASavedVars.ConsumeCharacter.foodLink)
             			 
		else foodLink = GetString(SI_PA_CHAT_CONSUME_NO_FOOD)
		end
		    return GetString(SI_PA_MENU_CONSUME_CURRENT_FOOD_BUFF)..foodBuffIcon..foodLink..foodStacks
        end , 
		reference = "PERSONALASSISTANT_PACO_FOOD_DESC",
    })
	
		
	
	PAConsumeOptionsTable:insert({	
         type = "checkbox",
         name = GetString(SI_PA_MENU_CONSUME_TURN_OFF_FOOD),
         tooltip = GetString(SI_PA_MENU_CONSUME_TURN_OFF_FOOD_T),
         getFunc = function() return not PASavedVars.ConsumeCharacter.isAutoEatFood end,
         setFunc = function(value) PA.Consume.SetIsAutoEating(not value)  end, --PASavedVars.ConsumeCharacter.isAutoEatFood = not value 
         width = "full",
         disabled =  (not PASavedVars.ConsumeCharacter.foodLink) or not (PASavedVars.ConsumeCharacter.foodLink ~= ""),		 
    })	
	

    PAConsumeOptionsTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_CONSUME_USE_NUMBER_FOOD),
        tooltip = GetString(SI_PA_MENU_CONSUME_USE_NUMBER_FOOD_T),
        maxChars = 3,
        textType = TEXT_TYPE_NUMERIC,
        width = "full",
        getFunc = function() return PASavedVars.ConsumeCharacter.foodBufferSeconds end,
        setFunc = function(value) PA.Consume.SetFoodBufferSeconds(value) end,
        default = PACOMenuDefaults.foodBufferSeconds,
        reference = "PERSONALASSISTANT_PACO_FOOD_BUFFER",
    })


    -- ---------------------------------------------------------------------------------------------------------
    PAConsumeOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_CONSUME_EXP_HEADER))
    })


	PAConsumeOptionsTable:insert({
        type = "description",
        text = function()
		local EXPLink = PASavedVars.ConsumeCharacter.EXPLink
		local EXPBuffIcon = ""
		local EXPStacks = ""
		if PASavedVars.ConsumeCharacter.EXPLink and PASavedVars.ConsumeCharacter.EXPLink ~= "" then 
		     EXPBuffIcon = zo_iconTextFormatNoSpace(GetItemLinkIcon(PASavedVars.ConsumeCharacter.EXPLink),32,32,"") 
			 EXPStacks = " x"..PA.Consume.GetBackpackInventory(PASavedVars.ConsumeCharacter.EXPLink)
		else
		     EXPLink = GetString(SI_PA_CHAT_CONSUME_NO_EXP)
		end 
		    return GetString(SI_PA_MENU_CONSUME_CURRENT_EXP_BUFF)..EXPBuffIcon..EXPLink..EXPStacks
		end,
		reference = "PERSONALASSISTANT_PACO_EXP_DESC",
    })
	
	PAConsumeOptionsTable:insert({	
         type = "checkbox",
         name = GetString(SI_PA_MENU_CONSUME_TURN_OFF_EXP),
         tooltip = GetString(SI_PA_MENU_CONSUME_TURN_OFF_EXP_T),
         getFunc = function() return not PASavedVars.ConsumeCharacter.isAutoConsumeEXP end,
         setFunc = function(value) PA.Consume.SetIsAutoConsumingEXP(not value) end, -- PASavedVars.ConsumeCharacter.isAutoConsumeEXP = not value
         width = "full",
         disabled =  (not PASavedVars.ConsumeCharacter.EXPLink) or not (PASavedVars.ConsumeCharacter.EXPLink ~= ""),		 
    })
	


    PAConsumeOptionsTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_CONSUME_USE_NUMBER_EXP),
        tooltip = GetString(SI_PA_MENU_CONSUME_USE_NUMBER_EXP_T),
        maxChars = 3,
        textType = TEXT_TYPE_NUMERIC,
        width = "full",
        getFunc = function() return  math.abs(PASavedVars.ConsumeCharacter.EXPBufferSeconds) end,
        setFunc = function(value) value = 0-value PA.Consume.SetEXPBufferSeconds(value) end,
        default = PACOMenuDefaults.foodBufferSeconds,
        reference = "PERSONALASSISTANT_PACO_EXP_BUFFER",
    })


    -- ---------------------------------------------------------------------------------------------------------

    PAConsumeOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_OTHER_SETTINGS_HEADER))
    })

    PAConsumeOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PACOMenuFunctions.getSilentModeSetting,
        setFunc = PACOMenuFunctions.setSilentModeSetting,
        disabled = PACOMenuFunctions.isSilentModeDisabled,
        default = PACOMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPAConsumeProfileSubMenuTable()
    PAConsumeProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PACOProfileManager.getProfileList(),
        choicesValues = PACOProfileManager.getProfileListValues(),
        width = "half",
        getFunc = PACOProfileManager.getActiveProfile,
        setFunc = PACOProfileManager.setActiveProfile,
        reference = "PERSONALASSISTANT_CONSUME_PROFILEDROPDOWN"
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        maxChars = 40,
        width = "half",
        getFunc = PACOProfileManager.getActiveProfileName,
        setFunc = PACOProfileManager.setActiveProfileName,
        disabled = PACOProfileManager.isNoProfileSelected
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PACOProfileManager.createNewProfile,
        disabled = PACOProfileManager.hasMaxProfileCountReached
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = function() return not PACOProfileManager.hasMaxProfileCountReached() end
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PACOProfileManager.hasOnlyOneProfile() or PACOProfileManager.isNoProfileSelected() end,
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PACOProfileManager.getInactiveProfileList(),
        choicesValues = PACOProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Consume.selectedCopyProfile end,
        setFunc = function(value) PA.Consume.selectedCopyProfile = value end,
        disabled = function() return PACOProfileManager.hasOnlyOneProfile() or PACOProfileManager.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_Consume_PROFILEDROPDOWN_COPY"
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PACOProfileManager.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PACOProfileManager.isNoCopyProfileSelected
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PACOProfileManager.hasOnlyOneProfile
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PACOProfileManager.getInactiveProfileList(),
        choicesValues = PACOProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Consume.selectedDeleteProfile end,
        setFunc = function(value) PA.Consume.selectedDeleteProfile = value end,
        disabled = PACOProfileManager.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_Consume_PROFILEDROPDOWN_DELETE"
    })

    PAConsumeProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PACOProfileManager.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PACOProfileManager.isNoDeleteProfileSelected
    })
end

-- =================================================================================================================


local function createOptions()
    _createPAConsumeMenu()

    --_createPAConsumeProfileSubMenuTable()


    PA.LAM2:RegisterAddonPanel("PersonalAssistantConsumeAddonOptions", PAConsumePanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantConsumeAddonOptions", PAConsumeOptionsTable)
end

-- =====================================================================================================================
-- Export
PA.Consume = PA.Consume or {}
PA.Consume.createOptions = createOptions
