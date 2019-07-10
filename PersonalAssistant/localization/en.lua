local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORS.DEFAULT, " at your service!   -   no localization for language [%s] available (yet)"}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORS.DEFAULT, " at your service!"}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORS.DEFAULT, " welcomes you! In order to get started, please go to the Addon Settings (or type ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") and select a profile. Thank you :-)"}),

    SI_PA_LAM_OUTDATED = table.concat({PAC.COLORS.ORANGE_RED, " requires a more recent version of '", PAC.COLORS.WHITE, "LibAddonMenu-2.0", PAC.COLORS.ORANGE_RED, "' than you currently have installed. Please download and update to the latest one from ", PAC.COLORS.WHITE, "http://esoui.com"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral Menu --
    SI_PA_MENU_PROFILE_HEADER = "Profiles",
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant is a collection of various features that have the goal to make playing ESO more convenient for you",

    SI_PA_PLEASE_SELECT_PROFILE = "<Please select Profile>",

    SI_PA_MENU_GENERAL_ACTIVE_PROFILE = "Active profile",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T = "Select the active profile for PersonalAssistant. It will automatically load all settings stored under that profile and changes are stored in the same place.",
    SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME = "Rename active profile",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Show welcome message",

    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Travel to House"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "If current location permits fast travel, this will initiate the teleport to your primary house!",

    SI_PA_MENU_RULES_HOW_TO_ADD_PAB = "In order to create a new rule for depositing and withdrawing items, simply right-click on an item in your inventory or bank and select in the context-menu:\n> PA Banking > Add new rule",
    SI_PA_MENU_RULES_HOW_TO_ADD_PAJ = "In order to create a new rule for permanently marking an item as junk, simply right-click on an item in your inventory or bank and select in the context-menu:\n> PA Junk > Mark as permanent junk",
    SI_PA_MENU_RULES_HOW_TO_FIND_MENU = table.concat({"You can find all active rules via the icon in the top main menu that you can open with [Alt] key, with ", PAC.COLOR.YELLOW:Colorize("/parules"), " or by clicking on this button:"}),
    SI_PA_MENU_RULES_HOW_TO_CREATE = "How to create new rules?",

    SI_PA_MENU_DANGEROUS_SETTING = "WARNING: Dangerous setting ahead! Use at own risk!",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_OTHER_SETTINGS_HEADER = "Other Settings",

    SI_PA_MENU_SILENT_MODE = "Silent Mode (Disable ALL chat messages)",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "Not yet implemented!"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_CHAT_GENERAL_ACTIVE_PROFILE_ACTIVE = table.concat({PAC.COLORS.DEFAULT, " active profile: ", PAC.COLORS.ORANGE_RED, "%s"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "Profile",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "", -- not required so far
    SI_PA_NS_BAG_BACKPACK = "Backpack",
    SI_PA_NS_BAG_BANK = "Bank",
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "Subscriber Bank",
    SI_PA_NS_BAG_UNKNOWN = "Unknown",

    -- -----------------------------------------------------------------------------------------------------------------
    -- ItemTypes (Custom Singluar/Plural definition) --
    SI_PA_ITEMTYPE4 = "<<1[Food/Foods]>>",
    SI_PA_ITEMTYPE5 = "<<1[Trophy/Trophies]>>",
    SI_PA_ITEMTYPE7 = "<<1[Potion/Potions]>>",
    SI_PA_ITEMTYPE8 = "<<1[Motif/Motives]>>",
    SI_PA_ITEMTYPE12 = "<<1[Drink/Drinks]>>",
    SI_PA_ITEMTYPE19 = "<<1[Soul Gem/Soul Gems]>>",
    SI_PA_ITEMTYPE22 = "<<1[Lockpick/Lockpicks]>>",
    SI_PA_ITEMTYPE29 = "<<1[Recipe/Recipes]>>",
    SI_PA_ITEMTYPE30 = "<<1[Poison/Poisons]>>",
    SI_PA_ITEMTYPE34 = "<<1[Collectible/Collectibles]>>",
    SI_PA_ITEMTYPE47 = "<<1[AvA Repair/AvA Repairs]>>",
    SI_PA_ITEMTYPE60 = "<<1[Master Writ/Master Writs]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Master Writs based on CraftingType (Custom definition) --
    SI_PA_MASTERWRIT_CRAFTINGTYPE0 = table.concat({"Other Writs (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}),
    SI_PA_MASTERWRIT_CRAFTINGTYPE1 = "Sealed Blacksmithing Writ",
    SI_PA_MASTERWRIT_CRAFTINGTYPE2 = "Sealed Clothier Writ",
    SI_PA_MASTERWRIT_CRAFTINGTYPE3 = "Sealed Enchanting Writ",
    SI_PA_MASTERWRIT_CRAFTINGTYPE4 = "Sealed Alchemy Writ",
    SI_PA_MASTERWRIT_CRAFTINGTYPE5 = "Sealed Provisioning Writ",
    SI_PA_MASTERWRIT_CRAFTINGTYPE6 = "Sealed Woodworking Writ",
    SI_PA_MASTERWRIT_CRAFTINGTYPE7 = "Sealed Jewelry Crafter Writ",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Do Nothing",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Deposit to Bank",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Withdraw to Backpack",

    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS = "Intricate Items",

    SI_PA_MENU_BANKING_REPAIRKIT = "Repair Kits",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "Select the Mathematical Operator for this item",
    SI_PA_REL_BACKPACK_EQUAL = "BACKPACK ==",
    SI_PA_REL_BACKPACK_LESSTHAN = "BACKPACK <", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANEQUAL = "BACKPACK <=",
    SI_PA_REL_BACKPACK_GREATERTHAN = "BACKPACK >", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANEQUAL = "BACKPACK >=",
    SI_PA_REL_BANK_EQUAL = "BANK ==",
    SI_PA_REL_BANK_LESSTHAN = "BANK <", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL = "BANK <=",
    SI_PA_REL_BANK_GREATERTHAN = "BANK >", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL = "BANK >=",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operator Tooltip --
    SI_PA_REL_BACKPACK_EQUAL_T = "BACKPACK equals (==)",
    SI_PA_REL_BACKPACK_LESSTHAN_T = "BACKPACK less than (<)", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T = "BACKPACK less than or equal to (<=)",
    SI_PA_REL_BACKPACK_GREATERTHAN_T = "BACKPACK greater than (>)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T = "BACKPACK greater than or equal to (>=)",
    SI_PA_REL_BANK_EQUAL_T = "BANK equals (==)",
    SI_PA_REL_BANK_LESSTHAN_T = "BANK less than (<)", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL_T = "BANK less than or equal to (<=)",
    SI_PA_REL_BANK_GREATERTHAN_T = "BANK greater than (>)", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL_T = "BANK greater than or equal to (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Move everything", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Only fill up existing stacks", -- 1: Fill existing stacks

    -- -----------------------------------------------------------------------------------------------------------------
    -- Icon Positions --
    SI_PA_POSITION_AUTO = "Automatic",
    SI_PA_POSITION_TOPLEFT = "Top Left",
    SI_PA_POSITION_TOPRIGHT = "Top Right",
    SI_PA_POSITION_BOTTOMLEFT = "Bottom Left",
    SI_PA_POSITION_BOTTOMRIGHT = "Bottom Right",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB_ADD_RULE = "Add new rule",
    SI_PA_SUBMENU_PAB_EDIT_RULE = "Modify rule",
    SI_PA_SUBMENU_PAB_DELETE_RULE = "Delete rule",
    SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON = "Add",
    SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON = "Save",
    SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON = "Delete",
    SI_PA_SUBMENU_PAB_NO_RULES = "No banking rules defined yet",
    SI_PA_SUBMENU_PAB_DISCLAIMER = "Disclaimer: These custom banking rules will be run after all other Auto Banking rules (Crafting, Special, and AvA Items) have been executed first.",

    SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK = "Mark as permanent junk",
    SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK = "Unmark as permanent junk",
    SI_PA_SUBMENU_PAJ_NO_RULES = "No junk rules defined yet",


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_PROFILES = "|cFFD700P|rersonal|cFFD700A|rssistant Profiles",
    SI_KEYBINDINGS_CATEGORY_PA_MENU = "|cFFD700P|rersonal|cFFD700A|rssistant Menu",

    SI_BINDING_NAME_PA_RULES_MAIN_MENU = "PersonalAssistant Rules",
    SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW = "Toggle Banking/Junk Rules Menu",

    SI_KEYBINDINGS_PA_LOAD_PROFILE = "Activate profile",
}

for key, value in pairs(PAStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Item Qualitiy Levels --
    SI_PA_QUALITY_DISABLED = table.concat({"- ", GetString(SI_CHECK_BUTTON_DISABLED), " -"}),
    SI_PA_QUALITY_TRASH = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_TRASH)),
    SI_PA_QUALITY_NORMAL = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_NORMAL)),
    SI_PA_QUALITY_FINE = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_MAGIC)),
    SI_PA_QUALITY_SUPERIOR = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARCANE)),
    SI_PA_QUALITY_EPIC = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARTIFACT)),
    SI_PA_QUALITY_LEGENDARY = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_LEGENDARY)),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_BLACKSMITHING),
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_CLOTHING),
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WOODWORKING),
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRYCRAFTING),
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALCHEMY),
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ENCHANTING),
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_PROVISIONING),
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_STYLE_MATERIALS),
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_TRAIT_ITEMS),
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_FURNISHING),

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR = "> %s",
    SI_PA_REL_NONE = "-",

    SI_PA_REL_OPERATOR0 = "-",
    SI_PA_REL_OPERATOR1 = "==",
    SI_PA_REL_OPERATOR2 = "<", -- not used so far
    SI_PA_REL_OPERATOR3 = "<=",
    SI_PA_REL_OPERATOR4 = ">", -- not used so far
    SI_PA_REL_OPERATOR5 = ">=",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MAINMENU_RULES_HEADER = "PersonalAssistant",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB = "PA Banking",
    SI_PA_SUBMENU_PAJ = "PA Junk",


    -- =================================================================================================================
    -- == KEYBINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_JUNK = "|cFFD700P|rersonal|cFFD700A|rssistant Junk",
}

for key, value in pairs(PAGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
