--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 14.02.2017
-- Time: 22:25
--

PALogger = {}

PALogger.logList = setmetatable({}, { __index = table })


function PALogger.log(logText)
    PALogger.logList:insert(logText)
end

function PALogger.flush()
    for i = 1, #PALogger.logList do
       d(PALogger.logList[i])
    end

    PALogger.logList = setmetatable({}, { __index = table })
end