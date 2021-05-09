local PAC = PersonalAssistant.Constants
local PABStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking can move Currencies, Crafting- and other Items between your character's backpack and the bank",

    -- Currencies --
    SI_PA_MENU_BANKING_CURRENCY_HEADER = GetString(SI_INVENTORY_CURRENCIES),
    SI_PA_MENU_BANKING_CURRENCY_ENABLE = table.concat({"Enable Auto Banking for ", GetString(SI_INVENTORY_CURRENCIES)}),
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Maximum to keep on character",

    -- Crafting Items --
    SI_PA_MENU_BANKING_CRAFTING_HEADER = "Crafting Items",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE = "Enable Auto Banking for Crafting Items",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Crafting Items?",
    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Crafting Items",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = "As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE = "Change all above Crafting Item dropdowns to",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T = "Change all above Crafting Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",

    -- Advanced Items --
    SI_PA_MENU_BANKING_ADVANCED_HEADER = "Special Items",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE = "Enable Auto Banking for Special Items",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Special Items?",
    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Special Items",

    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE = "Change all above Special Item dropdowns to",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T = "Change all above Special Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",

    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Known Motifs"}),
    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Known Recipes"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unknown Motifs"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unknown Recipes"}),

    -- Individual Items --
    SI_PA_MENU_BANKING_INDIVIDUAL_HEADER = "Individual Items",
    SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION = table.concat({"With the introduction of custom Banking rules, the \"Individual\" settings have been migrated to there. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- AvA Items --
    SI_PA_MENU_BANKING_AVA_HEADER = "AvA Items",
    SI_PA_MENU_BANKING_AVA_ENABLE = "Enable Auto Banking for AvA Items",
    SI_PA_MENU_BANKING_AVA_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Alliance versus Alliance (AvA) Items?",
    SI_PA_MENU_BANKING_AVA_DESCRIPTION = "Define the amount of different Alliance versus Alliance (AvA) Items you would like to keep in your inventory",
    SI_PA_MENU_BANKING_AVA_OTHER_HEADER = "Other",

    -- Other Settings --
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION = "Auto-Run PABanking item transfers",
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION_T = "Automatically run all item transfers between backpack and bank when accessing the bank? When turned off, you can still run a PABanking item transfer manually at the bank interface",

    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING = "Stacking rule when depositing",
    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T = "Define whether all Items shall be deposited, or only when there are existing stacks that can be completed",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING = "Stacking rule when withdrawing",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T = "Define whether all Items shall be withdrawn, or only when there are existing stacks that can be completed",

    SI_PA_MENU_BANKING_EXCLUDE_JUNK = "Do not move items that are marked as junk",

    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS = "Auto-Stack all items when opening the bank",
    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T = "Automatically stack all items in the bank and in the backpack when accessing the bank? Helps to keep everything better organized",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE = "Deposit/Withdraw %s",

    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK = "Amount to keep",
    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T = "Define the amount which (based on the mathematical operator) shall be kept in the bank or backpack",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "Minimum amount of %s to always keep on the character; if necessary with additional withdrawals from the bank",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "Maximum amount of %s to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "This cannot be undone; all individually selected values will be lost",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MAINMENU_BANKING_HEADER = "Banking Rules",

    SI_PA_MAINMENU_BANKING_HEADER_CATEGORY = "C", -- First letter of "Category"
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "Location",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "Rule",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "Amount",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "Item",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "Actions",


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Add Custom Rule Description --
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_PRE = "The %s should have exactly %d of the selected item.",
    SI_PA_DIALOG_BANKING_BANK_LESSTHANOREQUAL_PRE = "The %s should have at most (maximum) %d of the selected item.",
    SI_PA_DIALOG_BANKING_BANK_GREATERTHANOREQUAL_PRE = "The %s should have at least (minimum) %d of the selected item.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_NOTHING = "> %d in your %s => nothing happens.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_DEPOSIT = "> %d in your %s => transfers items to the %s until there are %d.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_NOTHING = "> %d - %d in your %s => nothing happens.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_DEPOSIT = "> %d - %d in your %s => transfers items to the %s until there are %d.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_WITHDRAW = "> %d - %d in your %s => transfer items away from the %s until there are %d left.",

    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_PRE = "The %s should have exactly %d of the selected item.",
    SI_PA_DIALOG_BANKING_BACKPACK_LESSTHANOREQUAL_PRE = "The %s should have at most (maximum) %d of the selected item.",
    SI_PA_DIALOG_BANKING_BACKPACK_GREATERTHANOREQUAL_PRE = "The %s should have at least (minimum) %d of the selected item.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_NOTHING = "> %d in your %s => nothing happens.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_DEPOSIT = "> %d in your %s => transfers items to the %s until there are %d.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_NOTHING = "> %d - %d in your %s => nothing happens.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_DEPOSIT = "> %d - %d in your %s => transfers items to the %s until there are %d.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_WITHDRAW = "> %d - %d in your %s => transfer items away from the %s until there are %d left.",

    SI_PA_DIALOG_BANKING_EXPLANATION = "This means, if you have . . .",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_FINISHED = "All item transfers completed",

    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = "%s withdrawn",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = "%s / %s withdrawn (Bank is empty)",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = "%s / %s withdrawn (Not enough space on character)",

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = "%s deposited",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = "%s / %s deposited (Character is empty)",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = "%s / %s deposited (Not enough space in bank)",

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = "%d x %s moved to %s",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "Could not move %s to %s. Not enough space!",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "Could not move %s to %s. Window was closed!",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "Some items were NOT deposited to avoid potential interferences with Dolgubon's Lazy Writ Crafter",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("added"), "!"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("updated"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("deleted"), "!"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("enabled"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("disabled"), "!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS = "Run PABanking",
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS_PENDING = "PABanking running...",
}

for key, value in pairs(PABStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PABGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER = GetCurrencyName(CURT_MONEY),
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER = GetCurrencyName(CURT_ALLIANCE_POINTS),
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER = GetCurrencyName(CURT_TELVAR_STONES),
    SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER = GetCurrencyName(CURT_WRIT_VOUCHERS),

    SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER = zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2),
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER = zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2),
    SI_PA_MENU_BANKING_ADVANCED_MASTER_WRITS_HEADER = zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_MASTER_WRIT), 2),
    SI_PA_MENU_BANKING_ADVANCED_HOLIDAY_WRITS_HEADER = zo_strformat("<<m:1>>", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_HOLIDAY_WRIT)),
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS),
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_POTION), 2), " & ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_POISON), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_FOOD), 2), " & ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_DRINK), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_TREASURE_MAPS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ": ", zo_strformat("<<m:1>>", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_TROPHY_TREASURE_MAP))}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_FRAGMENTS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ": ", zo_strformat(GetString("SI_PA_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_SURVEY_REPORTS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ": ", zo_strformat("<<m:1>>", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT))}),
    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS_HEADER = GetString(SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS),

    SI_PA_MENU_BANKING_AVA_SIEGE_BALLISTA_HEADER = GetString("SI_SIEGETYPE", SIEGE_TYPE_BALLISTA),
    SI_PA_MENU_BANKING_AVA_SIEGE_CATAPULT_HEADER = GetString("SI_SIEGETYPE", SIEGE_TYPE_CATAPULT),
    SI_PA_MENU_BANKING_AVA_SIEGE_TREBUCHET_HEADER = GetString("SI_SIEGETYPE", SIEGE_TYPE_TREBUCHET),
    SI_PA_MENU_BANKING_AVA_SIEGE_RAM_HEADER = GetString("SI_SIEGETYPE", SIEGE_TYPE_RAM),
    SI_PA_MENU_BANKING_AVA_SIEGE_OIL_HEADER = GetString("SI_SIEGETYPE", SIEGE_TYPE_OIL),
    SI_PA_MENU_BANKING_AVA_SIEGE_GRAVEYARD_HEADER = GetString("SI_SIEGETYPE", SIEGE_TYPE_GRAVEYARD),
    SI_PA_MENU_BANKING_AVA_REPAIR_HEADER = GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_AVA_REPAIR),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
}

for key, value in pairs(PABGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
