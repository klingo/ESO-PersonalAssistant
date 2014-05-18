-- Addon: PersonalAssistant
-- Version: 1.4.0
-- Developer: Klingo

PA = {}

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
	
	-- creates the (new) XML UI
--	PAUI.initUI()
	
	-- create the options with LAM
	PA_SettingsMenu.CreateOptions()

	-- register PARepair
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_STORE, PAR.OnShopOpen)
	
	-- register PABanking
	EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_BANK, PAB.OnBankOpen )
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
		return ResourceBundle.de[key]
	elseif PA_SavedVars.General.language == "fr" then
		return ResourceBundle.en[key]	-- always use "en" so far
	else
		return ResourceBundle.en[key]
	end
end

-- introduces the addon to the player
function PA.introduction()
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED)
	-- SLASH_COMMANDS["/pa"] = PAUI.toggleWindow
	
	if PA_SavedVars.General.language ~= "en" and PA_SavedVars.General.language ~= "de" then -- and PA_SavedVars.General.language ~= "fr" then
		PA.println("Welcome_NoSupport", PA_SavedVars.General.language)
	else
		PA.println("Welcome_Support", PA_SavedVars.General.language)
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
	CHAT_SYSTEM:AddMessage(string.format(text, unpack(args)))
	-- check this out: Singular & plural form using the zo_strformat() function 
	-- http://www.esoui.com/forums/showthread.php?p=7988
end

EVENT_MANAGER:RegisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED, PA.initAddon)
EVENT_MANAGER:RegisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED, PA.introduction)

-- ========================================================================================================================
-- Dev-Debug --
function PA.cursorPickup(type, param1, param2, param3, param4, param5, param6, itemSoundCategory) 
	itemType = GetItemType(param2, param3) 
	strItemType = PA.getResourceMessage(itemType)
	PA.println("itemType (%s): %s.", itemType, strItemType)
end

-- EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CursorPickup", EVENT_CURSOR_PICKUP, PA.cursorPickup)