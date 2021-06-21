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
local function isValueInTable(t, value)
    for _, v in pairs(t) do
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
    return table[key] ~= nil
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

local function getAdvancedBankingRulesComparator(advancedBankingRulesTable, excludeJunk)
    local function _passedItemFilterTypeAndItemTypeCheck(itemData, advancedBankingRule)
        local itemFilterType = GetItemFilterTypeInfo(itemData.bagId, itemData.slotIndex)
        if itemFilterType == advancedBankingRule.itemFilterType then
            if itemFilterType == ITEMFILTERTYPE_ARMOR and istable(advancedBankingRule.armorTypes) then
                local armorType = GetItemArmorType(itemData.bagId, itemData.slotIndex)
                for _, ruleArmorType in pairs(advancedBankingRule.armorTypes) do
                    if armorType == ruleArmorType then return true end
                end
                PA.debugln("_passedItemFilterTypeAndItemTypeCheck FAILED (1) - "..itemData.itemLink)
                return false
            elseif itemFilterType == ITEMFILTERTYPE_WEAPONS and istable(advancedBankingRule.weaponTypes) then
                local weaponType = GetItemWeaponType(itemData.bagId, itemData.slotIndex)
                for _, ruleWeaponType in pairs(advancedBankingRule.weaponTypes) do
                    if weaponType == ruleWeaponType then return true end
                end
                PA.debugln("_passedItemFilterTypeAndItemTypeCheck FAILED (2) - "..itemData.itemLink)
                return false
            elseif itemFilterType == ITEMFILTERTYPE_JEWELRY and istable(advancedBankingRule.equipTypes) then
                local _, _, _, _, _, equipType = GetItemInfo(itemData.bagId, itemData.slotIndex)
                for _, ruleEquipType in pairs(advancedBankingRule.equipTypes) do
                    if equipType == ruleEquipType then return true end
                end
                PA.debugln("_passedItemFilterTypeAndItemTypeCheck FAILED (3) - "..itemData.itemLink)
                return false
            end
            return true
        end
    end

    local function _passedItemQualityCheck(itemData, advancedBankingRule)
        if istable(advancedBankingRule.itemQualities) then
            local itemQuality = GetItemQuality(itemData.bagId, itemData.slotIndex)
            for _, ruleItemQuality in ipairs(advancedBankingRule.itemQualities) do
                if itemQuality == ruleItemQuality then return true end
            end
            PA.debugln("_passedItemQualityCheck FAILED - "..itemData.itemLink)
            return false
        else
            return true
        end
    end

    local function _passedItemLevelCheck(itemData, advancedBankingRule)
        if istable(advancedBankingRule.itemLevels) then
            local requiredChampionPoints = GetItemRequiredChampionPoints(itemData.bagId, itemData.slotIndex)
            local requiredLevel = GetItemRequiredLevel(itemData.bagId, itemData.slotIndex)
            local relativeRequiredLevel = requiredLevel + requiredChampionPoints

            local ruleMinRelativeLevel = advancedBankingRule.itemLevels.levelFrom
            if advancedBankingRule.itemLevels.levelFromType == PAC.ADVANCED_RULES.LEVEL.CHAMPION then
                ruleMinRelativeLevel = ruleMinRelativeLevel + 50
            end

            local ruleMaxRelativeLevel = advancedBankingRule.itemLevels.levelTo
            if advancedBankingRule.itemLevels.levelToType == PAC.ADVANCED_RULES.LEVEL.CHAMPION then
                ruleMaxRelativeLevel = ruleMaxRelativeLevel + 50
            end

--            return relativeRequiredLevel >= ruleMinRelativeLevel and relativeRequiredLevel <= ruleMaxRelativeLevel
            if relativeRequiredLevel >= ruleMinRelativeLevel and relativeRequiredLevel <= ruleMaxRelativeLevel then
                return true
            else
                PA.debugln("_passedItemLevelCheck FAILED - %s   (%d <= %d <= %d)", itemData.itemLink, tostring(ruleMinRelativeLevel), tostring(relativeRequiredLevel), tostring(ruleMaxRelativeLevel))
                return false
            end
        else
            return true
        end
    end

    local function _passedItemSetCheck(itemData, advancedBankingRule)
        if advancedBankingRule.itemSetSetting == nil then
            return true
        else
            local hasSet = GetItemLinkSetInfo(itemData.itemLink, false)
            if advancedBankingRule.itemSetSetting == PAC.ADVANCED_RULES.SET.YES and hasSet then
                return true
            elseif advancedBankingRule.itemSetSetting == PAC.ADVANCED_RULES.SET.NO and not hasSet then
                return true
            end
            PA.debugln("_passedItemSetCheck FAILED - "..itemData.itemLink)
            return false
        end
    end

    local function _passedItemCraftedCheck(itemData, advancedBankingRule)
        if advancedBankingRule.itemCraftedSetting == nil then
            return true
        else
            local isCrafted = IsItemLinkCrafted(itemData.itemLink)
            if advancedBankingRule.itemCraftedSetting == PAC.ADVANCED_RULES.CRAFTED.YES and isCrafted then
                return true
            elseif advancedBankingRule.itemCraftedSetting == PAC.ADVANCED_RULES.CRAFTED.NO and not isCrafted then
                return true
            end
            PA.debugln("_passedItemCraftedCheck FAILED - "..itemData.itemLink)
            return false
        end
    end

    local function _passedItemTraitCheck(itemData, advancedBankingRule)
        if advancedBankingRule.itemTraitSetting == nil then
            return true
        else
            local canBeResearched = CanItemLinkBeTraitResearched(itemData.itemLink)

            if advancedBankingRule.itemTraitSetting == PAC.ADVANCED_RULES.TRAITS.KNOWN and not canBeResearched then
                return true
            elseif advancedBankingRule.itemTraitSetting == PAC.ADVANCED_RULES.TRAITS.UNKNOWN and canBeResearched then
                return true
            elseif advancedBankingRule.itemTraitSetting == PAC.ADVANCED_RULES.TRAITS.SELECTED then
                local traitType = GetItemLinkTraitInfo(itemData.itemLink)
                if istable(advancedBankingRule.itemTraitTypes) then
                    for _, ruleTraitType in pairs(advancedBankingRule.itemTraitTypes) do
                        if traitType == ruleTraitType then return true end
                    end
                else
                    -- no trait types selected, i.e. item must not have a trait type
                    if traitType == ITEM_TRAIT_TYPE_NONE then return true end
                end
            end
            PA.debugln("_passedItemTraitCheck FAILED - "..itemData.itemLink)
            return false
        end
    end

    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData.bagId, itemData.slotIndex) then return false end

        for ruleId, advancedBankingRule in pairs(advancedBankingRulesTable) do
            itemData.itemLink = GetItemLink(itemData.bagId, itemData.slotIndex, LINK_STYLE_BRACKETS)
            -- only return 'true' if all cheks passed, and only run a subsequent check if the current one passed
            if _passedItemFilterTypeAndItemTypeCheck(itemData, advancedBankingRule) then
                if _passedItemQualityCheck(itemData, advancedBankingRule) then
                    if _passedItemLevelCheck(itemData, advancedBankingRule) then
                        if _passedItemSetCheck(itemData, advancedBankingRule) then
                            if _passedItemCraftedCheck(itemData, advancedBankingRule) then
                                if _passedItemTraitCheck(itemData, advancedBankingRule) then
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
        return false
    end
end

---@param combinedLists table a complex list of holidayWrits, itemTypes, surveyMaps, itemTraitTypes, masterWritCraftingTypes, specializedItemTypes, learnableKnowItemTypes and learnableUnknownItemTypes
---@param excludeJunk boolean whether junk items should be excluded
---@param skipItemsWithCustomRule boolean whether items for which a custom rule exists should be skipped
---@return fun(itemData: table) a comparator function that only returns item that match the complex list and pass the junk-test
local function getCombinedItemTypeSpecializedComparator(combinedLists, excludeJunk, skipItemsWithCustomRule)
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
        if skipItemsWithCustomRule and PA.Banking.hasItemActiveCustomRule(itemData.bagId, itemData.slotIndex) then return false end
        local itemId = GetItemId(itemData.bagId, itemData.slotIndex)
        local itemType, specializedItemType = GetItemType(itemData.bagId, itemData.slotIndex)
        if specializedItemType == SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT then
            for _, listSpecializedItemType in pairs(combinedLists.holidayWrits) do
                if listSpecializedItemType == itemData.specializedItemType then return true end
            end
        end
        for _, listItemType in pairs(combinedLists.itemTypes) do
            if listItemType == itemData.itemType then return true end
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
            for _, listSpecializedItemType in pairs(combinedLists.specializedItemTypes) do
                if listSpecializedItemType == itemData.specializedItemType then return true end
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
---@param excludeCharacterBound boolean whether character bound items should be excluded
---@param excludeStolen boolean whether stolen items should be excluded
---@return fun(itemData: table) a comparator function that only returns item that match the paItemIdList and pass the junk-test
local function getPAItemIdComparator(paItemIdList, excludeJunk, excludeCharacterBound, excludeStolen)
    return function(itemData)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) and excludeStolen then return false end
        if IsItemJunk(itemData.bagId, itemData.slotIndex) and excludeJunk then return false end
        if _isItemCharacterBound(itemData) and excludeCharacterBound then return false end
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

---@return string, string, string the applicable bags the player currently has access to (BAG_BACKPACK always, BAG_BANK and BAG_SUBSCRIBER_BANK only when bank open)
local function getAccessibleBags()
    if IsBankOpen() then
        return BAG_BACKPACK, getBankBags()
    end
    return BAG_BACKPACK
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

--- returns the default profile name of the provided profile number
---@param profileNo number the number/id of a profile
---@return string the name of the profile
local function getDefaultProfileName(profileNo)
    return table.concat({GetString(SI_PA_PROFILE), " ", profileNo})
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

--- Checks the itemLink if it is known (recipes and motifs), researched (item traits), or already added to collection (style pages and containers)
---@param itemLink string the itemLink to be checked
---@return string Constants.LEARNABLE.KNOWN, Constants.LEARNABLE.KNOWN or nil if there is no known/unknown status
local function getItemLinkLearnableStatus(itemLink)
    local itemType, specializedItemType = GetItemLinkItemType(itemLink)
    local itemFilterType = GetItemLinkFilterTypeInfo(itemLink)
    if GetAPIVersion() >= 100035 and itemFilterType == ITEMFILTERTYPE_COMPANION then
        -- make sure it's not a Blackwood companion item
        return nil
    end
    if itemType == ITEMTYPE_RECIPE then
        if IsItemLinkRecipeKnown(itemLink) then return PAC.LEARNABLE.KNOWN end
        return PAC.LEARNABLE.UNKNOWN
    elseif itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then
        if IsItemLinkBook(itemLink) then
            if IsItemLinkBookKnown(itemLink) then return PAC.LEARNABLE.KNOWN end
            return PAC.LEARNABLE.UNKNOWN
        end
    elseif itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY then
        local itemTraitType = GetItemLinkTraitType(itemLink)
        -- only check for the research status if it has a traitType and if it is not Ornate or Intricate
        if itemTraitType == ITEM_TRAIT_TYPE_NONE or
                itemTraitType == ITEM_TRAIT_TYPE_ARMOR_ORNATE or itemTraitType == ITEM_TRAIT_TYPE_JEWELRY_ORNATE or itemTraitType == ITEM_TRAIT_TYPE_WEAPON_ORNATE or
                itemTraitType == ITEM_TRAIT_TYPE_ARMOR_INTRICATE or itemTraitType == ITEM_TRAIT_TYPE_JEWELRY_INTRICATE or itemTraitType == ITEM_TRAIT_TYPE_WEAPON_INTRICATE then
            return nil
        end
        if CanItemLinkBeTraitResearched(itemLink) then return PAC.LEARNABLE.UNKNOWN end
        return PAC.LEARNABLE.KNOWN
    elseif specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER then
        -- APIVersion_100035: Need to check SPECIALIZED_ITEMTYPE_COLLECTIBLE_STYLE_PAGE in addition to SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE
        local containerCollectibleId = GetItemLinkContainerCollectibleId(itemLink)
        local collectibleName = GetCollectibleName(containerCollectibleId)
        if collectibleName ~= nil and collectibleName ~= "" then
            local isValidForPlayer = IsCollectibleValidForPlayer(containerCollectibleId)
            if isValidForPlayer then
                local isUnlocked = IsCollectibleUnlocked(containerCollectibleId)
                if isUnlocked then return PAC.LEARNABLE.KNOWN end
                return PAC.LEARNABLE.UNKNOWN
            end
        end
    end
    -- itemLink is neither known, nor unknown (not learnable or researchable)
    return nil
end

-- Export
PA.HelperFunctions = {
    round = round,
    roundDown = roundDown,
    isValueInTable = isValueInTable,
    isKeyInTable = isKeyInTable,
    removeValueFromIndexedTable = removeValueFromIndexedTable,
    orderedPairs = orderedPairs,
    getPAItemLinkIdentifier = getPAItemLinkIdentifier,
    getPAItemIdentifier = getPAItemIdentifier,
    getPAItemIdentifierFromItemData = getPAItemIdentifierFromItemData,
    getAdvancedBankingRulesComparator = getAdvancedBankingRulesComparator,
    getCombinedItemTypeSpecializedComparator = getCombinedItemTypeSpecializedComparator,
    getItemTypeComparator = getItemTypeComparator,
    getItemIdComparator = getItemIdComparator,
    getPAItemIdComparator = getPAItemIdComparator,
    getStolenJunkComparator = getStolenJunkComparator,
    isPlayerDead = isPlayerDead,
    isPlayerDeadOrReincarnating = isPlayerDeadOrReincarnating,
    getAccessibleBags = getAccessibleBags,
    getBankBags = getBankBags,
    getBagName = getBagName,
    split = split,
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
    getIconExtendedItemLink = getIconExtendedItemLink,
    getItemLinkLearnableStatus = getItemLinkLearnableStatus
}