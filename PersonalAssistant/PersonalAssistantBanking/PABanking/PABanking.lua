-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PABProfileManager = PA.ProfileManager.PABanking
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

-- NOTE: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. delay required)

-- ---------------------------------------------------------------------------------------------------------------------

local function _finishBankingItemTransfer()
    PAB.debugln("==============================================================")
    PAB.debugln("PA.Banking._finishBankingItemTransfer (7)")
    PAB.isBankItemTransferBlocked = false
    -- update the icons
    if PA.Loot and PA.ProfileManager.PALoot.hasActiveProfile() then
        PA.Loot.ItemIcons.refreshScrollListVisible()
    end
    -- update/hide the Keybind Strip
    PAB.KeybindStrip.updateBankKeybindStrip()
    -- inform player that everything is done
    PAB.println(SI_PA_CHAT_BANKING_FINISHED)

    local passedGameTime = GetGameTimeMilliseconds() - PAB.startGameTime
    PAB.debugln('PABanking:executeBankingItemTransfers took approx. %f s', PA.HelperFunctions.round(passedGameTime / 1000, 1))
end

local function _printLWCMessageIfItemsSkipped()
    PAB.debugln("==============================================================")
    PAB.debugln("PA.Banking._printLWCMessageIfItemsSkipped (6)")
    if PAB.hasSomeItemskippedForLWC then
        -- if some items were skipped because of LWC; display a message
        PAB.println(SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC)
    end
    -- Execute the function queue
    PAEM.executeNextFunctionInQueue(PAB.AddonName)
end

local function _stackBags()
    PAB.debugln("==============================================================")
    PAB.debugln("PA.Banking._stackBags (0 / 5)")
    if PAB.SavedVars.autoStackBags then
        StackBag(BAG_BANK)
        if IsESOPlusSubscriber() then
            StackBag(BAG_SUBSCRIBER_BANK)
        end
        StackBag(BAG_BACKPACK)
    end
    -- Execute the function queue
    PAEM.executeNextFunctionInQueue(PAB.AddonName)
end

-- OPTIMIZE: rename to specify that this triggers the compatibility?
local function hasLazyWritCrafterAndShouldGrabEnabled()
    if WritCreater and PA.Integration and PA.ProfileManager.PAIntegration.hasActiveProfile() then
        local _, hasAny = WritCreater.writSearch()
        return hasAny and WritCreater:GetSettings().shouldGrab and PA.Integration.SavedVars.LazyWritCrafter.compatibility
    end
    return false
end

local function executeBankingItemTransfers()
    if not PAB.isBankItemTransferBlocked then
        -- block other item transfers
        PAB.isBankItemTransferBlocked = true
        -- update/hide the Keybind Strip
        PAB.KeybindStrip.updateBankKeybindStrip()

        -- before queueing up the transactions, ensure that the SHARED_INVENTORY is updated
        PAB.startGameTime = GetGameTimeMilliseconds()
        SHARED_INVENTORY:RefreshInventory(BAG_BACKPACK)
        SHARED_INVENTORY:RefreshInventory(BAG_BANK)
        if IsESOPlusSubscriber() then
            SHARED_INVENTORY:RefreshInventory(BAG_SUBSCRIBER_BANK)
        end
        local passedGameTime = GetGameTimeMilliseconds() - PAB.startGameTime
        PAB.debugln('SHARED_INVENTORY:RefreshInventory took approx. %d ms', passedGameTime)

        -- add the different item transactions to the function queue (will be executed in REVERSE order)
        -- the eligibility is checked within the transactions
        -- give it 100ms time to "refresh" the bag data structure after stacking
        PAEM.addFunctionToQueue(_finishBankingItemTransfer, PAB.AddonName) -- unblock item transfers again at the end
        PAEM.addFunctionToQueue(_printLWCMessageIfItemsSkipped, PAB.AddonName)
        PAEM.addFunctionToQueue(_stackBags, PAB.AddonName)
        PAEM.addFunctionToQueue(PAB.depositOrWithdrawCustomItems, PAB.AddonName, 100)
        PAEM.addFunctionToQueue(PAB.depositOrWithdrawFCOISMarkedItems, PAB.AddonName, 100)
        PAEM.addFunctionToQueue(PAB.depositOrWithdrawAvAItems, PAB.AddonName, 100)
        PAEM.addFunctionToQueue(PAB.depositOrWithdrawAdvancedItems, PAB.AddonName, 100)
        PAEM.addFunctionToQueue(PAB.depositOrWithdrawCraftingItems, PAB.AddonName, 100)
        PAEM.addFunctionToQueue(_stackBags, PAB.AddonName)

        -- Execute the function queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    else
        PAB.debugln("PAB.isBankItemTransferBlocked = TRUE - parallel execution BLOCKED")
    end
end

local function OnBankOpen(eventCode, bankBag)
    -- immediately stop if not the actual BANK bag is opened (i.e. HOUSE_BANK)
    if IsHouseBankBag(bankBag) then return
    elseif PABProfileManager.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isBankClosed = false

        -- start with that no items were skipped for LazyWritCrafter
        PAB.hasSomeItemskippedForLWC = false

        -- show the keybindings when accessing bank view
        PAB.KeybindStrip.onBankOpenShowKeybindStrip()

        -- trigger the deposit and withdrawal of gold
        if not PAB.isBankCurrencyTransferBlocked then
            -- block others currency transfers
            PAB.isBankCurrencyTransferBlocked = true
            -- trigger currency transfer (includes unblocking)
            PAB.depositOrWithdrawCurrencies()
        end

        -- only directly execute all item transfers when setting is on
        if PAB.SavedVars.autoExecuteItemTransfers then
            executeBankingItemTransfers()
        else
            PAB.debugln("autoExecuteItemTransfers DISABLED - all item transfers skipped")
        end
    end

    -- some debug statements
    if PA.debug then
        PAB.debugln("IsESOPlusSubscriber() = %s", tostring(IsESOPlusSubscriber()));
        PAB.debugln("HasCraftBagAccess() = %s", tostring(HasCraftBagAccess()));
        PAB.debugln("GetBagUseableSize(BAG_BACKPACK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BACKPACK), GetNumBagUsedSlots(BAG_BACKPACK), GetNumBagFreeSlots(BAG_BACKPACK));
        PAB.debugln("GetBagUseableSize(BAG_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BANK), GetNumBagUsedSlots(BAG_BANK), GetNumBagFreeSlots(BAG_BANK));
        PAB.debugln("GetBagUseableSize(BAG_GUILDBANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_GUILDBANK), GetNumBagUsedSlots(BAG_GUILDBANK), GetNumBagFreeSlots(BAG_GUILDBANK));
        PAB.debugln("GetBagUseableSize(BAG_SUBSCRIBER_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_SUBSCRIBER_BANK), GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetNumBagFreeSlots(BAG_SUBSCRIBER_BANK));
        PAB.debugln("GetBagUseableSize(BAG_VIRTUAL) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_VIRTUAL), GetNumBagUsedSlots(BAG_VIRTUAL), GetNumBagFreeSlots(BAG_VIRTUAL));
        PAB.debugln("GetNextVirtualBagSlotId() = %d", GetNextVirtualBagSlotId() or -1);
        PAB.debugln("IsHouseBankBag() = %s", tostring(IsHouseBankBag(bankBag)));
    end
end

local function OnBankClose()
    -- hide the keybindings when leaving bank view
    PAB.KeybindStrip.onBankCloseHideKeybindStrip()

    -- unblock the item and currency transfer when leaving the bank
    PAB.isBankCurrencyTransferBlocked = false
    PAB.isBankItemTransferBlocked = false

    -- set the global variable to 'true' so the bankClosing can be detected
    PA.WindowStates.isBankClosed = true
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.hasLazyWritCrafterAndShouldGrabEnabled = hasLazyWritCrafterAndShouldGrabEnabled
PA.Banking.executeBankingItemTransfers = executeBankingItemTransfers
PA.Banking.OnBankOpen = OnBankOpen
PA.Banking.OnBankClose = OnBankClose