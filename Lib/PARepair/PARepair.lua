-- Module: PersonalAssistant.PARepair
-- Developer: Klingo

PAR = {}

function PAR.OnShopOpen()
	-- check if addon is enabled
	if PA_SavedVars.Repair.enabled == true then
		-- early check if there is something to repair
		if GetRepairAllCost() > 0 then
			-- check if equipped items shall be repaired
			if PA_SavedVars.Repair.equipped then
				PAR.RepairItems(BAG_WORN, PA_SavedVars.Repair.equippedThreshold)
			end
			-- check if inventory items shall be repaired
			if PA_SavedVars.Repair.inventory then
				PAR.RepairItems(BAG_BACKPACK, PA_SavedVars.Repair.inventoryThreshold)
			end
		else
			if PA_SavedVars.Repair.hideNoRepairMsg == false then
				d("PARepair: Nothing to repair.")
			end
		end
	end
end

function PAR.RepairItems(bagId, threshold)
	local _, bagSlots = GetBagInfo(bagId)
	local repairCost = 0
	local missingGold = 0	-- TODO: implement a missing gold to repair feature
	local repairedItems = 0
	local notRepairedItems = 0
	
	-- loop through all items of the corresponding bagId
	for slotIndex=0, bagSlots - 1 do
		-- check first if the item has durability (and therefore is repairable)
		if DoesItemHaveDurability(bagId, slotIndex) then
			-- then compare it with the threshold
			if GetItemCondition(bagId, slotIndex) <= threshold then
				local _, stackCount, _, _, _, _, _, _ = GetItemInfo(bagId, slotIndex)
				if stackCount > 0 then
					-- get the repair cost for that item and repair if possible
					local itemRepairCost = GetItemRepairCost(bagId, slotIndex)
					if itemRepairCost > 0 then
						if (itemRepairCost > GetCurrentMoney()) then
							-- even though not enough money available, continue as maybe a cheaper item still can be repaired
							notRepairedItems = notRepairedItems + stackCount
						else
							-- sum up the total repair costs
							repairCost = repairCost + itemRepairCost;
							repairedItems = repairedItems + stackCount
							RepairItem(bagId, slotIndex)
						end
					end
				end
			end
		end
	end

	local bagName = PAR.getBagName(bagId)

	-- check if the msg-output shall be skipped
	if PA_SavedVars.Repair.hideAllMsg then return end
	
	if repairedItems > 0 then
		if notRepairedItems > 0 then
			d("PARepair: " .. repairedItems .. " / " .. notRepairedItems .. " " .. bagName .. " items repaired for " .. repairCost .. " gold. (not enough gold)")
		else
			d("PARepair: All " .. bagName .. " items repaired for " .. repairCost .. " gold.")
		end
	else
		if notRepairedItems > 0 then
			d("PARepair: Not enough gold to repair " .. notRepairedItems .. " " .. bagName .. " items.")
		else
			if PA_SavedVars.Repair.hideNoRepairMsg == false then
				d("PARepair: Nothing to repair.")
			end
		end
	end
end

function PAR.getBagName(bagId)
	if (bagId == BAG_WORN) then
		return "equipped"
	else if (bagId == BAG_BACKPACK) then 
		return "inventory"
	else
		return "unknown"
	end
end

-- FIXME: does not support multiple parameters (yet)
function PAR.println(msg)
	if PA_SavedVars.Repair.hideAllMsg then return end
		d("PARepair: " .. msg)
	end
end