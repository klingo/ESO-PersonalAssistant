local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORS.DEFAULT, "at your service!   -   no localization for language [%s] available (yet)"}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORS.DEFAULT, "at your service! Active profile: ", PAC.COLOR.ORANGE_RED:Colorize("%s")}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORS.DEFAULT, "welcomes you! In order to get started, please go to the Addon Settings (or type ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") and select a profile. Thank you :-)"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant is a collection of various features that have the goal to make playing ESO more convenient for you",

    -- -----------------------------------------------------------------------------------------------------------------
    -- General Settings --
    SI_PA_MENU_GENERAL_HEADER = "General Settings",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Show welcome message",
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Travel to house"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "If current location permits fast travel, this will initiate the teleport to your primary house!",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE = "Travel in front of the house",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T = "If turned OFF, you will travel to the inside of the house instead",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Admin Settings --
    SI_PA_MENU_ADMIN_HEADER = "Admin Settings",
}

for key, value in pairs(PAStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end