-- Module: PersonalAssistant.PADeposit
-- Developer: Klingo

PAD = {}

function PAD.OnBankOpen()
	-- check if addon is enabled
	if PA_SavedVars.Deposit.enabled then
	
		local goldDeposited = false
		local itemDeposited = false
		
		-- check if gold deposit is enabled
		if PA_SavedVars.Deposit.gold then
			-- check for numeric value, if not, use default value of 0
			local minGoldToKeep = 0
			
			if tonumber(PA_SavedVars.Deposit.minGoldToKeep) ~= nil then
				minGoldToKeep = PA_SavedVars.Deposit.minGoldToKeep
			end
			
			-- check if minim amount of gold to keep is exceeded
			if (GetCurrentMoney() > minGoldToKeep) then
				goldDeposited = PAD_Gold.DepositGold(minGoldToKeep)
			end
		end
		
		-- check if item deposit is enabled
		if PA_SavedVars.Deposit.items then
			itemDeposited = PAD_Items.DepositItems()
		end
		
		if (not goldDeposited) and (not itemDeposited) then
			if (not PA_SavedVars.Deposit.hideNoDepositMsg) then
				PAD.println("Nothing to deposit.")
			end
		end
	end
end

function PAD.println(msg)
	if PA_SavedVars.Deposit.hideAllMsg then return end
    CHAT_SYSTEM:AddMessage("PADeposit: " .. msg)
end