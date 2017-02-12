--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 09.02.2017
-- Time: 20:31
--

PAEM = {}

PAEM.registeredIdentifierSet = {}

-- global indicators of whether some processing is ongoing
PAEM.isJunkProcessing = false

------------------------------------------------------------------------------------------------------------------------

function PAEM.RegisterForEvent(addonName, ESOevent, executableFunction, paIdentifier)
    -- create esoIdentifier based on module/addonName and ESO event
    local esoIdentifier = addonName.."_"..ESOevent

    -- if a specific PA identifier was set, use this one as the ESO identifer
    if (not paIdentifier == nil and not paIdentifier == "") then esoIdentifier = paIdentifier end

    -- an event will only be registered with ESO, when the same identiifer is not yet registered
    if not PAEM.containsEventInSet(esoIdentifier) then
        -- register the event with ESO
        EVENT_MANAGER:RegisterForEvent(esoIdentifier, ESOevent, executableFunction)
        -- and add it to PA's internal list of registered events
        PAEM.addEventToSet(esoIdentifier)
    end
end


function PAEM.UnregisterForEvent(addonName, ESOevent)
    -- create esoIdentifier based on addonName and ESO event
    local esoIdentifier = addonName.."_"..tostring(ESOevent)
    -- unregister the event from ESO
    EVENT_MANAGER:UnregisterForEvent(esoIdentifier, ESOevent)
    -- and remove it from PA's internal list of registered events
    PAEM.removeEventFromSet(esoIdentifier)
end


function PAEM.addEventToSet(key)
    PAEM.registeredIdentifierSet[key] = true
end

function PAEM.removeEventFromSet(key)
    PAEM.registeredIdentifierSet[key] = nil
end

function PAEM.containsEventInSet(key)
    return PAEM.registeredIdentifierSet[key] ~= nil
end

------------------------------------------------------------------------------------------------------------------------


--  Acts as a dispatcher between PARepair and PAJunk that both depend on [EVENT_OPEN_STORE]
function PAEM.EventOpenStore()

    if (PAJ) then
        -- first execute PAJunk (to sell junk and get gold)
        PAJ.OnShopOpen()
    end

    if (PAR) then
        -- only then execute PARepair (to spend gold for repairs)
        -- has to be done with some delay to get a proper update on the current gold amount from selling junk
        PAEM.WaitForJunkProcessingToExecute(function() PAR.OnShopOpen() end, true)
    end
end



function PAEM.WaitForJunkProcessingToExecute(functionToExecute, firstCall)
    if (PAEM.isJunkProcessing or firstCall) then
        -- still 'true', try again in 50 ms
        zo_callLater(function() PAEM.WaitForJunkProcessingToExecute(functionToExecute, false) end, 50)
    else
        -- boolean is false, execute method now
        functionToExecute()
    end
end