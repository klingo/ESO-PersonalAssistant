-- Local instances of Global tables --
local PA = PersonalAssistant

-- =====================================================================================================================

local PAConsumeMenuDefaults = {
    name = table.concat({GetString(SI_PA_PROFILE), " ", 1}),

    -- ---------------------------------------------
    autoConsumePoisonEnabled = false,

    -- ---------------------------------------------
    silentMode = false,
}

local PAConsumeMenuCharacterDefaults = {

	isAutoEatFood = false,
	foodLink = "",
	foodBufferSeconds = 300, -- seconds
    isAutoConsumeEXP = false,
	EXPLink = "",
	EXPBufferSeconds = -1, -- seconds

}

-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAConsume = PAConsumeMenuDefaults
PA.MenuDefaults.PAConsumeCharacter = PAConsumeMenuCharacterDefaults