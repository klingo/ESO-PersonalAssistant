-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawAdvancedItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawAdvancedItems")

    -- check if bankTransfer is already blocked
    if PAB.isBankTransferBlocked then return end
    PAB.isBankTransferBlocked = true

    -- preapre and fill the table with all advanced items that needs to be transferred
    local advancedItems = {}
    local itemIdBackpackAmountTable = PASV.Banking[PA.activeProfile].Advanced.ItemIdBackpackAmount
    local itemIdOperatorTable = PASV.Banking[PA.activeProfile].Advanced.ItemIdOperator
    for itemId, backpackAmount in pairs(itemIdBackpackAmountTable) do
        local operator = itemIdOperatorTable[itemId]
        table.insert(advancedItems, {
            itemId = itemId,
            operator = operator,
            backpackAmount = backpackAmount
        })
    end

    local itemIdComparator = PAB.getItemIdComparator(advancedItems)

    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BACKPACK)
    local bankBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

    d("#backpackBagCache = "..tostring(#backpackBagCache))
    d("#bankBagCache = "..tostring(#bankBagCache))


    -- TODO: do stuff here!
    -- 1) loop through itemId
    -- 2) check how much is on character
    -- 3) check how much is expected on character
    -- 4) calculate transfer
    -- 5) Execute?


    PAB.isBankTransferBlocked = false
    -- Execute the function queue
    PAB.triggerNextTransactionFunction()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawAdvancedItems = depositOrWithdrawAdvancedItems