-- Module: PersonalAssistant.PABanking
-- Developer: Klingo

PAB.isBankClosed = true

function PAB.OnBankOpen()
	local activeProfile = PA.savedVars.General.activeProfile

	-- check if addon is enabled
	if PAB.savedVars[activeProfile].enabled then
	
		local goldTransaction = false
		local itemTransaction = false
		
		-- set the global variable to 'false'
		PAB.isBankClosed = false
		
		-- check if gold deposit is enabled
		if PAB.savedVars[activeProfile].gold then
			-- check for numeric value, if not, use default value of 0
			local goldMinToKeep = 0
			
			if tonumber(PAB.savedVars[activeProfile].goldMinToKeep) ~= nil then
				goldMinToKeep = PAB.savedVars[activeProfile].goldMinToKeep
			end
			
			-- check if minim amount of gold to keep is exceeded
			if (GetCurrentMoney() > goldMinToKeep) then
				goldTransaction = PAB_Gold.DepositGold(goldMinToKeep)
			elseif (PAB.savedVars[activeProfile].goldWithdraw) then
				goldTransaction = PAB_Gold.WithdrawGold(goldMinToKeep)
			end
		end
		
		-- check if item deposit is enabled
		if PAB.savedVars[activeProfile].items then
			PAB_Items.loopCount = 0
			itemTransaction = PAB_Items.DepositAndWithdrawItems()
		end
		
		-- FIXME: this check does currently not work, need to be called with zo_calllater
		-- FIXME2: it especially does not work with the advanced item types
		if (not goldTransaction) and (not itemTransaction) then
			if (not PAB.savedVars[activeProfile].hideNoDepositMsg) then
				PAB.println("PAB_NoDeposit")
			end
		end
	end
end

function PAB.OnBankClose()
	-- set the global variable to 'true' so the bankClosing can be detected
	PAB.isBankClosed = true
end

function PAB.println(key, ...)
	if (not PAB.savedVars[PA.savedVars.General.activeProfile].hideAllMsg) then
		local args = {...}
		PAHF.println(key, unpack(args))
	end
end