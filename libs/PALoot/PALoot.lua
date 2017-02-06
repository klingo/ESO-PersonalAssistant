--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
-- To change this template use File | Settings | File Templates.
--

PAL = {}

function PAL.OnConfirmInteract(eventCode, dialogTitle, dialogBody, acceptText, cancelText)
    PAL.println("eventCode=", eventCode)
    PAL.println("dialogTitle=", dialogTitle)
    PAL.println("dialogBody=", dialogBody)
    PAL.println("acceptText=", acceptText)
    PAL.println("cancelText=", cancelText)
end

function PAL.println(key, ...)
    if (not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideAllMsg) then
        local args = {...}
        PA.println(key, unpack(args))
    end
end

