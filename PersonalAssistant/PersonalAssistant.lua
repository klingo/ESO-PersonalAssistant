-- Addon: PersonalAssistant
-- Developer: Klingo
-- ---------------------------------------------------------------------------------------------------------------------
if PA                               == nil then PA                              = {} end
if PA.savedVars                     == nil then PA.savedVars                    = {} end
if PA.savedVars.Profile             == nil then PA.savedVars.Profile            = {} end
if PA.savedVars.General             == nil then PA.savedVars.General            = {} end
if PA.savedVars.Repair              == nil then PA.savedVars.Repair             = {} end
if PA.savedVars.Banking             == nil then PA.savedVars.Banking            = {} end
if PA.savedVars.Banking.ItemTypes   == nil then PA.savedVars.Banking.ItemTypes  = {} end
if PA.savedVars.Loot                == nil then PA.savedVars.Loot               = {} end
if PA.savedVars.Junk                == nil then PA.savedVars.Junk               = {} end

PA.AddonName = "PersonalAssistant"
PA.AddonVersion = "2.0"

-- to enable certain debug statements (ingame: /padebugon & /padebugoff)
PA.debug = false

-- init default values
function PA.initDefaults()
    -- initialize the multi-profile structure
    PA.General_Defaults = {}
    -- -----------------------------------------------------
    -- default values for Addon
    PA.General_Defaults.savedVarsVersion = "200"
    for profileNo = 1, PAG_MAX_PROFILES do
        -- -----------------------------------------------------
        -- default values for PAGeneral
        PA.General_Defaults[profileNo] = {}
        PA.General_Defaults[profileNo].name = MenuHelper.getDefaultProfileName(profileNo)
        PA.General_Defaults[profileNo].welcome = true
    end
end


-- init saved variables and register Addon
function PA.initAddon(_, addOnName)
    if addOnName ~= PA.AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_ADD_ON_LOADED)

    -- initialize the default values
    PA.initDefaults()

    -- gets values from SavedVars, or initialises with default values
    PA.savedVars.General = ZO_SavedVars:NewAccountWide("PersonalAssistant_SavedVariables", 1, "General", PA.General_Defaults)
    PA.savedVars.Profile = ZO_SavedVars:New("PersonalAssistant_SavedVariables" , 1 , nil, { activeProfile = nil })

    -- initialize language
    PA.savedVars.Profile.language = GetCVar("language.2") or "en"
end


-- introduces the addon to the player
function PA.introduction()
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED)
    SLASH_COMMANDS["/padebugon"] = function() PA.toggleDebug(true) end
    SLASH_COMMANDS["/padebugoff"] = function() PA.toggleDebug(false) end
    SLASH_COMMANDS["/palistevents"] = function() PAEM.listAllEventsInSet() end
    SLASH_COMMANDS["/paflushlog"] = function() PALogger.flush() end

    --SLASH_COMMANDS["/pa"] = PAUI.toggleWindow

    -- create the options with LAM-2
    PA_SettingsMenu.CreateOptions()

    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil) then
        PAHF.println("Welcome_PleaseSelectProfile")
    else
        if PA.savedVars.General[activeProfile].welcome then
            if PA.savedVars.Profile.language ~= "en" and PA.savedVars.Profile.language ~= "de" and PA.savedVars.Profile.language ~= "fr" then
                PAHF.println("Welcome_NoSupport", GetCVar("language.2"))
            else
                PAHF.println("Welcome_Support")
            end
        end
    end
end

PAEM.RegisterForEvent(PA.AddonName, EVENT_ADD_ON_LOADED, PA.initAddon)
PAEM.RegisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED, PA.introduction)


-- ========================================================================================================================
-- Dev-Debug --
function PA.cursorPickup(type, param1, bagId, slotIndex, param4, param5, param6, itemSoundCategory)
    if (PA.debug) then
        local itemType, specializedItemType = GetItemType(bagId, slotIndex)
        local strItemType = PALocale.getResourceMessage(itemType)
        local stack, maxStack = GetSlotStackSize(bagId, slotIndex)
        -- local isSaved = ItemSaver.isItemSaved(bagId, slotIndex)
        local itemId = GetItemId(bagId, slotIndex)

        PAHF.println("itemType (%s): %s --> %s (%d/%d) --> itemId = %d --> specializedItemType = %s", itemType, strItemType, PAHF.getFormattedItemLink(bagId, slotIndex), stack, maxStack, itemId, specializedItemType)
    end
end

function PA.toggleDebug(newStatus)
    PA.debug = newStatus
    if (newStatus) then
        PAEM.RegisterForEvent(PA.AddonName, EVENT_CURSOR_PICKUP, PA.cursorPickup)
    else
        PAEM.UnregisterForEvent(PA.AddonName, EVENT_CURSOR_PICKUP)
    end
end