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
    local excludeJunk, excludeCharacterBound, excludeStolen = false, false, false
    local paItemIdComparator = PAHF.getPAItemIdComparator(customPAItems, excludeJunk, excludeCharacterBound, excludeStolen)
    local bagCache = SHARED_INVENTORY:GenerateFullSlotData(paItemIdComparator, PAHF.getAccessibleBags())
    PAJ.debugln("#bagCache = "..tostring(#bagCache))

    for index = #bagCache, 1, -1 do
        local itemData = bagCache[index]
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
    local excludeJunk, excludeCharacterBound, excludeStolen = true, false, false
    local paItemIdComparator = PAHF.getPAItemIdComparator(customPAItems, excludeJunk, excludeCharacterBound, excludeStolen)
    local bagCache = SHARED_INVENTORY:GenerateFullSlotData(paItemIdComparator, PAHF.getAccessibleBags())
    PAJ.debugln("#bagCache = "..tostring(#bagCache))

    for index = #bagCache, 1, -1 do
        local itemData = bagCache[index]
        if PAHF.CanItemBeMarkedAsJunkExt(itemData.bagId, itemData.slotIndex) then
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

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.Custom = {
    isItemLinkPermanentJunk = isItemLinkPermanentJunk,
    isItemPermanentJunk = isItemPermanentJunk,
    addItemLinkToPermanentJunk = addItemLinkToPermanentJunk,
    removeItemLinkFromPermanentJunk = removeItemLinkFromPermanentJunk
}