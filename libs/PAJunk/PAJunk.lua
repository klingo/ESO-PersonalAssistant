--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 09.02.2017
-- Time: 20:20
--

PAJ = {}

function PAJ.OnShopOpen()
    local activeProfile = PA_SavedVars.General.activeProfile

    -- check if addon is enabled
    if PA_SavedVars.Junk[activeProfile].enabled then
        -- check if auto-sell is enabled
        if PA_SavedVars.Junk[activeProfile].autoSellJunk then
            -- store current amount of money
            local moneyBefore = GetCurrentMoney();
            local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)

            -- Sell all items marked as junk
            SellAllJunk()

            -- check what the difference in money is
            local moneyDiff = GetCurrentMoney() - moneyBefore;
            local itemCountInBagDiff = itemCountInBagBefore - GetNumBagUsedSlots(BAG_BACKPACK)

            if (itemCountInBagDiff > 0) then
                -- at lesat one item was sold (although it might have been worthless)
                if (moneyDiff > 0) then
                    -- some valuable junk was sold
                    PAR.println("PAJ_SoldJunkInfo", itemCountInBagDiff, moneyDiff)
                else
                    -- only worthless junk was sold
                    PAR.println("PAJ_SoldJunkInfo", itemCountInBagDiff, moneyDiff)
                end
            else
                -- no item was sold
                if (moneyDiff > 0) then
                    -- no item was sold, but money appeared out of nowhere
                    -- should not happen :D
                    PAR.println("Error #1337: This should not happen!")
                end
            end
        end
    end
end


function PAJ.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local activeProfile = PA_SavedVars.General.activeProfile

    -- check if addon is enabled
    if PA_SavedVars.Junk[activeProfile].enabled then

        -- check if the updated happened in the backpack and if the item is new
        if ((bagId == BAG_BACKPACK) and (isNewItem)) then

            -- check if the item isnt already junk
            if not IsItemJunk(bagId, slotId) then
                -- get the itemType
                local itemType = GetItemType(bagId, slotId)
                local markAsJunk = false

                -- check if it is trash and if auto-flag-trash is enabled
                if ((itemType == ITEMTYPE_TRASH) and (PA_SavedVars.Junk[activeProfile].autoMarkTrash)) then
                    markAsJunk = true
                end

                -- TODO: check other item types etc.

                -----------------------------------------------------------------------

                if (markAsJunk) then
                    -- Now we know for sure the item _should_ be marked as Junk. Check if this indeed is possible.
                    if CanItemBeMarkedAsJunk(bagId, slotId) then
                        -- it is safe to mark the item as junk now
                        SetItemIsJunk(bagId, slotId, true)

                        local itemLink =  GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                        PAR.println("PAJ_MovedToJunk", itemLink)
                    end
                end
            end
        end
    end
end


function PAR.println(key, ...)
    if (not PA_SavedVars.Junk[PA_SavedVars.General.activeProfile].hideAllMsg) then
        local args = {...}
        PA.println(key, unpack(args))
    end
end


-- HasAnyJunk(number bagId, boolean excludeStolenItems)
-- Returns: boolean hasJunk

-- CanItemBeMarkedAsJunk(number bagId, number slotIndex)
-- Returns: boolean canBeMarkedAsJunk

-- IsItemJunk(number bagId, number slotIndex)
-- Returns: boolean junk

-- SetItemIsJunk(number bagId, number slotIndex, boolean junk)