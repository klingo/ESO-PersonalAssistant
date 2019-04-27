-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager
local PASVP = PA.SavedVarsPatcher

-- =====================================================================================================================
-- =====================================================================================================================

-- to enable certain debug statements (ingame: /padebugon & /padebugoff)
PA.debug = false

-- other settings
PA.AddonName = "PersonalAssistant"
PA.activeProfile = nil -- init with nil, is populated during [initAddon]

-- PABanking
PA.isBankClosed = true

-- whether welcome message should be shown, or was already shown
local showWelcomeMessage = true

-- init default values
local function _initDefaults()
    -- initialize the multi-profile structure
    PA.General_Defaults = {}
    -- -----------------------------------------------------
    -- default values for Addon
    PA.General_Defaults.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- -----------------------------------------------------
        -- default values for PAGeneral
        PA.General_Defaults[profileNo] = {
            name = PAHF.getDefaultProfileName(profileNo),
            welcome = true
        }
    end

    PA.Profile_Defaults = {
        activeProfile = nil,
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
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_ADD_ON_LOADED)

    -- initialize the default and player/alliance values
    _initDefaults()
    _initPlayerNameAndAlliance()

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.General = ZO_SavedVars:NewAccountWide("PersonalAssistant_SavedVariables", PACAddon.SAVED_VARS_VERSION.MAJOR.GENERAL, nil, PA.General_Defaults)
    PASavedVars.Profile = ZO_SavedVars:NewCharacterNameSettings("PersonalAssistant_SavedVariables", PACAddon.SAVED_VARS_VERSION.MAJOR.PROFILE, nil, PA.Profile_Defaults)

    -- create the options with LAM-2
    local PAMainMenu = PA.MainMenu
    PAMainMenu.createOptions()

    -- get the active Profile
    PA.activeProfile = PASavedVars.Profile.activeProfile

    -- register additional slash-commands (only for Addon author)
--    if GetUnitName("player") == PACAddon.AUTHOR then
        SLASH_COMMANDS["/padebugon"] = function() PA.toggleDebug(true) end
        SLASH_COMMANDS["/padebugoff"] = function() PA.toggleDebug(false) end
        SLASH_COMMANDS["/palistevents"] = function() PAEM.listAllEventsInSet() end
--    end
end


-- introduces the addon to the player
local function introduction()
    PAEM.UnregisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED)

    if PA.activeProfile == nil then
        PAHF.println(SI_PA_WELCOME_PLEASE_SELECT_PROFILE)
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
                PAHF.println(SI_PA_WELCOME_NO_SUPPORT, currLanguage)
            else
                PAHF.println(SI_PA_WELCOME_SUPPORT)
            end
        end
    end
end

PAEM.RegisterForEvent(PA.AddonName, EVENT_ADD_ON_LOADED, initAddon)
PAEM.RegisterForEvent(PA.AddonName, EVENT_PLAYER_ACTIVATED, introduction)
PAEM.RegisterForEvent(PACAddon.NAME_RAW.GENERAL, EVENT_PLAYER_ACTIVATED, PASVP.applyPatchIfNeeded, "SavedVarsPatcher")

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

        PAHF.println("itemType (%s): %s --> %s (%d/%d) --> itemId = %d --> specializedItemType (%s): %s || icon = [%s] || bag = [%s]", itemType, strItemType, itemLink, stack, maxStack, itemId, specializedItemType, strSpecializedItemType, icon, bagName)

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
    end
end

function PA.toggleDebug(newStatus)
    PA.debug = newStatus
    if newStatus then
        PAEM.RegisterForEvent(PA.AddonName, EVENT_CURSOR_PICKUP, PA.cursorPickup)
    else
        PAEM.UnregisterForEvent(PA.AddonName, EVENT_CURSOR_PICKUP)
    end
end