--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 09.02.2017
-- Time: 20:31
--

PAEM = {}

-- global indicators of whether some processing is ongoing
PAEM.isJunkProcessing = false


-- =====================================================================================================================
-- =====================================================================================================================


local registeredIdentifierSet = {}

local function addEventToSet(key)
    registeredIdentifierSet[key] = true
end

local function removeEventFromSet(key)
    registeredIdentifierSet[key] = nil
end

local function containsEventInSet(key)
    return registeredIdentifierSet[key] ~= nil
end

function PAEM.listAllEventsInSet()
    d("----------------------------------------------------")
    d("PA: listing all registered events")
    for key, value in pairs(registeredIdentifierSet) do
        -- d(key.."="..tostring(value))
        d(key)
    end
    d("----------------------------------------------------")
end


-- =====================================================================================================================
-- =====================================================================================================================


local function WaitForJunkProcessingToExecute(functionToExecute, firstCall)
    if (PAEM.isJunkProcessing or firstCall) then
        -- still 'true', try again in 50 ms
        zo_callLater(function() WaitForJunkProcessingToExecute(functionToExecute, false) end, 50)
    else
        -- boolean is false, execute method now
        functionToExecute()
    end
end

--  Acts as a dispatcher between PARepair and PAJunk that both depend on [EVENT_OPEN_STORE]
local function SharedEventOpenStore()

    if (PAJ) then
        -- first execute PAJunk (to sell junk and get gold)
        PAJ.OnShopOpen()
    end

    if (PAR) then
        -- only then execute PARepair (to spend gold for repairs)
        -- has to be done with some delay to get a proper update on the current gold amount from selling junk
        WaitForJunkProcessingToExecute(function() PAR.OnShopOpen() end, true)
    end
end

-- =====================================================================================================================
-- =====================================================================================================================


function PAEM.RegisterForEvent(addonName, ESOevent, executableFunction, paIdentifier)
    -- create esoIdentifier based on module/addonName and ESO event
    local esoIdentifier = ESOevent .. "_" .. addonName

    -- if a specific PA identifier was set, use this one as the ESO identifer
    if (paIdentifier ~= nil and paIdentifier ~= "") then esoIdentifier = ESOevent .. "_" .. paIdentifier end

    -- an event will only be registered with ESO, when the same identiifer is not yet registered
    if not containsEventInSet(esoIdentifier) then
        -- register the event with ESO
        EVENT_MANAGER:RegisterForEvent(esoIdentifier, ESOevent, executableFunction)
        -- and add it to PA's internal list of registered events
        addEventToSet(esoIdentifier)
    end
end


function PAEM.UnregisterForEvent(addonName, ESOevent, paIdentifier)
    -- create esoIdentifier based on addonName and ESO event
    local esoIdentifier = ESOevent .. "_" .. addonName

    -- if a specific PA identifier was set, use this one as the ESO identifer
    if (paIdentifier ~= nil and paIdentifier ~= "") then esoIdentifier = ESOevent .. "_" .. paIdentifier end

    -- unregister the event from ESO
    EVENT_MANAGER:UnregisterForEvent(esoIdentifier, ESOevent)
    -- and remove it from PA's internal list of registered events
    removeEventFromSet(esoIdentifier)
end



function PAEM.RefreshAllEventRegistrations()

    -- Check if the Addon 'PARepair' is even enabled
    if (PAR) then
        -- Check if the functionality is turned on within the addon
        if (PAMenu_Functions.getFunc.PARepair.enabled()) then
            -- Register PARepair for RepairKits and WeaponCharges
            PAEM.RegisterForEvent(PAR.AddonName, EVENT_PLAYER_COMBAT_STATE, PAR.EventPlayerCombateState)
            -- Register PARepair (in correspondance with PAJunk)
            PAEM.RegisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, SharedEventOpenStore, "RepairJunkSharedEvent")
        else
            -- Unregister PARepair
            PAEM.UnregisterForEvent(PAR.AddonName, EVENT_PLAYER_COMBAT_STATE)
            -- Unregister the SharedEvent, but only if PAJunk is not enabled!
            if not (PAJ and PAMenu_Functions.getFunc.PAJunk.enabled()) then
                PAEM.UnregisterForEvent(PAR.AddonName, EVENT_OPEN_STORE, "RepairJunkSharedEvent")
            end
        end
    end

    -- Check if the Addon 'PABanking' is even enabled
    if (PAB) then
        -- Check if the functionality is turned on within the addon
        if (PAMenu_Functions.getFunc.PABanking.enabled()) then
            -- Register PABanking
            PAEM.RegisterForEvent(PAB.AddonName, EVENT_OPEN_BANK, PAB.OnBankOpen)
            PAEM.RegisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK, PAB.OnBankClose)
        else
            -- Unregister PABanking
            PAEM.UnregisterForEvent(PAB.AddonName, EVENT_OPEN_BANK)
            PAEM.UnregisterForEvent(PAB.AddonName, EVENT_CLOSE_BANK)
        end
    end


    -- Check if the Addon 'PAloot' is even enabled
    if (PAL) then
        -- Check if the functionality is turned on within the addon
        if (PAMenu_Functions.getFunc.PALoot.enabled()) then
            -- Register PALoot
            PAEM.RegisterForEvent(PAL.AddonName, EVENT_LOOT_UPDATED, PAL.OnLootUpdated)
            PAEM.RegisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAL.OnInventorySingleSlotUpdate)
            ZO_PreHookHandler(RETICLE.interact, "OnEffectivelyShown", PAL.OnReticleTargetChanged)
        else
            -- Unregister PALoot
            PAEM.UnregisterForEvent(PAL.AddonName, EVENT_LOOT_UPDATED)
            PAEM.UnregisterForEvent(PAL.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
            ZO_PreHookHandler(RETICLE.interact, "OnEffectivelyShown", nil)
        end
    end


    -- Check if the Addon 'PAJunk' is even enabled
    if (PAJ) then
        -- Check if the functionality is turned on within the addon
        if (PAMenu_Functions.getFunc.PAJunk.enabled()) then
            -- Register PAJunk for looting junk items
            PAEM.RegisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAJ.OnInventorySingleSlotUpdate)
            -- Register PAJunk (in correspondance with PARepair)
            PAEM.RegisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, SharedEventOpenStore, "RepairJunkSharedEvent")
        else
            -- Unegister PAJunk
            PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
            -- Unregister the SharedEvent, but only if PARepair is not enabled!
            if not (PAR and PAMenu_Functions.getFunc.PARepair.enabled()) then
                PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, "RepairJunkSharedEvent")
            end
        end
    end
end

-- =====================================================================================================================
-- =====================================================================================================================