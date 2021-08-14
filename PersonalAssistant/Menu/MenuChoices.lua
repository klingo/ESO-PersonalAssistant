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
            GetString(SI_PA_REL_BACKPACK_EQUAL),
            -- GetString(SI_PA_REL_BACKPACK_LESSTHAN),
            GetString(SI_PA_REL_BACKPACK_LESSTHANEQUAL),
            -- GetString(SI_PA_REL_BACKPACK_GREATERTHAN),
            GetString(SI_PA_REL_BACKPACK_GREATERTHANEQUAL),
            GetString(SI_PA_REL_BANK_EQUAL),
            -- GetString(SI_PA_REL_BANK_LESSTHAN),
            GetString(SI_PA_REL_BANK_LESSTHANOREQUAL),
            -- GetString(SI_PA_REL_BANK_GREATERTHAN),
            GetString(SI_PA_REL_BANK_GREATERTHANOREQUAL),
        },
    },
    PAJunk = {
        qualityLevelNoDisabled = {
            GetString(SI_PA_QUALITY_TRASH),
            GetString(SI_PA_QUALITY_NORMAL),
            GetString(SI_PA_QUALITY_FINE),
            GetString(SI_PA_QUALITY_SUPERIOR),
            GetString(SI_PA_QUALITY_EPIC),
            GetString(SI_PA_QUALITY_LEGENDARY),
        },
        qualityLevel = {
            GetString(SI_PA_QUALITY_DISABLED),
            GetString(SI_PA_QUALITY_TRASH),
            GetString(SI_PA_QUALITY_NORMAL),
            GetString(SI_PA_QUALITY_FINE),
            GetString(SI_PA_QUALITY_SUPERIOR),
            GetString(SI_PA_QUALITY_EPIC),
            GetString(SI_PA_QUALITY_LEGENDARY),
        },
        qualityLevelReverse = {
            GetString(SI_PA_QUALITY_DISABLED),
            GetString(SI_PA_QUALITY_LEGENDARY),
            GetString(SI_PA_QUALITY_EPIC),
            GetString(SI_PA_QUALITY_SUPERIOR),
            GetString(SI_PA_QUALITY_FINE),
            GetString(SI_PA_QUALITY_NORMAL),
            GetString(SI_PA_QUALITY_TRASH),
        },
    },
    PALoot = {
        qualityLevel = {
            GetString(SI_PA_QUALITY_DISABLED),
            GetString(SI_PA_QUALITY_FINE),
            GetString(SI_PA_QUALITY_SUPERIOR),
            GetString(SI_PA_QUALITY_EPIC),
        },
    },
    PARepair = {
        defaultSoulGem = {
            GetString("SI_DEFAULTSOULGEMCHOICE", DEFAULT_SOUL_GEM_CHOICE_GOLD),
            GetString("SI_DEFAULTSOULGEMCHOICE", DEFAULT_SOUL_GEM_CHOICE_CROWN),
        },
        defaultRepairKit = {
            GetString("SI_DEFAULTSOULGEMCHOICE", DEFAULT_SOUL_GEM_CHOICE_GOLD),
            GetString("SI_DEFAULTSOULGEMCHOICE", DEFAULT_SOUL_GEM_CHOICE_CROWN),
        }
    },
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
            PAC.OPERATOR.BACKPACK_EQUAL,
            -- PAC.OPERATOR.BACKPACK_LESSTHAN,
            PAC.OPERATOR.BACKPACK_LESSTHANOREQUAL,
            -- PAC.OPERATOR.BACKPACK_GREATERTHAN,
            PAC.OPERATOR.BACKPACK_GREATERTHANOREQUAL,
            PAC.OPERATOR.BANK_EQUAL,
            -- PAC.OPERATOR.BANK_LESSTHAN,
            PAC.OPERATOR.BANK_LESSTHANOREQUAL,
            -- PAC.OPERATOR.BANK_GREATERTHAN,
            PAC.OPERATOR.BANK_GREATERTHANOREQUAL,
        },
    },
    PAJunk = {
        qualityLevelNoDisabled = {
            ITEM_FUNCTIONAL_QUALITY_TRASH,         -- 0
            ITEM_FUNCTIONAL_QUALITY_NORMAL,        -- 1
            ITEM_FUNCTIONAL_QUALITY_MAGIC,         -- 2
            ITEM_FUNCTIONAL_QUALITY_ARCANE,        -- 3
            ITEM_FUNCTIONAL_QUALITY_ARTIFACT,      -- 4
            ITEM_FUNCTIONAL_QUALITY_LEGENDARY,     -- 5
        },
        qualityLevel = {
            PAC.ITEM_QUALITY.DISABLED,             -- -1 (disabled)
            ITEM_FUNCTIONAL_QUALITY_TRASH,         -- 0
            ITEM_FUNCTIONAL_QUALITY_NORMAL,        -- 1
            ITEM_FUNCTIONAL_QUALITY_MAGIC,         -- 2
            ITEM_FUNCTIONAL_QUALITY_ARCANE,        -- 3
            ITEM_FUNCTIONAL_QUALITY_ARTIFACT,      -- 4
            ITEM_FUNCTIONAL_QUALITY_LEGENDARY,     -- 5
        },
        qualityLevelReverse = {
            PAC.ITEM_QUALITY.DISABLED_REVERSE,     -- 99 (disabled)
            ITEM_FUNCTIONAL_QUALITY_LEGENDARY,     -- 5
            ITEM_FUNCTIONAL_QUALITY_ARTIFACT,      -- 4
            ITEM_FUNCTIONAL_QUALITY_ARCANE,        -- 3
            ITEM_FUNCTIONAL_QUALITY_MAGIC,         -- 2
            ITEM_FUNCTIONAL_QUALITY_NORMAL,        -- 1
            ITEM_FUNCTIONAL_QUALITY_TRASH,         -- 0
        },
    },
    PALoot = {
        qualityLevel = {
            PAC.ITEM_QUALITY.DISABLED,             -- -1 (disabled)
            ITEM_FUNCTIONAL_QUALITY_MAGIC,         -- 2
            ITEM_FUNCTIONAL_QUALITY_ARCANE,        -- 3
            ITEM_FUNCTIONAL_QUALITY_ARTIFACT,      -- 4
        },
    },
    PARepair = {
        defaultSoulGem = {
            DEFAULT_SOUL_GEM_CHOICE_GOLD,
            DEFAULT_SOUL_GEM_CHOICE_CROWN,
        },
        defaultRepairKit = {
            DEFAULT_SOUL_GEM_CHOICE_GOLD,
            DEFAULT_SOUL_GEM_CHOICE_CROWN,
        }
    },
}

local PAMenuChoicesTooltips = {
    PABanking = {
        mathOperator = {
            GetString(SI_PA_REL_NONE),
            GetString(SI_PA_REL_BACKPACK_EQUAL_T),
            -- GetString(SI_PA_REL_BACKPACK_LESSTHAN_T),
            GetString(SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T),
            -- GetString(SI_PA_REL_BACKPACK_GREATERTHAN_T),
            GetString(SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T),
            GetString(SI_PA_REL_BANK_EQUAL_T),
            -- GetString(SI_PA_REL_BANK_LESSTHAN_T),
            GetString(SI_PA_REL_BANK_LESSTHANOREQUAL_T),
            -- GetString(SI_PA_REL_BANK_GREATERTHAN_T),
            GetString(SI_PA_REL_BANK_GREATERTHANOREQUAL_T),
        }
    }
}

-- Export
PA.MenuChoices = {
    choices = PAMenuChoices,
    choicesValues = PAMenuChoicesValues,
    choicesTooltips = PAMenuChoicesTooltips
}