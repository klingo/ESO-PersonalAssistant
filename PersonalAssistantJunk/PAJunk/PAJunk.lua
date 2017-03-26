--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 09.02.2017
-- Time: 20:20
--

-- =====================================================================================================================
-- =====================================================================================================================

local function GiveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
    -- check what the difference in money is
    local moneyDiff = GetCurrentMoney() - moneyBefore;
    local itemCountInBagDiff = itemCountInBagBefore - GetNumBagUsedSlots(BAG_BACKPACK)

    if (itemCountInBagDiff > 0) then
        -- at lesat one item was sold (although it might have been worthless)
        if (moneyDiff > 0) then
            -- some valuable junk was sold
            PAHF.println("PAJ_SoldJunkInfo", moneyDiff)
        else
            -- only worthless junk was sold
            PAHF.println("PAJ_SoldJunkInfo", moneyDiff)
        end
    else
        -- no item was sold
        if (moneyDiff > 0) then
            -- no item was sold, but money appeared out of nowhere
            -- should not happen :D
            PAHF.println(PAC_COLTEXT_PAJ .. "Error #1337: This should not happen!")
        end
    end

    -- set processing flag to FALSE again
    PAEM.isJunkProcessing = false
end

-- =====================================================================================================================
-- =====================================================================================================================

function PAJ.OnShopOpen()
    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Junk[PA.activeProfile].enabled then
            -- check if auto-sell is enabled
            if PA.savedVars.Junk[PA.activeProfile].autoSellJunk then
                -- check if there is junk to sell (exclude stolen items = true)
                if HasAnyJunk(BAG_BACKPACK, true) then
                    -- set processing flag to TRUE
                    PAEM.isJunkProcessing = true
                    -- store current amount of money
                    local moneyBefore = GetCurrentMoney();
                    local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)

                    -- Sell all items marked as junk
                    SellAllJunk()

                    -- Have to call it wiht some delay, as the "currentMoney" and item count is not updated fast enough
                    -- after calling SellAllJunk()
                    zo_callLater(function() GiveSoldJunkFeedback(moneyBefore, itemCountInBagBefore) end, 200)
                end
            end
        end
    end
end


function PAJ.OnInventorySingleSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Junk[PA.activeProfile].enabled then

            -- check if the updated happened in the backpack and if the item is new
            if ((bagId == BAG_BACKPACK) and (isNewItem)) then

                -- check if the item isnt already junk
                if not IsItemJunk(bagId, slotIndex) then
                    -- get the itemType
                    local itemType = GetItemType(bagId, slotIndex)
                    local itemTrait = GetItemTrait(bagId, slotIndex)
                    local markAsJunk = false

                    -- check if it is trash and if auto-flag-trash is enabled
                    if (PA.savedVars.Junk[PA.activeProfile].autoMarkTrash) then
                        if (itemType == ITEMTYPE_TRASH) then markAsJunk = true end
                    end

                    -- check if item has the [Ornate] trait and if it is enabled
                    if (PA.savedVars.Junk[PA.activeProfile].autoMarkOrnate) then
                        if (itemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE or itemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE or itemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE) then
                            markAsJunk = true
                        end
                    end

                    -- TODO: check other item types etc.

                    -----------------------------------------------------------------------

                    if (markAsJunk) then
                        -- Now we know for sure the item _should_ be marked as Junk. Check if this indeed is possible.
                        if CanItemBeMarkedAsJunk(bagId, slotIndex) then
                            -- it is safe to mark the item as junk now
                            SetItemIsJunk(bagId, slotIndex, true)

                            local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
                            PAHF.println("PAJ_MarkedAsJunk", itemLink)
                        end
                    end
                end
            end
        end
    end
end
