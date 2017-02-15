--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 14.02.2017
-- Time: 22:25
--

PALogger = {}

PALogger.logList = setmetatable({}, { __index = table })


function PALogger.log(logText)
    -- by default, Logger is disabled!
    if (false) then
        PALogger.logList:insert(logText)
    end
end

function PALogger.flush()
    for i = 1, #PALogger.logList do
       d(PALogger.logList[i])
    end

    PALogger.logList = setmetatable({}, { __index = table })
end