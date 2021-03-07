-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function getNonStolenItemLink(itemLink)
    -- if itemLink is NOT stolen, directly return it
    if not IsItemLinkStolen(itemLink) then return itemLink end
    -- if it is stolen, remove first the stolen information
    local itemLinkMod = string.gsub(itemLink, "1(:%d+:%d+|h|h)$", "0%1")
    -- then also remove the red border
    local itemLinkMod = string.gsub(itemLinkMod, "%d+(:%d+:%d+:%d+:%d+:%d+:%d+|h|h)$", "0%1")
    return itemLinkMod
end

local function addItemToPermanentJunk(itemLink, bagId, slotIndex)
    PAJ.debugln("PA.Junk.addItemToPermanentJunk")

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

            -- Also directly mark the item as junk (if possible)
            if CanItemBeMarkedAsJunk(bagId, slotIndex) then
                SetItemIsJunk(bagId, slotIndex, true)
                PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
            end

            -- refresh the list (if it was initialized)
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        else
            PAJ.debugln("ERROR; PAJ rule already existing")
        end
    end
end

local function removeItemFromPermanentJunk(itemLink, bagId, slotIndex)
    PAJ.debugln("PA.Junk.removeItemFromPermanentJunk")

    if PAJ.SavedVars.Custom.customItemsEnabled then
        local PAJCUstomPAItemIds = PAJ.SavedVars.Custom.PAItemIds
        local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
        if PAHF.isKeyInTable(PAJCUstomPAItemIds, paItemId) then
            -- is in table, delete rule
            PAJCUstomPAItemIds[paItemId] = nil
            if bagId and slotIndex then
                SetItemIsJunk(bagId, slotIndex, false)
                PlaySound(SOUNDS.INVENTORY_ITEM_UNJUNKED)
            end
            -- inform player
            PAJ.println(SI_PA_CHAT_JUNK_RULES_DELETED, itemLink:gsub("%|H0", "|H1"))
            -- refresh the list (if it was initialized)
            if PA.JunkRulesList then PA.JunkRulesList:Refresh() end
        else
            PAJ.debugln("ERROR; PAJ rule not existing, cannot be deleted")
        end
    end
end

local function addItemSetToPermanentJunk(itemLink, bagId, slotIndex)
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

            -- Also directly mark the item as junk (if possible)
            if CanItemBeMarkedAsJunk(bagId, slotIndex) then
                SetItemIsJunk(bagId, slotIndex, true)
                PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
            end

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
            PAJ.println(SI_PA_CHAT_JUNK_SET_RULES_DELETED, setName)

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
PA.Junk.addItemToPermanentJunk = addItemToPermanentJunk
PA.Junk.removeItemFromPermanentJunk = removeItemFromPermanentJunk
PA.Junk.addItemSetToPermanentJunk = addItemSetToPermanentJunk
PA.Junk.removeItemSetFromPermanentJunk = removeItemSetFromPermanentJunk