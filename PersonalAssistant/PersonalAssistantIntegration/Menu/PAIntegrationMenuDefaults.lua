-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PAIntegrationMenuDefaults = {
    LazyWritCrafter = {
        compatibility = true,
    },
    FCOItemSaver = {
        Locked = {
            preventAutoSell = false,
        },
        Research = {

        },
        Sell = {
            autoSellMarked = false,
        },
        Deconstruction = {

        },
        Improvement = {

        },
        SellGuildStore = {

        },
        Intricate = {

        },
    },
}


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAIntegration = PAIntegrationMenuDefaults