-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local _validCallbackEvents = {
    PA_BANKING_COMPLETE = "PA_BANKING_COMPLETE"
}

local function assertValidCallbackEvent(paEventName)
    assert(_validCallbackEvents[paEventName] ~= nil, string.format("PersonalAssistant.CallbackManager: Invalid paEventName '%s' provided!", paEventName))
    return true
end

-- ---------------------------------------------------------------------------------------------------------------------

local function RegisterExternalCallback(paEventName, callback, arg)
    assertValidCallbackEvent(paEventName)
    CALLBACK_MANAGER:RegisterCallback(paEventName, callback, arg)
end

local function UnregisterExternalCallback(paEventName, callback)
    assertValidCallbackEvent(paEventName)
    CALLBACK_MANAGER:UnregisterCallback(paEventName, callback)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CallbackManager = {
    PA_BANKING_COMPLETE = _validCallbackEvents.PA_BANKING_COMPLETE,
    RegisterExternalCallback = RegisterExternalCallback,
    UnregisterExternalCallback = UnregisterExternalCallback,
}