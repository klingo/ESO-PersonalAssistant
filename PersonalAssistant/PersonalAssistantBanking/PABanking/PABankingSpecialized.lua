-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawSpecializedItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawSpecializedItems")

    -- check if bankTransfer is already blocked
    if PAB.isBankTransferBlocked then return end
    PAB.isBankTransferBlocked = true


    -- TODO: do stuff here!


    PAB.isBankTransferBlocked = false
    -- Execute the function queue
    PAB.triggerNextTransactionFunction()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawSpecializedItems = depositOrWithdrawSpecializedItems