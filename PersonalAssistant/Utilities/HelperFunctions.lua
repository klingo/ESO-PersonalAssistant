-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
-- ---------------------------------------------------------------------------------------------------------------------

-- =================================================================================================================
-- == MATH / TABLE FUNCTIONS == --
-- -----------------------------------------------------------------------------------------------------------------

---@param num number the number to be rounded down
---@param numDecimalPlaces number the number of decimal places to be rounded down to (defualt = 0)
---@return number the rounded down number
local function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

---@param num number the number to be rounded down (to 0 decimal places)
---@return number the rounded down number
local function roundDown(num)
    if num > 0 then
        return math.floor(num)
    elseif num < 0 then
        return math.ceil(num)
    else
        return num
    end
end

---@param table table any table
---@param value string|number the value that might be in the table
---@return boolean whether the value exists in the table
local function isValueInTable(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

---@param table table any table
---@param key string|number the key that might in the table
---@return boolean whether the key exists in the table
local function isKeyInTable(table, key)
    if table ~= nil then
        for k in pairs(table) do
            if k == key then
                return true
            end
        end
    end
    return false
end


-- =================================================================================================================
-- == ITEM IDENTIFIERS == --
-- -----------------------------------------------------------------------------------------------------------------
-- All credits go to sirinsidiator for below ItemIdentifier code from AGS!

local _hasItemTypeDifferentQualities = {
    [ITEMTYPE_GLYPH_ARMOR] = true,
    [ITEMTYPE_GLYPH_JEWELRY] = true,
    [ITEMTYPE_GLYPH_WEAPON] = true,
    [ITEMTYPE_DRINK] = true,
    [ITEMTYPE_FOOD] = true,
}

--- itemId is basically what tells us that two items are the same thing,
--- but some types need additional data to determine if they are of the same strength (and value).
---@param itemLink string the itemLink of an ESO item
---@return string the paItemId of the provided item
local function getPAItemLinkIdentifier(itemLink)
    local itemType = GetItemLinkItemType(itemLink)
    local data = {zo_strsplit(":", itemLink:match("|H(.-)|h.-|h"))}
    local itemId = GetItemLinkItemId(itemLink)
    local level = GetItemLinkRequiredLevel(itemLink)
    local cp = GetItemLinkRequiredChampionPoints(itemLink)
    if(itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR) then
        local trait = GetItemLinkTraitInfo(itemLink)
        return string.format("%s,%s,%d,%d,%d", itemId, data[4], trait, level, cp)
    elseif(itemType == ITEMTYPE_POISON or itemType == ITEMTYPE_POTION) then
        return string.format("%s,%d,%d,%s", itemId, level, cp, data[23])
    elseif(_hasItemTypeDifferentQualities[itemType]) then
        return string.format("%s,%s", itemId, data[4])
    else
        return tostring(itemId)
    end
end

---@param bagId number the id of the bag
---@param slotIndex number the id of slot within the bag
---@return string the paItemId of the provided item
local function getPAItemIdentifier(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
    return getPAItemLinkIdentifier(itemLink)
end

---@param itemData table the itemData table of an ESO item
---@return string the paItemId of the provided item
local function getPAItemIdentifierFromItemData(itemData)
    if not itemData.paItemId then
        itemData.paItemId = getPAItemIdentifier(itemData.bagId, itemData.slotIndex)
    end
    return itemData.paItemId
end



-- =================================================================================================================
-- == COMPARATORS == --
-- -----------------------------------------------------------------------------------------------------------------

---@param itemData table the itemData table of an ESO item
---@return boolean whether the item is characterBound or not
local function _isItemCharacterBound(itemData)
    if itemData.isPACharacterBound == nil then
        local isBound = IsItemBound(itemData.bagId, itemData.slotIndex)
        local bindType = GetItemBindType(itemData.bagId, itemData.slotIndex)
        itemData.isPACharacterBound = isBound and (bindType == BIND_TYPE_ON_PICKUP_BACKPACK)
    end
    return itemData.isPACharacterBound
end

---@param combinedLists table a complex list of holidayWrits, itemTypes, surveyMaps, itemTraitTypes, masterWritCraftingTypes, specializedItemTypes, learnableKnowItemTypes and learnableUnknownItemTypes
---@param excludeJunk boolean whether junk items should be excluded
---@return fun(itemData: table) a comparator function that only returns item that match the complex list and pass the junk-test
local function getCombinedItemTypeSpecializedComparator(combinedLists, excludeJunk)
    local function _isItemOfItemTypeAndKnowledge(itemType, itemLink, expectedItemType, expectedIsKnown)
        if itemType == expectedItemType then
            if itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then
                local isBook = IsItemLinkBook(itemLink)
                if isBook then
                    local isKnown = IsItemLinkBookKnown(itemLink)
                    if isKnown == expectedIsKnown then return true end
                end
            elseif itemType == ITEMTYPE_RECIPE then
                local isRecipeKnown = IsItemLinkRecipeKnown(itemLink)
                if isRecipeKnown == expectedIsKnown then return true end
            end
        end
        return false
    end

    local _WRIT_ICON_TABLE_CRAFTING_TYPE = {
        ["/esoui/art/icons/master_writ_blacksmithing.dds"] = CRAFTING_TYPE_BLACKSMITHING,
        ["/esoui/art/icons/master_writ_clothier.dds"] = CRAFTING_TYPE_CLOTHIER,
        ["/esoui/art/icons/master_writ_woodworking.dds"] = CRAFTING_TYPE_WOODWORKING,
        ["/esoui/art/icons/master_writ_jewelry.dds"] = CRAFTING_TYPE_JEWELRYCRAFTING,
        ["/esoui/art/icons/master_writ_alchemy.dds"] = CRAFTING_TYPE_ALCHEMY,
        ["/esoui/art/icons/master_writ_enchanting.dds"] = CRAFTING_TYPE_ENCHANTING,
        ["/esoui/art/icons/master_writ_provisioning.dds"] = CRAFTING_TYPE_PROVISIONING,
    }

    local function _getCraftingTypeFromWritItemLink(itemType, specializedItemType, itemLink)
        if itemType == ITEMTYPE_MASTER_WRIT and specializedItemType == SPECIALIZED_ITEMTYPE_MASTER_WRIT then
            local icon = GetItemLinkInfo(itemLink)
            return _WRIT_ICON_TABLE_CRAFTING_TYPE[icon] or CRAFTING_TYPE_INVALID
        end
        return nil
    end

    return function(itemData)
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if _isItemCharacterBound(itemData) then return false end
        local itemId = GetItemId(itemData.bagId, itemData.slotIndex)
        local itemType, specializedItemType = GetItemType(itemData.bagId, itemData.slotIndex)
        if specializedItemType == SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT then
            for _, specializedItemType in pairs(combinedLists.holidayWrits) do
                if specializedItemType == itemData.specializedItemType then return true end
            end
        end
        for _, itemType in pairs(combinedLists.itemTypes) do
            if itemType == itemData.itemType then return true end
        end
        if specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT then
            for _, itemFilterType in pairs(combinedLists.surveyMaps) do
                if isValueInTable(PAC.BANKING_ADVANCED.SPECIALIZED.SURVEY_REPORTS[itemFilterType], itemId) then return true end
            end
        end
        local itemTraitType = GetItemTrait(itemData.bagId, itemData.slotIndex)
        for _, expectedItemTraitType in pairs(combinedLists.itemTraitTypes) do
            if expectedItemTraitType == itemTraitType then return true end
        end
        -- calculating the ItemLink is very expensive - only do it at the end when everything else was already checked
        if not itemData.itemLink then itemData.itemLink = GetItemLink(itemData.bagId, itemData.slotIndex) end
        if specializedItemType == SPECIALIZED_ITEMTYPE_MASTER_WRIT then
            local craftingType = _getCraftingTypeFromWritItemLink(itemType, specializedItemType, itemData.itemLink)
            for _, expectedCraftingType in pairs(combinedLists.masterWritCraftingTypes) do
                if expectedCraftingType == craftingType then return true end
            end
        end
        if not IsItemLinkContainer(itemData.itemLink) then
            for _, specializedItemType in pairs(combinedLists.specializedItemTypes) do
                if specializedItemType == itemData.specializedItemType then return true end
            end
        end
        for _, expectedItemType in pairs(combinedLists.learnableKnownItemTypes) do
           if _isItemOfItemTypeAndKnowledge(itemType, itemData.itemLink, expectedItemType, true) then return true end
        end
        for _, expectedItemType in pairs(combinedLists.learnableUnknownItemTypes) do
            if _isItemOfItemTypeAndKnowledge(itemType, itemData.itemLink, expectedItemType, false) then return true end
        end
        return false
    end
end

---@param itemTypeList table a list of itemTypes to be checked
---@param excludeJunk boolean whether junk items should be excluded
---@return fun(itemData: table) a comparator function that only returns item that match the itemTypes and pass the junk-test
local function getItemTypeComparator(itemTypeList, excludeJunk)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData) then return false end
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end

---@param itemIdList table a list of itemIds to be checked
---@param excludeJunk boolean whether junk items should be excluded
---@return fun(itemData: table) a comparator function that only returns item that match the itemIdList and pass the junk-test
local function getItemIdComparator(itemIdList, excludeJunk)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData) then return false end
        local itemId = GetItemId(itemData.bagId, itemData.slotIndex)
        for expectedItemId, _ in pairs(itemIdList) do
            if expectedItemId == itemId then return true end
        end
        return false
    end
end

---@param paItemIdList table a list of paItemIds to be checked
---@param excludeJunk boolean whether junk items should be excluded
---@return fun(itemData: table) a comparator function that only returns item that match the paItemIdList and pass the junk-test
local function getPAItemIdComparator(paItemIdList, excludeJunk)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData) then return false end
        local paItemId = itemData.paItemId or getPAItemIdentifierFromItemData(itemData)
        for expectedPAItemId, _ in pairs(paItemIdList) do
            if expectedPAItemId == paItemId then return true end
        end
        return false
    end
end

---@return fun(itemData: table) a comparator function that only returns stolen junk items
local function getStolenJunkComparator()
    return function(itemData)
        if _isItemCharacterBound(itemData) then return false end
        local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
        local isJunk = IsItemJunk(itemData.bagId, itemData.slotIndex)
        return isStolen and isJunk
    end
end


-- =================================================================================================================
-- == PLAYER STATES == --
-- -----------------------------------------------------------------------------------------------------------------

---@return boolean whether the player is currently dead
local function isPlayerDead()
    return IsUnitDead("player")
end

---@return boolean whether the player is currently dead or reincarnating
local function isPlayerDeadOrReincarnating()
   return IsUnitDeadOrReincarnating("player")
end

---@return string, string the applicable bank bags of the player based on the ESO Plus Subscriber situation
local function getBankBags()
    if IsESOPlusSubscriber() then
        return BAG_BANK, BAG_SUBSCRIBER_BANK
    else
        return BAG_BANK
    end
end


-- =================================================================================================================
-- == TEXT / NUMBER TRANSFORMATIONS == --
-- -----------------------------------------------------------------------------------------------------------------
--- returns a noun for the bagId
---@param bagId number the id of the bag
---@return string the name of the bag
local function getBagName(bagId)
    if bagId == BAG_WORN then
        return GetString(SI_PA_NS_BAG_EQUIPMENT)
    elseif bagId == BAG_BACKPACK then
        return GetString(SI_PA_NS_BAG_BACKPACK)
    elseif bagId == BAG_BANK then
        return GetString(SI_PA_NS_BAG_BANK)
    elseif bagId == BAG_SUBSCRIBER_BANK then
        return GetString(SI_PA_NS_BAG_SUBSCRIBER_BANK)
    elseif bagId == BAG_VIRTUAL then
        return GetString(SI_PA_NS_BAG_VIRTUAL)
    elseif bagId == BAG_HOUSE_BANK_ONE or bagId == BAG_HOUSE_BANK_TWO or bagId == BAG_HOUSE_BANK_THREE or bagId == BAG_HOUSE_BANK_FOUR
        or bagId == BAG_HOUSE_BANK_FIVE or bagId == BAG_HOUSE_BANK_SIX or bagId == BAG_HOUSE_BANK_SEVEN or bagId == BAG_HOUSE_BANK_EIGHT
        or bagId == BAG_HOUSE_BANK_NINE or bagId == BAG_HOUSE_BANK_TEN then
        return GetString(SI_PA_NS_BAG_HOUSE_BANK)
    else
        return GetString(SI_PA_NS_BAG_UNKNOWN)
    end
end


-- =================================================================================================================
-- == TEXT FORMATTING AND OUTPUT == --
-- -----------------------------------------------------------------------------------------------------------------

---- Formats the provided currency amount with an icon based on the type
---@param currencyAmount number the amount that should be formatted (can be negative)
---@param currencyType string the type of currency (default = CURT_MONEY)
---@param noColor boolean if set to true the amount-text will not be colored (default = false)
---@return string the formatted text with currency icon
local function getFormattedCurrency(currencyAmount, currencyType, noColor)
    local currencyType = currencyType or CURT_MONEY
    local noColor = noColor or false
    local formatType = ZO_CURRENCY_FORMAT_AMOUNT_ICON
    local extraOptions = {}
    if currencyAmount < 0 then
        -- negative amount
        if not noColor then formatType = ZO_CURRENCY_FORMAT_ERROR_AMOUNT_ICON end
        currencyAmount = currencyAmount * -1 -- need to make it a positive number again
    else
        -- positive amount
        if not noColor then extraOptions = { color = PAC.COLOR.GREEN } end
    end
    return zo_strformat(SI_NUMBER_FORMAT, ZO_Currency_FormatKeyboard(currencyType, currencyAmount, formatType, extraOptions))
end

--- Formats the provided currency amount without icon based on the type
---@param currencyAmount string the amount that should be formatted
---@param currencyType string the type of currency (default = CURT_MONEY)
---@return string the formatted text text without currency icon
---@return string the formatted currency (amount + type)
local function getFormattedCurrencySimple(currencyAmount, currencyType)
    local currencyType = currencyType or CURT_MONEY
    if currencyAmount < 0 then currencyAmount = currencyAmount * -1 end  -- need to make it a positive number again
    local currencyAmountFmt = zo_strformat(SI_NUMBER_FORMAT, ZO_LocalizeDecimalNumber(currencyAmount))
    return PAC.COLOR.CURRENCIES[currencyType]:Colorize(currencyAmountFmt)
end

--- returns a fixed/formatted ItemLink
--- needed as the regular GetItemLink sometimes(?) returns lower-case only texts
---@param bagId number the id of the bag
---@param slotIndex number the id of the slot within the
---@return string the formatted itemLink
local function getFormattedItemLink(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
    if itemLink == "" then return "[unknown]" end
    local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(bagId, slotIndex))
    local itemData = itemLink:match("|H.-:(.-)|h")
    return zo_strformat(SI_TOOLTIP_ITEM_NAME, (("|H%s:%s|h[%s]|h"):format(LINK_STYLE_BRACKETS, itemData, itemName)))
end

--- currently supports one text and n arguments
---@param text string the text with placeholders to be filled by the varargs
---@vararg any the values to be put in the placeholders of the text
---@return string the formatted text
local function getFormattedText(text, ...)
    local args = { ... }
    local unpackedString = string.format(text, unpack(args))
    if unpackedString == "" then
        unpackedString = text
    end
    return unpackedString
end


---@param key string a label-key from the localization
---@vararg any the values to be put in the placeholders of the resolved key
---@return void
local function getFormattedKey(key, ...)
    local text = GetString(key)
    return getFormattedText(text, ...)
end

--- currently supports one text and n arguments
---@alias LibChatMessage
---@param lcmChat LibChatMessage the instance of LibChatMessage
---@param prefix string the prefix for the chat message
---@param text string the actual chat message
---@vararg any values to be put in the placeholders of the text
---@return void
local function println(lcmChat, prefix, text, ...)
    local textKey = GetString(text)
    local prefix = prefix or ""

    -- check if LibChatMessage is running and if a valid "chat" is provided
    if PA.LibChatMessage and lcmChat then
        if textKey ~= nil and textKey ~= "" then
            lcmChat:Print(getFormattedText(textKey, ...))
        else
            lcmChat:Print(getFormattedText(text, ...))
        end
    else
        -- otherwise stick to the old "debug solution"
        if textKey ~= nil and textKey ~= "" then
            CHAT_SYSTEM:AddMessage(table.concat({prefix, ": ", getFormattedText(textKey, ...)}))
        else
            CHAT_SYSTEM:AddMessage(table.concat({prefix, ": ", getFormattedText(text, ...)}))
        end
    end
end

--- write the provided key/text into the debug Output window (WHITE font)
---@param prefix string the prefix for the debug message
---@param text string the actual debug message
---@vararg any values to be put in the placeholders of the debug-text
---@return void
local function debugln(prefix, text, ...)
    if PA.debug then
        local textKey = GetString(text)
        local prefix = prefix or ""

        if textKey ~= nil and textKey ~= "" then
            PA.DebugWindow.printToDebugOutputWindow(table.concat({prefix, ": ", getFormattedText(textKey, ...)}))
        else
            PA.DebugWindow.printToDebugOutputWindow(table.concat({prefix, ": ", getFormattedText(text, ...)}))
        end
    end
end

--- the same like println, except that it is only printed for the addon author (i.e. charactername = Klingo)
---@param key string a label-key from the localization
---@vararg any values to be put in the placeholders of the debug-text
---@return void
local function debuglnAuthor(key, ...)
    if GetUnitName("player") == PAC.ADDON.AUTHOR then
        println(PA.chat, "", key, ...)
    end
end


-- =================================================================================================================
-- == PROFILES == --
-- -----------------------------------------------------------------------------------------------------------------

---@return boolean whether player has selected a PA profile
local function hasActiveProfile()
    local PAMenuFunctions = PA.MenuFunctions
    return not PAMenuFunctions.PAGeneral.isNoProfileSelected()
end

--- returns the default profile name of the provided profile number
---@param profileNo number the number/id of a profile
---@return string the name of the profile
local function getDefaultProfileName(profileNo)
    return table.concat({GetString(SI_PA_PROFILE), " ", profileNo})
end

--- sync the LOCAL profiles with the ones from GLOBAL
---@param localSavedVars table the savedVars table of the local profile
---@param localDefaults table the table with the defaults for the savedVars table
---@return void
local function syncLocalProfilesWithGlobal(localSavedVars, localDefaults)
    local PASavedVars = PA.SavedVars
    for profileNo = 1, PASavedVars.General.profileCounter do
        if istable(PASavedVars.General[profileNo]) and not istable(localSavedVars[profileNo]) then
            -- GLOBAL has a profile, but LOCAL does not - create it!
            localSavedVars[profileNo] = {}
            ZO_DeepTableCopy(localDefaults, localSavedVars[profileNo])
        elseif istable(localSavedVars[profileNo]) and not istable(PASavedVars.General[profileNo]) then
            -- LOCAL has a profile, but GLOBAL does not - delete it!
            localSavedVars[profileNo] = nil
        end
    end
end

--- Source: https://wiki.esoui.com/IsAddonRunning
---@param addonName string name of the addon
---@return boolean whether the addon is running
local function isAddonRunning(addonName)
    local manager = GetAddOnManager()
    for i = 1, manager:GetNumAddOns() do
        local name, _, _, _, _, state = manager:GetAddOnInfo(i)
        if name == addonName and state == ADDON_STATE_ENABLED then
            return true
        end
    end
    return false
end


-- =================================================================================================================
-- == ITEM LINKS == --
-- -----------------------------------------------------------------------------------------------------------------

---@param itemLink string the itemLink to be checked
---@return boolean if the item is character boudn or not
local function isItemLinkCharacterBound(itemLink)
    local isBound = IsItemLinkBound(itemLink)
    if isBound then
        local bindType = GetItemLinkBindType(itemLink)
        return bindType == BIND_TYPE_ON_PICKUP_BACKPACK
    end
    return false
end


---@param itemLink string the itemLink to be checked
---@return boolean if the item has the Intricate trait
local function isItemLinkIntricateTraitType(itemLink)
    local itemTraitInformation = GetItemTraitInformationFromItemLink(itemLink)
    return itemTraitInformation == ITEM_TRAIT_INFORMATION_INTRICATE
end

---@param itemLink string the itemLink to be checked
---@return string the itemLink with the matching Intricate/Stolen icon added on the right side
local function getIconExtendedItemLink(itemLink)
    -- check if it is stolen or of type [Intricate]
    local itemStolen = IsItemLinkStolen(itemLink)
    local intricateTrait = isItemLinkIntricateTraitType(itemLink)

    -- prepare additional icons if needed
    local itemLinkExt = itemLink
    if intricateTrait then itemLinkExt = table.concat({itemLinkExt, " ", PAC.ICONS.ITEMS.TRAITS.INTRICATE.SMALL}) end
    if itemStolen then itemLinkExt = table.concat({itemLinkExt, " ", PAC.ICONS.ITEMS.STOLEN.SMALL}) end
    return itemLinkExt
end

-- Export
PA.HelperFunctions = {
    round = round,
    roundDown = roundDown,
    isValueInTable = isValueInTable,
    isKeyInTable = isKeyInTable,
    getPAItemLinkIdentifier = getPAItemLinkIdentifier,
    getPAItemIdentifier = getPAItemIdentifier,
    getPAItemIdentifierFromItemData = getPAItemIdentifierFromItemData,
    getCombinedItemTypeSpecializedComparator = getCombinedItemTypeSpecializedComparator,
    getItemTypeComparator = getItemTypeComparator,
    getItemIdComparator = getItemIdComparator,
    getPAItemIdComparator = getPAItemIdComparator,
    getStolenJunkComparator = getStolenJunkComparator,
    isPlayerDead = isPlayerDead,
    isPlayerDeadOrReincarnating = isPlayerDeadOrReincarnating,
    getBankBags = getBankBags,
    getBagName = getBagName,
    hasActiveProfile = hasActiveProfile,
    getFormattedCurrency = getFormattedCurrency,
    getFormattedCurrencySimple = getFormattedCurrencySimple,
    getFormattedItemLink = getFormattedItemLink,
    getFormattedText = getFormattedText,
    getFormattedKey = getFormattedKey,
    println = println,
    debugln = debugln,
    debuglnAuthor = debuglnAuthor,
    getDefaultProfileName = getDefaultProfileName,
    syncLocalProfilesWithGlobal = syncLocalProfilesWithGlobal,
    isAddonRunning = isAddonRunning,
    isItemLinkCharacterBound = isItemLinkCharacterBound,
    isItemLinkIntricateTraitType = isItemLinkIntricateTraitType,
    getIconExtendedItemLink = getIconExtendedItemLink
}