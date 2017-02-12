--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 09.02.2017
-- Time: 20:31
--

PAED = {}

--  Acts as a dispatcher between PARepair and PAJunk that both depend on [EVENT_OPEN_STORE]
function PAED.EventOpenStore()
    -- first execute PAJunk (to sell junk and get gold)
    PAJ.OnShopOpen()

    -- only then execute PARepair (to spend gold for repairs)
    -- has to be done with some delay to get a proper update on the current gold amount from selling junk
    PAED.WaitForJunkProcessingToExecute(function() PAR.OnShopOpen() end, true)
end



function PAED.WaitForJunkProcessingToExecute(functionToExecute, firstCall)
    if (PA.isJunkProcessing or firstCall) then
        -- still 'true', try again in 50 ms
        zo_callLater(function() PAED.WaitForJunkProcessingToExecute(functionToExecute, false) end, 50)
    else
        -- boolean is false, execute method now
        functionToExecute()
    end
end