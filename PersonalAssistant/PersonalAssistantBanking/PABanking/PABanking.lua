-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAB = PA.Banking
local PAHF = PA.HelperFunctions


local function doSameBagStacking(bagId)
    -- TODO: needed?
end

-- ---------------------------------------------------------------------------------------------------------------------

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

        -- check if Crafting Item deposit is enabled
        if PASV.Banking[PA.activeProfile].Crafting.craftingItemsEnabled then
            -- trigger the deposit and withdrawal of crafting items
            PAB.depositOrWithdrawCraftingItems()
        end
    end

    -- some debug statements
    if (PA.debug) then
        PAHF.debugln("IsESOPlusSubscriber() = %s", tostring(IsESOPlusSubscriber()));
        PAHF.debugln("HasCraftBagAccess() = %s", tostring(HasCraftBagAccess()));
        PAHF.debugln("GetBagUseableSize(BAG_BACKPACK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BACKPACK), GetNumBagUsedSlots(BAG_BACKPACK), GetNumBagFreeSlots(BAG_BACKPACK));
        PAHF.debugln("GetBagUseableSize(BAG_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BANK), GetNumBagUsedSlots(BAG_BANK), GetNumBagFreeSlots(BAG_BANK));
        PAHF.debugln("GetBagUseableSize(BAG_GUILDBANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_GUILDBANK), GetNumBagUsedSlots(BAG_GUILDBANK), GetNumBagFreeSlots(BAG_GUILDBANK));
        PAHF.debugln("GetBagUseableSize(BAG_SUBSCRIBER_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_SUBSCRIBER_BANK), GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetNumBagFreeSlots(BAG_SUBSCRIBER_BANK));
        PAHF.debugln("GetBagUseableSize(BAG_VIRTUAL) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_VIRTUAL), GetNumBagUsedSlots(BAG_VIRTUAL), GetNumBagFreeSlots(BAG_VIRTUAL));
        PAHF.debugln("GetNextVirtualBagSlotId() = %d", GetNextVirtualBagSlotId());
    end
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