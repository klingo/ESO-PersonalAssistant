-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAB = PA.Banking
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function doSameBagStacking(bagId)
    -- TODO: needed?
end

local function triggerNextTransactionFunction()
    -- Execute the function queue
    if #PAB.transactionFunctionQueue > 0 then
        -- remove the last entry from the list, and store it
        local functionToCall = table.remove(PAB.transactionFunctionQueue)
        -- call that function and pass on the remaining list of transactionFunctions
        functionToCall()
    end
end


local function getItemTypeComparator(itemTypeList)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end

-- TODO: getIndividualItemTypeComparator???

local function getItemIdComparator(itemIdList)
    return function(itemData)
        for _, customItemData in pairs(itemIdList) do
            if customItemData.itemId == GetItemId(itemData.bagId, itemData.slotIndex)  then return true end
        end
        return false
    end
end


local function OnBankOpen()
    if (PAHF.hasActiveProfile()) then
        -- set the global variable to 'false'
        PA.isBankClosed = false

        -- TODO: to be evaluated if needed; and how to implement
        --    if (sameBagStacking) then
        --        doSameBagStacking(BAG_BACKPACK)
        --        doSameBagStacking(BAG_BANK)
        --        doSameBagStacking(BAG_SUBSCRIBER_BANK)
        --    end

        -- check if gold deposit is enabled
        if PASV.Banking[PA.activeProfile].Currencies.currenciesEnabled then
            -- trigger the deposit and withdrawal of gold
            PAB.depositOrWithdrawCurrencies()
        end

        -- check if the different transactions are enabled and add them to the function queue
        PAB.transactionFunctionQueue = {}
        if PASV.Banking[PA.activeProfile].Advanced.specializedItemsEnabled then
            table.insert(PAB.transactionFunctionQueue, PAB.depositOrWithdrawAdvancedItems)
        end
        if PASV.Banking[PA.activeProfile].Individual.individualItemsEnabled then
            table.insert(PAB.transactionFunctionQueue, PAB.depositOrWithdrawIndividualItems)
        end
        if PASV.Banking[PA.activeProfile].Crafting.craftingItemsEnabled then
            table.insert(PAB.transactionFunctionQueue, PAB.depositOrWithdrawCraftingItems)
        end

        -- Execute the function queue
        PAB.triggerNextTransactionFunction()
    end

    -- some debug statements
    PAHF.debugln("IsESOPlusSubscriber() = %s", tostring(IsESOPlusSubscriber()));
    PAHF.debugln("HasCraftBagAccess() = %s", tostring(HasCraftBagAccess()));
    PAHF.debugln("GetBagUseableSize(BAG_BACKPACK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BACKPACK), GetNumBagUsedSlots(BAG_BACKPACK), GetNumBagFreeSlots(BAG_BACKPACK));
    PAHF.debugln("GetBagUseableSize(BAG_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BANK), GetNumBagUsedSlots(BAG_BANK), GetNumBagFreeSlots(BAG_BANK));
    PAHF.debugln("GetBagUseableSize(BAG_GUILDBANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_GUILDBANK), GetNumBagUsedSlots(BAG_GUILDBANK), GetNumBagFreeSlots(BAG_GUILDBANK));
    PAHF.debugln("GetBagUseableSize(BAG_SUBSCRIBER_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_SUBSCRIBER_BANK), GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetNumBagFreeSlots(BAG_SUBSCRIBER_BANK));
    PAHF.debugln("GetBagUseableSize(BAG_VIRTUAL) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_VIRTUAL), GetNumBagUsedSlots(BAG_VIRTUAL), GetNumBagFreeSlots(BAG_VIRTUAL));
    PAHF.debugln("GetNextVirtualBagSlotId() = %d", GetNextVirtualBagSlotId());
end

local function OnBankClose()
    -- set the global variable to 'true' so the bankClosing can be detected
    PA.isBankClosed = true
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.OnBankOpen = OnBankOpen
PA.Banking.OnBankClose = OnBankClose
PA.Banking.triggerNextTransactionFunction = triggerNextTransactionFunction
PA.Banking.getItemTypeComparator = getItemTypeComparator
PA.Banking.getItemIdComparator = getItemIdComparator