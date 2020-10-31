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

    -- Special Items --
    SI_PA_MENU_BANKING_SPECIAL_HEADER = "Special Items",
    SI_PA_MENU_BANKING_SPECIAL_ENABLE = "Enable Auto Banking for Special Items",
    SI_PA_MENU_BANKING_SPECIAL_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Special Items?",
    SI_PA_MENU_BANKING_SPECIAL_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Special Items",

    SI_PA_MENU_BANKING_SPECIAL_GLOBAL_MOVEMODE = "Change all above Special Item dropdowns to",
    SI_PA_MENU_BANKING_SPECIAL_GLOBAL_MOVEMODE_T = "Change all above Special Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",

    SI_PA_MENU_BANKING_SPECIAL_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Known Motives"}),
    SI_PA_MENU_BANKING_SPECIAL_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Known Recipes"}),
    SI_PA_MENU_BANKING_SPECIAL_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unknown Motives"}),
    SI_PA_MENU_BANKING_SPECIAL_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unknown Recipes"}),

    -- Simple Banking Rules --
    SI_PA_MENU_BANKING_RULES_SIMPLE_HEADER = "Simple Banking Rules",
    SI_PA_MENU_BANKING_RULES_SIMPLE_DISABLED_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Advanced Banking Rules --
    SI_PA_MENU_BANKING_RULES_ADVANCED_HEADER = "Advanced Banking Rules",
    SI_PA_MENU_BANKING_RULES_ADVANCED_DESCRIPTION = table.concat({"Advanced banking rules allow you to create complex rules for Apparels, Jewelries, and Weapons to very specifically define which ones should be deposited to, or withdrawn from the bank.\nThese rules are executed after the simple banking rules.", "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

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
    SI_PA_MAINMENU_BANKING_HEADER = "Simple Banking Rules",
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "Location",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "Rule",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "Amount",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "Item",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "Actions",

    SI_PA_MAINMENU_BANKING_ADVANCED_HEADER = "Advanced Banking Rules",
    SI_PA_MAINMENU_BANKING_ADVANCED_RULE_ID = "#",
    SI_PA_MAINMENU_BANKING_ADVANCED_BAG_ID = "<>",
    SI_PA_MAINMENU_BANKING_ADVANCED_RULE_SUMMARY = "Rule Summary",
    SI_PA_MAINMENU_BANKING_ADVANCED_ACTIONS = "Actions",


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

    -- -----------------------------------------------------------------------------------------------------------------
    -- Simple Banking Rules --
    SI_PA_DIALOG_BANKING_SIMPLE_DISCLAIMER = "Disclaimer: These custom banking rules will be run after all other Auto Banking rules (Crafting, Special, and AvA Items) have been executed first.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Advanced Banking Rules --
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_ACTION = "Item Action",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_GROUP = "Item Group",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_QUALITIES = "Item Qualities",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TYPES = "Item Types",
    SI_PA_DIALOG_BANKING_ADVANCED_LEVEL_RANGE = "Level / Champion Point Range",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TRAITS = "Item Traits",
    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES = "Trait Types",
    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS = "Set Items",
    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS = "Crafted Items",

    SI_PA_DIALOG_BANKING_ADVANCED_PLEASE_SELECT = "<Please Select>",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_GROUP_PLEASE_SELECT = "Please select an [Item Group] first...",

    SI_PA_DIALOG_BANKING_ADVANCED_NONE = "None",
    SI_PA_DIALOG_BANKING_ADVANCED_AVAILABLE = "Available",
    SI_PA_DIALOG_BANKING_ADVANCED_SELECTED = "Selected",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_QUALITIES_ANY = "Any Quality",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TYPES_ANY = "Any Item Type",
    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TRAITS_NONE = "No Traits",

    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_ANY = "Any items (Set and NON-Set)",
    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_SET = "Only items part of a Set",
    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_NO_SET = "Only items NOT part of a Set",

    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_ANY = "Any items (crafted and NON-crafted)",
    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_CRAFTED = "Only crafted items",
    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_NOT_CRAFTED = "Only NON-crafted items",

    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_SELECTED = "Only selected traits",
    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_ANY = "Any items (known and unknown traits)",
    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_KNOWN = "Only items with known traits",
    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_UNKNOWN = "Only items with unknown traits",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Advanced Banking Rules - Rule Construction --
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SUMMARY_DEPOSIT = "DEPOSIT %s to BANK",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SUMMARY_WITHDRAW = "WITHDRAW %s to BACKPACK",

    SI_PA_DIALOG_BANKING_ADVANCED_RULE_ITEM_TYPE = "[%s]",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_TWO_HANDED = table.concat({GetString("SI_EQUIPTYPE", EQUIP_TYPE_TWO_HAND), " "}),
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_OF_QUALITY = "of [%s] quality",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_LEVEL = "Level",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_CP = "CP",

    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SET = "[Set]",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_SET = "[Non-Set]",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_CRAFTED = "[Crafted]",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_CRAFTED = "[Non-Crafted]",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_KNOWN_TRAITS = "with [known] traits",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_UNKNOWN_TRAITS = "with [unknown] traits",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_TRAITS = "with [no] traits",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SELECTED_TRAITS = "with [%s] trait",

    SI_PA_DIALOG_BANKING_ADVANCED_RULE_ALL = "all",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_AND = "and [%s]",
    SI_PA_DIALOG_BANKING_ADVANCED_RULE_BETWEEN = "between [%s] and [%s]",


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
    SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL = "%d/%d x %s moved to %s",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "Could not move %s to %s. Not enough space!",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "Could not move %s to %s. Window was closed!",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "Some items were NOT deposited to avoid potential interferences with Dolgubon's Lazy Writ Crafter",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("added"), "!"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("updated"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("deleted"), "!"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("enabled"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("disabled"), "!"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Advanced Rules --
    SI_PA_CHAT_BANKING_ADVANCED_RULES_ADDED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("added"), "!"}),
    SI_PA_CHAT_BANKING_ADVANCED_RULES_UPDATED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("updated"), "!"}),
    SI_PA_CHAT_BANKING_ADVANCED_RULES_DELETED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("deleted"), "!"}),
    SI_PA_CHAT_BANKING_ADVANCED_RULES_ENABLED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("enabled"), "!"}),
    SI_PA_CHAT_BANKING_ADVANCED_RULES_DISABLED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("disabled"), "!"}),
    SI_PA_CHAT_BANKING_ADVANCED_RULES_MOVED_UP = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("moved up"), " and is now Rule #%d!"}),
    SI_PA_CHAT_BANKING_ADVANCED_RULES_MOVED_DOWN = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("moved down"), " and is now Rule #%d!"}),


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
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER = zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2),

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
