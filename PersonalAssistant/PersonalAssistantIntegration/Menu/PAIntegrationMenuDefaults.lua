-- Local instances of Global tables --
local PA = PersonalAssistant

-- =====================================================================================================================

local PAIntegrationMenuDefaults = {
    name = table.concat({GetString(SI_PA_PROFILE), " ", 1}),

    -- ---------------------------------------------
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


-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAIntegration = PAIntegrationMenuDefaults