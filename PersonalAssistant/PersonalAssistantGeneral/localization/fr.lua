local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = table.concat({PAC.COLORS.DEFAULT, "à votre service !   -   La traduction pour le language [%s] n'est pas (encore) disponible"}),
    SI_PA_WELCOME_SUPPORT = table.concat({PAC.COLORS.DEFAULT, "à votre service ! Profil actif: ", PAC.COLOR.ORANGE_RED:Colorize("%s")}),
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({PAC.COLORS.DEFAULT, "vous souhaite la bienvenue ! Pour commencer, veuillez aller dans les réglages d'extensions (ou taper ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") afin de sélectionner un profil. Merci :-)"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant est un ensemble de fonctionnalités diverses qui ont pour but de vous rendre le jeu ESO plus agréable",

    -- -----------------------------------------------------------------------------------------------------------------
    -- General Settings --
    SI_PA_MENU_GENERAL_HEADER = "Paramètres généraux",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Afficher le message d'accueil",
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Aller à la maison"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "Si la position actuelle permet un voyage rapide, cela lancera la téléportation vers votre maison primaire !",
    --SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE = "",
    --SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T = "",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Admin Settings --
    SI_PA_MENU_ADMIN_HEADER = "Paramètres administrateur",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
