-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

local function getGoldChangeAmount(currAmount, targetMinimum, transactionStep)
    local currMoneyKeepDiff = targetMinimum - currAmount

    -- only do additional caluclations if transaction step is > 1
    if (transactionStep > 1) then
        -- when the difference is positive, add the transactionStep to the diff
        if (currMoneyKeepDiff > 0) then
            -- since the diff-value is positive, we want do withdraw money
            currMoneyKeepDiff = currMoneyKeepDiff + transactionStep
        end
        -- afterwards, multiply (for all) the diff by the transactionStep
        currMoneyKeepDiff = currMoneyKeepDiff / transactionStep
        -- then round down
        currMoneyKeepDiff = PAHF.roundDown(currMoneyKeepDiff)
        -- and finally, multiply by the transactionStep
        currMoneyKeepDiff = currMoneyKeepDiff * transactionStep
    end

    return currMoneyKeepDiff
end


local function withdrawGold(goldChange)
    local bankedMoney = GetCurrencyAmount(CURT_MONEY, CURRENCY_LOCATION_BANK)

    if (bankedMoney >= goldChange) then
        -- actual WITHDRAWAL
        -- TODO: check for maxTransfer?
        TransferCurrency(CURT_MONEY, goldChange, CURRENCY_LOCATION_BANK, CURRENCY_LOCATION_CHARACTER)
        PAHF.println(L.PAB_GoldWithdrawn, goldChange)
    else
        -- not enough gold to withdraw planned amount; caclulcate minimum that can be withdrawn
        local goldTransactionStep = PASV.Banking[PA.activeProfile].goldTransactionStep
        local toWithdraw = getGoldChangeAmount(bankedMoney, 0, goldTransactionStep) * -1
        -- actual WITHDRAWAL
        -- TODO: check for maxTransfer?
        TransferCurrency(CURT_MONEY, toWithdraw, CURRENCY_LOCATION_BANK, CURRENCY_LOCATION_CHARACTER)
        PAHF.println(L.PAB_GoldWithdrawnInsufficient, toWithdraw, bankedMoney)
    end
end


local function depositGold(goldChange)
    -- actual DEPOSIT
    local maxTransfer = GetMaxCurrencyTransfer(CURT_MONEY, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
    if (maxTransfer >= goldChange) then
        TransferCurrency(CURT_MONEY, goldChange, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
        PAHF.println(L.PAB_GoldDeposited, goldChange)
    else
        TransferCurrency(CURT_MONEY, maxTransfer, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
        local exceededAmount = goldChange - maxTransfer
        -- TODO: dedicated message when not all can be transfer
        PAHF.println("Cannot deposit "..exceededAmount)
    end
end


-- =====================================================================================================================
-- =====================================================================================================================


local function DepositOrWithdrawGold()
    local currentMoney = GetCurrencyAmount(CURT_MONEY, CURRENCY_LOCATION_CHARACTER)
    local goldMinToKeep = PASV.Banking[PA.activeProfile].goldMinToKeep
    local withdrawToMinGold = PASV.Banking[PA.activeProfile].withdrawToMinGold
    local goldTransactionStep = PASV.Banking[PA.activeProfile].goldTransactionStep

    -- calculate the exact amount
    local goldChangeAmount = getGoldChangeAmount(currentMoney, goldMinToKeep, goldTransactionStep)

    if (goldChangeAmount < 0) then
        -- deposit money
        depositGold(goldChangeAmount * -1)
    elseif (goldChangeAmount > 0 and withdrawToMinGold) then
        -- withdraw money
        withdrawGold(goldChangeAmount)
    else
        -- no gold transaction required
    end
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.DepositOrWithdrawGold = DepositOrWithdrawGold