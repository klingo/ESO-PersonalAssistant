-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local PAIntegrationMenuDefaults = {
    LazyWritCrafter = {
        compatibility = true,
    },
    FCOItemSaver = {

    },
}


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAIntegration = PAIntegrationMenuDefaults