-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _unmarkAllPAItemIdsFromJunk(paItemId)
    PAJ.debugln("#_unmarkAllPAItemIdsFromJunk(%s)", tostring(paItemId))
    local customPAItems = {
        [paItemId] = {}
    }
    local excludeJunk, excludeCharacterBound = false, false
    local paItemIdComparator = PAHF.getPAItemIdComparator(customPAItems, excludeJunk, excludeCharacterBound)
    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(paItemIdComparator, BAG_BACKPACK)
    PAJ.debugln("#backpackBagCache = "..tostring(#backpackBagCache))

    for index = #backpackBagCache, 1, -1 do
        local itemData = backpackBagCache[index]
        local isJunk = IsItemJunk(itemData.bagId, itemData.slotIndex)
        if isJunk then
            SetItemIsJunk(itemData.bagId, itemData.slotIndex, false)
            PlaySound(SOUNDS.INVENTORY_ITEM_UNJUNKED)
        end
    end
end

local function _markAllPAItemIdsAsJunk(paItemId)
    PAJ.debugln("#_markAllPAItemIdsAsJunk(%s)", tostring(paItemId))
    local customPAItems = {
        [paItemId] = {}
    }
    local excludeJunk, excludeCharacterBound = true, false
    local paItemIdComparator = PAHF.getPAItemIdComparator(customPAItems, excludeJunk, excludeCharacterBound)
    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(paItemIdComparator, BAG_BACKPACK)
    PAJ.debugln("#backpackBagCache = "..tostring(#backpackBagCache))

    for index = #backpackBagCache, 1, -1 do
        local itemData = backpackBagCache[index]
        if CanItemBeMarkedAsJunk(itemData.bagId, itemData.slotIndex) then
            SetItemIsJunk(itemData.bagId, itemData.slotIndex, true)
            PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
        end
    end
end

local function _unmarkAllSetItemIdsFromJunk(setId)
    PAJ.debugln("#_unmarkAllSetItemIdsFromJunk(%s)", tostring(setId))
    local excludeJunk = false
    local setIdComparator = PAHF.getSetIdComparator(setId, excludeJunk)
    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(setIdComparator, BAG_BACKPACK)
    PAJ.debugln("#backpackBagCache = "..tostring(#backpackBagCache))

    for index = #backpackBagCache, 1, -1 do
        local itemData = backpackBagCache[index]
        local isJunk = IsItemJunk(itemData.bagId, itemData.slotIndex)
        if isJunk then
            SetItemIsJunk(itemData.bagId, itemData.slotIndex, false)
            PlaySound(SOUNDS.INVENTORY_ITEM_UNJUNKED)
        end
    end
end

local function _markAllSetItemIdsAsJunk(setId)
    PAJ.debugln("#_markAllSetItemIdsAsJunk(%s)", tostring(setId))
    local excludeJunk = true
    local setIdComparator = PAHF.getSetIdComparator(setId, excludeJunk)
    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(setIdComparator, BAG_BACKPACK)
    PAJ.debugln("#backpackBagCache = "..tostring(#backpackBagCache))

    for index = #backpackBagCache, 1, -1 do
        local itemData = backpackBagCache[index]
        if CanItemBeMarkedAsJunk(itemData.bagId, itemData.slotIndex) then
            SetItemIsJunk(itemData.bagId, itemData.slotIndex, true)
            PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getNonStolenItemLink(itemLink)
    -- if itemLink is NOT stolen, directly return it
    if not IsItemLinkStolen(itemLink) then return itemLink end
    -- if it is stolen, remove first the stolen information
    local itemLinkMod = string.gsub(itemLink, "1(:%d+:%d+|h|h)$", "0%1")
    -- then also remove the red border
    itemLinkMod = string.gsub(itemLinkMod, "%d+(:%d+:%d+:%d+:%d+:%d+:%d+|h|h)$", "0%1")
    return itemLinkMod
end

local function isItemLinkPermanentJunk(itemLink)
    local PAJCUstomPAItemIds = PAJ.SavedVars.Custom.PAItemIds
    local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
    return PAHF.isKeyInTable(PAJCUstomPAItemIds, paItemId)
end

local function isItemPermanentJunk(bagId, slotIndex)
    local PAJCUstomPAItemIds = PAJ.SavedVars.Custom.PAItemIds
    local paItemId = PAHF.getPAItemIdentifier(bagId, slotIndex)
    return PAHF.isKeyInTable(PAJCUstomPAItemIds, paItemId)
end

local function isSetItemPermanentJunk(bagId, slotIndex)
    local PAJCustomSetIds = PAJ.SavedVars.Custom.SetIds
    local itemLink = GetItemLink(bagId, slotIndex)
    local hasSet, _, _, _, _, setId = GetItemLinkSetInfo(itemLink, false)
    return hasSet and PAHF.isKeyInTable(PAJCustomSetIds, setId)
end

local function addItemLinkToPermanentJunk(itemLink)
    PAJ.debugln("PA.Junk.addItemLinkToPermanentJunk")

    if PAJ.SavedVars.Custom.customItemsEnabled then
        local PAJCUstomPAItemIds = PAJ.SavedVars.Custom.PAItemIds
        local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
        -- only add the entry if it is an UPDATE case, or if it does not exist yet
        if not PAHF.isKeyInTable(PAJCUstomPAItemIds, paItemId) then
            local localItemLink = getNonStolenItemLink(itemLink)
            PAJCUstomPAItemIds[paItemId] = {
                itemLink = localItemLink,
                junkCount = 0,
                ruleAdded = GetTimeStamp()
            }
            PA.Junk.println(SI_PA_CHAT_JUNK_RULES_ADDED, localItemLink:gsub("%|H0", "|H1"))

            -- loop though whole inventory to mark all matching items
            _markAllPAItemIdsAsJunk(paItemId)

            -- refresh the list (if it was initialized)
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        else
            PAJ.debugln("ERROR; PAJ rule already existing")
        end
    end
end

local function removeItemLinkFromPermanentJunk(itemLink)
    PAJ.debugln("PA.Junk.removeItemLinkFromPermanentJunk")

    if PAJ.SavedVars.Custom.customItemsEnabled then
        local PAJCUstomPAItemIds = PAJ.SavedVars.Custom.PAItemIds
        local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
        if PAHF.isKeyInTable(PAJCUstomPAItemIds, paItemId) then
            -- is in table, delete rule
            PAJCUstomPAItemIds[paItemId] = nil
            -- inform player
            PAJ.println(SI_PA_CHAT_JUNK_RULES_DELETED, itemLink:gsub("%|H0", "|H1"))

            -- loop though whole inventory to unmark all matching items
            _unmarkAllPAItemIdsFromJunk(paItemId)

            -- refresh the list (if it was initialized)
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        else
            PAJ.debugln("ERROR; PAJ rule not existing, cannot be deleted")
        end
    end
end

local function addItemSetToPermanentJunk(itemLink)
    PAJ.debugln("PA.Junk.addItemSetToPermanentJunk")

    if PAJ.SavedVars.Custom.customItemsEnabled then
        local PAJCustomSetIds = PAJ.SavedVars.Custom.SetIds
        local hasSet, setName, _, _, _, setId = GetItemLinkSetInfo(itemLink, false)
        -- only add the entry if it is an UPDATE case, or if it does not exist yet
        if hasSet and not PAHF.isKeyInTable(PAJCustomSetIds, setId) then
            local localItemLink = getNonStolenItemLink(itemLink)
            PAJCustomSetIds[setId] = {
                itemLink = localItemLink,
                setName = setName,
                junkCount = 0,
                ruleAdded = GetTimeStamp()
            }
            PA.Junk.println(SI_PA_CHAT_JUNK_SET_RULES_ADDED, setName)

            -- loop though whole inventory to mark all matching items
            _markAllSetItemIdsAsJunk(setId)

            -- refresh the list (if it was initialized)
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        else
            PAJ.debugln("ERROR; PAJ rule already existing")
        end
    end
end

local function removeItemSetFromPermanentJunk(itemLink)
    PAJ.debugln("PA.Junk.removeItemSetFromPermanentJunk")

    if PAJ.SavedVars.Custom.customItemsEnabled then
        local PAJCustomSetIds = PAJ.SavedVars.Custom.SetIds
        local hasSet, setName, _, _, _, setId = GetItemLinkSetInfo(itemLink, false)
        if hasSet and PAHF.isKeyInTable(PAJCustomSetIds, setId) then
            -- is in table, delete rule
            PAJCustomSetIds[setId] = nil
            -- inform player
            PAJ.println(SI_PA_CHAT_JUNK_SET_RULES_DELETED, setName)

            -- loop though whole inventory to unmark all matching set items
            _unmarkAllSetItemIdsFromJunk(setId)

            -- refresh the list (if it was initialized)
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        else
            PAJ.debugln("ERROR; PAJ Set rule not existing, cannot be deleted")
        end
    end
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.Custom = {
    isItemLinkPermanentJunk = isItemLinkPermanentJunk,
    isItemPermanentJunk = isItemPermanentJunk,
    isSetItemPermanentJunk = isSetItemPermanentJunk,
    addItemLinkToPermanentJunk = addItemLinkToPermanentJunk,
    removeItemLinkFromPermanentJunk = removeItemLinkFromPermanentJunk,
    addItemSetToPermanentJunk = addItemSetToPermanentJunk,
    removeItemSetFromPermanentJunk = removeItemSetFromPermanentJunk
}