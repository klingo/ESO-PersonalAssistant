-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local PAMenuChoices = {
    PABanking = {
        stackingType = {
            GetString(SI_PA_ST_MOVE_FULL),
            GetString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY)
        },
        itemMoveMode = {
            GetString(SI_PA_BANKING_MOVE_MODE_DONOTHING),
            GetString(SI_PA_BANKING_MOVE_MODE_TOBANK),
            GetString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK)
        },
        mathOperator = {
            GetString(SI_PA_REL_NONE),
            GetString(SI_PA_REL_EQUAL),
            -- GetString(SI_PA_REL_LESSTHAN),
            GetString(SI_PA_REL_LESSTHANEQUAL),
            -- GetString(SI_PA_REL_GREATERTHAN),
            GetString(SI_PA_REL_GREATERTHANEQUAL)
        },
    },
    PAJunk = {
        qualityLevel = {
            GetString(SI_PA_QUALITY_DISABLED),
            GetString(SI_PA_QUALITY_TRASH),
            GetString(SI_PA_QUALITY_NORMAL),
            GetString(SI_PA_QUALITY_FINE),
            GetString(SI_PA_QUALITY_SUPERIOR),
            GetString(SI_PA_QUALITY_EPIC),
--            GetString(SI_PA_QUALITY_LEGENDARY),
        }
    }
}

local PAMenuChoicesValues = {
    PABanking = {
        stackingType = {
            PAC.STACKING.FULL,
            PAC.STACKING.INCOMPLETE
        },
        itemMoveMode = {
            PAC.MOVE.IGNORE,
            PAC.MOVE.DEPOSIT,
            PAC.MOVE.WITHDRAW,
        },
        mathOperator = {
            PAC.OPERATOR.NONE,
            PAC.OPERATOR.EQUAL,
            -- PAC.OPERATOR.LESSTHAN,
            PAC.OPERATOR.LESSTHANOREQUAL,
            -- PAC.OPERATOR.GREATERTHAN,
            PAC.OPERATOR.GREATERTHANOREQUAL,
        },
    },
    PAJunk = {
        qualityLevel = {
            PAC.ITEM_QUALITY.DISABLED,  -- -1 (disabled)
            ITEM_QUALITY_TRASH,         -- 0
            ITEM_QUALITY_NORMAL,        -- 1
            ITEM_QUALITY_MAGIC,         -- 2
            ITEM_QUALITY_ARCANE,        -- 3
            ITEM_QUALITY_ARTIFACT,      -- 4
--            ITEM_QUALITY_LEGENDARY,     -- 5
        }
    }
}

local PAMenuChoicesTooltips = {
}

-- Export
PA.MenuChoices = {
    choices = PAMenuChoices,
    choicesValues = PAMenuChoicesValues,
    choicesTooltips = PAMenuChoicesTooltips
}