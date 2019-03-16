local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!   -   no localization for language [%s] available (yet)"}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!"}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " welcomes you! In order to get started, please go to the Addon Settings (or type ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") and select a profile. Thank you :-)"}),

    -- Key Bindings
    SI_PA_KB_LOAD_PROFILE = "Activate profile",


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral Menu --
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant is a collection of various features that have the goal to make playing ESO more convenient for you",

    SI_PA_PLEASE_SELECT_PROFILE = "<Please select Profile>",

    SI_PA_MENU_GENERAL_ACTIVE_PROFILE = "Active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T = "Select the active profile for PersonalAssistant. It will automatically load all settings stored under that profile and changes are stored in the same place.",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME = "Rename active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T = "Rename the active profile",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Show welcome message",
    SI_PA_MENU_GENERAL_SHOW_WELCOME_T = "Display a welcome message from the addon upon successfully starting?",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking can move Currencies, Crafting and other Items for you between your character's backpack and the bank",

    SI_PA_MENU_BANKING_CURRENCY = GetString(SI_INVENTORY_CURRENCIES), -- TODO: move to generic?
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Maximum to keep on character",

    SI_PA_MENU_BANKING_CRAFTING = "Crafting",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = table.concat({PAC.COLORS.LIGHT_BLUE, "As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag"}),

    SI_PA_MENU_BANKING_ADVANCED = "Special",
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Glyphs",
    SI_PA_MENU_BANKING_ADVANCED_PAPERS = "Papers",

    SI_PA_MENU_BANKING_INDIVIDUAL = "Individual",
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT = "Repair Kits",
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC = "Other",

    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK = "Amount to keep in backpack",
    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T = "Define the amount which shall together with the mathematical operator be kept in the backpack",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for %s"}),
    SI_PA_MENU_BANKING_ANY_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different %s?",
    SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for %s Items"}),
    SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different %s Items?",

    SI_PA_MENU_BANKING_ANY_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for %s Items",
    SI_PA_MENU_BANKING_ANY_TYPE_ENABLE = "Deposit/Withdraw %s",
    SI_PA_MENU_BANKING_ANY_TYPE_ENABLE_T = "Automatically deposit %s to the bank, or withdraw when needed?",
    SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE = "Deposit/Withdraw %s Items",
    SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE_T = "Automatically deposit %s Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "Minimum amount of %s to always keep on the character; if necessary with additional withdrawals from the bank",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "Maximum amount of %s to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE = "Change all above %s Item dropdowns to",
    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_T = "Change all above %s Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",
    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "This cannot be undone; all individually selected values will be lost",

    SI_PA_MENU_BANKING_DEPOSIT_STACKING = "Stacking rule when depositing",
    SI_PA_MENU_BANKING_DEPOSIT_STACKING_T = "Define whether all Items shall be deposited, or only when there are existing stacks that can be completed",
    SI_PA_MENU_BANKING_WITHDRAWAL_STACKING = "Stacking rule when withdrawing",
    SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T = "Define whether all Items shall be withdrawn, or only when there are existing stacks that can be completed",

    SI_PA_MENU_BANKING_TRANSACTION_INTERVAL = "Interval between item transactions (msecs)",
    SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T = "The time in milliseconds between two consecutive item transactions. If too many item moves don't work, consider increasing this value.",

    SI_PA_MENU_BANKING_AUTOSTACKBAGS = "Auto-Stack all items when opening the bank",
    SI_PA_MENU_BANKING_AUTOSTACKBAGS_T = "Automatically stack all items in the bank and in the backpack when accessing the bank? Helps to keep everything better organized",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    -- TODO: Refactor all texts below for PAJunk!
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk can directly mark items as junk if they match any of the configurable rules; except if it just was created or retrieved from mail",

    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = table.concat({" ", PAC.COLORS.LIGHT_BLUE, "Enable Auto-Marking of Items as Junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Automatically mark Items as Junk, depending on various different conditions?",

    SI_PA_MENU_JUNK_TRASH_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.JUNK.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] as junk?"}),

    SI_PA_MENU_JUNK_WEAPONS_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.WEAPON.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON))}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON))}),
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_T = "???", -- TODO: add tooltip
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD = "If Weapon quality level is at or below",
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Weapons as Junk if they are of the selected quality or lower",

    SI_PA_MENU_JUNK_ARMOR_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.ARMOR.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_ARMOR))}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_ARMOR))}),
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_T = "???", -- TODO: add tooltip
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD = "If Armor quality level is at or below",
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Armor as Junk if it is of the selected quality or lower",

    SI_PA_MENU_JUNK_JEWELRY_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.JEWELRY.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY = table.concat({"Auto-Mark "}, zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))),
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_T = "???",  -- TODO: add tooltip
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD = "If Jewelry quality level is at or below",
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Jewelry as Junk if it is of the selected quality or lower",

    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Auto-Sell Junk?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_T = "Automatically sell all items marked as junk?",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Auto-Mark [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait items"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Automatically mark items with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait (increased sell price) as junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Also mark Items that are part of a Set",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "If turned OFF, only items that are NOT belonging to a set will be marked as Junk\nRecommendation: OFF",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Also mark Items with unknown Traits",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "If turned OFF, only items with no Traits or known Traits will be marked as Junk\nRecommendation: OFF",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot Menu --
    -- TODO: Refactor all texts below for PALoot!
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot can notify you when items of special interest (such as unknown recipes, motifs, or traits) have been looted",
    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", "When Looting ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE))}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = table.concat({"Display message if ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " is unknown"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = "???",

    -- Loot Motifs
    SI_PA_MENU_LOOT_MOTIFS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", "When Looting ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF))}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = table.concat({"Display message if ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " is unknown"}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = "???",

    -- Loot Apparel & Weapons
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.WEAPON.NORMAL, "  ", "When Looting ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS))}),
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "Display message if Trait is not yet researched",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = "???",

    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "Warn when low on inventory space",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T ="Display a warning in the chat window if you are low on inventory space",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "Inventory space threshold",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "If the remaining free inventory space is below this threshold, a message is displayed in the chat window",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail Menu --
    SI_PA_MENU_MAIL_DESCRIPTION = "PAMail hopefully will be able to independently collect the materials sent to you by the Crafting Hirelings ;-)",

    SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Mail for Hireling Materials?"}),
    SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE_T = "Enable Auto Mail (read, loot, and delete) for Mails with Raw Materials from Hirelings?",
    SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS = "Delete empty Hireling Mails afterwards?",
    SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T = "After mails from Hirelings have been processed and their items looted, automatically delete the empty mails?",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair repairs your armor and recharges your weapons for you, be it at a merchant or out on the field",

    SI_PA_MENU_REPAIR_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Repair for Equipped Items"}),

    -- TODO: Refactor all texts below for PARepair!
    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", "Repair with ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Repair equipped Items with ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "???",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", "Repair with ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Repair equipped Items with ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "???",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Use Crown ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T = "???",
    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY = "Avg. durability threshold in %",
    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T = "Repair ALL equipped items only if they are on average at or below the defined durability threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = table.concat({"Warn when low on ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"Display a warning in the chat window if you are low on ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), ". If you have none left, it will warn you once every 10 minutes at most."}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "Repair Kit threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"If the remaining amount of ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), " is below this threshold, a message is displayed in the chat window"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", "Recharge Weapons with ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM))}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Recharge equipped weapons with ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)), "?"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "Re-Charge equipped weapons when their charge level reaches zero",
    SI_PA_MENU_REPAIR_RECHARGE_CHATMODE = "Chat display after Recharge",
    SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T = "How to display the information of a re-charged weaponin the chat window",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"Warn when low on ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM))}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"Display a warning in the chat window if you are low on ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)), ". If you have none left, it will warn you once every 10 minutes at most."}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = table.concat({GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM), " threshold"}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"If the remaining amount of ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)), " is below this threshold, a message is displayed in the chat window"}),


    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_CHAT_OUTPUT_ENABLE = "Enable Chat Output",
    SI_PA_MENU_CHAT_OUTPUT_ENABLE_T = "Should information about actions from the addon be printed to the chat?",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "Not yet implemented!"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s withdrawn"}),
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn (Bank is empty)"}),
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn (Not enough space on character)"}),

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s deposited"}),
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited (Character is empty)"}),
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited (Not enough space in bank)"}),

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s moved to %s"}),
    SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAB, "%d/%d x %s moved to %s"}),
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Not enough space!"}),
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Window was closed!"}),


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Quality", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_SOLD_JUNK_INFO = table.concat({PAC.COLORED_TEXTS.PAJ, "Sold junk items for ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d hours"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d minutes"}),


    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({PAC.COLORED_TEXTS.PAL, "%s can be ", PAC.COLORS.ORANGE,"learned", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({PAC.COLORED_TEXTS.PAL, "%s can be ", PAC.COLORS.ORANGE,"learned", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({PAC.COLORED_TEXTS.PAL, "%s has [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] that can be researched!"}),

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({PAC.COLORED_TEXTS.PAL, "%sYou have <<1[", PAC.COLORS.WHITE,"no/only ", PAC.COLORS.WHITE, "%d/only ", PAC.COLORS.WHITE, "%d]>> %s<<1[inventory space/inventory space/inventory spaces]>> left!"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({PAC.COLORED_TEXTS.PAL, "%sYou have <<1[", PAC.COLORS.WHITE,"no/only ", PAC.COLORS.WHITE, "%d/only ", PAC.COLORS.WHITE, "%d]>> %s<<1[Repair Kits/Repair Kit/Repair Kits]>> left!"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({PAC.COLORED_TEXTS.PAL, "%sYou have <<1[", PAC.COLORS.WHITE,"no/only ", PAC.COLORS.WHITE, "%d/only ", PAC.COLORS.WHITE, "%d]>> %s<<1[Soul Gems/SoulGem/Soul Gems]>> left!"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_OUTPUT_MISSING = "missing", -- example output: "[...] (55 Gold missing)"

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({PAC.COLORED_TEXTS.PAR, "Repaired %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " with %s"}),
    SI_PA_CHAT_REPAIR_CHARGE_WEAPON = table.concat({PAC.COLORED_TEXTS.PAR, "%s (%d%% --> %d%%) - %s"}),


    -- =================================================================================================================
    -- == OTHER STRINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "Profile",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Do Nothing",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Deposit to Bank",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Withdraw to Backpack",

    -- Operators --
    SI_PA_REL_OPERATOR_T = "Select the Mathematical Operator for this item",
    SI_PA_REL_EQUAL = "equals (=)",
    SI_PA_REL_LESSTHAN = "less than (<)", -- not required so far
    SI_PA_REL_LESSTHANEQUAL = "less than or equal to (<=)",
    SI_PA_REL_GREATERTHAN = "greater than (>)", -- not required so far
    SI_PA_REL_GREATERTHANEQUAL = "greater than or equal to (>=)",

    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Move everything", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Only fill up existing stacks", -- 1: Fill existing stacks


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail --
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_ENCHANTING = "Raw Enchanter Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_WOODWORKING = "Raw Woodworker Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_CLOTHING = "Raw Clothier Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_BLACKSMITHING = "Raw Blacksmith Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_PROVISIONING = "Raw Provisioner Materials",


    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "", -- not required so far
    SI_PA_NS_BAG_BACKPACK = "Backpack",
    SI_PA_NS_BAG_BANK = "Bank",
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "Subscriber Bank",
    SI_PA_NS_BAG_UNKNOWN = "Unknown",


    -- =================================================================================================================
    -- -----------------------------------------------------------------------------------------------------------------
    -- CURRENTLY NOT USED --
    -- TODO. check if texts can be reused for chat output enable/disable
    PABMenu_HideNoDeposit = "Hide 'Nothing to Deposit' message",
    PABMenu_HideNoDeposit_T = "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though.",
    PABMenu_HideAll = "Hide ALL banking messages",
    PABMenu_HideAll_T = "Silent-Mode: No banking message will be displayed. You also won't see your deposited gold/items.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- TODO: to be removed below?
    SI_PA_MENU_LOOT_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Loot"}),
    SI_PA_MENU_LOOT_ENABLE_T = "Enable Auto Loot?",

    -- =================================================================================================================

}

for key, value in pairs(PAStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- MainMenu --
    SI_PA_MENU_TITLE = PAC.COLORED_TEXTS.PA,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral Menu --
    SI_PA_MENU_GENERAL_HEADER = PAC.COLORED_TEXTS.PAG,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_HEADER = PAC.COLORED_TEXTS.PAB,

    SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_ALLIANCE_POINTS].NORMAL, "  ", GetCurrencyName(CURT_ALLIANCE_POINTS)}),
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_TELVAR_STONES].NORMAL, "  ", GetCurrencyName(CURT_TELVAR_STONES)}),
    SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_WRIT_VOUCHERS].NORMAL, "  ", GetCurrencyName(CURT_WRIT_VOUCHERS)}),

    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.BLACKSMITHING.LARGE, " ",  GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_BLACKSMITHING)}),
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.CLOTHING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_CLOTHING)}),
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.WOODWORKING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WOODWORKING)}),
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.JEWELCRAFTING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRYCRAFTING)}),
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ALCHEMY.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALCHEMY)}),
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ENCHANTING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ENCHANTING)}),
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.PROVISIONING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_PROVISIONING)}),
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.STYLEMATERIALS.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_STYLE_MATERIALS)}),
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.TRAITITEMS.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_TRAIT_ITEMS)}),
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.FURNISHING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_FURNISHING)}),

    SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF))}),
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE))}),
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)}),
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.POTION.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_POTION)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_POISON))}),
    SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.FOOD.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_FOOD)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_DRINK))}),
    SI_PA_MENU_BANKING_ADVANCED_PAPERS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.TREASURE_MAP.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_ADVANCED_PAPERS)}),

    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER = table.concat({" ", PAC.ICONS.ITEMS.LOCKPICK.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_LOCKPICK))}),
    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM))}),
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GENERIC_HELP.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC)}),


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_HEADER = PAC.COLORED_TEXTS.PAJ,


    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot Menu --
    SI_PA_MENU_LOOT_HEADER = PAC.COLORED_TEXTS.PAL,


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail Menu --
    SI_PA_MENU_MAIL_HEADER = PAC.COLORED_TEXTS.PAM,


    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_HEADER = PAC.COLORED_TEXTS.PAR,


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " ", GetString(SI_PA_CHAT_REPAIR_OUTPUT_MISSING) ,")"}),


    -- =================================================================================================================
    -- == OTHER STRINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR = "> %s",
    SI_PA_REL_NONE = "-",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Item Qualitiy Levels --
    SI_PA_QUALITY_TRASH = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_TRASH)),
    SI_PA_QUALITY_NORMAL = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_NORMAL)),
    SI_PA_QUALITY_FINE = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_MAGIC)),
    SI_PA_QUALITY_SUPERIOR = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARCANE)),
    SI_PA_QUALITY_EPIC = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARTIFACT)),
    SI_PA_QUALITY_LEGENDARY = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_LEGENDARY)),
}

for key, value in pairs(PAGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
