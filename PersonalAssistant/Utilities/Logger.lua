-- Local instances of Global tables --
local PA = PersonalAssistant

-- =====================================================================================================================

-- Local constants --
PA.LibDebugLogger = _G["LibDebugLogger"]

-- ---------------------------------------------------------------------------------------------------------------------

local function getFormattedText(text, ...)
    local args = { ... }
    local unpackedString = string.format(text, unpack(args))
    if unpackedString == "" then
        unpackedString = text
    end
    return unpackedString
end

local function debugln(prefix, text, ...)
    local textKey = GetString(text)
    local prefix = prefix or ""

    if textKey ~= nil and textKey ~= "" then
        PA.DebugWindow.printToDebugOutputWindow(table.concat({prefix, ": ", getFormattedText(textKey, ...)}))
    else
        PA.DebugWindow.printToDebugOutputWindow(table.concat({prefix, ": ", getFormattedText(text, ...)}))
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

PA.Logger = ZO_Object:Subclass()

function PA.Logger:New(...)
    local obj = ZO_Object.New(self)
    obj:Initialize(...)
    return obj
end

function PA.Logger:Initialize(name, tag)
    assert(type(name) == "string" and name ~= "", "Invalid name for logger")
    assert(type(tag) == "string" and tag ~= "", "Invalid tag for logger")
    self.name = name
    self.tag = tag

    if PA.LibDebugLogger then
        self.libDebugLogger = PA.LibDebugLogger(self.name)
    end
end

function PA.Logger:NewSubLogger(...)
    local obj = ZO_Object.New(self)
    obj:InitializeSub(...)
    return obj
end

function PA.Logger:InitializeSub(parentLogger, name, tag)
    assert(type(name) == "string" and name ~= "", "Invalid name for logger")
    assert(type(tag) == "string" and tag ~= "", "Invalid tag for logger")
    self.personalAssistantLoggerEnabled = false
    self.libDebugLoggerEnabled = false
    self.name = name
    self.tag = tag

    if PA.LibDebugLogger then
        assert(parentLogger ~= nil and parentLogger.libDebugLogger ~= nil, "Invalid parent for logger")
        self.libDebugLogger = parentLogger.libDebugLogger:Create(self.name)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

function PA.Logger:Create(name, tag)
    return PA.Logger:New(name, tag)
end

function PA.Logger:CreateSubLogger(name, tag)
    return PA.Logger:NewSubLogger(self, name, tag)
end

function PA.Logger:SetPersonalAssistantLoggerEnabled(enabled)
    self.personalAssistantLoggerEnabled = enabled
    -- FIXME: This call can cause an endless-loop - find a way to NOT do it always!
    -- showing when already shown causes problems; thus always hide it first ;)
    --PA.DebugWindow.hideDebugOutputWindow()
    --if self.personalAssistantLoggerEnabled then
    --    PA.DebugWindow.showDebugOutputWindow()
    --end
end

function PA.Logger:SetLibDebugLoggerEnabled(enabled)
    self.libDebugLoggerEnabled = enabled
end

function PA.Logger:Verbose(text, ...)
    -- PersonalAssistantLogger
    if self.personalAssistantLoggerEnabled then
        debugln(self.tag, text, ...)
    end
    -- LibDebugLogger
    if self.libDebugLoggerEnabled and self.libDebugLogger then
        self.libDebugLogger:Verbose(text, ...)
    end
end

function PA.Logger:Debug(text, ...)
    -- PersonalAssistantLogger
    if self.personalAssistantLoggerEnabled then
        debugln(self.tag, text, ...)
    end
    -- LibDebugLogger
    if self.libDebugLoggerEnabled and self.libDebugLogger then
        self.libDebugLogger:Debug(text, ...)
    end
end

function PA.Logger:Info(text, ...)
    -- PersonalAssistantLogger
    if self.personalAssistantLoggerEnabled then
        debugln(self.tag, text, ...)
    end
    -- LibDebugLogger
    if self.libDebugLoggerEnabled and self.libDebugLogger then
        self.libDebugLogger:Info(text, ...)
    end
end

function PA.Logger:Warn(text, ...)
    -- PersonalAssistantLogger
    if self.personalAssistantLoggerEnabled then
        debugln(self.tag, text, ...)
    end
    -- LibDebugLogger (always enabled for WARN)
    if self.libDebugLogger then
        self.libDebugLogger:Warn(text, ...)
    end
end

function PA.Logger:Error(text, ...)
    -- PersonalAssistantLogger
    if self.personalAssistantLoggerEnabled then
        debugln(self.tag, text, ...)
    end
    -- LibDebugLogger (always enabled for ERROR)
    if self.libDebugLogger then
        self.libDebugLogger:Error(text, ...)
    end
end