local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORS.DEFAULT, "zu deinen Diensten!   -   für deine Sprache [%s] ist leider (noch) keine Lokalisierung verfügbar"}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORS.DEFAULT, "zu deinen Diensten! Aktives Profil: ", PAC.COLOR.ORANGE_RED:Colorize("%s")}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORS.DEFAULT, "heisst dich willkommen! Um loslegen zu können, gehe bitte zu den Einstellungen der Erweiterung (oder verwende ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") und wählen ein Profil aus. Vielen Dank :-)"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant ist eine Sammlung diverser Funktionalitäten mit dem Ziel um deine Zeit in ESO noch angenehmenr zu machen",

    -- -----------------------------------------------------------------------------------------------------------------
    -- General Settings --
    SI_PA_MENU_GENERAL_HEADER = "Generelle Einstellungen",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Wilkommensmeldung anzeigen",
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Zum Haus reisen"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "Wenn das aktuelle Gebiet das Reisen zulässt, wird damit die Transportation zu deinem primären Haus ausgelöst!",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE = "Vor das Haus reisen",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T = "Wenn AUSgeschaltet, reist Du stattdessen in das Innere des Hauses",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Admin Settings --
    SI_PA_MENU_ADMIN_HEADER = "Admin Einstellungen",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
