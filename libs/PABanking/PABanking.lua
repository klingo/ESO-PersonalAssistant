-- Module: PersonalAssistant.PABanking
-- Developer: Klingo

PAB = {}

function PAB.OnBankOpen()
	-- check if addon is enabled
	if PA_SavedVars.Banking.enabled then
	
		local goldTransaction = false
		local itemTransaction = false
		
		-- check if gold deposit is enabled
		if PA_SavedVars.Banking.gold then
			-- check for numeric value, if not, use default value of 0
			local goldMinToKeep = 0
			
			if tonumber(PA_SavedVars.Banking.goldMinToKeep) ~= nil then
				goldMinToKeep = PA_SavedVars.Banking.goldMinToKeep
			end
			
			-- check if minim amount of gold to keep is exceeded
			if (GetCurrentMoney() > goldMinToKeep) then
				goldTransaction = PAB_Gold.DepositGold(goldMinToKeep)
			elseif (PA_SavedVars.Banking.goldWithdraw) then
				goldTransaction = PAB_Gold.WithdrawGold(goldMinToKeep)
			end
		end
		
		-- check if item deposit is enabled
		if PA_SavedVars.Banking.items then
			-- check if hireling chests have to be opened
			if PA_SavedVars.Banking.openHirelingChest then
				-- open all hireling chests
				local timerDelay = PAB.openHirelingChests()
				
				-- give it some time to update after opening the hireling chests
				timerDelay = timerDelay + 1000
				zo_callLater(function() itemTransaction = PAB_Items.DepositAndWithdrawItems() end, timerDelay)
			else
				itemTransaction = PAB_Items.DepositAndWithdrawItems()
			end
		end
		
		-- FIXME: This check does not work in case of openedHirelingChests because of the callLater function
		if (not PA_SavedVars.Banking.openHirelingChest) and (not goldTransaction) and (not itemTransaction) then
			if (not PA_SavedVars.Banking.hideNoDepositMsg) then
				PA.println("PAB_NoDeposit")
			end
		end
	end
end

-- =========================================================================================================================
-- opens all Hireling chests in a bag
function PAB.openHirelingChests()
	local bagItemList = PAB_Items.getItemTypeList(BAG_BACKPACK)
	local timer = 0
	
	for currBagItem = 0, #bagItemList do
		if bagItemList[currBagItem] == ITEMTYPE_CONTAINER then
			if IsItemUsable(BAG_BACKPACK, currBagItem) then
				-- to be safe, check for 5 empty slots in the backpack
				if CheckInventorySpaceAndWarn(5) then
					local itemName = GetItemName(BAG_BACKPACK, currBagItem)
					if PAB.isItemNameHirelingChest(itemName) then
						zo_callLater(function() PAB.useItem(BAG_BACKPACK, currBagItem) end, timer)
						timer = timer + 500
					end
				else
					PA.println("PAB_NoSpaceToOpen", PA.getBagName(BAG_BACKPACK), zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLink(BAG_BACKPACK, currBagItem, LINK_STYLE_BRACKETS)))
				end
			end
		end
	end
	
	return timer
end

function PAB.useItem(bagId, slotIndex)
	PA.println("PAB_Hireling_UseItem", zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)))
	-- clear the cursor first
	ClearCursor()
	-- call secure protected (use item via cursor)
	CallSecureProtected("UseItem", bagId, slotIndex)
	-- clear the cursor again to avoid issues
	ClearCursor()
end

-- checks if one of the distinct profession names is found within the itemName
function PAB.isItemNameHirelingChest(itemName)
	if string.find(itemName, PA.getResourceMessage("PAB_Hireling_Blacksmith")) ~= nil then return true end
	if string.find(itemName, PA.getResourceMessage("PAB_Hireling_Clothier")) ~= nil then return true end
	if string.find(itemName, PA.getResourceMessage("PAB_Hireling_Enchanter")) ~= nil then return true end
	if string.find(itemName, PA.getResourceMessage("PAB_Hireling_Woodworker")) ~= nil then return true end
	return false
end