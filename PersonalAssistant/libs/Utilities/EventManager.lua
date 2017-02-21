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
        d(key.."="..tostring(value))
    end
    d("----------------------------------------------------")
end

-- =====================================================================================================================
-- =====================================================================================================================

function PAEM.RegisterForEvent(addonName, ESOevent, executableFunction, paIdentifier)
    -- create esoIdentifier based on module/addonName and ESO event
    local esoIdentifier = ESOevent.."_"..addonName

    -- if a specific PA identifier was set, use this one as the ESO identifer
    if (paIdentifier ~= nil and paIdentifier ~= "") then esoIdentifier = ESOevent.."_"..paIdentifier end

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
    local esoIdentifier = ESOevent.."_"..addonName

    -- if a specific PA identifier was set, use this one as the ESO identifer
    if (paIdentifier ~= nil and paIdentifier ~= "") then esoIdentifier = ESOevent.."_"..paIdentifier end

    -- unregister the event from ESO
    EVENT_MANAGER:UnregisterForEvent(esoIdentifier, ESOevent)
    -- and remove it from PA's internal list of registered events
    removeEventFromSet(esoIdentifier)
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
function PAEM.EventOpenStore()

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