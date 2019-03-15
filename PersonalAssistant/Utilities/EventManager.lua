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
    if (paIdentifier ~= nil and paIdentifier ~= "") then
        -- if a specific PA identifier was set, use this one as the ESO identifer
        return table.concat({ESO_EVENT, "_", paIdentifier})
    else
        -- elsecreate esoIdentifier based on module/addonName and ESO event
        return table.concat({ESO_EVENT, "_", addonName})
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _waitForJunkProcessingToExecute(functionToExecute, firstCall)
    local PAEM = PA.EventManager
    if (PAEM.isJunkProcessing or firstCall) then
        -- still 'true', try again in 50 ms
        zo_callLater(function() _waitForJunkProcessingToExecute(functionToExecute, false) end, 50)
    else
        -- boolean is false, execute method now
        functionToExecute()
    end
end

-- Acts as a dispatcher between PARepair and PAJunk that both depend on [EVENT_OPEN_STORE]
local function _sharedEventOpenStore()
    local PAMenuFunctions = PA.MenuFunctions
    local PARMenuFunctions = PAMenuFunctions.PARepair
    local PAJMenuFunctions = PAMenuFunctions.PAJunk

    local PAJ = PA.Junk
    if PAJ and PAJMenuFunctions.getAutoSellJunkSetting() then
        -- first execute PAJunk (to sell junk and get gold)
        PAJ.OnShopOpen()
    end

    local PAR = PA.Repair
    if PAR and PARMenuFunctions.getRepairWithGoldSetting() then
        -- only then execute PARepair (to spend gold for repairs)
        -- has to be done with some delay to get a proper update on the current gold amount from selling junk
        _waitForJunkProcessingToExecute(function() PAR.OnShopOpen() end, true)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function RegisterForEvent(addonName, ESO_EVENT, executableFunction, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getEsoIdentifier(addonName, ESO_EVENT, paIdentifier)

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
    local esoIdentifier = _getEsoIdentifier(addonName, ESO_EVENT, paIdentifier)

    -- an event filter will only be registered with ESO, when an event with the same identifier is already registered
    if _containsEventInSet(esoIdentifier) then
        -- check if a filter was provided
        if ESO_FILTER ~=nil and ESOFilterValue ~= nil then
            EVENT_MANAGER:AddFilterForEvent(esoIdentifier, ESO_EVENT, ESO_FILTER, ESOFilterValue)
        end
    end
end

local function UnregisterForEvent(addonName, ESOevent, paIdentifier)
    -- get the esoIdentifier
    local esoIdentifier = _getEsoIdentifier(addonName, ESO_EVENT, paIdentifier)

    -- unregister the event from ESO
    EVENT_MANAGER:UnregisterForEvent(esoIdentifier, ESOevent)
    -- and remove it from PA's internal list of registered events
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
    local PAR = PA.Repair
    local PAB = PA.Banking
    local PAL = PA.Loot
    local PAJ = PA.Junk
    local PAM = PA.Mail


    -- Check if the Addon 'PARepair' is even enabled
    if PAR then
        -- Check if the functionality is turned on within the addon
        local PARMenuFunctions = PAMenuFunctions.PARepair
        -- Check if the functionality is turned on within the addon
        if PARMenuFunctions.getAutoRepairEnabledSetting() then
            -- TODO: add RefreshAllEventRegistrations to getter/setter function
            -- Register for WeaponCharges
            if PARMenuFunctions.getRechargeWithSoulGemSetting() then
                -- TODO: check if it is enabled here and Refresh the events upon changing that setting
                RegisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAR.RechargeEquippedWeaponsWithSoulGems, "SoulGems")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_ITEM_CHARGE)
            else
                UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SoulGems")
            end

            -- Register for RepairKits
            if PARMenuFunctions.getRepairWithRepairKitSetting() then
                RegisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAR.RepairEquippedItemsWithRepairKits, "RepairKits")
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)
                RegisterFilterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DURABILITY_CHANGE)
            else
                UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "RepairKits")
            end

            -- Register for GoldRepair
            -- TODO: make new separate event that still checks for selling Junk
--            if PARMenuFunctions.getRepairWithGoldSetting() then
--                RegisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, _sharedEventOpenStore, "RepairJunkSharedEvent")
--            else
                --
--            end

            -- Register PARepair (in correspondance with PAJunk)
            -- TODO: Check this function
            RegisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, _sharedEventOpenStore, "RepairJunkSharedEvent")

        else
            -- Unregister PARepair
            UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "SoulGems")
            UnregisterForEvent(PAR.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, "RepairKits")

            -- Unregister the SharedEvent, but only if PAJunk is not enabled!
            if not (PAJ and PAMenuFunctions.PAJunk.getAutoMarkAsJunkEnabledSetting()) then
                UnregisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, "RepairJunkSharedEvent")
            end
        end
    end

    -- Check if the Addon 'PABanking' is even enabled
    if PAB then
        -- Check if the functionality is turned on within the addon
        local PABMenuFunctions = PAMenuFunctions.PABanking
        if (PABMenuFunctions.getCurrenciesEnabledSetting() or PABMenuFunctions.getCraftingItemsEnabledSetting()
            or PABMenuFunctions.getAdvancedItemsEnabledSetting() or PABMenuFunctions.getIndividualItemsEnabledSetting()) then
            -- Register PABanking
            -- TODO: Check this function
            RegisterForEvent(PAB.AddonName, EVENT_OPEN_BANK, PAB.OnBankOpen)
            -- TODO: Check this function
            RegisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK, PAB.OnBankClose)
        else
            -- Unregister PABanking
            UnregisterForEvent(PAB.AddonName, EVENT_OPEN_BANK)
            UnregisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK)
        end
    end


    -- Check if the Addon 'PAloot' is even enabled
    if PAL then
        -- Check if the functionality is turned on within the addon
        if (PAMenuFunctions.PALoot.isEnabled()) then
            -- Register PALoot to check looted items
            RegisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAL.OnInventorySingleSlotUpdate)
            RegisterFilterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
            RegisterFilterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)

            -- needed in order to track stacking the backpack
            RegisterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, PAL.UpdateNumBagUsedSlots)
            RegisterFilterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
            -- TODO. test if neede for bank?

            -- needed in order to track individual sells at vendor
            RegisterForEvent(PAL.AddonName, EVENT_SELL_RECEIPT, PAL.UpdateNumBagUsedSlots)
        else
            -- Unregister PALoot
            UnregisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
            UnregisterForEvent(PAL.AddonName, EVENT_STACKED_ALL_ITEMS_IN_BAG)
            UnregisterForEvent(PAL.AddonName, EVENT_SELL_RECEIPT)
        end
    end


    -- Check if the Addon 'PAJunk' is even enabled
    if PAJ then
        -- Check if the functionality is turned on within the addon
        if (PAMenuFunctions.PAJunk.getAutoMarkAsJunkEnabledSetting()) then
            -- Register PAJunk for looting junk items
            RegisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAJ.OnInventorySingleSlotUpdate)
            RegisterFilterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
            RegisterFilterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)
            -- Register PAJunk (for Fences)
            RegisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE, PAJ.OnFenceOpen)
            -- Register PAJunk (in correspondance with PARepair)
            RegisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, _sharedEventOpenStore, "RepairJunkSharedEvent")
            -- Register Mailbox Open check (to disable marking as junk)
            RegisterForEvent(PAJ.AddonName, EVENT_MAIL_OPEN_MAILBOX, PAJ.OnMailboxOpen)
            RegisterForEvent(PAJ.AddonName, EVENT_MAIL_CLOSE_MAILBOX, PAJ.OnMailboxClose)
        else
            -- Unregister PAJunk
            UnregisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
            UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_FENCE)
            -- Unregister the SharedEvent, but only if PARepair is not enabled!
            if not (PAR and PAMenuFunctions.PARepair.getAutoRepairEnabledSetting()) then
                UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, "RepairJunkSharedEvent")
            end
            -- Unregister Mailbox Check
            UnregisterForEvent(PAJ.AddonName, EVENT_MAIL_OPEN_MAILBOX)
            UnregisterForEvent(PAJ.AddonName, EVENT_MAIL_CLOSE_MAILBOX)
        end
    end

    -- Check if the Addon 'PAMail' is even enabled
    if PAM then
        -- Check if the functionality is turned on within the addon
        local PAMMenuFunctions = PAMenuFunctions.PAMail
        if PAMMenuFunctions.getHirelingAutoMailEnabledSetting() then
            -- Register PAMail
            -- TODO: EVENT_PLAYER_ACTIVATED does not work, check why (maybe not needed anyway?)
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED, PAM.readHirelingMails)
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_READABLE, PAM.takeAttachedItemsFromSingleMail)
            RegisterForEvent(PAM.AddonName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, PAM.takeAttachedItemSuccess)
        else
            -- Unregister PAMail
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED)
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_READABLE)
            UnregisterForEvent(PAM.AddonName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
        end
    end
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.EventManager = {
    listAllEventsInSet = listAllEventsInSet,
    RegisterForEvent = RegisterForEvent,
    RegisterFilterForEvent = RegisterFilterForEvent,
    UnregisterForEvent = UnregisterForEvent,
    RefreshAllEventRegistrations = RefreshAllEventRegistrations,
    isJunkProcessing = false, -- TODO: check if really needed?
}