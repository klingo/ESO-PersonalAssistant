-- Addon: PersonalAssistant.PARepair
-- Version: 1.0.0
-- Developer: Klingo

PAR = {}

function PAR.OnShopOpen()
	-- check if addon is enabled
	if PA_SavedVars.Repair.enabled == true then
		-- check if only equipped items shall be repaired
		if PA_SavedVars.Repair.onlyEquipped then
			PAR.RepairOnlyEquippedItems()
		else
			if GetCurrentMoney() >= GetRepairAllCost() then
				PAR.RepairAllItems()
			else
				PAR.println("Not enough gold.")
			end
		end
	end
end

function PAR.RepairAllItems()
    local repairAllCost = GetRepairAllCost()
	-- check if there is anything to repair at all
    if repairAllCost > 0 then
        RepairAll()
        PAR.println("All items repaired for " .. repairAllCost .. " gold.")
    else
        PAR.println("Nothing to repair.")
    end
end

function PAR.RepairInventoryItems()
	-- TODO: implement partial inventory repair
end

function PAR.RepairOnlyEquippedItems()
    local _, bagSlots = GetBagInfo(BAG_WORN)
    local repairEquippedCost = 0
	local notEnoughGold = false
	-- loop through every equipped item
    for slotIndex=0, bagSlots - 1 do
        local condition = GetItemCondition(bagId, slotIndex)
		-- compare the item's condition with the threshold
        if condition <= PA_SavedVars.Repair.threshold then
            local _, stackCount, _, _, _, _, _, quality = GetItemInfo(bagId, slotIndex)
            if stackCount > 0 then
				-- get the repairCost for that item and repair if possible
                local itemRepairCost = GetItemRepairCost(bagId, slotIndex)
                if itemRepairCost > 0 then
					if (itemRepairCost > GetCurrentMoney()) then
						-- not enough gold, stop loop
						notEnoughGold = true
						break
					else
						-- sum up the total repair costs
						repairEquippedCost = repairEquippedCost + itemRepairCost;
						RepairItem(bagId, slotIndex)
					end
                end
            end
		end
    end
	
	-- FIXME: if there is not enough gold to even repair the first item, it wrongly says that nothing was there to be repaired.
    if repairEquippedCost > 0 then
		if (notEnoughGold == true) then
			PAR.println("Not enough gold to repair all items.")
		else
			PAR.println("All equipped items repaired for " .. repairEquippedCost .. " gold")
		end
    else
        if PA_SavedVars.Repair.hideNoRepairMsg == false then
            PAR.println("Nothing to repair.")
        end
    end
end

function PAR.println(msg)
	if PA_SavedVars.Repair.hideAllMsg then return end
    d("PARepair: " .. msg)
end