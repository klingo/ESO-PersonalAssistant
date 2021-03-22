-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local WILD_CARD_KEY = '*'
local PACopyDefaults

--- Original 'InitializeWildCardFromDefaults' function by Zenimax Online!
--- Found in: /esoui/libraries/utility/zo_savedvars.lua
local function PAInitializeWildCardFromDefaults(sv, defaults)
    --Make sure that all existing tables have the appropriate defaults
    --It's possible for a table to exist in the sv table (that was created in response to a wild card table), but only certain values have been set
    --It needs to inherit the rest of the values from the default table
    for savedVarKey, savedVarValue in pairs(sv) do
        if type(savedVarValue) == "table" then
            if not rawget(defaults, savedVarValue) then
                PACopyDefaults(savedVarValue, defaults)
            end
        end
    end

    setmetatable(sv, {
        --Indexing this will copy the defaults, assign it to the previously missing key and return it
        --It's almost like it was always there!
        __index = function(t, k)
            if k ~= nil then
                local newValue = PACopyDefaults({}, defaults)
                rawset(t, k, newValue)
                return newValue
            end
        end,
    })
end

--- Original 'CopyPotentialTable' function by Zenimax Online!
--- Found in: /esoui/libraries/utility/zo_savedvars.lua
local function PACopyPotentialTable(sv, key, defaults)
    if not rawget(sv, key) then
        --SVs have nothing, copy and create a new entry
        rawset(sv, key, PACopyDefaults({}, defaults))
    elseif type(sv[key]) == "table" then
        --SV has an entry, and it's a table, set it up for defaults
        PACopyDefaults(sv[key], defaults)
    end
    --The SV isn't a table, nothing to do
end

--- Original 'CopyDefaults' function by Zenimax Online!
--- Found in: /esoui/libraries/utility/zo_savedvars.lua
PACopyDefaults = function(sv, defaults)
    for defaultKey, defaultValue in pairs(defaults) do
        if defaultKey == WILD_CARD_KEY then
            if type(defaultValue) == "table" then
                --Wild card value is a subtable, initialize the subtable
                PAInitializeWildCardFromDefaults(sv, defaultValue)
            else
                --Wild card value is (probably) a primitive, just return a copy when the wild card is indexed
                setmetatable(sv, { __index = function(t, k)
                    if k ~= nil then
                        return defaultValue
                    end
                end,})
            end
        elseif type(defaultValue) == "table" then
            PACopyPotentialTable(sv, defaultKey, defaultValue)
        elseif rawget(sv, defaultKey) == nil then
            rawset(sv, defaultKey, defaultValue)
        end
    end

    return sv
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.ZO_SavedVars.CopyDefaults = PACopyDefaults