-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
    -- check what the difference in money is
    local moneyDiff = GetCurrentMoney() - moneyBefore;
    local itemCountInBagDiff = itemCountInBagBefore - GetNumBagUsedSlots(BAG_BACKPACK)

    if (itemCountInBagDiff > 0) then
        -- at lesat one item was sold (although it might have been worthless)
        if (moneyDiff > 0) then
            -- some valuable junk was sold
            PAHF.println(SI_PA_JUNK_SOLD_JUNK_INFO, moneyDiff)
        else
            -- only worthless junk was sold
            PAHF.println(SI_PA_JUNK_SOLD_JUNK_INFO, moneyDiff)
        end
    else
        -- no item was sold
        if (moneyDiff > 0) then
            -- no item was sold, but money appeared out of nowhere
            -- should not happen :D
            PAHF.println(PAC.COLORED_TEXTS.PAJ .. "Error #1337: This should not happen!")
        end
    end

    -- set processing flag to FALSE again
    PAEM.isJunkProcessing = false
end


local function _markAsJunkIfPossible(bagId, slotIndex)
    -- Check if ESO allows the item to be marked as junk
    if CanItemBeMarkedAsJunk(bagId, slotIndex) then
        -- TODO: integrate FCOItemSaver

        local playerLocked = IsItemPlayerLocked(bagId, slotIndex)
--        d("playerLocked="..tostring(playerLocked))

--        CanItemBePlayerLocked(number Bag bagId, number slotIndex)
--        Returns: boolean canBePlayerLocked
--
--        IsItemPlayerLocked(number Bag bagId, number slotIndex)
--        Returns: boolean playerLocked
--
--        SetItemIsPlayerLocked(number Bag bagId, number slotIndex, boolean playerLocked)

        -- It is considered safe to mark the item as junk now
        SetItemIsJunk(bagId, slotIndex, true)

        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)

        return true, itemLink
    end
    return false, nil
end


-- ---------------------------------------------------------------------------------------------------------------------

local function OnShopOpen()
    if (PAHF.hasActiveProfile()) then
        -- check if auto-sell is enabled
        if PASV.Junk[PA.activeProfile].autoSellJunk then
            -- check if there is junk to sell (exclude stolen items = true)
            if HasAnyJunk(BAG_BACKPACK, true) then
                -- set processing flag to TRUE
                PAEM.isJunkProcessing = true
                -- store current amount of money
                local moneyBefore = GetCurrentMoney();
                local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)

                -- Sell all items marked as junk
                SellAllJunk()

                -- Have to call it with some delay, as the "currentMoney" and item count is not updated fast enough
                -- after calling SellAllJunk()
                zo_callLater(function() _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore) end, 200)
            end
        end
    end
end


local function OnInventorySingleSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if (PAHF.hasActiveProfile()) then

        -- check if auto-marking is enabled
        if PASV.Junk[PA.activeProfile].AutoMarkAsJunk.autoMarkAsJunkEnabled then

            -- check if the updated happened in the backpack and if the item is new
            if ((bagId == BAG_BACKPACK) and (isNewItem)) then
                -- get the itemType and itemTrait
                local itemType = GetItemType(bagId, slotIndex)
                local itemTrait = GetItemTrait(bagId, slotIndex)

                -- check for the different itemTypes and itemTraits
                if (itemType == ITEMTYPE_TRASH) then
                    if PASV.Junk[PA.activeProfile].AutoMarkAsJunk.autoMarkTrash then
                        local markedAsJunk, itemLink = _markAsJunkIfPossible(bagId, slotIndex)
                        if (markedAsJunk) then
                            PAHF.println(SI_PA_JUNK_MARKED_AS_JUNK_TRASH, itemLink)
                        end
                    end

                elseif (itemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE or itemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE or itemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE) then
                    if PASV.Junk[PA.activeProfile].AutoMarkAsJunk.autoMarkOrnate then
                        local markedAsJunk, itemLink = _markAsJunkIfPossible(bagId, slotIndex)
                        if (markedAsJunk) then
                            PAHF.println(SI_PA_JUNK_MARKED_AS_JUNK_ORNATE, itemLink)
                        end
                    end
                end
                -- TODO: check other item types etc.
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.OnShopOpen = OnShopOpen
PA.Junk.OnInventorySingleSlotUpdate = OnInventorySingleSlotUpdate
