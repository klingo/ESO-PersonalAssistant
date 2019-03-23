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
    -- Generic Menu --
    -- TODO: make this specific per addon
    SI_PA_MENU_SILENT_MODE = "Silent Mode (Disable ALL chat messages)",
    SI_PA_MENU_SILENT_MODE_T = "If Silent Mode is enabled, no messages from this Addon will be displayed in the chat anymore",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "Not yet implemented!"}),


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
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Do Nothing",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Deposit to Bank",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Withdraw to Backpack",

    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT = "Repair Kits",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "Select the Mathematical Operator for this item",
    SI_PA_REL_EQUAL = "equals (=)",
    SI_PA_REL_LESSTHAN = "less than (<)", -- not required so far
    SI_PA_REL_LESSTHANEQUAL = "less than or equal to (<=)",
    SI_PA_REL_GREATERTHAN = "greater than (>)", -- not required so far
    SI_PA_REL_GREATERTHANEQUAL = "greater than or equal to (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
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

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- MainMenu --
    SI_PA_MENU_TITLE = PAC.COLORED_TEXTS.PA,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral Menu --
    SI_PA_MENU_GENERAL_HEADER = PAC.COLORED_TEXTS.PAG,


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Item Qualitiy Levels --
    SI_PA_QUALITY_TRASH = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_TRASH)),
    SI_PA_QUALITY_NORMAL = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_NORMAL)),
    SI_PA_QUALITY_FINE = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_MAGIC)),
    SI_PA_QUALITY_SUPERIOR = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARCANE)),
    SI_PA_QUALITY_EPIC = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARTIFACT)),
    SI_PA_QUALITY_LEGENDARY = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_LEGENDARY)),

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR = "> %s",
    SI_PA_REL_NONE = "-",
}

for key, value in pairs(PAGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
