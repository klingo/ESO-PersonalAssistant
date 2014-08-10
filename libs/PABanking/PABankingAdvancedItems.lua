-- Module: PersonalAssistant.PABanking.AdvancedItems
-- Developer: Klingo

PAB_AdvancedItems = {}

function PAB_AdvancedItems.DoAdvancedItemTransaction()
	local timer = 100
	
	-- let us start with the lockpicks!
	local backpackItemNameList = PAB_Items.getItemNameList(BAG_BACKPACK)
	local bankItemNameList = PAB_Items.getItemNameList(BAG_BANK)
	
	-- store some transfer related information
	local transferList = {}
	local transferInfo = {}
	local currRowIndex = 0
	
	-- TODO: loop this part?
	local checkItemName = PAL.getResourceMessage("PAItemType_Lockpick"):upper()
	
	
-- populate the transfer List here
-- -------------------------------------------------------------------------------------------------
	transferList[0] = checkItemName
	transferInfo[checkItemName] = {}
	transferInfo[checkItemName]["operator"] = PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypesAdvanced[PA_ITEMTYPE_LOCKIPCK].Key
	transferInfo[checkItemName]["targetStackSize"] = PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypesAdvanced[PA_ITEMTYPE_LOCKIPCK].Value
	
	if (transferInfo[checkItemName]["operator"] ~= PAC_OPERATOR_NONE) then
		for currBackpackItem = 0, #backpackItemNameList do
			if (backpackItemNameList[currBackpackItem] == PAL.getResourceMessage("PAItemType_Lockpick"):upper()) then
				-- create a new row in the table
				transferInfo[currRowIndex] = {}
				transferInfo[currRowIndex]["itemName"] = backpackItemNameList[currBackpackItem]
				transferInfo[currRowIndex]["bagId"] = BAG_BACKPACK
				transferInfo[currRowIndex]["slotIndex"] = currBackpackItem
				PA.println("slotindex : "..tostring(currBackpackItem).." in row "..tostring(currRowIndex).." (size: "..tostring(GetSlotStackSize(BAG_BACKPACK, currBackpackItem))..")")
				transferInfo[currRowIndex]["slotStackSize"] = GetSlotStackSize(BAG_BACKPACK, currBackpackItem)
				if (transferInfo[checkItemName]["backpackStackSize"] == nil) then
					if (transferInfo[currRowIndex]["slotStackSize"] == nil) then
						transferInfo[checkItemName]["backpackStackSize"] = 0
					else
						transferInfo[checkItemName]["backpackStackSize"] = transferInfo[currRowIndex]["slotStackSize"]
					end
				else
					transferInfo[checkItemName]["backpackStackSize"] = transferInfo[checkItemName]["backpackStackSize"] + transferInfo[currRowIndex]["slotStackSize"]
				end
				currRowIndex = currRowIndex + 1
			end
		end
		
		for currBankItem = 0, #bankItemNameList do
			if (bankItemNameList[currBankItem] == PAL.getResourceMessage("PAItemType_Lockpick"):upper()) then
				-- create a new row in the table
				transferInfo[currRowIndex] = {}
				transferInfo[currRowIndex]["itemName"] = bankItemNameList[currBankItem]
				transferInfo[currRowIndex]["bagId"] = BAG_BANK
				transferInfo[currRowIndex]["slotIndex"] = currBankItem
				transferInfo[currRowIndex]["slotStackSize"] = GetSlotStackSize(BAG_BANK, currBankItem)
				if (transferInfo[checkItemName]["bankStackSize"] == nil) then
					if (transferInfo[currRowIndex]["slotStackSize"] == nil) then
						transferInfo[checkItemName]["bankStackSize"] = 0
					else
						transferInfo[checkItemName]["bankStackSize"] = transferInfo[currRowIndex]["slotStackSize"]
					end
				else
					transferInfo[checkItemName]["bankStackSize"] = transferInfo[checkItemName]["bankStackSize"] + transferInfo[currRowIndex]["slotStackSize"]
				end
				currRowIndex = currRowIndex + 1
			end
		end
	end
	
	if (transferInfo[checkItemName]["backpackStackSize"] == nil) then
		transferInfo[checkItemName]["backpackStackSize"] = 0
	end
	if (transferInfo[checkItemName]["bankStackSize"] == nil) then
		transferInfo[checkItemName]["bankStackSize"] = 0
	end
	
	
	
-- go through the transfer list and prepare the transfers
-- -------------------------------------------------------------------------------------------------
	for currItemTransferIndex = 0, #transferList do

		checkItemName = transferList[currItemTransferIndex]
		if (transferInfo[checkItemName]["backpackStackSize"] >= transferInfo[checkItemName]["targetStackSize"]) then
			-- we already have enough items in the bank - no withdrawal, but maybe depositing required
			if ((transferInfo[checkItemName]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemName]["operator"] == PAC_OPERATOR_LESSTAHNEQAL)) then
				transferInfo[checkItemName]["toDeposit"] = transferInfo[checkItemName]["backpackStackSize"] - transferInfo[checkItemName]["targetStackSize"]
				transferInfo[checkItemName]["toWithdraw"] = 0
			elseif (transferInfo[checkItemName]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL) then
				transferInfo[checkItemName]["toDeposit"] = 0
				transferInfo[checkItemName]["toWithdraw"] = 0
			end
			
		elseif ((transferInfo[checkItemName]["backpackStackSize"] + transferInfo[checkItemName]["bankStackSize"]) >= transferInfo[checkItemName]["targetStackSize"]) then
			-- with the bank, there are enough items - withdrawal might be required!
			if ((transferInfo[checkItemName]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemName]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL)) then
				transferInfo[checkItemName]["toDeposit"] = 0
				transferInfo[checkItemName]["toWithdraw"] = transferInfo[checkItemName]["targetStackSize"] - transferInfo[checkItemName]["backpackStackSize"]
			elseif (transferInfo[checkItemName]["operator"] == PAC_OPERATOR_LESSTAHNEQAL) then
				transferInfo[checkItemName]["toDeposit"] = 0
				transferInfo[checkItemName]["toWithdraw"] = 0
			end
			
		elseif (transferInfo[checkItemName]["bankStackSize"] > 0) then
			-- not enough items in total, but there are some left in the bank
			transferInfo[checkItemName]["toDeposit"] = 0
			transferInfo[checkItemName]["toWithdraw"] = transferInfo[checkItemName]["bankStackSize"]
			if ((transferInfo[checkItemName]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemName]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL)) then
				-- SHOW WARNING: NOT ENOUGH ITEMS !!!
			end
			
		else
			-- not enough items in total and nothing left in the bank
			transferInfo[checkItemName]["toDeposit"] = 0
			transferInfo[checkItemName]["toWithdraw"] = 0
			if ((transferInfo[checkItemName]["operator"] == PAC_OPERATOR_EQUAL) or (transferInfo[checkItemName]["operator"] == PAC_OPERATOR_GREATERTHANEQUAL)) then
				-- SHOW WARNING: NOT ENOUGH ITEMS !!!
			end
		end
		
	-- -------------------------------------------------------------------------------------------------
		if (transferInfo[checkItemName]["toDeposit"] > 0) then
			transferInfo["fromBagId"] = BAG_BACKPACK
			transferInfo["toBagId"] = BAG_BANK
		elseif (transferInfo[checkItemName]["toWithdraw"] > 0) then
			transferInfo["fromBagId"] = BAG_BANK
			transferInfo["toBagId"] = BAG_BACKPACK
		else
			return
		end
		
		-- total amount that shall be transferred
		local transferableAmount = transferInfo[checkItemName]["toDeposit"] + transferInfo[checkItemName]["toWithdraw"]
	
		for currCheckItemIndex = 0, #transferInfo do
			PA.println("finish: "..tostring(currCheckItemIndex))
			if (transferInfo[currCheckItemIndex]["itemName"] == checkItemName) then
				if (transferInfo[currCheckItemIndex]["bagId"] == transferInfo["fromBagId"]) then
					currFromBagItem = transferInfo[currCheckItemIndex]["slotIndex"]
					PA.println("aaa")
					if (transferInfo[currCheckItemIndex]["slotStackSize"] >= transferableAmount) then
						transferInfo["stackSize"] = transferableAmount
					else
						transferInfo["stackSize"] = transferInfo[currCheckItemIndex]["slotStackSize"]
						transferableAmount = transferableAmount - transferInfo[currCheckItemIndex]["slotStackSize"]
					end
					
					currToBagItem = nil
					
					transferInfo["fromItemName"] = checkItemName
					transferInfo["fromItemLink"] = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLink(transferInfo["fromBagId"], currFromBagItem, LINK_STYLE_BRACKETS))
					
					PA.println("currFromBagItem: "..tostring(currFromBagItem))
					PAB_Items.transferItem(currFromBagItem, currToBagItem, transferInfo, true)
					-- PAB_Items.transferItem(currFromBagItem, currToBagItem, transferInfo, lastLoop)
				end
			end
		end
	end
	
	-- TODO: Stack items
end