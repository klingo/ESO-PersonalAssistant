-- Module: PersonalAssistant.PABanking.Items
-- Developer: Klingo

PAB_Items = {}

function PAB_Items.DepositAndWithdrawItems()
	local backpackItemTypeList = PAB_Items.getItemTypeList(BAG_BACKPACK)
	local bankItemTypeList = PAB_Items.getItemTypeList(BAG_BANK)
	
	-- first deposit items to the bank
	PAB_Items.itemsDeposited = PAB_Items.DoItemTransaction(BAG_BACKPACK, BAG_BANK, backpackItemTypeList, bankItemTypeList, PAC_ITEMTYPE_DEPOSIT)
	
	-- then update lists and withdraw items from the bank
	backpackItemTypeList = PAB_Items.getItemTypeList(BAG_BACKPACK)
	bankItemTypeList = PAB_Items.getItemTypeList(BAG_BANK)
	PAB_Items.itemsWithdrawn = PAB_Items.DoItemTransaction(BAG_BANK, BAG_BACKPACK, bankItemTypeList, backpackItemTypeList, PAC_ITEMTYPE_WITHDRAWAL)
	
	if (PAB_Items.itemsDeposited or PAB_Items.itemsWithdrawn) then
		return true
	else
		return false
	end
end

function PAB_Items.DoItemTransaction(fromBagId, toBagId, fromBagItemTypeList, toBagItemTypeList, transactionType)
	local timer = 100
	
	for currFromBagItem = 0, #fromBagItemTypeList do
		-- store some transfer related information per item
		local transferInfo = {}
		transferInfo["fromBagId"] = fromBagId
		transferInfo["toBagId"] = toBagId
		transferInfo["fromItemName"] = GetItemName(transferInfo["fromBagId"], currFromBagItem):upper()
		transferInfo["fromItemLink"] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLink(transferInfo["fromBagId"], currFromBagItem, LINK_STYLE_BRACKETS))
		transferInfo["stackSize"] = GetSlotStackSize(transferInfo["fromBagId"], currFromBagItem)

		-- check if the item is marked as junk and whether junk shall be deposited too
		if IsItemJunk(transferInfo["fromBagId"], currFromBagItem) and not PA_SavedVars.Banking.itemsIncludeJunk then
			-- do nothing; skip item
		else
			-- loop through all item types
			for currItemType = 0, #PAItemTypes do
				-- checks if this item type has been enabled for deposits/withdraws
				if PA_SavedVars.Banking.ItemTypes[currItemType] == transactionType then
					-- then check if it does match the type of the source item
					if fromBagItemTypeList[currFromBagItem] == PAItemTypes[currItemType] then
						
						-- then loop through all items in the target bag
						for currToBagItem = 0, #toBagItemTypeList do
							-- store the name of the target item
							transferInfo["toItemName"] = GetItemName(transferInfo["toBagId"], currToBagItem):upper()
							
							-- compare the names
							if transferInfo["fromItemName"] == transferInfo["toItemName"] then
								-- item found in target bag, transfer item from source bag to target bag and get info how many items left
								PAB_Items.itemMoved = true
								transferInfo["stackSize"] = PAB_Items.transferItem(currFromBagItem, currToBagItem, transferInfo)
							end
							
							-- if no items left, break. otherwise continue the loop
							if transferInfo["stackSize"] == 0 then
								break
							-- if "-1" returned, not enough space was available. stop the rest.
							elseif transferInfo["stackSize"] < 0 then
								return
							end
						end
						
						-- all target-items checked - are still stacks left?
						if transferInfo["stackSize"] > 0 then
							PAB_Items.itemMoved = true
							zo_callLater(function() PAB_Items.transferItem(currFromBagItem, nil, transferInfo) end, timer)
							timer = timer + 300
							break
						end
					end
				end
			end
		end
	end
	
	return PAB_Items.itemMoved
end

-- prepares the actual move
function PAB_Items.transferItem(fromSlotIndex, toSlotIndex, transferInfo)
	-- if there is no toSlot, try to find one
	if toSlotIndex == nil then toSlotIndex = FindFirstEmptySlotInBag(transferInfo["toBagId"]) end
	-- good, there is a slot
	if toSlotIndex ~= nil then
		local bankStackSize = GetSlotStackSize(transferInfo["toBagId"], toSlotIndex)
		-- new stack size modulo 100 (max size)
		local moveableStackSize = 100 - bankStackSize
		local remainingStackSize = 0
		
		if (transferInfo["stackSize"] <= moveableStackSize) then
			moveableStackSize = transferInfo["stackSize"]
		else
			remainingStackSize = transferInfo["stackSize"] - moveableStackSize
		end

		if moveableStackSize > 0 then
			PAB_Items.moveItem(fromSlotIndex, toSlotIndex, moveableStackSize, transferInfo)
			
			-- Before version 1.4.0 it could happen that when the item is not yet in the bank, the itemMove failed.
			-- This used to happen only if there are more than ~20 new items for the bank.
			-- This method will check if the item is still in its original place after 2 seconds
			-- and prints a message in case it happened again.
			zo_callLater(function() PAB_Items.isItemMoved(fromSlotIndex, transferInfo) end, 2000)
		end
	
		return remainingStackSize
	else
		PA.println("PAB_NoSpaceInFor", PA.getBagName(transferInfo["toBagId"]) , transferInfo["fromItemLink"])
		return -1
	end
end

-- checks if an item really has been moved or of it is still there
function PAB_Items.isItemMoved(fromSlotIndex, transferInfo)
	-- check if the same stack size is in the "old" slotIndex
	if (GetSlotStackSize(transferInfo["fromBagId"], fromSlotIndex) == transferInfo["stackSize"]) then
		-- check if the same item name is in the "old" slotIndex
		if (GetItemName(transferInfo["fromBagId"], fromSlotIndex):upper() == transferInfo["fromItemName"]) then
			-- the item is still there and has NOT been moved.
			PA.println("PAB_ItemMovedToFailed", transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
			
			-- try to transfer the item again (does not work YET, it generates an endless loop)
			-- zo_callLater(function() PAB_Items.transferItem(fromSlotIndex, nil, transferInfo) end, 500)
			-- TODO: maybe create a list for a post-processing
		end
	end
end

-- actually moves the item
function PAB_Items.moveItem(fromSlotIndex, toSlotIndex, stackSize, transferInfo)
    local result = true
    -- clear the cursor first
    ClearCursor()
    -- call secure protected (pickup the item via cursor)
    result = CallSecureProtected("PickupInventoryItem", transferInfo["fromBagId"], fromSlotIndex, stackSize)
    if (result) then
        -- call secure protected (drop the item on the cursor)
        result = CallSecureProtected("PlaceInInventory", transferInfo["toBagId"], toSlotIndex)
    end
    -- clear the cursor again to avoid issues
    ClearCursor()
	
	if result then
		PA.println("PAB_ItemMovedTo", stackSize, transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
	else
		PA.println("PAB_ItemNotMovedTo", stackSize, transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
	end
end

-- ---------------------------------------------------------------------------------------------------------------
-- returns a list of all item types in a bag
function PAB_Items.getItemTypeList(bagId)
	local itemTypeList = {}
	local _, bagSlots = GetBagInfo(bagId )
	
	for slotIndex = 0, bagSlots - 1 do
		itemTypeList[slotIndex] = GetItemType(bagId, slotIndex)
	end
	
	return itemTypeList
end