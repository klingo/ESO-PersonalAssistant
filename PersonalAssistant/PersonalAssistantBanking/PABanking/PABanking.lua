-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAB = PA.Banking
local PAHF = PA.HelperFunctions

local isBankClosed = true

-- ---------------------------------------------------------------------------------------------------------------------

local function OnBankOpen()

    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PASV.Banking[PA.activeProfile].enabled then

            local goldTransaction = false
            local itemTransaction = false

            -- set the global variable to 'false'
            isBankClosed = false

            -- check if gold deposit is enabled
            if PASV.Banking[PA.activeProfile].goldTransaction then
                -- trigger the deposit and withdrawal of gold
                PAB.DepositOrWithdrawGold()
            end

            -- check if item deposit is enabled
            if PASV.Banking[PA.activeProfile].itemTransaction then
                -- TODO: TEMPORARILY DISABLED !!!!
--                PAB_Items.DepositWithdrawItems()
--                PAB_Items.loopCount = 0
--                itemTransaction = PAB_Items.DepositAndWithdrawItems()
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