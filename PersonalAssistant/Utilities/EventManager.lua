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
        return table.concat({ESO_EVENT, "_", paIdentifier})
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
        if ESO_FILTER ~=nil and ESOFilterValue ~= nil then
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
    -- check fi the Callback is registered and if yes fire it
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

-- ---------------------------------------------------------------------------------------------------------------------

local function RefreshAllEventRegistrations()
    local PAMenuFunctions = PA.MenuFunctions

    -- Check if the Addon 'PABanking' is even enabled
    local PAB = PA.Banking
    if PAB then
        -- Check if the functionality is turned on within the addon
        local PABMenuFunctions = PAMenuFunctions.PABanking
        if PABMenuFunctions.getCurrenciesEnabledSetting() or PABMenuFunctions.getCraftingItemsEnabledSetting()
                or PABMenuFunctions.getAdvancedItemsEnabledSetting() or PABMenuFunctions.getIndividualItemsEnabledSetting() then
            -- Register PABanking
            RegisterForEvent(PAB.AddonName, EVENT_OPEN_BANK, PAB.OnBankOpen)
            RegisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK, PAB.OnBankClose)
        else
            -- Unregister PABanking completely
            UnregisterForEvent(PAB.AddonName, EVENT_OPEN_BANK)
            UnregisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK)
        end
    end


    -- Check if the Addon 'PAJunk' is even enabled
    local PAJ = PA.Junk
    if PAJ then
        -- Check if the functionality is turned on within the addon
        local PAJMenuFunctions = PAMenuFunctions.PAJunk
        if PAJMenuFunctions.getAutoMarkAsJunkEnabledSetting() then
            -- Register PAJunk for looting junk items
            RegisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAJ.OnInventorySingleSlotUpdate)
            RegisterFilterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
            RegisterFilterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)

            -- Register PAJunk for selling
            if PAJMenuFunctions.getAutoSellJunkSetting() then
                -- Register PAJunk (for Merchants and Fences)
                RegisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, PAJ.OnShopOpen)
                RegisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE, PAJ.OnFenceOpen)
            else
                -- Or unregister if auto-sell is disabled
                UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE)
                UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE)
            end

            -- Register Mailbox Open check (to disable marking as junk)
            RegisterForEvent(PAJ.AddonName, EVENT_MAIL_OPEN_MAILBOX, PAJ.OnMailboxOpen)
            RegisterForEvent(PAJ.AddonName, EVENT_MAIL_CLOSE_MAILBOX, PAJ.OnMailboxClose)
        else
            -- Unregister PAJunk completely
            UnregisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
            UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE)
            UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE)

            -- Unregister PAJunk Mailbox Check
            UnregisterForEvent(PAJ.AddonName, EVENT_MAIL_OPEN_MAILBOX)
            UnregisterForEvent(PAJ.AddonName, EVENT_MAIL_CLOSE_MAILBOX)
        end
    end


    -- Check if the Addon 'PAloot' is even enabled
    local PAL = PA.Loot
    if PAL then
        -- Check if the functionality is turned on within the addon
        local PALMenuFunctions = PAMenuFunctions.PALoot
        if PALMenuFunctions.isEnabled() then
            -- Register PALoot to check looted items
            RegisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAL.OnInventorySingleSlotUpdate)
            RegisterFilterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
            RegisterFilterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)

            -- needed in order to track stacking the backpack
            -- TODO: why is this triggered when selling Junk?!
            RegisterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, PAL.UpdateNumBagUsedSlots)
            RegisterFilterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)

            -- needed in order to track individual sells at vendor
            RegisterForEvent(PAL.AddonName, EVENT_SELL_RECEIPT, PAL.UpdateNumBagUsedSlots)
        else
            -- Unregister PALoot completely
            UnregisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
            UnregisterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG)
            UnregisterForEvent(PAL.AddonName, EVENT_SELL_RECEIPT)
        end
    end


    -- Check if the Addon 'PAMail' is even enabled
    local PAM = PA.Mail
    if PAM then
        -- Check if the functionality is turned on within the addon
        local PAMMenuFunctions = PAMenuFunctions.PAMail
        if PAMMenuFunctions.getHirelingAutoMailEnabledSetting() then
            -- Register PAMail
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED, PAM.readHirelingMails)
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_READABLE, PAM.takeAttachedItemsFromSingleMail)
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, PAM.takeAttachedItemSuccess)
        else
            -- Unregister PAMail completely
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED)
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_READABLE)
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
        end
    end


    -- Check if the Addon 'PARepair' is even enabled
    local PAR = PA.Repair
    if PAR then
        -- Check if the functionality is turned on within the addon
        local PARMenuFunctions = PAMenuFunctions.PARepair
        -- Check if the functionality is turned on within the addon
        if PARMenuFunctions.getAutoRepairEnabledSetting() then
            -- Register for GoldRepair
            if PARMenuFunctions.getRepairWithGoldSetting() or PARMenuFunctions.getRepairInventoryWithGoldSetting() then
                -- check if AutoSellJunk is also enabled
                if PAMenuFunctions.PAJunk.getAutoSellJunkSetting() then
                    -- if yes, only register a callback instead of the event, since repairing should be done once all junk is sold
                    RegisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen)
                else
                    -- if not, we can register the PARepair Open Store Event
                    RegisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen)
                    -- and unregister callback if existing
                    UnregisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen)
                end
            else
                UnregisterForEvent(PAR.AddonName, EVENT_OPEN_STORE)
                UnregisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen)
            end

            -- Register for RepairKits
            if PARMenuFunctions.getRepairWithRepairKitSetting() then
                RegisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAR.RepairEquippedItemsWithRepairKits, "RepairKits")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DURABILITY_CHANGE)
            else
                UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "RepairKits")
            end

            -- Register for WeaponCharges
            if PARMenuFunctions.getRechargeWithSoulGemSetting() then
                RegisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAR.RechargeEquippedWeaponsWithSoulGems, "SoulGems")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_ITEM_CHARGE)
            else
                UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SoulGems")
            end
        else
            -- Unregister PARepair completely
            UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SoulGems")
            UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "RepairKits")
            UnregisterForEvent(PAR.AddonName, EVENT_OPEN_STORE)
            UnregisterForCallback(PAR.AddonName, EVENT_OPEN_STORE, PAR.OnShopOpen)
        end
    end
end



--[[
Each Sub-Addon write the SavedVars (for all profiles) in the first column, wheres this function references the currently
selected profile in the second column whenever the profile is changed:
--------------------------------------------------------------------------------------------
Sub-AddOn   | Cross-Profile SavedVars               | Curr-Profile SavedVars
--------------------------------------------------------------------------------------------
PABanking   | PersonalAssistant.SavedVars.Banking   | PersonalAssistant.Banking.SavedVars
PAJunk      | PersonalAssistant.SavedVars.Junk      | PersonalAssistant.Junk.SavedVars
PALoot      | PersonalAssistant.SavedVars.Loot      | PersonalAssistant.Loot.SavedVars
PAMail      | PersonalAssistant.SavedVars.Mail      | PersonalAssistant.Mail.SavedVars
PARepair    | PersonalAssistant.SavedVars.Repair    | PersonalAssistant.Repair.SavedVars
--------------------------------------------------------------------------------------------
--]]
local function RefreshAllSavedVarReferences(activeProfile)
    -- refreshes all profile specific SavedVars references, so the profile does not need to be read all the time
    local PASavedVars = PA.SavedVars
    if not PA.General then PA.General = {} end
    PA.General.SavedVars = PASavedVars.General[activeProfile]

    if PA.Banking then PA.Banking.SavedVars = PASavedVars.Banking[activeProfile] end
    if PA.Junk then PA.Junk.SavedVars = PASavedVars.Junk[activeProfile] end
    if PA.Loot then PA.Loot.SavedVars = PASavedVars.Loot[activeProfile] end
    if PA.Mail then PA.Mail.SavedVars = PASavedVars.Mail[activeProfile] end
    if PA.Repair then PA.Repair.SavedVars = PASavedVars.Repair[activeProfile] end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.EventManager = {
    listAllEventsInSet = listAllEventsInSet,
    addFunctionToQueue = addFunctionToQueue,
    executeNextFunctionInQueue = executeNextFunctionInQueue,
    RegisterForEvent = RegisterForEvent,
    RegisterFilterForEvent = RegisterFilterForEvent,
    UnregisterForEvent = UnregisterForEvent,
    FireCallbacks = FireCallbacks,
    RefreshAllEventRegistrations = RefreshAllEventRegistrations,
    RefreshAllSavedVarReferences = RefreshAllSavedVarReferences,
}