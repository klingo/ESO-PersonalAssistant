-- Module: PersonalAssistant.PABanking.AdvancedItems
-- Developer: Klingo

PAB_AdvancedItems = {}

function PAB_AdvancedItems.DoAdvancedItemTransaction()

    local activeProfile = PA.savedVars.General.activeProfile

	local movedAnything = false

	-- TODO: replace BACKPACK and BANK with FROM and TO
	local backpackItemNameList = PAB_Items.getItemNameList(BAG_BACKPACK)
	local bankItemNameList = PAB_Items.getItemNameList(BAG_BANK)
	
	-- store some transfer related information
	local transferList = {}
	local transferInfo = {}
	local currRowIndex = 0
		
	
-- populate the transfer List here
-- -------------------------------------------------------------------------------------------------
	-- let us start with the lockpicks!
	transferList[0] = PABItemTypesAdvanced[0]
-- 	transferList[1] = XYZ
-- 	transferList[2] = XYZ
	
	for transferIndex = 0, #transferList do
	
		local checkItemId = transferList[transferIndex]
		
		transferInfo[checkItemId] = {}
		transferInfo[checkItemId]["operator"] = PA.savedVars.Banking[activeProfile].ItemTypesAdvanced[transferIndex].Key
		transferInfo[checkItemId]["targetStackSize"] = PA.savedVars.Banking[activeProfile].ItemTypesAdvanced[transferIndex].Value
		
		if (transferInfo[checkItemId]["operator"] ~= PAC_OPERATOR_NONE) then
			for currBackpackItem = 0, #backpackItemNameList do
				if (GetItemId(BAG_BACKPACK, currBackpackItem) == checkItemId) then
					-- create a new row in the table
					transferInfo[currRowIndex] = {}
					transferInfo[currRowIndex]["fromItemName"] = backpackItemNameList[currBackpackItem]
					transferInfo[currRowIndex]["itemId"] = checkItemId
					transferInfo[currRowIndex]["bagId"] = BAG_BACKPACK
					transferInfo[currRowIndex]["slotIndex"] = currBackpackItem
					transferInfo[currRowIndex]["slotStackSize"] = GetSlotStackSize(BAG_BACKPACK, currBackpackItem)
					if (transferInfo[checkItemId]["backpackStackSize"] == nil) then
						if (transferInfo[currRowIndex]["slotStackSize"] == nil) then
							transferInfo[checkItemId]["backpackStackSize"] = 0
						else
							transferInfo[checkItemId]["backpackStackSize"] = transferInfo[currRowIndex]["slotStackSize"]
						end
					else
						transferInfo[checkItemId]["backpackStackSize"] = transferInfo[checkItemId]["backpackStackSize"] + transferInfo[currRowIndex]["slotStackSize"]
					end
					currRowIndex = currRowIndex + 1
				end
			end
			
			for currBankItem = 0, #bankItemNameList do
				if (GetItemId(BAG_BANK, currBankItem) == checkItemId) then
					-- create a new row in the table
					transferInfo[currRowIndex] = {}
					transferInfo[currRowIndex]["fromItemName"] = bankItemNameList[currBankItem]
					transferInfo[currRowIndex]["itemId"] = checkItemId
					transferInfo[currRowIndex]["bagId"] = BAG_BANK
					transferInfo[currRowIndex]["slotIndex"] = currBankItem
					transferInfo[currRowIndex]["slotStackSize"] = GetSlotStackSize(BAG_BANK, currBankItem)
					if (transferInfo[checkItemId]["bankStackSize"] == nil) then
						if (transferInfo[currRowIndex]["slotStackSize"] == nil) then
							transferInfo[checkItemId]["bankStackSize"] = 0
						else
							transferInfo[checkItemId]["bankStackSize"] = transferInfo[currRowIndex]["slotStackSize"]
						end
					else
						transferInfo[checkItemId]["bankStackSize"] = transferInfo[checkItemId]["bankStackSize"] + transferInfo[currRowIndex]["slotStackSize"]
					end
					currRowIndex = currRowIndex + 1
				end
			end
		end
		
		if (transferInfo[checkItemId]["backpackStackSize"] == nil) then
			transferInfo[checkItemId]["backpackStackSize"] = 0
		end
		if (transferInfo[checkItemId]["bankStackSize"] == nil) then
			transferInfo[checkItemId]["bankStackSize"] = 0
		end
		
		
		
	-- go through the transfer list and prepare the transfers
	-- -------------------------------------------------------------------------------------------------
		for currItemTransferIndex = 0, #transferList do

			checkItemId = transferList[currItemTransferIndex]
			if (transferInfo[checkItemId]["backpackStackSize"] >= transferInfo[checkItemId]["targetStackSize"]) then
				-- we already have enough items in the bank - no withdrawal, but maybe depositing required
				if ((transferInfo[checkItemId]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemId]["operator"] == PAC_OPERATOR_LESSTAHNEQAL)) then
					transferInfo[checkItemId]["toDeposit"] = transferInfo[checkItemId]["backpackStackSize"] - transferInfo[checkItemId]["targetStackSize"]
					transferInfo[checkItemId]["toWithdraw"] = 0
				elseif (transferInfo[checkItemId]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL) then
					transferInfo[checkItemId]["toDeposit"] = 0
					transferInfo[checkItemId]["toWithdraw"] = 0
				end
				
			elseif ((transferInfo[checkItemId]["backpackStackSize"] + transferInfo[checkItemId]["bankStackSize"]) >= transferInfo[checkItemId]["targetStackSize"]) then
				-- with the bank, there are enough items - withdrawal might be required!
				if ((transferInfo[checkItemId]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemId]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL)) then
					transferInfo[checkItemId]["toDeposit"] = 0
					transferInfo[checkItemId]["toWithdraw"] = transferInfo[checkItemId]["targetStackSize"] - transferInfo[checkItemId]["backpackStackSize"]
				elseif (transferInfo[checkItemId]["operator"] == PAC_OPERATOR_LESSTAHNEQAL) then
					transferInfo[checkItemId]["toDeposit"] = 0
					transferInfo[checkItemId]["toWithdraw"] = 0
				end
				
			elseif (transferInfo[checkItemId]["bankStackSize"] > 0) then
				-- not enough items in total, but there are some left in the bank
				transferInfo[checkItemId]["toDeposit"] = 0
				transferInfo[checkItemId]["toWithdraw"] = transferInfo[checkItemId]["bankStackSize"]
				if ((transferInfo[checkItemId]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemId]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL)) then
					-- SHOW WARNING: NOT ENOUGH ITEMS !!!
				end
				
			else
				-- not enough items in total and nothing left in the bank
				transferInfo[checkItemId]["toDeposit"] = 0
				transferInfo[checkItemId]["toWithdraw"] = 0
				if ((transferInfo[checkItemId]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemId]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL)) then
					-- SHOW WARNING: NOT ENOUGH ITEMS !!!
				end
			end
			
		-- -------------------------------------------------------------------------------------------------
			if (transferInfo[checkItemId]["toDeposit"] == nil) then
				return false
			elseif (transferInfo[checkItemId]["toDeposit"] > 0) then
				transferInfo["fromBagId"] = BAG_BACKPACK
				transferInfo["toBagId"] = BAG_BANK
			elseif (transferInfo[checkItemId]["toWithdraw"] > 0) then
				transferInfo["fromBagId"] = BAG_BANK
				transferInfo["toBagId"] = BAG_BACKPACK
			else
				return false
			end
			
			-- total amount that shall be transferred
			local transferableAmount = transferInfo[checkItemId]["toDeposit"] + transferInfo[checkItemId]["toWithdraw"]
		
			for currCheckItemIndex = 0, #transferInfo do
				if (transferableAmount > 0) then
					if (transferInfo[currCheckItemIndex]["itemId"] == checkItemId) then
						if (transferInfo[currCheckItemIndex]["bagId"] == transferInfo["fromBagId"]) then
							local currFromBagItem = transferInfo[currCheckItemIndex]["slotIndex"]
							if (transferInfo[currCheckItemIndex]["slotStackSize"] >= transferableAmount) then
								transferInfo["stackSize"] = transferableAmount
								transferableAmount = 0
							else
								transferInfo["stackSize"] = transferInfo[currCheckItemIndex]["slotStackSize"]
								transferableAmount = transferableAmount - transferInfo[currCheckItemIndex]["slotStackSize"]
							end
							
							-- get the best possible target bag slot index
							currToBagItem = PAB_AdvancedItems.getBestToBagSlotIndex(transferInfo, checkItemId)
							
							transferInfo["fromItemLink"] = PAHF.getFormattedItemLink(transferInfo["fromBagId"], currFromBagItem)
							
							movedAnything = true
							PAB_Items.transferItem(currFromBagItem, currToBagItem, transferInfo, true)
							-- PAB_Items.transferItem(currFromBagItem, currToBagItem, transferInfo, lastLoop)
						end
					end
				end
			end
		end
	end
	
	return movedAnything
end



function PAB_AdvancedItems.getBestToBagSlotIndex(transferInfo, checkItemId)

	for currCheckItemIndex = 0, #transferInfo do
		if (transferInfo[currCheckItemIndex]["itemId"] == checkItemId) then
			if (transferInfo[currCheckItemIndex]["bagId"] == transferInfo["toBagId"]) then
				local currToBagItem = transferInfo[currCheckItemIndex]["slotIndex"]
				local _, maxStackSize = GetSlotStackSize(transferInfo["toBagId"], currToBagItem)
				local freeStackSize = maxStackSize - transferInfo[currCheckItemIndex]["slotStackSize"]
				if (freeStackSize > 0) then
					return transferInfo[currCheckItemIndex]["slotIndex"]
				else
					-- stack already full; skip it!
				end
			end
		end
	end
	
	-- if there was nothing returned so far, start a new stack
	return nil
end