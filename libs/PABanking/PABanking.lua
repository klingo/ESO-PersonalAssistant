-- Module: PersonalAssistant.PABanking
-- Developer: Klingo

PAB = {}
PAB.isBankClosed = false

function PAB.OnBankOpen()
	-- check if addon is enabled
	if PA_SavedVars.Banking.enabled then
	
		local goldTransaction = false
		local itemTransaction = false
		
		-- set the global variable to 'false'
		PAB.isBankClosed = false
		
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
			PAB_Items.loopCount = 0
			itemTransaction = PAB_Items.DepositAndWithdrawItems()
		end
		
		if (not goldTransaction) and (not itemTransaction) then
			if (not PA_SavedVars.Banking.hideNoDepositMsg) then
				PA.println("PAB_NoDeposit")
			end
		end
	end
end

function PAB.OnBankClose()
	-- set the global variable to 'true' so the bankClosing can be detected
	PAB.isBankClosed = true
end