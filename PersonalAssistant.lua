-- Addon: PersonalAssistant
-- Version: 1.2.2
-- Developer: Klingo

PA = {}

-- PA.colors
PA.colWhite = "|cFFFFFF"
PA.colYellow = "|cFFFF00"

-- default values
PA.General_Defaults = {}
PA.Repair_Defaults = {}
PA.Deposit_Defaults = {
	ItemTypes = {}
}
PA.Withdrawal_Defaults = {
	ItemTypes = {}
}

-- init saved variables and register Addon
function PA.initAddon(eventCode, addOnName)
    if addOnName ~= "PersonalAssistant" then
        return
    end
	
	-- initialize the default values
	PA.initDefaults()

	PA_SavedVars.General = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "General", PA.General_Defaults)
    PA_SavedVars.Repair = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 2, "Repair", PA.Repair_Defaults)
	PA_SavedVars.Deposit = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 2, "Deposit", PA.Deposit_Defaults)
--	PA_SavedVars.Withdrawal = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Withdrawal", PA.Withdrawal_Defaults)

	-- set the language
	PA_SavedVars.General.language = GetCVar("language.2") or "en" --returns "en", "de" or "fr"
	
	-- creates the (new) XML UI
--	PAUI.initUI()
	
	-- create the options with LAM
	PA_SettingsMenu.CreateOptions()

	-- register PARepair
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_STORE, PAR.OnShopOpen)
	
	-- register PADeposit
	EVENT_MANAGER:RegisterForEvent( "PersonalAssistant", EVENT_OPEN_BANK, PAD.OnBankOpen )
end

-- init default values
function PA.initDefaults()
	-- default values for Addon
	PA.General_Defaults.language = 1
	
	-- default values for PARepair
	PA.Repair_Defaults.enabled = true
	PA.Repair_Defaults.equipped = true
	PA.Repair_Defaults.equippedThreshold = 75
	PA.Repair_Defaults.backpack = false
	PA.Repair_Defaults.backpackThreshold = 75
    PA.Repair_Defaults.hideNoRepairMsg = false
    PA.Repair_Defaults.hideAllMsg = false
	
	-- default values for PADeposit
	PA.Deposit_Defaults.enabled = true
	PA.Deposit_Defaults.gold = true
	PA.Deposit_Defaults.depositPercentage = 50
	PA.Deposit_Defaults.depositStep = 1
	PA.Deposit_Defaults.depositInterval = 300
	PA.Deposit_Defaults.minGoldToKeep = 250
	PA.Deposit_Defaults.lastDeposit = 0
	PA.Deposit_Defaults.items = false
	PA.Deposit_Defaults.junk = false
    PA.Deposit_Defaults.hideNoDepositMsg = false
    PA.Deposit_Defaults.hideAllMsg = false
	
	-- default values for PAWithdraw
	PA.Withdrawal_Defaults.enabled = false
	PA.Withdrawal_Defaults.devDebug = false
	
	-- default values for ItemTypes (only prepare defaults for enabled itemTypes)
	-- deposit=true, withdrawal=false
	for i = 0, #PAItemTypes do
		if PAItemTypes[i] ~= "" then
			PA.Deposit_Defaults.ItemTypes[i] = false
			PA.Withdrawal_Defaults.ItemTypes[i] = false
		end
	end
	

end

-- returns the localized text for a key
function PA.getResourceMessage(key)
	if PA_SavedVars.General.language == "de" then
		return ResourceBundle.en[key]	-- always use "en" so far
	elseif PA_SavedVars.General.language == "fr" then
		return ResourceBundle.en[key]	-- always use "en" so far
	else
		return ResourceBundle.en[key]
	end
end

-- introduces the addon to the player
function PA.introduction()
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED)

	if PA_SavedVars.General.language ~= "en" then -- or vars.lang ~= "de" or vars.lang ~= "fr" then
		CHAT_SYSTEM:AddMessage(string.format(PA.colYellow .."P".. PA.colWhite.."ersonal"..PA.colYellow.."A"..PA.colWhite.."ssistant"..PA.colYellow.." at your service!   -   no localization for (%s) available yet.", PA_SavedVars.General.language))
	else
--	CHAT_SYSTEM:AddMessage(PA.colYellow .."P".. PA.colWhite.."ersonal"..PA.colYellow.."A"..PA.colWhite.."ssistant"..PA.colYellow.." at your service! Type '/pa' for GUI.")
	CHAT_SYSTEM:AddMessage(PA.colYellow .."P".. PA.colWhite.."ersonal"..PA.colYellow.."A"..PA.colWhite.."ssistant"..PA.colYellow.." at your service!")
	end
end

-- SLASH_COMMANDS["/pa"] = PAUI.toggleWindow

EVENT_MANAGER:RegisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED, PA.initAddon)
EVENT_MANAGER:RegisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED, PA.introduction)

-----------------------------------------------------------------------------------------------------
-- Dev-Debug --
function PA.cursorPickup(type, param1, param2, param3, param4, param5, param6, itemSoundCategory) 
	itemType = GetItemType(param2, param3) 
	strItemType = PA.getResourceMessage(itemType)
	CHAT_SYSTEM:AddMessage("itemType ("..itemType.."): "..strItemType)
end

-- EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CursorPickup", EVENT_CURSOR_PICKUP, PA.cursorPickup)