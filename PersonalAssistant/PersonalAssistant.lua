-- Addon: PersonalAssistant
-- Developer: Klingo

PA = {}
PA.AddonVersion = "2.0.0"

-- globla indicators of whether some processing is ongoing
PA.isJunkProcessing = false

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


-- init saved variables and register Addon
function PA.initAddon(eventCode, addOnName)
    if addOnName ~= "PersonalAssistant" then
        return
    end
	
	-- initialize the default values
	PA.initDefaults()

	-- gets values from SavedVars, or initialises with default values
	PA.savedVars = {}

	PA.savedVars.General = ZO_SavedVars:NewAccountWide("PersonalAssistant_SavedVariables", 1, "General", PA.General_Defaults)
	PA.savedVars.Profiles = ZO_SavedVars:NewAccountWide("PersonalAssistant_SavedVariables", 1, "Profiles", PA.Profiles_Defaults)
	if PAR then PA.savedVars.Repair = PAR.savedVars end
	if PAB then PA.savedVars.Banking = PAB.savedVars end
	if PAL then PA.savedVars.Loot = PAL.savedVars end
	if PAJ then PA.savedVars.Junk = PAJ.savedVars end

	-- addon load complete - unregister event
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED)
end


-- init default values
function PA.initDefaults()
	for profileNo = 1, PAG_MAX_PROFILES do
		-- initialize the multi-profile structure

        -- -----------------------------------------------------
		-- default values for Addon
		PA.General_Defaults.activeProfile = 1
		PA.General_Defaults.savedVarsVersion = ""

        -- -----------------------------------------------------
		-- default values for PAGeneral
        PA.General_Defaults[profileNo] = {}
		PA.General_Defaults[profileNo].welcome = true

        -- -----------------------------------------------------
		-- default values for Profiles
        PA.Profiles_Defaults[profileNo] = {}
		PA.Profiles_Defaults[profileNo].name = MenuHelper.getDefaultProfileName(profileNo)
	end
end


-- introduces the addon to the player
function PA.introduction()
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED)
    -- SLASH_COMMANDS["/pa"] = PAUI.toggleWindow

    -- create the options with LAM-2
    PA_SettingsMenu.CreateOptions()

	if PA.savedVars.General[PA.savedVars.General.activeProfile].welcome then
		if PA.savedVars.General.language ~= "en" and PA.savedVars.General.language ~= "de" and PA.savedVars.General.language ~= "fr" then
			PAHF.println("Welcome_NoSupport", PA.savedVars.General.language)
		else
			PAHF.println("Welcome_Support", PA.savedVars.General.language)
		end
	end
end




EVENT_MANAGER:RegisterForEvent("PersonalAssistant_AddonLoaded", EVENT_ADD_ON_LOADED, PA.initAddon)
EVENT_MANAGER:RegisterForEvent("PersonalAssistant_PlayerActivated", EVENT_PLAYER_ACTIVATED, PA.introduction)


-- ========================================================================================================================
-- Dev-Debug --
function PA.cursorPickup(type, param1, bagId, slotIndex, param4, param5, param6, itemSoundCategory) 
	local itemType, specializedItemType = GetItemType(bagId, slotIndex)
	local strItemType = PALocale.getResourceMessage(itemType)
	local stack, maxStack = GetSlotStackSize(bagId, slotIndex)
	local isSaved = ItemSaver.isItemSaved(bagId, slotIndex)
	local itemId = GetItemId(bagId, slotIndex)
	PAHF.println("itemType (%s): %s. (special = %s) ---> (%d/%d) --> %s   (saved = %s | itemId = %d)", itemType, strItemType, specializedItemType, stack, maxStack, PAHF.getFormattedItemLink(bagId, slotIndex), tostring(isSaved), itemId)
end

-- EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CursorPickup", EVENT_CURSOR_PICKUP, PA.cursorPickup)