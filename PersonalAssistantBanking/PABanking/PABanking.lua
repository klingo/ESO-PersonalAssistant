-- Module: PersonalAssistant.PABanking
-- Developer: Klingo

PAB.isBankClosed = true

-- =====================================================================================================================
-- =====================================================================================================================

function PAB.OnBankOpen()

    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Banking[PA.activeProfile].enabled then

            local goldTransaction = false
            local itemTransaction = false

            -- set the global variable to 'false'
            PAB.isBankClosed = false

            -- check if gold deposit is enabled
            if PA.savedVars.Banking[PA.activeProfile].enabledGold then
                -- trigger the deposit and withdrawal of gold
                PAB_Gold.DepositWithdrawGold()

--                -- check for numeric value, if not, use default value of 0
--                local goldMinToKeep = 0
--
--                if tonumber(PA.savedVars.Banking[PA.activeProfile].goldMinToKeep) ~= nil then
--                    goldMinToKeep = PA.savedVars.Banking[PA.activeProfile].goldMinToKeep
--                end
--
--                -- check if minim amount of gold to keep is exceeded
--                if (GetCurrentMoney() > goldMinToKeep) then
--                    goldTransaction = PAB_Gold.DepositGold(goldMinToKeep)
--                elseif (PA.savedVars.Banking[PA.activeProfile].withdrawToMinGold) then
--                    goldTransaction = PAB_Gold.WithdrawGold(goldMinToKeep)
--                end
            end

            -- check if item deposit is enabled
            if PA.savedVars.Banking[PA.activeProfile].enabledItems then
                PAB_Items.loopCount = 0
                itemTransaction = PAB_Items.DepositAndWithdrawItems()
            end

            -- FIXME: this check does currently not work, need to be called with zo_calllater
            -- FIXME2: it especially does not work with the advanced item types
--            if (not goldTransaction) and (not itemTransaction) then
--                if (not PA.savedVars.Banking[PA.activeProfile].hideNoDepositMsg) then
--                    PAHF.println("PAB_NoDeposit")
--                end
--            end
        end
    end
end

function PAB.OnBankClose()
    -- set the global variable to 'true' so the bankClosing can be detected
    PAB.isBankClosed = true
end
