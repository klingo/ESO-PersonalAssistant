-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

local function withdrawCurrency(ccyAmountToWithdraw, currencyType)
    local ccyAmountOnBank = GetCurrencyAmount(currencyType, CURRENCY_LOCATION_BANK)
    local maxCcyTransfer = GetMaxCurrencyTransfer(currencyType, CURRENCY_LOCATION_BANK, CURRENCY_LOCATION_CHARACTER)
    local originalCcyAmountToWithdraw = ccyAmountToWithdraw

    -- check if all requested amount can be transfered; if not calculate the valid amount
    if (ccyAmountOnBank >= ccyAmountToWithdraw) then
        -- enough currency in SOURCE
        if (maxCcyTransfer >= ccyAmountToWithdraw) then
            -- enough space in TARGET --> FULL
            PAHF.println(L.PAB_Currency_Withdrawal_Full, ccyAmountToWithdraw, PAC_ICON_CURRENCY[currencyType].SMALL)
        else
            -- not enough space in TARGET --> PARTIAL (limited by TARGET)
            ccyAmountToWithdraw = maxCcyTransfer
            PAHF.println(L.PAB_Currency_Withdrawal_Partial_Target, ccyAmountToWithdraw, originalCcyAmountToWithdraw, PAC_ICON_CURRENCY[currencyType].SMALL)
        end
    else
        -- not enough currency in SOURCE --> PARTIAL (limited by SOURCE)
        ccyAmountToWithdraw = ccyAmountOnBank
        PAHF.println(L.PAB_Currency_Withdrawal_Partial_Source, ccyAmountToWithdraw, originalCcyAmountToWithdraw, PAC_ICON_CURRENCY[currencyType].SMALL)
    end

    -- actual WITHDRAWAL
    TransferCurrency(currencyType, ccyAmountToWithdraw, CURRENCY_LOCATION_BANK, CURRENCY_LOCATION_CHARACTER)
end


local function depositCurrency(ccyAmountToDeposit, currencyType)
    local ccyAmountOnCharacter = GetCurrencyAmount(currencyType, CURRENCY_LOCATION_CHARACTER) -- TODO: really needed?
    local maxCcyTransfer = GetMaxCurrencyTransfer(currencyType, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
    local originalCcyAmountToDeposit = ccyAmountToDeposit

    if (ccyAmountOnCharacter >= ccyAmountToDeposit) then
        -- enough currency in SOURCE
        if (maxCcyTransfer >= ccyAmountToDeposit) then
            -- enough space in TARGET --> FULL
            PAHF.println(L.PAB_Currency_Deposit_Full, ccyAmountToDeposit, PAC_ICON_CURRENCY[currencyType].SMALL)
        else
            -- not enough space in TARGET --> PARTIAL (limited by TARGET)
            ccyAmountToDeposit = maxCcyTransfer
            PAHF.println(L.PAB_Currency_Deposit_Partial_Target, ccyAmountToDeposit, originalCcyAmountToDeposit, PAC_ICON_CURRENCY[currencyType].SMALL)
        end
    else
        -- not enough currency in SOURCE --> PARTIAL (limited by SOURCE)
        ccyAmountToDeposit = ccyAmountOnCharacter
        PAHF.println(L.PAB_Currency_Deposit_Partial_Source, ccyAmountToDeposit, originalCcyAmountToDeposit, PAC_ICON_CURRENCY[currencyType].SMALL)
    end


    -- actual DEPOSIT
    TransferCurrency(currencyType, ccyAmountToDeposit, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
end


local function getChangeCcyAmount(currentCcyAmount, minToKeep, maxToKeep)
    -- Character has less than the minimum; positive amount returned (WITHDRAW)
    if currentCcyAmount < minToKeep then return (minToKeep - currentCcyAmount) end
    -- Character has more than the maximum; negative amount returned (DEPOSIT)
    if currentCcyAmount > maxToKeep then return (maxToKeep - currentCcyAmount) end
    -- if nothing returned yet; neither deposit nor withdraw is required
    return 0
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCurrencies()

    local currencies = {
        {
            currencyType = CURT_MONEY,
            enabled = PASV.Banking[PA.activeProfile].goldTransaction,
            minToKeep = tonumber(PASV.Banking[PA.activeProfile].goldMinToKeep),
            maxToKeep = tonumber(PASV.Banking[PA.activeProfile].goldMaxToKeep),
        },
        {
            currencyType = CURT_ALLIANCE_POINTS,
            enabled = PASV.Banking[PA.activeProfile].alliancePointsTransaction,
            minToKeep = tonumber(PASV.Banking[PA.activeProfile].alliancePointsMinToKeep),
            maxToKeep = tonumber(PASV.Banking[PA.activeProfile].alliancePointsMaxToKeep),
        },
        {
            currencyType = CURT_TELVAR_STONES,
            enabled = PASV.Banking[PA.activeProfile].telVarTransaction,
            minToKeep = tonumber(PASV.Banking[PA.activeProfile].telVarMinToKeep),
            maxToKeep = tonumber(PASV.Banking[PA.activeProfile].telVarMaxToKeep),
        },
        {
            currencyType = CURT_WRIT_VOUCHERS,
            enabled = PASV.Banking[PA.activeProfile].writVouchersTransaction,
            minToKeep = tonumber(PASV.Banking[PA.activeProfile].writVouchersMinToKeep),
            maxToKeep = tonumber(PASV.Banking[PA.activeProfile].writVouchersMaxToKeep),
        },
    }

    for _, currency in pairs(currencies) do
        if (currency.enabled) then
            -- get the current amount of the currency on character
            local currentCcyAmount = GetCurrencyAmount(currency.currencyType, CURRENCY_LOCATION_CHARACTER)

            -- get the amount that needs to be transfered (either way)
            local changeCcyAmount = getChangeCcyAmount(currentCcyAmount, currency.minToKeep, currency.maxToKeep)

            -- act based on the to be transferred amount
            if (changeCcyAmount < 0) then
                -- deposit currency
                depositCurrency(changeCcyAmount * -1, currency.currencyType)
            elseif (changeCcyAmount > 0) then
                -- withdraw currency
                withdrawCurrency(changeCcyAmount, currency.currencyType)
            else
                -- no currency transaction required
            end
        end
    end
end



-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCurrencies = depositOrWithdrawCurrencies