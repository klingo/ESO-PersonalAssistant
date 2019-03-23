-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- =====================================================================================================================
-- =====================================================================================================================

local function _isNotStolenOrStolenAndAllowed(itemData, isStolenAllowed)
    local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
    return not isStolen or (isStolen and isStolenAllowed)
end

local function getCombinedItemTypeSpecializedComparator(itemTypeList, spevializedItemTypeList, includeStolenItems)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        for _, specializedItemType in pairs(spevializedItemTypeList) do
            if specializedItemType == itemData.specializedItemType and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        return false
    end
end

local function getItemTypeComparator(itemTypeList, includeStolenItems)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        return false
    end
end

local function getItemIdComparator(itemIdList, includeStolenItems)
    return function(itemData)
        for itemId, _ in pairs(itemIdList) do
            if itemId == GetItemId(itemData.bagId, itemData.slotIndex) and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        return false
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

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

local function isValueInTable(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

local function isPlayerDead()
    return IsUnitDead("player")
end

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

-- returns a fixed/formatted ItemLink
local function getFormattedItemLink(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
    if itemLink == "" then return end
    local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(bagId, slotIndex))
    local itemData = itemLink:match("|H.-:(.-)|h")
    return zo_strformat(SI_TOOLTIP_ITEM_NAME, (("|H%s:%s|h[%s]|h"):format(LINK_STYLE_BRACKETS, itemData, itemName)))
end

local function hasActiveProfile()
    local PAMenuFunctions = PA.MenuFunctions
    return not PAMenuFunctions.PAGeneral.isNoProfileSelected()
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
local function println(text, ...)
    local textKey = GetString(text)
    if textKey ~= nil and textKey ~= "" then
        CHAT_SYSTEM:AddMessage(getFormattedText(textKey, ...))
    else
        CHAT_SYSTEM:AddMessage(getFormattedText(text, ...))
    end
end

-- the same like println, except that it only prints it if debug is on
local function debugln(key, ...)
    if PA.debug then
        println(key, ...)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

-- returns the default profile name of the provided profile number
local function getDefaultProfileName(profileNo)
    if profileNo <= PAC.GENERAL.MAX_PROFILES then
        return table.concat({GetString(SI_PA_PROFILE), " ", profileNo})
    else
        return GetString(SI_PA_PLEASE_SELECT_PROFILE)
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

-- Export
PA.HelperFunctions = {
    getCombinedItemTypeSpecializedComparator = getCombinedItemTypeSpecializedComparator,
    getItemTypeComparator = getItemTypeComparator,
    getItemIdComparator = getItemIdComparator,
    round = round,
    roundDown = roundDown,
    isValueInTable = isValueInTable,
    isPlayerDead = isPlayerDead,
    getBagName = getBagName,
    getFormattedItemLink = getFormattedItemLink,
    hasActiveProfile = hasActiveProfile,
    getFormattedText = getFormattedText,
    getFormattedKey = getFormattedKey,
    println = println,
    debugln = debugln,
    getDefaultProfileName = getDefaultProfileName,
    isAddonRunning = isAddonRunning
}