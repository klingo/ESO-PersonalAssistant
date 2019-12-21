-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
-- ---------------------------------------------------------------------------------------------------------------------


-- =================================================================================================================
-- == COMPARATORS == --
-- -----------------------------------------------------------------------------------------------------------------

local function _isItemCharacterBound(bagId, slotIndex)
    local isBound = IsItemBound(bagId, slotIndex)
    if isBound then
        local bindType = GetItemBindType(bagId, slotIndex)
        return bindType == BIND_TYPE_ON_PICKUP_BACKPACK
    end
    return false
end

local function getCombinedItemTypeSpecializedComparator(combinedLists, excludeJunk)
    local function _isItemOfItemTypeAndKnowledge(bagId, slotIndex, expectedItemType, expectedIsKnown)
        local itemType = GetItemType(bagId, slotIndex)
        if itemType == expectedItemType then
            local itemLink = GetItemLink(bagId, slotIndex)
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

    local function _getCraftingTypeFromWritItemLink(itemLink)
        local itemType, specializedItemType = GetItemLinkItemType(itemLink)
        if itemType == ITEMTYPE_MASTER_WRIT and specializedItemType == SPECIALIZED_ITEMTYPE_MASTER_WRIT then
            local icon = GetItemLinkInfo(itemLink)
            return _WRIT_ICON_TABLE_CRAFTING_TYPE[icon] or CRAFTING_TYPE_INVALID
        end
        return nil
    end

    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData.bagId, itemData.slotIndex) then return false end
        local itemLink = GetItemLink(itemData.bagId, itemData.slotIndex)
        for _, itemType in pairs(combinedLists.learnableKnownItemTypes) do
           if _isItemOfItemTypeAndKnowledge(itemData.bagId, itemData.slotIndex, itemType, true) then return true end
        end
        for _, itemType in pairs(combinedLists.learnableUnknownItemTypes) do
            if _isItemOfItemTypeAndKnowledge(itemData.bagId, itemData.slotIndex, itemType, false) then return true end
        end
        for _, craftingType in pairs(combinedLists.masterWritCraftingTypes) do
            local itemLink = GetItemLink(itemData.bagId, itemData.slotIndex)
            if craftingType == _getCraftingTypeFromWritItemLink(itemLink) then return true end
        end
        for _, itemType in pairs(combinedLists.itemTypes) do
            if itemType == itemData.itemType then return true end
        end
        for _, specializedItemType in pairs(combinedLists.specializedItemTypes) do
            if specializedItemType == itemData.specializedItemType and not IsItemLinkContainer(itemLink) then return true end
        end
        for _, itemTraitType in pairs(combinedLists.itemTraitTypes) do
            if itemTraitType == GetItemTrait(itemData.bagId, itemData.slotIndex) then return true end
        end
        return false
    end
end

local function getItemTypeComparator(itemTypeList, excludeJunk)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
            if _isItemCharacterBound(itemData.bagId, itemData.slotIndex) then return false end
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end

local function getItemIdComparator(itemIdList, excludeJunk)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData.bagId, itemData.slotIndex) then return false end
        for itemId, _ in pairs(itemIdList) do
            if itemId == GetItemId(itemData.bagId, itemData.slotIndex) then return true end
        end
        return false
    end
end

local function getStolenJunkComparator()
    return function(itemData)
        if _isItemCharacterBound(itemData.bagId, itemData.slotIndex) then return false end
        local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
        local isJunk = IsItemJunk(itemData.bagId, itemData.slotIndex)
        return isStolen and isJunk
    end
end


-- =================================================================================================================
-- == MATH / TABLE FUNCTIONS == --
-- -----------------------------------------------------------------------------------------------------------------

local function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function roundDown(num)
    if num > 0 then
        return math.floor(num)
    elseif num < 0 then
        return math.ceil(num)
    else
        return num
    end
end

local function isValueInTable(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

local function isKeyInTable(t, key)
    for k in pairs(t) do
        if k == key then
            return true
        end
    end
    return false
end

local function removeValueFromIndexedTable(t, value)
    for k, v in ipairs(t) do
        if v == value then
            table.remove(t, k)
            return
        end
    end
end

-- Source: http://lua-users.org/wiki/SortedIteration
--- Equivalent of the pairs() function o tables. Allows to iterate in order
local function orderedPairs(t)
    local function cmp_multitype(op1, op2)
        local type1, type2 = type(op1), type(op2)
        if type1 ~= type2 then --cmp by type
            return type1 < type2
        elseif type1 == "number" or type1 == "string" then --type2 is equal to type1
            return op1 < op2 --comp by default
        elseif type1 == "boolean" then
            return op1 == true
        else
            return tostring(op1) < tostring(op2) --cmp by address
        end
    end
    local function __genOrderedIndex(t)
        local orderedIndex = {}
        for key in pairs(t) do
            table.insert(orderedIndex, key)
        end
        table.sort(orderedIndex, cmp_multitype)
        return orderedIndex
    end
    local function orderedNext(t, state)
        -- Equivalent of the next function, but returns the keys in the alphabetic
        -- order. We use a temporary ordered key table that is stored in the
        -- table being iterated.
        local key
        --print("orderedNext: state = "..tostring(state) )
        if state == nil then
            -- the first time, generate the index
            t.__orderedIndex = __genOrderedIndex(t)
            key = t.__orderedIndex[1]
        else
            -- fetch the next value
            for i = 1,table.getn(t.__orderedIndex) do
                if t.__orderedIndex[i] == state then
                    key = t.__orderedIndex[i+1]
                end
            end
        end
        if key then
            return key, t[key]
        end
        -- no more value to return, cleanup
        t.__orderedIndex = nil
        return
    end
    return orderedNext, t, nil
end


-- =================================================================================================================
-- == PLAYER STATES == --
-- -----------------------------------------------------------------------------------------------------------------

local function isPlayerDead()
    return IsUnitDead("player")
end

local function isPlayerDeadOrReincarnating()
   return IsUnitDeadOrReincarnating("player")
end


-- =================================================================================================================
-- == TEXT / NUMBER TRANSFORMATIONS == --
-- -----------------------------------------------------------------------------------------------------------------
-- returns a noun for the bagId
local function getBagName(bagId)
    if bagId == BAG_WORN then
        return GetString(SI_PA_NS_BAG_EQUIPMENT)
    elseif bagId == BAG_BACKPACK then
        return GetString(SI_PA_NS_BAG_BACKPACK)
    elseif bagId == BAG_BANK then
        return GetString(SI_PA_NS_BAG_BANK)
    elseif bagId == BAG_SUBSCRIBER_BANK then
        return GetString(SI_PA_NS_BAG_SUBSCRIBER_BANK)
    else
        return GetString(SI_PA_NS_BAG_UNKNOWN)
    end
end

local function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then
            break
        end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end


-- =================================================================================================================
-- == TEXT FORMATTING AND OUTPUT == --
-- -----------------------------------------------------------------------------------------------------------------

-- based on: https://esodata.uesp.net/100028/src/libraries/globals/localization.lua.html#202
--- Formats the provided arguments in a licalized, "or"-separated list
-- @param argumentTable the ordered table of strings
-- @eturn the localized list with "or"-separated entries
local function getCommaSeparatedOrList(argumentTable)
    if argumentTable ~= nil and #argumentTable > 0 then
        local numArguments = #argumentTable
        -- If there's only one item in the list, the string is just the first item
        if numArguments == 1 then
            return argumentTable[1]
        else
            -- loop through the first through the second to last element adding commas in between
            -- don't add the last since we will use a different separator for it
            local listString = table.concat(argumentTable, GetString(SI_LIST_COMMA_SEPARATOR), 1, numArguments - 1)
            -- add the last element of the array to the list using the ", or" separator
            local finalSeparator = SI_PA_LIST_COMMA_OR_SEPARATOR
            -- if there are only two items in the list, we want to use "or" without a comma
            if numArguments == 2 then
                finalSeparator = SI_PA_LIST_OR_SEPARATOR
            end
            listString = string.format('%s%s%s', listString, GetString(finalSeparator), argumentTable[numArguments])
            return listString
        end
    else
        return ""
    end
end

--- Formats the provided currency amount with an icon based on the type
-- @param currencyAmount the amount that should be formatted (can be negative)
-- @param currencyType the type of currency (default = CURT_MONEY)
-- @param noColor if set to true the amount-text will not be colored (default = false)
-- @return the formatted text with currency icon
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
-- @param currencyAmount the amount that should be formatted
-- @param currencyType the type of currency (defualt = CURT_MONEY)
-- @return the formattext text without currency icon
local function getFormattedCurrencySimple(currencyAmount, currencyType)
    local currencyType = currencyType or CURT_MONEY
    local noColor = noColor or false
    if currencyAmount < 0 then currencyAmount = currencyAmount * -1 end  -- need to make it a positive number again
    return PAC.COLOR.CURRENCIES[currencyType]:Colorize(zo_strformat(SI_NUMBER_FORMAT, ZO_LocalizeDecimalNumber(currencyAmount)))
end

-- returns a fixed/formatted ItemLink
-- needed as the regular GetItemLink sometimes(?) returns lower-case only texts
local function getFormattedItemLink(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
    if itemLink == "" then return "[unknown]" end
    local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(bagId, slotIndex))
    local itemData = itemLink:match("|H.-:(.-)|h")
    return zo_strformat(SI_TOOLTIP_ITEM_NAME, (("|H%s:%s|h[%s]|h"):format(LINK_STYLE_BRACKETS, itemData, itemName)))
end

-- currently supports one text and n arguments
local function getFormattedText(text, ...)
    local args = { ... }
    local unpackedString = string.format(text, unpack(args))
    if unpackedString == "" then
        unpackedString = text
    end
    return unpackedString
end


local function getFormattedKey(key, ...)
    local text = GetString(key)
    return getFormattedText(text, ...)
end

-- currently supports one text and n arguments
local function println(prefix, text, ...)
    local textKey = GetString(text)
    local prefix = prefix or ""
    if textKey ~= nil and textKey ~= "" then
        CHAT_SYSTEM:AddMessage(table.concat({prefix, getFormattedText(textKey, ...)}))
    else
        CHAT_SYSTEM:AddMessage(table.concat({prefix, getFormattedText(text, ...)}))
    end
end

-- write the provided key/text into the debug Output window (WHITE font)
local function debugln(key, ...)
    if PA.debug then
        local textKey = GetString(key)
        if textKey ~= nil and textKey ~= "" then
            PA.DebugWindow.printToDebugOutputWindow(getFormattedText(textKey, ...))
        else
            PA.DebugWindow.printToDebugOutputWindow(getFormattedText(key, ...))
        end
    end
end

-- the same like println, except that it is only printed for the addon author (i.e. charactername = Klingo)
local function debuglnAuthor(key, ...)
    if GetUnitName("player") == PAC.ADDON.AUTHOR then
        println("", key, ...)
    end
end


-- =================================================================================================================
-- == PROFILES == --
-- -----------------------------------------------------------------------------------------------------------------

local function hasActiveProfile()
    local PAMenuFunctions = PA.MenuFunctions
    return not PAMenuFunctions.PAGeneral.isNoProfileSelected()
end

-- returns the default profile name of the provided profile number
local function getDefaultProfileName(profileNo)
    if profileNo <= PAC.GENERAL.MAX_PROFILES then
        return table.concat({GetString(SI_PA_PROFILE), " ", profileNo})
    else
        return GetString(SI_PA_MENU_PROFILE_PLEASE_SELECT)
    end
end

-- Source: https://wiki.esoui.com/IsAddonRunning
-- addonName *string*
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

local function isItemLinkCharacterBound(itemLink)
    local isBound = IsItemLinkBound(itemLink)
    if isBound then
        local bindType = GetItemLinkBindType(itemLink)
        return bindType == BIND_TYPE_ON_PICKUP_BACKPACK
    end
    return false
end

local function isItemLinkIntricateTraitType(itemLink)
    local itemTraitInformation = GetItemTraitInformationFromItemLink(itemLink)
    return itemTraitInformation == ITEM_TRAIT_INFORMATION_INTRICATE
end

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
    getCombinedItemTypeSpecializedComparator = getCombinedItemTypeSpecializedComparator,
    getItemTypeComparator = getItemTypeComparator,
    getItemIdComparator = getItemIdComparator,
    getStolenJunkComparator = getStolenJunkComparator,
    round = round,
    roundDown = roundDown,
    isValueInTable = isValueInTable,
    isKeyInTable = isKeyInTable,
    removeValueFromIndexedTable = removeValueFromIndexedTable,
    orderedPairs = orderedPairs,
    isPlayerDead = isPlayerDead,
    isPlayerDeadOrReincarnating = isPlayerDeadOrReincarnating,
    getBagName = getBagName,
    split = split,
    hasActiveProfile = hasActiveProfile,
    getCommaSeparatedOrList = getCommaSeparatedOrList,
    getFormattedCurrency = getFormattedCurrency,
    getFormattedCurrencySimple = getFormattedCurrencySimple,
    getFormattedItemLink = getFormattedItemLink,
    getFormattedText = getFormattedText,
    getFormattedKey = getFormattedKey,
    println = println,
    debugln = debugln,
    debuglnAuthor = debuglnAuthor,
    getDefaultProfileName = getDefaultProfileName,
    isAddonRunning = isAddonRunning,
    isItemLinkCharacterBound = isItemLinkCharacterBound,
    isItemLinkIntricateTraitType = isItemLinkIntricateTraitType,
    getIconExtendedItemLink = getIconExtendedItemLink
}