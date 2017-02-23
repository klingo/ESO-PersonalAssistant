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
            end

            -- check if item deposit is enabled
            if PA.savedVars.Banking[PA.activeProfile].enabledItems then
                -- TODO: TEMPORARILY DISABLED !!!!
--                PAB_Items.DepositWithdrawItems()
--                PAB_Items.loopCount = 0
--                itemTransaction = PAB_Items.DepositAndWithdrawItems()
            end
        end
    end
end

function PAB.OnBankClose()
    -- set the global variable to 'true' so the bankClosing can be detected
    PAB.isBankClosed = true
end
