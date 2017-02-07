-- Addon: PersonalAssistant
-- Developer: Klingo

PA = {}
PA.AddonVersion = "1.6.0"

-- 1.3.3 fix
-- http://www.esoui.com/forums/showthread.php?t=2054
-- http://www.esoui.com/forums/showthread.php?t=1944

-- TODO:
-- Update Currency System: https://forums.elderscrollsonline.com/en/discussion/200789/imperial-city-api-patch-notes-change-log-live/p1
-- Support Virtual Bags: https://forums.elderscrollsonline.com/en/discussion/261946/dark-brotherhood-api-patch-notes-change-log-pts
-- Support Specialized Item Types: https://forums.elderscrollsonline.com/en/discussion/261946/dark-brotherhood-api-patch-notes-change-log-pts

-- default values
PA.General_Defaults = {}
PA.Profiles_Defaults = {}
PA.Repair_Defaults = {}
PA.Banking_Defaults = {}
PA.Loot_Defaults = {}

-- init saved variables and register Addon
function PA.initAddon(eventCode, addOnName)
    if addOnName ~= "PersonalAssistant" then
        return
    end
	
	-- initialize the default values
	PA.initDefaults()

	-- gets values from SavedVars, or initialises with default values
	PA_SavedVars.General = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "General", PA.General_Defaults)
	PA_SavedVars.Profiles = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Profiles", PA.Profiles_Defaults)
    PA_SavedVars.Repair = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 2, "Repair", PA.Repair_Defaults)
	PA_SavedVars.Banking = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 2, "Banking", PA.Banking_Defaults)
    PA_SavedVars.Loot = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Loot", PA.Loot_Defaults)

	-- set the language
	PA_SavedVars.General.language = GetCVar("language.2") or "en" --returns "en", "de" or "fr"
	
	-- fix/update saved vars changes since last version
	SVC.updateSavedVars()
	
	-- create the options with LAM-2
	PA_SettingsMenu.CreateOptions()

	-- register PARepair
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_STORE, PAR.OnShopOpen)
	
	-- register PABanking
	EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_BANK, PAB.OnBankOpen)
	EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_CLOSE_BANK, PAB.OnBankClose)

    -- register PALoot
    ZO_PreHookHandler(RETICLE.interact, "OnEffectivelyShown", PALo.OnReticleTargetChanged)
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_LOOT_UPDATED, PALo.OnLootUpdated)
	
	-- add hook for contextMenu modification
	-- ZO_PreHook("ZO_InventorySlot_ShowContextMenu", PAJ.AddContextMenuOption)
	
	-- addon load complete - unregister event
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED)
end

-- init default values
function PA.initDefaults()
	for profileNo = 1, PAG_MAX_PROFILES do
		-- initialize the multi-profile structure
		PA.General_Defaults[profileNo] = {}
		PA.Profiles_Defaults[profileNo] = {}
		PA.Repair_Defaults[profileNo] = {}
		PA.Banking_Defaults[profileNo] = {
			ItemTypes = {},
			ItemTypesAdvanced = {}
		}
		for itemTypeAdvancedNo = 0, #PAItemTypesAdvanced do	-- amount of advanced item types
			PA.Banking_Defaults[profileNo].ItemTypesAdvanced[itemTypeAdvancedNo] = {
				Key = {},
				Value = {}
			}
        end
        PA.Loot_Defaults[profileNo] = {
            ItemTypes = {}
        }

		-- default values for Addon
		PA.General_Defaults.language = 1
		PA.General_Defaults.activeProfile = 1
		PA.General_Defaults.savedVarsVersion = ""
		
		-- default values for PAGeneral
		PA.General_Defaults[profileNo].welcome = true
		
		-- default values for Profiles
		PA.Profiles_Defaults[profileNo].name = MenuHelper.getDefaultProfileName(profileNo)
		
		-- default values for PARepair
		PA.Repair_Defaults[profileNo].enabled = true
		PA.Repair_Defaults[profileNo].equipped = true
		PA.Repair_Defaults[profileNo].equippedThreshold = 75
		PA.Repair_Defaults[profileNo].backpack = false
		PA.Repair_Defaults[profileNo].backpackThreshold = 75
		PA.Repair_Defaults[profileNo].hideNoRepairMsg = false
		PA.Repair_Defaults[profileNo].hideAllMsg = false
		
		-- default values for PABanking
		PA.Banking_Defaults[profileNo].enabled = true
		PA.Banking_Defaults[profileNo].gold = true
		PA.Banking_Defaults[profileNo].goldDepositInterval = 300
		PA.Banking_Defaults[profileNo].goldDepositPercentage = 50
		PA.Banking_Defaults[profileNo].goldTransactionStep = "1"
		PA.Banking_Defaults[profileNo].goldMinToKeep = 250
		PA.Banking_Defaults[profileNo].goldWithdraw = false
		PA.Banking_Defaults[profileNo].goldLastDeposit = 0
		PA.Banking_Defaults[profileNo].items = false
		PA.Banking_Defaults[profileNo].itemsDepStackType = PAB_STACKING_FULL
		PA.Banking_Defaults[profileNo].itemsWitStackType = PAB_STACKING_FULL
		PA.Banking_Defaults[profileNo].itemsTimerInterval = 300
		PA.Banking_Defaults[profileNo].itemsJunkSetting = PAC_ITEMTYPE_IGNORE
		PA.Banking_Defaults[profileNo].hideNoDepositMsg = false
		PA.Banking_Defaults[profileNo].hideAllMsg = false

		-- default values for ItemTypes (only prepare defaults for enabled itemTypes)
		-- deposit=true, withdrawal=false
		for i = 0, #PAItemTypes do
			if PAItemTypes[i] ~= "" then
				PA.Banking_Defaults[profileNo].ItemTypes[i] = 0
			end
		end
		
		-- default values for advanced ItemTypes
		PA.Banking_Defaults[profileNo].ItemTypesAdvanced[0].Key = PAC_OPERATOR_NONE		-- 0 = Lockpick
		PA.Banking_Defaults[profileNo].ItemTypesAdvanced[0].Value = 100					-- 0 = Lockpick

		-- default values for PALoot
        PA.Loot_Defaults[profileNo].enabled = false
        PA.Loot_Defaults[profileNo].lootGold = true
        PA.Loot_Defaults[profileNo].lootItems = true
        PA.Loot_Defaults[profileNo].hideItemLootMsg = false
        PA.Loot_Defaults[profileNo].hideGoldLootMsg = false
        PA.Loot_Defaults[profileNo].hideAllMsg = false

        -- default values for ItemTypes (only prepare defaults for enabled itemTypes)
        -- auto-loot=true, ignore=false
        for i = 1, #PALoItemTypes do
            if PALoItemTypes[i] ~= "" then
                PA.Loot_Defaults[profileNo].ItemTypes[PALoItemTypes[i]] = 0
            end
        end
	end
end

-- introduces the addon to the player
function PA.introduction()
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED)
--	SLASH_COMMANDS["/pa"] = PAUI.toggleWindow
	
	if PA_SavedVars.General[PA_SavedVars.General.activeProfile].welcome then
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
		return PAL.getResourceMessage("NS_Bag_Equipment")
	elseif (bagId == BAG_BACKPACK) then 
		return PAL.getResourceMessage("NS_Bag_Backpack")
	elseif (bagId == BAG_BANK) then 
		return PAL.getResourceMessage("NS_Bag_Bank")
	else
		return PAL.getResourceMessage("NS_Bag_Unknown")
	end
end

-- returns an adjective for the bagId
function PA.getBagNameAdjective(bagId)
	if (bagId == BAG_WORN) then
		return PAL.getResourceMessage("NS_Bag_Equipped")
	elseif (bagId == BAG_BACKPACK) then 
		return PAL.getResourceMessage("NS_Bag_Backpacked")
	elseif (bagId == BAG_BANK) then 
		return PAL.getResourceMessage("NS_Bag_Banked")
	else
		return PAL.getResourceMessage("NS_Bag_Unknown")
	end
end

-- returns a fixed/formatted ItemLink
function PA.getFormattedItemLink(bagId, slotIndex)
	local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
	if itemLink == "" then return end
 
	local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(bagId, slotIndex))
	local itemData = itemLink:match("|H.-:(.-)|h")
 
	return zo_strformat(SI_TOOLTIP_ITEM_NAME, (("|H%s:%s|h[%s]|h"):format(LINK_STYLE_BRACKETS, itemData, itemName)))
end

-- currently supports one text-key and n arguments
function PA.println(key, ...)
	local text = PAL.getResourceMessage(key)
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
	local strItemType = PAL.getResourceMessage(itemType)
	local stack, maxStack = GetSlotStackSize(bagId, slotIndex)
	local isSaved = ItemSaver.isItemSaved(bagId, slotIndex)
	PA.println("itemType (%s): %s. ---> (%d/%d) --> %s   (saved = %s)", itemType, strItemType, stack, maxStack, PA.getFormattedItemLink(bagId, slotIndex), tostring(isSaved))
end

-- EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CursorPickup", EVENT_CURSOR_PICKUP, PA.cursorPickup)