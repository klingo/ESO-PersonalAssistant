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
	-- first check if hireling chests have to be opened
--	if PA_SavedVars.Banking.openHirelingChest then
		-- open all hireling chests
--		PAB_Items.openHirelingChests(backpackItemTypeList)
		-- update the backpack list after opening the hireling chests
--		backpackItemTypeList = PAB_Items.getItemTypeList(BAG_BACKPACK)
--	end
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
	-- if there is not toSlot, try to find one
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
			
			-- Sometimes, when the item is not yet in the bank, the itemMove fails.
			-- Apparently this happens only if there are more than ~20 new items for the bank
			-- This method will check if the item is still in its original place after 2 seconds
			zo_callLater(function() PAB_Items.isItemMoved(fromSlotIndex, transferInfo) end, 2000)
		end
	
		return remainingStackSize
	else
		CHAT_SYSTEM:AddMessage(string.format("Not enough space in %s for: %s", PA.getBagName(transferInfo["toBagId"]) , transferInfo["fromItemLink"]))
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
			CHAT_SYSTEM:AddMessage(string.format("FAILURE: %s could NOT be moved to %s.", transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"])))
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
		CHAT_SYSTEM:AddMessage(string.format("%s x %s was moved to %s.", stackSize, transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"])))
	else
		CHAT_SYSTEM:AddMessage(string.format("%s was NOT moved to %s.", transferInfo["fromItemLink"], PA.getBagName(transferInfo["toBagId"])))
	end
end

-- opens all Hireling chests in a bag
--function PAB_Items.openHirelingChests(bagItemList)
--	for currBagItem = 0, #bagItemList do
--		if bagItemList[currBagItem] == ITEMTYPE_CONTAINER then
--			if IsItemUsable(BAG_BACKPACK, currBagItem) then
--				if CheckInventorySpaceAndWarn(5) then
--					local itemName = GetItemName(BAG_BACKPACK, currBagItem)
--					if PAB_Items.isItemNameHirelingChest(itemName) then
--						-- clear the cursor first
--						ClearCursor()
--						-- call secure protected (use item via cursor)
--						CallSecureProtected("UseItem", BAG_BACKPACK, currBagItem)
--						-- clear the cursor again to avoid issues
--						ClearCursor()
--					end
--				else
--					CHAT_SYSTEM:AddMessage("PABanking: Not enough space in backpack to open hireling chest.")
--				end
--			end
--		end
--	end
--end

-- checks if one of the distinct profession names is found within the itemName
--function PAB_Items.isItemNameHirelingChest(itemName)
--	if string.find(itemName, "Blacksmith") ~= nil then return true end
--	if string.find(itemName, "Clothier") ~= nil then return true end
--	if string.find(itemName, "Enchanter") ~= nil then return true end
--	if string.find(itemName, "Woodworker") ~= nil then return true end
--	return false
--end

-- returns a list of all item types in a bag
function PAB_Items.getItemTypeList(bagId)
	local itemTypeList = {}
	local _, bagSlots = GetBagInfo(bagId )
	
	for slotIndex = 0, bagSlots - 1 do
		itemTypeList[slotIndex] = GetItemType(bagId, slotIndex)
	end
	
	return itemTypeList
end