-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAHF = PA.HelperFunctions
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

-- NOTE: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. zo_callLater needed)

-- ---------------------------------------------------------------------------------------------------------------------

local function _stackBags()
    if PAB.SavedVars.autoStackBags then
        StackBag(BAG_BANK)
        StackBag(BAG_SUBSCRIBER_BANK)
        StackBag(BAG_BACKPACK)
    end
    -- Execute the function queue
    PAEM.executeNextFunctionInQueue(PAB.AddonName)
end

local function OnBankOpen()
    if (PAHF.hasActiveProfile()) then
        -- set the global variable to 'false'
        PA.isBankClosed = false

        -- check if gold deposit is enabled
        if PAB.SavedVars.Currencies.currenciesEnabled then
            -- trigger the deposit and withdrawal of gold
            PAB.depositOrWithdrawCurrencies()
        end

        -- check if the different transactions are enabled and add them to the function queue (will be executed in REVERSE order)
        -- give it 100ms time to "refresh" the bag data structure after stacking
        PAEM.addFunctionToQueue(_stackBags, PAB.AddonName)
        if PAB.SavedVars.Advanced.advancedItemsEnabled then
            PAEM.addFunctionToQueue(PAB.depositOrWithdrawAdvancedItems, PAB.AddonName, 100)
        end
        if PAB.SavedVars.Individual.individualItemsEnabled then
            PAEM.addFunctionToQueue(PAB.depositOrWithdrawIndividualItems, PAB.AddonName, 100)
        end
        if PAB.SavedVars.Crafting.craftingItemsEnabled and not IsESOPlusSubscriber() then
            PAEM.addFunctionToQueue(PAB.depositOrWithdrawCraftingItems, PAB.AddonName, 100)
        end
        PAEM.addFunctionToQueue(_stackBags, PAB.AddonName)

        -- Execute the function queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
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