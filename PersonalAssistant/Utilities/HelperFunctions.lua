-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
-- ---------------------------------------------------------------------------------------------------------------------

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

local function getCombinedItemTypeSpecializedComparator(combinedLists)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
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

local function getItemTypeComparator(itemTypeList)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end

local function getItemIdComparator(itemIdList)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        for itemId, _ in pairs(itemIdList) do
            if itemId == GetItemId(itemData.bagId, itemData.slotIndex) then return true end
        end
        return false
    end
end

local function getStolenJunkComparator()
    return function(itemData)
        local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
        local isJunk = IsItemJunk(itemData.bagId, itemData.slotIndex)
        return isStolen and isJunk
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

local function isKeyInTable(table, key)
    for k in pairs(table) do
        if k == key then
            return true
        end
    end
    return false
end

local function isPlayerDead()
    return IsUnitDead("player")
end

local function isPlayerDeadOrReincarnating()
   return IsUnitDeadOrReincarnating("player")
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

local function hasActiveProfile()
    local PAMenuFunctions = PA.MenuFunctions
    return not PAMenuFunctions.PAGeneral.isNoProfileSelected()
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
local function println(text, ...)
    local textKey = GetString(text)
    if textKey ~= nil and textKey ~= "" then
        CHAT_SYSTEM:AddMessage(getFormattedText(textKey, ...))
    else
        CHAT_SYSTEM:AddMessage(getFormattedText(text, ...))
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

-- ---------------------------------------------------------------------------------------------------------------------

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
    isPlayerDead = isPlayerDead,
    isPlayerDeadOrReincarnating = isPlayerDeadOrReincarnating,
    getBagName = getBagName,
    hasActiveProfile = hasActiveProfile,
    getFormattedItemLink = getFormattedItemLink,
    getFormattedText = getFormattedText,
    getFormattedKey = getFormattedKey,
    println = println,
    debugln = debugln,
    debuglnAuthor = debuglnAuthor,
    getDefaultProfileName = getDefaultProfileName,
    isAddonRunning = isAddonRunning,
    isItemLinkIntricateTraitType = isItemLinkIntricateTraitType,
    getIconExtendedItemLink = getIconExtendedItemLink
}