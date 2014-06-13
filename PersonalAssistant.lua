-- Addon: PersonalAssistant
-- Version: 1.5.0
-- Developer: Klingo

PA = {}
PA.AddonVersion = "1.5.0"

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

	-- set the language
	PA_SavedVars.General.language = GetCVar("language.2") or "en" --returns "en", "de" or "fr"
	
	-- creates the (new) XML UI - after a delay of one second
	zo_callLater(function() PAUI.initUI() end, 1000)
	
	-- create the options with LAM
	PA_SettingsMenu.CreateOptions()

	-- register PARepair
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_STORE, PAR.OnShopOpen)
	
	-- register PABanking
	EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_BANK, PAB.OnBankOpen)
	EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_CLOSE_BANK, PAB.OnBankClose)
	
	-- addon load complete - unregister event
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED)
end

-- init default values
function PA.initDefaults()
	-- default values for Addon
	PA.General_Defaults.language = 1
	PA.General_Defaults.welcome = true
	
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
	PA.Banking_Defaults.itemsTimerInterval = 300
	PA.Banking_Defaults.itemsJunkSetting = 0
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
		return ResourceBundle.de[key]
	elseif PA_SavedVars.General.language == "fr" then
		return ResourceBundle.fr[key]
	else
		return ResourceBundle.en[key]
	end
end

-- introduces the addon to the player
function PA.introduction()
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED)
	SLASH_COMMANDS["/pa"] = PAUI.toggleWindow
	
	if PA_SavedVars.General.welcome then
		if PA_SavedVars.General.language ~= "en" and PA_SavedVars.General.language ~= "de" and PA_SavedVars.General.language ~= "fr" then
			PA.println("Welcome_NoSupport", PA_SavedVars.General.language)
		else
			PA.println("Welcome_Support", PA_SavedVars.General.language)
		end
	end
end

-- returns a noun for the bagId
function PA.getBagName(bagId)
	if (bagId == BAG_WORN) then
		return PA.getResourceMessage("NS_Bag_Equipment")
	elseif (bagId == BAG_BACKPACK) then 
		return PA.getResourceMessage("NS_Bag_Backpack")
	elseif (bagId == BAG_BANK) then 
		return PA.getResourceMessage("NS_Bag_Bank")
	else
		return PA.getResourceMessage("NS_Bag_Unknown")
	end
end

-- returns an adjective for the bagId
function PA.getBagNameAdjective(bagId)
	if (bagId == BAG_WORN) then
		return PA.getResourceMessage("NS_Bag_Equipped")
	elseif (bagId == BAG_BACKPACK) then 
		return PA.getResourceMessage("NS_Bag_Backpacked")
	elseif (bagId == BAG_BANK) then 
		return PA.getResourceMessage("NS_Bag_Banked")
	else
		return PA.getResourceMessage("NS_Bag_Unknown")
	end
end

-- currently supports one text-key and n arguments
function PA.println(key, ...)
	local text = PA.getResourceMessage(key)
	if text == nil then text = key end
	local args = {...}
	local unpackedString = string.format(text, unpack(args))
	if (unpackedString == "") then
		unpackedString = key
	end
	CHAT_SYSTEM:AddMessage(unpackedString)
	-- check this out: Singular & plural form using the zo_strformat() function 
	-- http://www.esoui.com/forums/showthread.php?p=7988
end

EVENT_MANAGER:RegisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED, PA.initAddon)
EVENT_MANAGER:RegisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED, PA.introduction)

-- ========================================================================================================================
-- Dev-Debug --
function PA.cursorPickup(type, param1, bagId, slotIndex, param4, param5, param6, itemSoundCategory) 
	local itemType = GetItemType(bagId, slotIndex) 
	local strItemType = PA.getResourceMessage(itemType)
	local stack, maxStack = GetSlotStackSize(bagId, slotIndex)
	PA.println("itemType (%s): %s. ---> (%d/%d)", itemType, strItemType, stack, maxStack)
end

-- EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CursorPickup", EVENT_CURSOR_PICKUP, PA.cursorPickup)