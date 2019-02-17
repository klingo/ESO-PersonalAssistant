local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!   -   no localization for language [%s] available (yet)."}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!"}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " welcomes you! In order to get started, please go to the Addon Settings (or type /pa) and select a profile. Thank you :-)"}),

    -- Key Bindings
    SI_PA_KB_LOAD_PROFILE = "Activate profile",

    -- =================================================================================================================

    -- PAGeneral --
    SI_PA_PROFILE = "Profile",
    SI_PA_PLEASE_SELECT_PROFILE = "<Please select Profile>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output - UI Settings --
    SI_PA_REPAIR_CHATMODE_NONE = "<no output>",
    SI_PA_REPAIR_CHATMODE_MAX = "Full Detail Report",

    -- PARepair Chat Output - NORMAL setting --
    SI_PA_REPAIR_CHAT_OUTPUT_GOLD_MISSING = "missing", -- example output: "[...] (55 Gold missing)"

    -- PARepair Chat Output - MAX setting --
    SI_PA_REPAIR_CHATMODE_MAX_INTRO = table.concat({PAC.COLORED_TEXTS.PAR, "Repairing all items with a durability of ", PAC.COLORS.WHITE, "%d%%", PAC.COLORS.DEFAULT, " or lower:"}),
    SI_PA_REPAIR_CHATMODE_MAX_REPAIRED = table.concat({PAC.COLORED_TEXTS.PAR, "Repaired %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_REPAIR_CHATMODE_MAX_NOT_REPAIRED = table.concat({PAC.COLORED_TEXTS.PAR, "Could not repair %s ", PAC.COLORS.WHITE, "(%d%%)"}),
    SI_PA_REPAIR_CHATMODE_MAX_SUMMARY_FULL = table.concat({PAC.COLORED_TEXTS.PAR, "%d / %d items repaired for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_REPAIR_CHATMODE_MAX_SUMMARY_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAR, "%d / %d items repaired for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " missing for full repair)"}),
    SI_PA_REPAIR_CHATMODE_MAX_SUMMARY_NOTHING = table.concat({PAC.COLORED_TEXTS.PAR, "Nothing to repair"}),

    -- PARepair Chat Output - Weapon Charge --
    SI_PA_REPAIR_CHARGE_CHATMODE_NONE = "<no output>",
    SI_PA_REPAIR_CHARGE_CHATMODE_MIN = table.concat({PAC.COLORS.DEFAULT, "%s %s (%d%% --> %d%%)"}),
    SI_PA_REPAIR_CHARGE_CHATMODE_NORMAL = table.concat({PAC.COLORED_TEXTS.PAR, "%s (%d%% --> %d%%) - %s"}),
    SI_PA_REPAIR_CHARGE_CHATMODE_MAX = table.concat({PAC.COLORED_TEXTS.PAR, "Charged %s %s from %d%% to %d%%  with %s %s"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_WITHDRAWAL_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s withdrawn."}),
    SI_PA_BANKING_WITHDRAWAL_PARTIAL_SOURCE = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn. (Bank is empty)"}),
    SI_PA_BANKING_WITHDRAWAL_PARTIAL_TARGET = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn. (Not enough space on character)"}),

    SI_PA_BANKING_DEPOSIT_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s deposited."}),
    SI_PA_BANKING_DEPOSIT_PARTIAL_SOURCE = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited. (Character is empty)"}),
    SI_PA_BANKING_DEPOSIT_PARTIAL_TARGET = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited. (Not enough space in bank)"}),

    SI_PA_BANKING_ITEMS_MOVED_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s moved to %s"}),
    SI_PA_BANKING_ITEMS_MOVED_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAB, "%d/%d x %s moved to %s"}),
    SI_PA_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Not enough space!"}),
    SI_PA_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Window was closed!"}),

    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Do Nothing",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Deposit to Bank",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Withdraw to Backpack",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_LOOT_LOOT_MODE_IGNORE = "Ignore",
    SI_PA_LOOT_LOOT_MODE_IGNORE_T = "Nothing happens, the item is ignored",
    SI_PA_LOOT_LOOT_MODE_AUTOLOOT = "Auto-Loot",
    SI_PA_LOOT_LOOT_MODE_AUTOLOOT_T = "Automatically loots the item",
    SI_PA_LOOT_LOOT_MODE_LOOTDESTROY = table.concat({"Auto-Loot and ", PAC.COLORS.RED, "Destroy"}),
    SI_PA_LOOT_LOOT_MODE_LOOTDESTROY_T = table.concat({PAC.COLORS.RED, "CAUTION: USE AT OWN RISK!|r Automatically loots the item, but then immediately destroys the looted amount again."}),
    SI_PA_LOOT_RECIPE_UNKNOWN_SUFFIX = "(unknown)",

    -- PALoot Chat Output - Loot Gold --
    SI_PA_LOOT_GOLD_CHATMODE_NONE = "<no output>",
    SI_PA_LOOT_GOLD_CHATMODE_MAX = table.concat({PAC.COLORED_TEXTS.PAL, "Looted ", PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " Gold"}),

    -- PALoot Chat Output - Loot Items --
    SI_PA_LOOT_ITEMS_CHATMODE_NONE = "<no output>",

    -- PALoot Chat Output - Loot Items Destroyed--
    SI_PA_LOOT_ITEMS_DESTROYED_CHATMODE_MIN = table.concat({PAC.COLORS.DEFAULT, "%d x %s destroyed"}),
    SI_PA_LOOT_ITEMS_DESTROYED_CHATMODE_NORMAL = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s destroyed"}),
    SI_PA_LOOT_ITEMS_DESTROYED_CHATMODE_MAX = table.concat({PAC.COLORED_TEXTS.PAL, "%d x %s %s have been destroyed"}),

    SI_PA_LOOT_ITEMS_DESTROYED_FAILED_MOVE = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.ORANGE, "FAILURE: Could NOT split %d/%d %s %s into seperate stack to destroy safely"}),
    SI_PA_LOOT_ITEMS_DESTROYED_FAILED_DESTORY = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.ORANGE, "FAILURE: No free inventory slot to safely destroy %d/%d %s %s"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_JUNK_MARKED_AS_JUNK = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk"}),
    SI_PA_JUNK_MARKED_AS_JUNK_TRASH = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (Trash)"}),
    SI_PA_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (Ornate)"}),
    SI_PA_JUNK_SOLD_JUNK_INFO = table.concat({PAC.COLORED_TEXTS.PAJ, "Sold junk items for ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail --
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_ENCHANTING = "Raw Enchanter Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_WOODWORKING = "Raw Woodworker Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_CLOTHING = "Raw Clothier Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_BLACKSMITHING = "Raw Blacksmith Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_PROVISIONING = "Raw Provisioner Materials",

    -- =================================================================================================================

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGMenu --
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE = "Active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T = "Select the profile settings that shall be used. Changing the selection will automatically load the settings. Changes below will automatically be stored under the profile.",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME = "Rename active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T = "Rename the active profile",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Show welcome message",
    SI_PA_MENU_GENERAL_SHOW_WELCOME_T = "Display a welcome message from the addon upon successfully starting?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARMenu --
    SI_PA_MENU_REPAIR_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Repair for Equipped Items"}),

    -- TODO: Refactor all texts below for PARepair!
    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", "Repair with ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Repair equipped Items with ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "???",

    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold.",

    SI_PA_MENU_REPAIR_CHATMODE = "Chat display after Repairs",
    SI_PA_MENU_REPAIR_CHATMODE_T = "How to display the information of a full repair in the chat window",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", "Repair with ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Repair equipped Items with ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "???",

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", "Recharge Weapons with ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM))}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Repair equipped Items with ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)), "?"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "???",

    SI_PA_MENU_REPAIR_RECHARGE_DURABILITY = "Re-Charge threshold in %",
    SI_PA_MENU_REPAIR_RECHARGE_DURABILITY_T = "Re-Charge equipped weapons when their charge level is at or below the defined threshold. (Lesser soul gems will be used before common ones)",

    SI_PA_MENU_REPAIR_RECHARGE_CHATMODE = "Chat display after Recharge",
    SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T = "How to display the information of a re-charged weaponin the chat window",


    SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN = "Repair equipped items",
    SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN_T = "Repair equipped items at a merchant?",
    SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN_DURABILITY = "- Durability threshold in %",
    SI_PA_MENU_REPAIR_GOLD_REPAIR_WORN_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold.",
    SI_PA_MENU_REPAIR_KIT_REPAIR_WORN = "Use Repair Kits",
    SI_PA_MENU_REPAIR_KIT_REPAIR_WORN_T = "Repair equipped items with repair kits when out in the field? (Common repair kits will be used before greater ones)",
    SI_PA_MENU_REPAIR_KIT_REPAIR_WORN_DURABILITY = "- Durability threshold in %",
    SI_PA_MENU_REPAIR_KIT_REPAIR_WORN_DURABILITY_T = "Equipped items will only be repaired with a repair kit when their durability is at or below the defined threshold",
    SI_PA_MENU_REPAIR_REPAIR_CHATMODE_FULL = "Chat display: Full repairs",
    SI_PA_MENU_REPAIR_REPAIR_CHATMODE_FULL_T = "How to display the information of a full repair in the chat window",
    SI_PA_MENU_REPAIR_REPAIR_CHATMODE_PARTIAL = "Chat display: Partial/incomplete repairs",
    SI_PA_MENU_REPAIR_REPAIR_CHATMODE_PARTIAL_T = "How to display the information of an incomplet or parcial repair i.e. due to insufficient gold) in the chat window",
    SI_PA_MENU_REPAIR_CHARGE_WEAPONS = "Re-Charge Weapons",
    SI_PA_MENU_REPAIR_CHARGE_WEAPONS_T = "Re-Charge equipped weapons?",
    SI_PA_MENU_REPAIR_CHARGE_WEAPONS_DURABILITY = "- Re-Charge threshold in %",
    SI_PA_MENU_REPAIR_CHARGE_WEAPONS_DURABILITY_T = "Re-Charge equipped weapons when their charge level is at or below the defined threshold. (Lesser soul gems will be used before common ones)",
    SI_PA_MENU_REPAIR_CHARGE_CHATMODE = "Chat display: Charging weapons",
    SI_PA_MENU_REPAIR_CHARGE_CHATMODE_T = "How to display the information of a re-charged weapon in the chat window",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABMenu --
    SI_PA_MENU_BANKING_CURRENCY = "Currencies",
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Maximum to keep on character",

    SI_PA_MENU_BANKING_CRAFTING = "Crafting",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = table.concat({PAC.COLORS.LIGHT_BLUE, "As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag."}),

    SI_PA_MENU_BANKING_ADVANCED = "Special",
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Glyphs",
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS = "Liquids",

    SI_PA_MENU_BANKING_INDIVIDUAL = "Individual",
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT = "Repair Kits",
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC = "Other",

    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK = "Amount to keep in backpack",
    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T = "Define the amount which shall together with the mathematical operator be kept in the backpack.",

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

    -- -----------------------------------------------------------------------------------------------------------------

    SI_PA_MENU_BANKING_DEPOSIT_STACKING = "Stacking rule when depositing",
    SI_PA_MENU_BANKING_DEPOSIT_STACKING_T = "Define whether all Items shall be deposited, or only when there are existing stacks that can be completed.",
    SI_PA_MENU_BANKING_WITHDRAWAL_STACKING = "Stacking rule when withdrawing",
    SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T = "Define whether all Items shall be withdrawn, or only when there are existing stacks that can be completed.",

    SI_PA_MENU_BANKING_TRANSACTION_INTERVAL = "Interval between item transactions (msecs)",
    SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T = "The time in milliseconds between two consecutive item transactions. If too many item moves don't work, consider increasing this value.",

    SI_PA_MENU_BANKING_AUTOSTACKBANK = "Auto-Stack all items when opening the bank",
    SI_PA_MENU_BANKING_AUTOSTACKBANK_T = "Automatically stack all items in the bank when opening it? Helps to keep everything better organized.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- CURRENTLY NOT USED --
    PABMenu_HideNoDeposit = "Hide 'Nothing to Deposit' message",
    PABMenu_HideNoDeposit_T = "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though.",
    PABMenu_HideAll = "Hide ALL banking messages",
    PABMenu_HideAll_T = "Silent-Mode: No banking message will be displayed. You also won't see your deposited gold/items.",
    PABMenu_DepButton = "Deposit all",
    PABMenu_DepButton_T = "Change all dropdown values to 'Deposit'",
    PABMenu_WitButton = "Withdraw all",
    PABMenu_WitButton_T = "Change all dropdown values to 'Withdraw'",
    PABMenu_IgnButton = "Ignore all",
    PABMenu_IgnButton_T = "Change all dropdown values to '-'",
    PABMenu_Lockipck_Header = table.concat({PAC.COLORS.LIGHT_BLUE, "Lockpicks"}),
    PABMenu_Keep_in_Backpack = "Amount to keep in backpack",
    PABMenu_Keep_in_Backpack_T = "Define the amount which shall together with the mathematical operator be kept in the backpack.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PALMenu --
    SI_PA_MENU_LOOT_ESO_AUTOLOOT_DESCRIPTION = table.concat({PAC.COLORS.LIGHT_BLUE, "Because the Auto Loot option of ESO is turned on, PALoot has been disabled. Everything is already automatically looted."}),
    SI_PA_MENU_LOOT_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Loot"}),
    SI_PA_MENU_LOOT_ENABLE_T = "Enable Auto Loot?",
    SI_PA_MENU_LOOT_LOOT_GOLD = "Auto-Loot gold",
    SI_PA_MENU_LOOT_LOOT_GOLD_T = "Automatically loot gold?",
    SI_PA_MENU_LOOT_LOOT_GOLD_CHATMODE = "Chat Display of Auto-Looted Gold",
    SI_PA_MENU_LOOT_LOOT_GOLD_CHATMODE_T = "How to display the information of looted gold in the chat window",
    SI_PA_MENU_LOOT_LOOT_ITEMS = "Auto-Loot items",
    SI_PA_MENU_LOOT_LOOT_ITEMS_T = "Automatically loot items?",
    SI_PA_MENU_LOOT_LOOT_ITEMS_CHATMODE = "Chat Display of Auto-Looted Items",
    SI_PA_MENU_LOOT_LOOT_ITEMS_CHATMODE_T = "How to display the information of looted items in the chat window",
    SI_PA_MENU_LOOT_LOOT_STOLENITEMS = "Auto-Steal items",
    SI_PA_MENU_LOOT_LOOT_STOLENITEMS_T = "Include (to be) stolen items for the Auto-Loot?",
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS = "Harvestable items",
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_T = "Open the sub-menu to define for each harvestable item type whether it shall be auto-looted or not.",
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_DESCRIPTION = "Enable and disable auto-loot for harvestable items such as ores, herbs, woods, runestones, or fishing holes.",
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_BAIT_HEADER = table.concat({PAC.COLORS.LIGHT_BLUE, "BAIT HANDLING"}),
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_BAIT = "Handling of [Bait] items",
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_BAIT_T = "When looting harvestable items, sometimes there also is bait which prevents the node from re-spawning when not looted. Define here what should happen in such cases.",
    SI_PA_MENU_LOOT_LOOT_HARVESTABLEITEMS_HEADER = table.concat({PAC.COLORS.LIGHT_BLUE, "ITEM TYPES"}),
    SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS = "Lootable items",
    SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS_T = "Open the sub-menu to define for each lootable item type whether it shall be auto-looted or not.",
    SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS_DESCRIPTION = "Enable and disable auto-loot for lootable items such as clothing raw materials from animals.",
    SI_PA_MENU_LOOT_LOOT_LOOTABLEITEMS_HEADER = table.concat({PAC.COLORS.LIGHT_BLUE, "ITEM TYPES"}),
    SI_PA_MENU_LOOT_AUTOLOOT_QUESTITEMS = "Quest Items",
    SI_PA_MENU_LOOT_AUTOLOOT_LOCKPICKS = "Lockpick",
    SI_PA_MENU_LOOT_AUTOLOOT_ALL_BUTTON = "Auto-Loot all",
    SI_PA_MENU_LOOT_AUTOLOOT_ALL_BUTTON_T = "Change all dropdown values to 'Auto-Loot'",
    SI_PA_MENU_LOOT_IGNORE_ALL_BUTTON = "Ignore all",
    SI_PA_MENU_LOOT_IGNORE_ALL_BUTTON_T = "Change all dropdown values to 'Ignore'",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJMenu --
    SI_PA_MENU_JUNK_ITEMTYPE_DESCRIPTION = "Enable and disable the automatic marking as junk for selected items based on various conditions.",

    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = table.concat({" ", PAC.COLORS.LIGHT_BLUE, "Enable Auto-Marking of Items as Junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Automatically mark Items as Junk, depending on various different conditions?",
    SI_PA_MENU_JUNK_AUTOMARK_HEADER = table.concat({PAC.ICONS.CRAFTBAG.JUNK.LARGE, " ", "Auto-Mark as Junk"}),

    SI_PA_MENU_JUNK_AUTOMARK_TRASH = "Auto-Mark [Trash] items",
    SI_PA_MENU_JUNK_AUTOMARK_TRASH_T = "Automatically mark items of type [Trash] as junk?",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = "Auto-Mark [Ornate] trait items",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = "Automatically mark items with [Ornate] trait (increased sell price) as junk?",

    SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY = "Auto-Mark Weapons",
    SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY_T = "???", -- TODO: add tooltip
    SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY_THRESHOLD = "If Weapon quality level is at or below",
    SI_PA_MENU_JUNK_AUTOMARK_WEAPONSQUALITY_THRESHOLD_T = "Automatically mark weapons as junk if they are of the selected quality or lower",
    SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY = "Auto-Mark Armor",
    SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY_T = "???", -- TODO: add tooltip
    SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY_THRESHOLD = "If Armor quality level is at or below",
    SI_PA_MENU_JUNK_AUTOMARK_ARMORQUALITY_THRESHOLD_T = "Automatically mark armor as junk if they are of the selected quality or lower",

    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Auto-Sell Junk?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_T = "Automatically sell all items marked as junk?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMMenu --
    SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Mail for Hireling Materials?"}),
    SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE_T = "Enable Auto Mail (read, loot, and delete) for Mails with Raw Materials from Hirelings?",
    SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS = "Delete empty Hireling Mails afterwards?",
    SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T = "After mails from Hirelings have been processed and their items looted, automatically delete the empty mails?",

    -- =================================================================================================================
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "", -- not required so far
    SI_PA_NS_BAG_EQUIPPED = "equipped",
    SI_PA_NS_BAG_BACKPACK = "Backpack",
    SI_PA_NS_BAG_BACKPACKED = "backpack",
    SI_PA_NS_BAG_BANK = "Bank",
    SI_PA_NS_BAG_BANKED = "", -- not required so far
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "Subscriber Bank",
    SI_PA_NS_BAG_SUBSCRIBER_BANKED = "", -- not required so far
    SI_PA_NS_BAG_UNKNOWN = "Unknown",

    -- Operators --
    SI_PA_REL_OPERATOR_T = "Select the Mathematical Operator for this item.",
    SI_PA_REL_EQUAL = "equals (=)",
    SI_PA_REL_LESSTHAN = "less than (<)", -- not required so far
    SI_PA_REL_LESSTHANEQUAL = "less than or equal to (<=)",
    SI_PA_REL_GREATERTHAN = "greater than (>)", -- not required so far
    SI_PA_REL_GREATERTHANEQUAL = "greater than or equal to (>=)",

    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Move everything", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Only fill up existing stacks", -- 1: Fill existing stacks
}

for key, value in pairs(PAStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- -----------------------------------------------------------------------------------------------------------------
    -- MainMenu --
    SI_PA_MENU_TITLE = PAC.COLORED_TEXTS.PA,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGMenu --
    SI_PA_MENU_GENERAL_HEADER = PAC.COLORED_TEXTS.PAG,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARMenu --
    SI_PA_MENU_REPAIR_HEADER = PAC.COLORED_TEXTS.PAR,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABMenu --
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

    SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF)}),
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE))}),
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)}),
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.POTION.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_ADVANCED_LIQUIDS)}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER = table.concat({" ", PAC.ICONS.ITEMS.TREASURE_MAP.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_TROPHY)}),

    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER = table.concat({" ", PAC.ICONS.ITEMS.LOCKPICK.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_LOCKPICK)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM))}),
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GENERIC_HELP.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC)}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PALMenu --
    SI_PA_MENU_LOOT_HEADER = PAC.COLORED_TEXTS.PAL,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJMenu --
    SI_PA_MENU_JUNK_HEADER = PAC.COLORED_TEXTS.PAJ,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMMenu --
    SI_PA_MENU_MAIL_HEADER = PAC.COLORED_TEXTS.PAM,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output - UI Settings --
    SI_PA_REPAIR_CHATMODE_MIN = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, ")"}),
    SI_PA_REPAIR_CHATMODE_NORMAL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " ", GetString(SI_PA_REPAIR_CHAT_OUTPUT_GOLD_MISSING),")"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output - MIN setting --
    SI_PA_REPAIR_CHATMODE_MIN_SUMMARY_FULL = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_REPAIR_CHATMODE_MIN_SUMMARY_PARTIAL = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, ")"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output - NORMAL setting --
    SI_PA_REPAIR_CHATMODE_NORMAL_SUMMARY_FULL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_REPAIR_CHATMODE_NORMAL_SUMMARY_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " ", GetString(SI_PA_REPAIR_CHAT_OUTPUT_GOLD_MISSING) ,")"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot Chat Output - Loot Items --
    SI_PA_LOOT_ITEMS_CHATMODE_MIN = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s"}),
    SI_PA_LOOT_ITEMS_CHATMODE_NORMAL = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s %s"}),
    SI_PA_LOOT_ITEMS_CHATMODE_MAX = table.concat({PAC.COLORED_TEXTS.PAL, "%d x %s %s %s"}),

    -- PALoot Chat Output - Loot Gold --
    SI_PA_LOOT_GOLD_CHATMODE_MIN = table.concat({PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_LOOT_GOLD_CHATMODE_NORMAL = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),


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
