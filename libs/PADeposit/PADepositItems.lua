-- Module: PersonalAssistant.PADeposit.Items
-- Developer: Klingo

PAD_Items = {}

function PAD_Items.DepositItems()
	local backpackItemTypeList = PAD_Items.getItemTypeList(BAG_BACKPACK)
	local bankItemTypeList = PAD_Items.getItemTypeList(BAG_BANK)
	local timer = 100
	
	PAD_Items.itemDeposited = false
	
	for currBackpackItem = 0, #backpackItemTypeList do
		-- store some transfer related information per item
		local transferInfo = {}
		transferInfo["fromBagId"] = BAG_BACKPACK
		transferInfo["toBagId"] = BAG_BANK
		transferInfo["fromItemName"] = GetItemName(transferInfo["fromBagId"], currBackpackItem):upper()
		transferInfo["fromItemLink"] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLink(transferInfo["fromBagId"], currBackpackItem, LINK_STYLE_BRACKETS))
		transferInfo["stackSize"] = GetSlotStackSize(transferInfo["fromBagId"], currBackpackItem)

		-- check if the item is marked as junk and whether junk shall be deposited too
		if IsItemJunk(transferInfo["fromBagId"], currBackpackItem) and not PA_SavedVars.Deposit.junk then
			-- do nothing; skip item
		else
			-- loop through all item types
			for currItemType = 0, #PAItemTypes do
				-- checks if this item type has been enabled for deposits
				if PA_SavedVars.Deposit.ItemTypes[currItemType] then
					-- then check if it does match the type of the backpack item
					if backpackItemTypeList[currBackpackItem] == PAItemTypes[currItemType] then
						
						-- then loop through all items in the bank
						for currBankItem = 0, #bankItemTypeList do
							-- store the name of the bank item
							transferInfo["toItemName"] = GetItemName(transferInfo["toBagId"], currBankItem):upper()
							
							-- compare the names
							if transferInfo["fromItemName"] == transferInfo["toItemName"] then
								-- item found in bank, transfer item from backpack to bank and get info how many items left
								PAD_Items.itemDeposited = true
								transferInfo["stackSize"] = PAD_Items.transferItem(currBackpackItem, currBankItem, transferInfo)
							end
							
							-- if no items left, break. otherwise continue the loop
							if transferInfo["stackSize"] == 0 then
								break
							-- if "-1" returned, not enough space was available. stop the rest.
							elseif transferInfo["stackSize"] < 0 then
								return
							end
						end
						
						-- all bank-items checked - are still stacks left?
						if transferInfo["stackSize"] > 0 then
							PAD_Items.itemDeposited = true
							zo_callLater(function() PAD_Items.transferItem(currBackpackItem, nil, transferInfo) end, timer)
							timer = timer + 250
							break
						end
					end
				end
			end
		end
	end
	
	return PAD_Items.itemDeposited
end

-- prepares the actual move
function PAD_Items.transferItem(fromSlotIndex, toSlotIndex, transferInfo)
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
			PAD_Items.moveItem(fromSlotIndex, toSlotIndex, moveableStackSize, transferInfo)
			
			-- Sometimes, when the item is not yet in the bank, the itemMove fails.
			-- Apparently this happens only if there are more than ~20 new items for the bank
			-- This method will check if the item is still in its original place after 2 seconds
			zo_callLater(function() PAD_Items.isItemMoved(fromSlotIndex, transferInfo) end, 2000)
		end
	
		return remainingStackSize
	else
		CHAT_SYSTEM:AddMessage(string.format("Not enough space in bank for: %s", transferInfo["fromItemLink"]))
		return -1
	end
end

-- checks if an item really has been moved or of it is still there
function PAD_Items.isItemMoved(fromSlotIndex, transferInfo)
	-- check if the same stack size is in the "old" slotIndex
	if (GetSlotStackSize(transferInfo["fromBagId"], fromSlotIndex) == transferInfo["stackSize"]) then
		-- check if the same item name is in the "old" slotIndex
		if (GetItemName(transferInfo["fromBagId"], fromSlotIndex):upper() == transferInfo["fromItemName"]) then
			-- the item is still there and has NOT been moved.
			CHAT_SYSTEM:AddMessage(string.format("FAILURE: %s could NOT be added to bank.", transferInfo["fromItemLink"]))
			-- try to transfer the item again (does not work YET, it generates an endless loop)
			-- zo_callLater(function() PAD_Items.transferItem(fromSlotIndex, nil, transferInfo) end, 500)
			-- TODO: maybe create a list for a post-processing
		end
	end
end

-- actually moves the item
function PAD_Items.moveItem(fromSlotIndex, toSlotIndex, stackSize, transferInfo)
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
		CHAT_SYSTEM:AddMessage(string.format("%s x %s was added to bank.", stackSize, transferInfo["fromItemLink"]))
	else
		CHAT_SYSTEM:AddMessage(string.format("%s was NOT added to bank.", transferInfo["fromItemLink"]))
	end
end

-- returns a list of all item types in a bag
function PAD_Items.getItemTypeList(bagId)
	local itemTypeList = {}
	local _, bagSlots = GetBagInfo(bagId )
	
	for slotIndex = 0, bagSlots - 1 do
		itemTypeList[slotIndex] = GetItemType(bagId, slotIndex)
	end
	
	return itemTypeList
end