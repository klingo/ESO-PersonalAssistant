-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local _registeredIdentifierSet = {}

local function _addEventToSet(key)
    _registeredIdentifierSet[key] = true
end

local function _removeEventFromSet(key)
    _registeredIdentifierSet[key] = nil
end

local function _containsEventInSet(key)
    return _registeredIdentifierSet[key] ~= nil
end

local function _getEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
    if paIdentifier ~= nil and paIdentifier ~= "" then
        -- if a specific PA identifier was set, use this one as the ESO identifer
        return table.concat({ESO_EVENT, "_", addonName, "_", paIdentifier})
    else
        -- else create esoIdentifier based on module/addonName and ESO event
        return table.concat({ESO_EVENT, "_", addonName})
    end
end

local function _getEventEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
    return "EV_".._getEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
end

local function _getCallbackEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
    return "CB_".._getEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
end

-- ---------------------------------------------------------------------------------------------------------------------

local _functionQueue = {}

local function addFunctionToQueue(functionToBeExecuted, queueName, functionDelay)
    -- make sure queueName and functionDelay are provided
    if queueName == nil then queueName = "default" end
    if functionDelay == nil then functionDelay = 0 end

    -- make sure queue is existing
    if _functionQueue[queueName] == nil then _functionQueue[queueName] = {} end

    -- now insert function into queue
    table.insert(_functionQueue[queueName], {
        fnct = functionToBeExecuted,
        delay = functionDelay
    })
end

local function executeNextFunctionInQueue(queueName)
    -- make sure queueName is provided
    if queueName == nil then queueName = "default" end
    -- get queue and execute first entry if existing
    local queue = _functionQueue[queueName]
    if queue ~= nil and #queue > 0 then
        local functionData = table.remove(queue)
        local functionToCall = functionData.fnct
        local functionDelay = functionData.delay

        zo_callLater(function() functionToCall() end, functionDelay)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function RegisterForEvent(addonName, ESO_EVENT, executableFunction, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getEventEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
    -- an event will only be registered with ESO, when the same identifier is not yet registered
    if not _containsEventInSet(esoIdentifier) then
        -- register the event with ESO
        EVENT_MANAGER:RegisterForEvent(esoIdentifier, ESO_EVENT, executableFunction)
        -- and add it to PA's internal list of registered events
        _addEventToSet(esoIdentifier)
    end
end

local function RegisterFilterForEvent(addonName, ESO_EVENT, ESO_FILTER, ESOFilterValue, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getEventEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
    -- an event filter will only be registered with ESO, when an event with the same identifier is already registered
    if _containsEventInSet(esoIdentifier) then
        -- check if a filter was provided
        if ESO_FILTER ~= nil and ESOFilterValue ~= nil then
            EVENT_MANAGER:AddFilterForEvent(esoIdentifier, ESO_EVENT, ESO_FILTER, ESOFilterValue)
        end
    end
end

local function UnregisterForEvent(addonName, ESO_EVENT, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getEventEsoIdentifier(addonName, ESO_EVENT, paIdentifier)
    -- unregister the event from ESO
    EVENT_MANAGER:UnregisterForEvent(esoIdentifier, ESO_EVENT)
    -- and remove it from PA's internal list of registered events
    _removeEventFromSet(esoIdentifier)
end

local function FireCallbacks(addonName, callbackName, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getCallbackEsoIdentifier(addonName, callbackName, paIdentifier)
    -- check if the Callback is registered and if yes fire it
    if _containsEventInSet(esoIdentifier) then
        CALLBACK_MANAGER:FireCallbacks(esoIdentifier)
    end
end

local function RegisterForCallback(addonName, callbackName, executableFunction, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getCallbackEsoIdentifier(addonName, callbackName, paIdentifier)
    -- a callback will only be registered with ESO, when the same callback is not yet registered
    if not _containsEventInSet(esoIdentifier) then
        -- register the callback with ESO
        CALLBACK_MANAGER:RegisterCallback(esoIdentifier, executableFunction)
        -- and add it to PA's internal list of registered events/callbacks
        _addEventToSet(esoIdentifier)
    end
end

local function UnregisterForCallback(addonName, callbackName, executableFunction, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getCallbackEsoIdentifier(addonName, callbackName, paIdentifier)
    -- unregister the callback from ESO
    CALLBACK_MANAGER:UnregisterCallback(esoIdentifier, executableFunction)
    -- and remove it from PA's internal list of registered events/callbacks
    _removeEventFromSet(esoIdentifier)
end

local function listAllEventsInSet()
    d("----------------------------------------------------")
    d("PA: listing all registered events")
    for key, value in pairs(_registeredIdentifierSet) do
        -- d(key.."="..tostring(value))
        d(key)
    end
    d("----------------------------------------------------")
end

local function getAllReventsInSet()
    return _registeredIdentifierSet
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _hasAnyPAJunkIntegrationsTurnedOn()
    local PAI = PA.Integration
    if PAI and FCOIS then
        local PAIFCOISSavedVars = PAI.SavedVars.FCOItemSaver
        return PAIFCOISSavedVars.Sell.autoSellMarked or PAIFCOISSavedVars.Locked.preventAutoSell
    end
    return false
end

-- ---------------------------------------------------------------------------------------------------------------------

local function RefreshAllEventRegistrations()
    local PAMenuFunctions = PA.MenuFunctions

    -- Check if the Addon 'PABanking' is even enabled
    local PAB = PA.Banking
    if PAB then
        -- Check if the functionality is turned on within the addon
        local PABMenuFunctions = PAMenuFunctions.PABanking
        if PABMenuFunctions.getCurrenciesEnabledSetting() or PABMenuFunctions.getCraftingItemsEnabledSetting()
                or PABMenuFunctions.getAdvancedItemsEnabledSetting() then
            -- Register PABanking
            RegisterForEvent(PAB.AddonName, EVENT_OPEN_BANK, PAB.OnBankOpen, "OpenBank")
            RegisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK, PAB.OnBankClose, "CloseBank")
        else
            -- Unregister PABanking completely
            UnregisterForEvent(PAB.AddonName, EVENT_OPEN_BANK, "OpenBank")
            UnregisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK, "CloseBank")
        end
    end


    -- Check if the Addon 'PAJunk' is even enabled
    local PAJ = PA.Junk
    if PAJ then
        -- Check if the functionality is turned on within the addon
        local PAJMenuFunctions = PAMenuFunctions.PAJunk
        if PAJMenuFunctions.getAutoMarkAsJunkEnabledSetting() then
            -- Register PAJunk for looting junk items
            RegisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAJ.OnInventorySingleSlotUpdate, "SingleSlotUpdate")
            RegisterFilterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK, "SingleSlotUpdate")
            RegisterFilterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT, "SingleSlotUpdate")

            -- Register Mailbox Open Check (to disable marking as junk)
            RegisterForEvent(PAJ.AddonName, EVENT_MAIL_OPEN_MAILBOX, PAJ.OnMailboxOpen, "OpenMailbox")
            RegisterForEvent(PAJ.AddonName, EVENT_MAIL_CLOSE_MAILBOX, PAJ.OnMailboxClose, "CloseMailbox")
        else
            -- Unregister PAJunk AutoMarking
            UnregisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SingleSlotUpdate")

            -- Unregister PAJunk Mailbox Open Check
            UnregisterForEvent(PAJ.AddonName, EVENT_MAIL_OPEN_MAILBOX, "OpenMailbox")
            UnregisterForEvent(PAJ.AddonName, EVENT_MAIL_CLOSE_MAILBOX, "CloseMailbox")
        end

        -- Register PAJunk for selling (also in case PAJunk related integrations are turned on)
        if PAJMenuFunctions.getAutoSellJunkSetting() or _hasAnyPAJunkIntegrationsTurnedOn() then
            -- Register PAJunk (for Merchants and Fences)
            RegisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, PAJ.OnShopOpen, "OpenStore")
            RegisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE, PAJ.OnFenceOpen, "OpenFence")
            RegisterForEvent(PAJ.AddonName, EVENT_CLOSE_STORE, PAJ.OnStoreAndFenceClose, "CloseStore")
        else
            -- Unregister Auto-Sell for Merchants and Fences
            UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, "OpenStore")
            UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE, "OpenFence")
            UnregisterForEvent(PAJ.AddonName, EVENT_CLOSE_STORE, "CloseStore")
        end

        if PAJMenuFunctions.getKeybindingMarkUnmarkAsJunkSetting() or PAJMenuFunctions.getKeybindingDestroyItemSetting() then
            -- initialize enabled/visible hooks on inventory items
            PAJ.KeybindStrip.initHooksOnInventoryItems()
        end
    end


    -- Check if the Addon 'PAloot' is even enabled
    local PAL = PA.Loot
    if PAL then
        -- Check if the functionality is turned on within the addon
        local PALMenuFunctions = PAMenuFunctions.PALoot
        if PALMenuFunctions.getLootEventsEnabledSetting() then
            -- Register PALoot to check looted items
            RegisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAL.OnInventorySingleSlotUpdate, "SingleSlotUpdate")
            RegisterFilterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK, "SingleSlotUpdate")
            RegisterFilterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT, "SingleSlotUpdate")

            -- needed in order to track stacking the backpack
            -- TODO: why is this triggered when selling Junk?!
            RegisterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, PAL.UpdateNumBagUsedSlots, "StackedAllItems")
            RegisterFilterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, REGISTER_FILTER_BAG_ID, BAG_BACKPACK, "StackedAllItems")

            -- needed in order to track individual sells at vendor
            RegisterForEvent(PAL.AddonName, EVENT_SELL_RECEIPT, PAL.UpdateNumBagUsedSlots, "SellReceipt")
        else
            -- Unregister PALoot completely
            UnregisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SingleSlotUpdate")
            UnregisterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, "StackedAllItems")
            UnregisterForEvent(PAL.AddonName, EVENT_SELL_RECEIPT, "SellReceipt")
        end

        if PALMenuFunctions.getItemIconsEnabledSetting() then
            RegisterForEvent(PAL.AddonName, EVENT_TRADING_HOUSE_RESPONSE_RECEIVED, PAL.ItemIcons.initHooksOnTradeHouse, "TradeHouseHook")

            -- initialize Item Visuals on bags, crafting stations, and the loot window
            PAL.ItemIcons.initHooksOnBags()
            PAL.ItemIcons.initHooksOnCraftingStations()
            PAL.ItemIcons.initHooksOnLootWindow()
            PAL.ItemIcons.initHooksOnMerchantsAndBuyback()
        else
            UnregisterForEvent(PAL.AddonName, EVENT_TRADING_HOUSE_RESPONSE_RECEIVED, "TradeHouseHook")
        end
    end


    -- Check if the Addon 'PAMail' is even enabled
    local PAM = PA.Mail
    if PAM then
        -- Check if the functionality is turned on within the addon
        local PAMMenuFunctions = PAMenuFunctions.PAMail
        if PAMMenuFunctions.getHirelingAutoMailEnabledSetting() then
            -- Register PAMail
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED, PAM.readHirelingMails, "NumUnreadChanged")
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_READABLE, PAM.takeAttachedItemsFromSingleMail, "MailReadable")
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, PAM.takeAttachedItemSuccess, "TakeAttachedItemSuccess")
        else
            -- Unregister PAMail completely
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED, "NumUnreadChanged")
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_READABLE, "MailReadable")
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, "TakeAttachedItemSuccess")
        end
    end


    -- Check if the Addon 'PARepair' is even enabled
    local PAR = PA.Repair
    if PAR then
        -- Check if the functionality is turned on within the addon
        local PARMenuFunctions = PAMenuFunctions.PARepair
        -- Check if the functionality is turned on within the addon
        if PARMenuFunctions.getAutoRepairEquippedEnabledSetting() or PARMenuFunctions.getAutoRepairInventoryEnabledSetting() then
            -- Register for GoldRepair
            if PARMenuFunctions.getRepairEquippedWithGoldSetting() or PARMenuFunctions.getRepairInventoryWithGoldSetting() then
                -- check if AutoSellJunk is also enabled
                if PA.Junk and PAMenuFunctions.PAJunk and PAMenuFunctions.PAJunk.getAutoSellJunkSetting() then
                    -- if yes, only register a callback instead of the event, since repairing should be done once all junk is sold
                    RegisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen, "OpenStore")
                else
                    -- if not, we can register the PARepair Open Store Event
                    RegisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen, "OpenStore")
                    -- and unregister callback if existing
                    UnregisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen, "OpenStore")
                end
            else
                UnregisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, "OpenStore")
                UnregisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen, "OpenStore")
            end

            -- Register for RepairKits
            if PARMenuFunctions.getRepairWithRepairKitSetting() then
                -- this is to repair items when they lose durability during fights etc.
                RegisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAR.CheckAndRepairSingleEquippedItemWithRepairKit, "RepairKits")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN, "RepairKits")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DURABILITY_CHANGE, "RepairKits")
                -- this is to repair items after materializing from ghost to alive
                RegisterForEvent(PAR.AddonName, EVENT_PLAYER_REINCARNATED, PAR.CheckAndRepairAllEquippedItemsWithRepairKits, "RepairKits-Reincarnate")
                -- this is to repair items after respawning at a wayshrine (without ghost form)
                RegisterForEvent(PAR.AddonName, EVENT_PLAYER_ALIVE, PAR.CheckAndRepairAllEquippedItemsWithRepairKits, "RepairKits-Alive")
            else
                UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "RepairKits")
                UnregisterForEvent(PAR.AddonName, EVENT_PLAYER_REINCARNATED, "RepairKits-Reincarnate")
                UnregisterForEvent(PAR.AddonName, EVENT_PLAYER_ALIVE, "RepairKits-Alive")
            end

            -- Register for WeaponCharges
            if PARMenuFunctions.getRechargeWithSoulGemSetting() then
                RegisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAR.RechargeEquippedWeaponsWithSoulGems, "SoulGems")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN, "SoulGems")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_ITEM_CHARGE, "SoulGems")
            else
                UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SoulGems")
            end
        else
            -- Unregister PARepair completely
            UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SoulGems")
            UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "RepairKits")
            UnregisterForEvent(PAR.AddonName, EVENT_PLAYER_REINCARNATED, "RepairKits-Reincarnate")
            UnregisterForEvent(PAR.AddonName, EVENT_PLAYER_ALIVE, "RepairKits-Alive")
            UnregisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, "OpenStore")
            UnregisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen, "OpenStore")
        end
    end


    -- Cross-Addon events and hooks
    local PAItemContextMenu = PA.ItemContextMenu
    -- Register Item Context Menu
    local LCM = LibCustomMenu or LibStub("LibCustomMenu")
    if LCM then
        PAItemContextMenu.initHooksOnInventoryContextMenu()
    else
        PA.debugln("Cannot initialise InventoryContextMenu hooks because LibCustomMenu is not available")
    end
end



--[[
Each Sub-Addon has multi-profile SavedVars that can be accessed as listed in the first column (Cross-Profile SavedVars),
but in order to avoid reading the activeProfile all the time, below function makes a static reference in the second
column (Curr-Profile SavedVars) that will always point to the Cross-Profile SavedVars of the active profile.
|------------------------------------------------------------------------------------------------------------------|
| Sub-AddOn     | Cross-Profile SavedVars                                | Curr-Profile SavedVars                  |
|------------------------------------------------------------------------------------------------------------------|
| PABanking     | PersonalAssistant.SavedVars.Banking[activeProfile]     | PersonalAssistant.Banking.SavedVars     |
| PAIntegration | PersonalAssistant.SavedVars.Integration[activeProfile] | PersonalAssistant.Integration.SavedVars |
| PAJunk        | PersonalAssistant.SavedVars.Junk[activeProfile]        | PersonalAssistant.Junk.SavedVars        |
| PALoot        | PersonalAssistant.SavedVars.Loot[activeProfile]        | PersonalAssistant.Loot.SavedVars        |
| PAMail        | PersonalAssistant.SavedVars.Mail[activeProfile]        | PersonalAssistant.Mail.SavedVars        |
| PARepair      | PersonalAssistant.SavedVars.Repair[activeProfile]      | PersonalAssistant.Repair.SavedVars      |
|------------------------------------------------------------------------------------------------------------------|
--]]
local function RefreshAllSavedVarReferences(activeProfile)
    -- refreshes all profile specific SavedVars references, so the profile does not need to be read all the time
    local PASavedVars = PA.SavedVars
    if not PA.General then PA.General = {} end
    PA.General.SavedVars = PASavedVars.General[activeProfile]

    if PA.Banking then PA.Banking.SavedVars = PASavedVars.Banking[activeProfile] end
    if PA.Integration then PA.Integration.SavedVars = PASavedVars.Integration[activeProfile] end
    if PA.Junk then PA.Junk.SavedVars = PASavedVars.Junk[activeProfile] end
    if PA.Loot then PA.Loot.SavedVars = PASavedVars.Loot[activeProfile] end
    if PA.Mail then PA.Mail.SavedVars = PASavedVars.Mail[activeProfile] end
    if PA.Repair then PA.Repair.SavedVars = PASavedVars.Repair[activeProfile] end

    -- also refresh the PABankingRulesList and PAJunkRulesList with the new profile
    FireCallbacks("PersonalAssistant", EVENT_ADD_ON_LOADED, "InitPABankingRulesList")
    FireCallbacks("PersonalAssistant", EVENT_ADD_ON_LOADED, "InitPAJunkRulesList")
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.EventManager = {
    listAllEventsInSet = listAllEventsInSet,
    getAllReventsInSet = getAllReventsInSet,
    addFunctionToQueue = addFunctionToQueue,
    executeNextFunctionInQueue = executeNextFunctionInQueue,
    RegisterForEvent = RegisterForEvent,
    RegisterFilterForEvent = RegisterFilterForEvent,
    UnregisterForEvent = UnregisterForEvent,
    FireCallbacks = FireCallbacks,
    RegisterForCallback = RegisterForCallback,
    UnregisterForCallback = UnregisterForCallback,
    RefreshAllEventRegistrations = RefreshAllEventRegistrations,
    RefreshAllSavedVarReferences = RefreshAllSavedVarReferences,
}