-- Addon: PersonalAssistant
-- Version: 1.3.0
-- Developer: Klingo

PA = {}

-- PA.colors
PA.colWhite = "|cFFFFFF"
PA.colYellow = "|cFFFF00"

-- default values
PA.General_Defaults = {}
PA.Repair_Defaults = {}
PA.Banking_Defaults = {
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
	PA_SavedVars.Banking = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Banking", PA.Banking_Defaults)
	
	-- clears old saved variables!
	PA_SavedVars.Deposit = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 3, "Deposit", nil)
	PA_SavedVars.Withdrawal = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 2, "Withdrawal", nil)

	-- set the language
	PA_SavedVars.General.language = GetCVar("language.2") or "en" --returns "en", "de" or "fr"
	
	-- creates the (new) XML UI
--	PAUI.initUI()
	
	-- create the options with LAM
	PA_SettingsMenu.CreateOptions()

	-- register PARepair
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_STORE, PAR.OnShopOpen)
	
	-- register PABanking
	EVENT_MANAGER:RegisterForEvent( "PersonalAssistant", EVENT_OPEN_BANK, PAB.OnBankOpen )
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
	
	-- default values for PABanking
	PA.Banking_Defaults.enabled = true
	PA.Banking_Defaults.gold = true
	PA.Banking_Defaults.goldDepositInterval = 300
	PA.Banking_Defaults.goldDepositPercentage = 50
	PA.Banking_Defaults.goldTransactionStep = 1
	PA.Banking_Defaults.goldMinToKeep = 250
	PA.Banking_Defaults.goldWithdraw = false
	PA.Banking_Defaults.goldLastDeposit = 0
	PA.Banking_Defaults.items = false
	PA.Banking_Defaults.openHirelingChest = false
	PA.Banking_Defaults.itemsIncludeJunk = false
    PA.Banking_Defaults.hideNoDepositMsg = false
    PA.Banking_Defaults.hideAllMsg = false

	-- default values for ItemTypes (only prepare defaults for enabled itemTypes)
	-- deposit=true, withdrawal=false
	for i = 0, #PAItemTypes do
		if PAItemTypes[i] ~= "" then
			PA.Banking_Defaults.ItemTypes[i] = 0
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

-- returns a name for the bagId; there might be pre-defined namespaces?
function PA.getBagName(bagId)
	if (bagId == BAG_WORN) then
		return "equipped"
	elseif (bagId == BAG_BACKPACK) then 
		return "backpack"
	elseif (bagId == BAG_BANK) then 
		return "bank"
	else
		return "unknown"
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