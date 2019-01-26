-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFUnctions

local isBankClosed = true

-- ---------------------------------------------------------------------------------------------------------------------

local function OnBankOpen()

    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Banking[PA.activeProfile].enabled then

            local goldTransaction = false
            local itemTransaction = false

            -- set the global variable to 'false'
            isBankClosed = false

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

        -- some debug statements
        if (PA.debug) then
            PAHF_DEBUG.debugln("IsESOPlusSubscriber() = %s", tostring(IsESOPlusSubscriber()));
            PAHF_DEBUG.debugln("HasCraftBagAccess() = %s", tostring(HasCraftBagAccess()));
            PAHF_DEBUG.debugln("GetBagUseableSize(BAG_BACKPACK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BACKPACK), GetNumBagUsedSlots(BAG_BACKPACK), GetNumBagFreeSlots(BAG_BACKPACK));
            PAHF_DEBUG.debugln("GetBagUseableSize(BAG_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BANK), GetNumBagUsedSlots(BAG_BANK), GetNumBagFreeSlots(BAG_BANK));
            PAHF_DEBUG.debugln("GetBagUseableSize(BAG_SUBSCRIBER_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_SUBSCRIBER_BANK), GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetNumBagFreeSlots(BAG_SUBSCRIBER_BANK));
            PAHF_DEBUG.debugln("GetNextVirtualBagSlotId() = %d", GetNextVirtualBagSlotId());
        end

    end
end

local function OnBankClose()
    -- set the global variable to 'true' so the bankClosing can be detected
    isBankClosed = true
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.OnBankOpen = OnBankOpen
PA.Banking.OnBankClose = OnBankClose