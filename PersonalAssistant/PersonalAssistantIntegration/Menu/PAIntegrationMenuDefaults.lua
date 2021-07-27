-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

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
            preventMoving = false,
        },
        Sell = {
            autoSellMarked = false,
        },
        Deconstruction = {
            itemMoveMode = PAC.MOVE.IGNORE,
        },
        Improvement = {
            itemMoveMode = PAC.MOVE.IGNORE,
        },
        Research = {
            itemMoveMode = PAC.MOVE.IGNORE,
        },
        SellGuildStore = {
            itemMoveMode = PAC.MOVE.IGNORE,
        },
        Intricate = {
            itemMoveMode = PAC.MOVE.IGNORE,
        },
        GearSets = {
            itemMoveMode = {
                [1] = PAC.MOVE.IGNORE,
                [2] = PAC.MOVE.IGNORE,
                [3] = PAC.MOVE.IGNORE,
                [4] = PAC.MOVE.IGNORE,
                [5] = PAC.MOVE.IGNORE,
            }
        },
        DynamicIcons = {

        }
    },
}


-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PAIntegration = PAIntegrationMenuDefaults