local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!   -   no localization for language [%s] available (yet)."}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!"}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " welcomes you! In order to get started, please go to the Addon Settings (or type /pa) and select a profile. Thank you :-)"}),

    -- Key Bindings
    SI_PA_KB_LOAD_PROFILE = "Activate profile",

    -- =================================================================================================================

    -- PAGeneral --
    SI_PA_PROFILE = "Profile 1",
    SI_PA_PLEASE_SELECT_PROFILE = "<Please select Profile>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output - Full Repair --
    SI_PA_REPAIR_FULL_CHATMODE_NONE = "<no output>",
    SI_PA_REPAIR_FULL_CHATMODE_MIN = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_REPAIR_FULL_CHATMODE_NORMAL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_REPAIR_FULL_CHATMODE_FULL = table.concat({PAC.COLORED_TEXTS.PAR, "All %s items repaired for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),

    -- PARepair Chat Output - Partial Repair --
    SI_PA_REPAIR_PARTIAL_CHATMODE_NONE = "<no output>",
    SI_PA_REPAIR_PARTIAL_CHATMODE_MIN = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, ")"}),
    SI_PA_REPAIR_PARTIAL_CHATMODE_NORMAL = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " missing)"}),
    SI_PA_REPAIR_PARTIAL_CHATMODE_FULL = table.concat({PAC.COLORED_TEXTS.PAR, "%d / %d %s items repaired for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " missing for full repair)"}),

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
    SI_PA_LOOT_GOLD_CHATMODE_MIN = table.concat({PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_LOOT_GOLD_CHATMODE_NORMAL = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_LOOT_GOLD_CHATMODE_MAX = table.concat({PAC.COLORED_TEXTS.PAL, "Looted ", PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " Gold"}),

    -- PALoot Chat Output - Loot Items --
    SI_PA_LOOT_ITEMS_CHATMODE_NONE = "<no output>",
    SI_PA_LOOT_ITEMS_CHATMODE_MIN = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s"}),
    SI_PA_LOOT_ITEMS_CHATMODE_NORMAL = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s %s"}),
    SI_PA_LOOT_ITEMS_CHATMODE_MAX = table.concat({PAC.COLORED_TEXTS.PAL, "%d x %s %s %s"}),

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

    -- MainMenu --
    SI_PA_MENU_TITLE = PAC.COLORED_TEXTS.PA,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGMenu --
    SI_PA_MENU_GENERAL_HEADER = PAC.COLORED_TEXTS.PAG,
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE = "Active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T = "Select the profile settings that shall be used. Changing the selection will automatically load the settings. Changes below will automatically be stored under the profile.",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME = "Rename active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T = "Rename the active profile",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Show welcome message",
    SI_PA_MENU_GENERAL_SHOW_WELCOME_T = "Display a welcome message from the addon upon successfully starting?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARMenu --
    SI_PA_MENU_REPAIR_HEADER = PAC.COLORED_TEXTS.PAR,
    SI_PA_MENU_REPAIR_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Repair"}),
    SI_PA_MENU_REPAIR_ENABLE_T = "Enable Auto Repair?",
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
    SI_PA_MENU_BANKING_HEADER = PAC.COLORED_TEXTS.PAB,
    SI_PA_MENU_BANKING_CURRENCY_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Currencies"}),
    SI_PA_MENU_BANKING_CURRENCY_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Currencies?",

    SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", "Gold"}),
    SI_PA_MENU_BANKING_CURRENCY_GOLD_ENABLE = "Deposit/Withdraw Gold",
    SI_PA_MENU_BANKING_CURRENCY_GOLD_ENABLE_T = "Automatically deposit excess Gold to the bank, or withdraw when needed?",
    SI_PA_MENU_BANKING_CURRENCY_GOLD_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_GOLD_MINTOKEEP_T = "Minimum amount of Gold to always keep on the character; if necessary with additional withdrawals from te bank",
    SI_PA_MENU_BANKING_CURRENCY_GOLD_MAXTOKEEP = "Maximum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_GOLD_MAXTOKEEP_T = "Maximum amount of Gold to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_ALLIANCE_POINTS].NORMAL, "  ", "Alliance Points"}),
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_ENABLE = "Deposit/Withdraw Alliance Points",
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_ENABLE_T = "Automatically deposit excess Alliance Points to the bank, or withdraw when needed?",
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_MINTOKEEP_T = "Minimum amount of Alliance Points to always keep on the character; if necessary with additional withdrawals from te bank",
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_MAXTOKEEP = "Maximum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_MAXTOKEEP_T = "Maximum amount of Alliance Points to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_TELVAR_STONES].NORMAL, "  ", "Tel Var Stones"}),
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_ENABLE = "Deposit/Withdraw Tel Var Stones",
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_ENABLE_T = "Automatically deposit excess Tel Var Stones to the bank, or withdraw when needed?",
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_MINTOKEEP_T = "Minimum amount of Tel Var Stones to always keep on the character; if necessary with additional withdrawals from te bank",
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_MAXTOKEEP = "Maximum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_MAXTOKEEP_T = "Maximum amount of Tel Var Stones to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_WRIT_VOUCHERS].NORMAL, "  ", "Writ Vouchers"}),
    SI_PA_MENU_BANKING_CURRENCY_WRIT_ENABLE = "Deposit/Withdraw Writ Vouchers",
    SI_PA_MENU_BANKING_CURRENCY_WRIT_ENABLE_T = "Automatically deposit excess Writ Vouchers to the bank, or withdraw when needed?",
    SI_PA_MENU_BANKING_CURRENCY_WRIT_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_WRIT_MINTOKEEP_T = "Minimum amount of Writ Vouchers to always keep on the character; if necessary with additional withdrawals from te bank",
    SI_PA_MENU_BANKING_CURRENCY_WRIT_MAXTOKEEP = "Maximum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_WRIT_MAXTOKEEP_T = "Maximum amount of Writ Vouchers to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = table.concat({PAC.COLORS.LIGHT_BLUE, "As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag."}),

    SI_PA_MENU_BANKING_CRAFTING_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Crafting Items"}),
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Crafting Items?",

    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Crafting Items",

    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE = "Change all above Crafting Item dropdowns to",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T = "Change all above Crafting Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_W = "This cannot be undone; all individually selected values will be lost",

    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.BLACKSMITHING.LARGE, " ", "Blacksmithing"}),
    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_ENABLE = "Deposit/Withdraw Blacksmithing Items",
    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_ENABLE_T = "Automatically deposit Blacksmithing Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.CLOTHING.LARGE, " ", "Clothing"}),
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_ENABLE = "Deposit/Withdraw Clothing Items",
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_ENABLE_T = "Automatically deposit Clothing Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.WOODWORKING.LARGE, " ", "Woodworking"}),
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_ENABLE = "Deposit/Withdraw Woodworking Items",
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_ENABLE_T = "Automatically deposit Woodworking Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.JEWELCRAFTING.LARGE, " ", "Jewelry Crafting"}),
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_ENABLE = "Deposit/Withdraw Jewelry Crafting Items",
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_ENABLE_T = "Automatically deposit Jewelry Crafting Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ALCHEMY.LARGE, " ", "Alchemy"}),
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_ENABLE = "Deposit/Withdraw Alchemy Items",
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_ENABLE_T = "Automatically deposit Alchemy Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ENCHANTING.LARGE, " ", "Enchanting"}),
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_ENABLE = "Deposit/Withdraw Enchanting Items",
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_ENABLE_T = "Automatically deposit Enchanting Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.PROVISIONING.LARGE, " ", "Provisioning"}),
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_ENABLE = "Deposit/Withdraw Provisioning Items",
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_ENABLE_T = "Automatically deposit Provisioning Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.STYLEMATERIALS.LARGE, " ", "Style Materials"}),
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_ENABLE = "Deposit/Withdraw Style Material Items",
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_ENABLE_T = "Automatically deposit Style Material Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.TRAITITEMS.LARGE, " ", "Trait Items"}),
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_ENABLE = "Deposit/Withdraw Trait Items",
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_ENABLE_T = "Automatically deposit Trait Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.FURNISHING.LARGE, " ", "Furnishing"}),
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_ENABLE = "Deposit/Withdraw Furnishing Items",
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_ENABLE_T = "Automatically deposit Furnishing Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_ADVANCED_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Special Items"}),
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Special Items?",

    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Special Items",

    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE = "Change all above Special Item dropdowns to",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T = "Change all above Special Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_W = "This cannot be undone; all individually selected values will be lost",

    SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", "Motif"}),
    SI_PA_MENU_BANKING_ADVANCED_MOTIF_ENABLE = "Deposit/Withdraw Motif Items",
    SI_PA_MENU_BANKING_ADVANCED_MOTIF_ENABLE_T = "Automatically deposit Motif Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", "Recipe"}),
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_ENABLE = "Deposit/Withdraw Recipes",
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_ENABLE_T = "Automatically deposit Recipes to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.NORMAL, "  ", "Glyphs"}),
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_ENABLE = "Deposit/Withdraw Glyphs",
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_ENABLE_T = "Automatically deposit Glyphs to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.POTION.NORMAL, "  ", "Liquids"}),
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_ENABLE = "Deposit/Withdraw Liquids",
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_ENABLE_T = "Automatically deposit Liquids to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER = table.concat({" ", PAC.ICONS.ITEMS.TREASURE_MAP.NORMAL, "  ", "Trophies"}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_ENABLE = "Deposit/Withdraw Trophies",
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_ENABLE_T = "Automatically deposit Trophies to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE = table.concat({" ", PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Individual Items"}),
    SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Individual Items?",

    SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Individual Items",

    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER = table.concat({" ", PAC.ICONS.ITEMS.LOCKPICK.NORMAL, "  ", "Lockpicks"}), -- TODO: replace with SI_ITEMTYMPE ?
    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_ENABLE = "Deposit/Withdraw Lockpicks", -- TODO: replace with SI_ITEMTYMPE ?
    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_ENABLE_T = "Automatically deposit Lockpicks to the bank, or withdraw when needed?", -- TODO: replace with SI_ITEMTYMPE ?

    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", "Soul Gems"}), -- TODO: replace with SI_ITEMTYMPE ?
    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_ENABLE = "Deposit/Withdraw Soul Gems", -- TODO: replace with SI_ITEMTYMPE ?
    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_ENABLE_T = "Automatically deposit Soul Gems to the bank, or withdraw when needed?", -- TODO: replace with SI_ITEMTYMPE ?

    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", "Repair Kits"}), -- TODO: replace with SI_ITEMTYMPE ?
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_ENABLE = "Deposit/Withdraw Repair Kits", -- TODO: replace with SI_ITEMTYMPE ?
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_ENABLE_T = "Automatically deposit Repair Kits to the bank, or withdraw when needed?", -- TODO: replace with SI_ITEMTYMPE ?

    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GENERIC_HELP.NORMAL, "  ", "Other Items"}),
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_ENABLE = "Deposit/Withdraw Other Items",
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_ENABLE_T = "Automatically deposit Other Items to the bank, or withdraw when needed?",

    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK = "Amount to keep in backpack",
    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T = "Define the amount which shall together with the mathematical operator be kept in the backpack.",

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
    SI_PA_MENU_LOOT_HEADER = PAC.COLORED_TEXTS.PAL,
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
    SI_PA_MENU_JUNK_HEADER = PAC.COLORED_TEXTS.PAJ,
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
    SI_PA_MENU_MAIL_HEADER = PAC.COLORED_TEXTS.PAM,
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
    SI_PA_REL_OPERATOR = "> %s",
    SI_PA_REL_OPERATOR_T = "Select the Mathematical Operator for this item.",
    SI_PA_REL_NONE = "-",
    SI_PA_REL_EQUAL = "equals (=)",
    SI_PA_REL_LESSTHAN = "less than (<)", -- not required so far
    SI_PA_REL_LESSTHANEQUAL = "less than or equal to (<=)",
    SI_PA_REL_GREATERTHAN = "greater than (>)", -- not required so far
    SI_PA_REL_GREATERTHANEQUAL = "greater than or equal to (>=)",

    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Move everything", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Only fill up existing stacks", -- 1: Fill existing stacks

    -- Item Qualitiy Levels --
    SI_PA_QUALITY_TRASH = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_TRASH)),
    SI_PA_QUALITY_NORMAL = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_NORMAL)),
    SI_PA_QUALITY_FINE = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_MAGIC)),
    SI_PA_QUALITY_SUPERIOR = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARCANE)),
    SI_PA_QUALITY_EPIC = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARTIFACT)),
    SI_PA_QUALITY_LEGENDARY = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_LEGENDARY)),
}

for key, value in pairs(PAStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
