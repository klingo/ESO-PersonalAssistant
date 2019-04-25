-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawAvAItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawAvAItems")

    if PAB.SavedVars.AvA.avaItemsEnabled then


    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawAvAItems = depositOrWithdrawAvAItems