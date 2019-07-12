-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager
local PASVP = PA.SavedVarsPatcher

-- =====================================================================================================================
-- =====================================================================================================================

-- other settings
PA.AddonName = "PersonalAssistant"
PA.activeProfile = nil -- init with nil, is populated during [initAddon]

-- window states
PA.WindowStates = {
    isFenceClosed = true,
    isStoreClosed = true,
    isMailboxClosed = true,
    isBankClosed = true,
}

-- whether welcome message should be shown, or was already shown
local showWelcomeMessage = true

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local General_Defaults = {}
local Profile_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAJunk texts if silentMode is disabled
local function println(text, ...)
    PAHF.println(PAC.COLORED_TEXTS.PA, text, ...)
end

-- init default values
local function _initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PAGeneral
    General_Defaults.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        General_Defaults[profileNo] = PAMenuDefaults.PAGeneral
        General_Defaults[profileNo].name = PAHF.getDefaultProfileName(profileNo)
    end

    Profile_Defaults = {
        activeProfile = nil,
        debug = false,
    }
end

-- init player name and player alliance
local function _initPlayerNameAndAlliance()
    local playerName = GetUnitName("player")
    local numCharacters = GetNumCharacters()
    for index = 1, numCharacters do
        local name, _, _, _, _, alliance, _, _ = GetCharacterInfo(index)
        local nameFmt = zo_strformat(SI_UNIT_NAME, name)
        if playerName == nameFmt then
            PA.playerName = nameFmt
            PA.alliance = alliance
            break
        end
    end
end


-- init saved variables and register Addon
local function initAddon(_, addOnName)
    if addOnName ~= PA.AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_ADD_ON_LOADED, "AddonInit")

    -- initialize the default and player/alliance values
    _initDefaults()
    _initPlayerNameAndAlliance()

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.General = ZO_SavedVars:NewAccountWide("PersonalAssistant_SavedVariables", PACAddon.SAVED_VARS_VERSION.MAJOR.GENERAL, nil, General_Defaults)
    PASavedVars.Profile = ZO_SavedVars:NewCharacterNameSettings("PersonalAssistant_SavedVariables", PACAddon.SAVED_VARS_VERSION.MAJOR.PROFILE, nil, Profile_Defaults)

    -- get the active Profile and the debug setting
    PA.activeProfile = PASavedVars.Profile.activeProfile
    PA.debug = PASavedVars.Profile.debug

    -- create the options with LAM-2
    local PAMainMenu = PA.MainMenu
    PAMainMenu.createOptions()

    -- init the overall Rules Main Menu
    PA.CustomDialogs.initRulesMainMenu()

    -- register additional slash-commands for the custom rules
    SLASH_COMMANDS["/parules"] = function() PA.CustomDialogs.togglePARulesMenu() end

    -- register additional slash-commands for debugging
    SLASH_COMMANDS["/padebugon"] = function() PA.toggleDebug(true) end
    SLASH_COMMANDS["/padebugoff"] = function() PA.toggleDebug(false) end
    SLASH_COMMANDS["/palistevents"] = function() PAEM.listAllEventsInSet() end
    SLASH_COMMANDS["/padw"] = function() PA.DebugWindow.showStaticDebugInformationWindow() end
end


-- introduces the addon to the player
local function introduction()
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED, "Introduction")

    -- display debug window on login (if turned on)
    if PA.debug then
        PA.DebugWindow.showDebugOutputWindow()
    end

    if PA.activeProfile == nil then
        PA.println(SI_PA_WELCOME_PLEASE_SELECT_PROFILE)
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshAllSavedVarReferences(PA.activeProfile)
        -- then also all the events can be initialised
        PAEM.RefreshAllEventRegistrations()
        -- finally check for the welcome message
        local PAGSavedVars = PA.General.SavedVars
        if showWelcomeMessage and PAGSavedVars.welcome then
            showWelcomeMessage = false
            local currLanguage = GetCVar("language.2") or "en"
            if currLanguage ~= "en" and currLanguage ~= "de" and currLanguage ~= "fr" then
                PA.println(SI_PA_WELCOME_NO_SUPPORT, currLanguage)
            else
                PA.println(SI_PA_WELCOME_SUPPORT)
            end
        end
    end
end

-- wrapper method that prefixes the addon shortname
function PA.debugln(text, ...)
    local addonText = PAC.COLORED_TEXTS_DEBUG.PAG .. text
    PAHF.debugln(addonText, ...)
end

PAEM.RegisterForEvent(PA.AddonName, EVENT_ADD_ON_LOADED, initAddon, "AddonInit")
PAEM.RegisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED, introduction, "Introduction")
PAEM.RegisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED, PASVP.applyPatchIfNeeded, "SavedVarsPatcher")

-- =====================================================================================================================
-- Dev-Debug --
function PA.cursorPickup(type, param1, bagId, slotIndex, param4, param5, param6, itemSoundCategory)
    if PA.debug then
        local itemType, specializedItemType = GetItemType(bagId, slotIndex)
        local strItemType = GetString("SI_ITEMTYPE", itemType)
        local strSpecializedItemType = GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType)
        local stack, maxStack = GetSlotStackSize(bagId, slotIndex)
        -- local isSaved = ItemSaver.isItemSaved(bagId, slotIndex)
        local itemId = GetItemId(bagId, slotIndex)
        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
        local icon, _, _, _, _, _, itemStyleId = GetItemInfo(bagId, slotIndex)

        local bagName = ""
        if bagId == BAG_BACKPACK then bagName = "BAG_BACKPACK"
        elseif bagId == BAG_BANK then bagName = "BAG_BANK"
        elseif bagId == BAG_BUYBACK then bagName = "BAG_BUYBACK"
        elseif bagId == BAG_GUILDBANK then bagName = "BAG_GUILDBANK"
        elseif bagId == BAG_VIRTUAL then bagName = "BAG_VIRTUAL"
        elseif bagId == BAG_WORN then bagName = "BAG_WORN"
        elseif bagId == BAG_SUBSCRIBER_BANK then bagName = "BAG_SUBSCRIBER_BANK" end

        PAHF.println("", "itemType (%s): %s --> %s (%d/%d) --> itemId = %d --> specializedItemType (%s): %s || icon = [%s] || bag = [%s]", itemType, strItemType, itemLink, stack, maxStack, itemId, specializedItemType, strSpecializedItemType, icon, bagName)

        local canBeResearched = CanItemLinkBeTraitResearched(itemLink)
        local isBeingResearched = PA.Loot.isTraitBeingResearched(itemLink)
        local tradeskillType = GetItemLinkCraftingSkillType(itemLink)
        local numLines = GetNumSmithingResearchLines(tradeskillType)
        local traitType, traitDescription = GetItemLinkTraitInfo(itemLink)
        local craftingType, researchLineName = GetRearchLineInfoFromRetraitItem(bagId, slotIndex)
        local itemEquipType = GetItemLinkEquipType(itemLink)
        local isUnique = IsItemLinkUnique(itemLink)

        d("canBeResearched="..tostring(canBeResearched))
        d("isBeingResearched="..tostring(isBeingResearched))
        d("tradeskillType="..tostring(tradeskillType))
        d("numLines="..tostring(numLines))
        d("traitType="..tostring(traitType))
        d("traitDescription="..tostring(traitDescription))
        d("craftingType="..tostring(craftingType))
        d("researchLineName="..tostring(researchLineName))
        d("itemEquipType="..tostring(itemEquipType))
        d("isUnique="..tostring(isUnique))

        local itemStyle = GetItemLinkItemStyle(itemLink)
        local itemStyleName = GetItemStyleName(itemStyle)
        local isItemStyleKnown = IsSmithingStyleKnown(itemStyleId, 1)

        d("itemStyle="..tostring(itemStyle))
        d("itemStyleName="..tostring(itemStyleName))
        d("isItemStyleKnown="..tostring(isItemStyleKnown))

        local isBook = IsItemLinkBook(itemLink)
        local isPartOfCollection = IsItemLinkBookPartOfCollection(itemLink)
        local isKnown= IsItemLinkBookKnown(itemLink)

        d("isBook="..tostring(isBook))
        d("isPartOfCollection="..tostring(isPartOfCollection))
        d("isKnown="..tostring(isKnown))

        local flavorText = GetItemLinkFlavorText(itemLink)
        d("flavorText="..tostring(flavorText))

        local sellInformation = GetItemLinkSellInformation(itemLink)
        d("sellInformation="..GetString("SI_ITEMSELLINFORMATION", sellInformation).."("..sellInformation..")")

        local isItemFromCrownStore = IsItemFromCrownStore(bagId, slotIndex)
        d("isItemFromCrownStore="..tostring(isItemFromCrownStore))

        local isContainer = IsItemLinkContainer(itemLink)
        if isContainer then
            local containerCollectibleId = GetItemLinkContainerCollectibleId(itemLink)
            local name, description, icon, deprecatedLockedIcon, unlocked, purchasable, isActive, categoryType, hint = GetCollectibleInfo(containerCollectibleId)
            local isValidForPlayer = IsCollectibleValidForPlayer(containerCollectibleId)
            d("name="..tostring(name))
            d("description="..tostring(description))
            d("unlocked="..tostring(unlocked))
            d("isActive="..tostring(isActive))
            d("categoryType="..tostring(categoryType))
            d("hint="..tostring(hint))
            d("isValidForPlayer="..tostring(isValidForPlayer))
        end

        local numItemTags = GetItemLinkNumItemTags(itemLink)
        for itemTagIndex = 1, numItemTags do
            local itemTagDescription, itemTagCategory = GetItemLinkItemTagInfo(itemLink, itemTagIndex)
            d("itemTagDescription="..tostring(zo_strformat("<<1>>", itemTagDescription, 1)).."      itemTagCategory="..tostring(itemTagCategory))
        end

        local boundState = select(21, ZO_LinkHandler_ParseLink(itemLink))
        local isBound = IsItemLinkBound(itemLink)
        local isBOPAndTradeable = IsItemBoPAndTradeable(bagId, slotIndex)
        d("boundState="..tostring(boundState))
        d("isBound="..tostring(isBound))
        d("isBOPAndTradeable="..tostring(isBOPAndTradeable))
    end
end

function PA.toggleDebug(newStatus)
    -- check is needed to avoid endless loop (i.e. ESO crash)
    if PA.SavedVars.Profile.debug ~= newStatus then
        PA.SavedVars.Profile.debug = newStatus
        PA.debug = newStatus
        if newStatus then
            PA.DebugWindow.showDebugOutputWindow()
            if GetUnitName("player") == PACAddon.AUTHOR then
                PAEM.RegisterForEvent(PA.AddonName, EVENT_CURSOR_PICKUP, PA.cursorPickup, "CursorPickup")
            end
        else
            PA.DebugWindow.hideDebugOutputWindow()
            if GetUnitName("player") == PACAddon.AUTHOR then
                PAEM.UnregisterForEvent(PA.AddonName, EVENT_CURSOR_PICKUP, "CursorPickup")
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.println = println