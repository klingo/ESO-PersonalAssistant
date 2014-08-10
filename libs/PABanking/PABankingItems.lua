-- Module: PersonalAssistant.PABanking.Items
-- Developer: Klingo

PAB_Items = {}
PAB_Items.queueSize = 0
PAB_Items.loopCount = 0

function PAB_Items.DepositAndWithdrawItems(lastLoop)
	lastLoop = lastLoop or false
	
	PAB_Items.failedDeposits = 0
	PAB_Items.loopCount = PAB_Items.loopCount + 1
	
	-- first deposit items to the bank
	PAB_Items.itemsDeposited = PAB_Items.DoItemTransaction(BAG_BACKPACK, BAG_BANK, PAC_ITEMTYPE_DEPOSIT, lastLoop)
	
	-- then withdraw items from the bank
	PAB_Items.itemsWithdrawn = PAB_Items.DoItemTransaction(BAG_BANK, BAG_BACKPACK, PAC_ITEMTYPE_WITHDRAWAL, lastLoop)
	
	-- then we can deposit the advanced items to the bank
	PAB_Items.itemsAdvancedDepositedWithdrawn = PAB_AdvancedItems.DoAdvancedItemTransaction()
	
	if (PAB_Items.itemsDeposited or PAB_Items.itemsWithdrawn or PAB_Items.itemsAdvancedDepositedWithdrawn) then
		return true
	else
		return false
	end
end

function PAB_Items.DoItemTransaction(fromBagId, toBagId, transactionType, lastLoop)
	local timer = 100
	local skipChecksAndProceed = false
	
	local fromBagItemTypeList = PAB_Items.getItemTypeList(fromBagId)
	local toBagItemTypeList = PAB_Items.getItemTypeList(toBagId)
	
	-- pre-determine if in case of Junk the checks shall be skipped
	if ((transactionType == PAC_ITEMTYPE_DEPOSIT) and (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting == PAC_ITEMTYPE_DEPOSIT)) then
		-- we are in deposit mode and junk shall be deposited
		skipChecksAndProceed = true
	elseif ((transactionType == PAC_ITEMTYPE_WITHDRAWAL) and (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting == PAC_ITEMTYPE_WITHDRAWAL)) then
		-- we are in withdrawal mode and junk shall be withdrawn
		skipChecksAndProceed = true
	end
	
	for currFromBagItem = 0, #fromBagItemTypeList do
		-- store some transfer related information per item
		local transferInfo = {}
		transferInfo["fromBagId"] = fromBagId
		transferInfo["toBagId"] = toBagId
		transferInfo["fromItemName"] = GetItemName(transferInfo["fromBagId"], currFromBagItem):upper()
		transferInfo["fromItemLink"] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLink(transferInfo["fromBagId"], currFromBagItem, LINK_STYLE_BRACKETS))
		transferInfo["stackSize"] = GetSlotStackSize(transferInfo["fromBagId"], currFromBagItem)
		
		local isJunk = IsItemJunk(transferInfo["fromBagId"], currFromBagItem)
		
		-- check if the item is marked as junk and whether junk shall be deposited too
		if isJunk and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting == PAC_ITEMTYPE_IGNORE then
			-- do nothing; skip item (no junk shall be moved)
		elseif isJunk and ((transactionType == PAC_ITEMTYPE_DEPOSIT) and (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting == PAC_ITEMTYPE_WITHDRAWAL)) then
			-- do nothing; skip item (junk has to be withdrawn but we are in deposit mode)
		elseif isJunk and ((transactionType == PAC_ITEMTYPE_WITHDRAWAL) and (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting == PAC_ITEMTYPE_DEPOSIT)) then
			-- do nothing; skip item (junk has to be deposited but we are in withdraw mode)
		else
			-- loop through all item types
			for currItemType = 0, #PAItemTypes do
				-- checks if this item type has been enabled for deposits/withdraws and if it does match the type of the source item.... or if it is Junk and checks shall be skipped
				if (((PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypes[currItemType] == transactionType) and (fromBagItemTypeList[currFromBagItem] == PAItemTypes[currItemType])) or (isJunk and skipChecksAndProceed)) then
					-- then loop through all items in the target bag
					for currToBagItem = 0, #toBagItemTypeList do
						-- store the name of the target item
						transferInfo["toItemName"] = GetItemName(transferInfo["toBagId"], currToBagItem):upper()
						
						-- compare the names
						if transferInfo["fromItemName"] == transferInfo["toItemName"] then
							-- item found in target bag, transfer item from source bag to target bag and get info how many items left
							PAB_Items.itemMoved = true
							transferInfo["stackSize"] = PAB_Items.transferItem(currFromBagItem, currToBagItem, transferInfo, lastLoop)
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
						zo_callLater(function() PAB_Items.transferItem(currFromBagItem, nil, transferInfo, lastLoop) end, timer)
						timer = timer + PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsTimerInterval
						-- increase the queue of the "callLater" calls
						PAB_Items.queueSize = PAB_Items.queueSize + 1
						break
					end

				end
			end
		end
	end
	
	return PAB_Items.itemMoved
end

-- prepares the actual move
function PAB_Items.transferItem(fromSlotIndex, toSlotIndex, transferInfo, lastLoop)
	-- if there is no toSlot, try to find one
	if toSlotIndex == nil then toSlotIndex = FindFirstEmptySlotInBag(transferInfo["toBagId"]) end
	-- good, there is a slot
	if toSlotIndex ~= nil then
		local bankStackSize = GetSlotStackSize(transferInfo["toBagId"], toSlotIndex)
		-- have to read GetSlotStackSize again, as the targetBag-Slot could be empty, leading to value 0
		local _, maxStackSize = GetSlotStackSize(transferInfo["fromBagId"], fromSlotIndex)
		-- new stack size = maxStackSize minus existing bankStack
		local moveableStackSize = maxStackSize - bankStackSize
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
			-- This method will check if the item is still in its original place after 1-2 seconds
			-- and prints a message in case it happened again.
			zo_callLater(function() PAB_Items.isItemMoved(fromSlotIndex, moveableStackSize, transferInfo, lastLoop) end, (1000 + PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsTimerInterval))
		end
	
		return remainingStackSize
	else
		PAB.println("PAB_NoSpaceInFor", PA.getBagName(transferInfo["toBagId"]) , transferInfo["fromItemLink"])
		return -1
	end
end

-- checks if an item really has been moved or of it is still there
function PAB_Items.isItemMoved(fromSlotIndex, moveableStackSize, transferInfo, lastLoop)
	local depositFailed = false
	-- check if the same stack size is in the "old" slotIndex
	if (GetSlotStackSize(transferInfo["fromBagId"], fromSlotIndex) == transferInfo["stackSize"]) then
		-- check if the same item name is in the "old" slotIndex
		if (GetItemName(transferInfo["fromBagId"], fromSlotIndex):upper() == transferInfo["fromItemName"]) then
			-- the item is still there and has NOT been moved.
			depositFailed = true
			PAB_Items.failedDeposits = PAB_Items.failedDeposits + 1
			if lastLoop then
				PAB.println("PAB_ItemMovedToFailed", transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
			end
		end
	end
	
	if not depositFailed then
		-- now we know for sure that the deposit did work
		PAB.println("PAB_ItemMovedTo", moveableStackSize, transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
	end
	
	-- decrease the queue size as the check has been done
	PAB_Items.queueSize = PAB_Items.queueSize - 1
	
	if PAB_Items.queueSize == 0 then
		PAB_Items.reDeposit()
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
		-- we only know for sure that it did work after the check that is done later. Don't post the success message yet!
		-- PAB.println("PAB_ItemMovedTo", stackSize, transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
	else
		PAB.println("PAB_ItemNotMovedTo", stackSize, transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"]))
	end
end


-- checks if there are failedDeposits and re-runs the whole deposit-process in case the bank has not yet been closed
function PAB_Items.reDeposit()
	-- the bank is still open and there were failed Deposits
	if not PAB.isBankClosed and PAB_Items.failedDeposits > 0 then
		-- only run the deposit again if it didn't loop for three times yet
		if PAB_Items.loopCount < PAB_MAX_DEPOSIT_LOOPS then
			-- do it again! :)
			PAB_Items.DepositAndWithdrawItems()
		elseif PAB_Items.loopCount == PAB_MAX_DEPOSIT_LOOPS then
			-- and a last time (lastLoop = true)
			PAB_Items.DepositAndWithdrawItems(true)
		end
	else
		-- either the bank was closed or there are no more items to be deposited; or the maxLoop was reached
		-- TODO: implement summary stats
	end
end


-- ---------------------------------------------------------------------------------------------------------------
-- returns a list of all item types in a bag
function PAB_Items.getItemTypeList(bagId)
	local itemTypeList = {}
	local bagSlots = GetBagSize(bagId)
	
	for slotIndex = 0, bagSlots - 1 do
		itemTypeList[slotIndex] = GetItemType(bagId, slotIndex)
	end
	
	return itemTypeList
end

-- returns a list of all item names in a bag
function PAB_Items.getItemNameList(bagId)
	local itemNameList = {}
	local bagSlots = GetBagSize(bagId)
	
	for slotIndex = 0, bagSlots - 1 do
		itemNameList[slotIndex] = GetItemName(bagId, slotIndex):upper()
	end
	
	return itemNameList
end