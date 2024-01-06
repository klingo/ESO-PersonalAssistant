local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = "¡A su servicio!   -   no tiene soporte para el lenguaje [%s] todavía",
    SI_PA_WELCOME_SUPPORT = "¡A su servicio!",
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({"bienvenido/a! En orden para conseguir comenzar, por favor ir a Configuración de los Complementos y selecciona un perfil. Gracias :-)"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant es una colección de varias características que tiene como objetivo hace la jugabilidad de ESO mas conveniente para ti.\n\nCada módulo tiene su propia lista de perfiles para todas las cuentas donde tú podrás seleccionar por cada personaje cual debería estar activo.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- General Settings --
    SI_PA_MENU_GENERAL_HEADER = "Configuraciones Generales",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Muestra el mensaje de bienvenida",

    SI_PA_MENU_GENERAL_TELEPORT_HEADER = "Hogar",
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Viajar a tu hogar"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "Si la reciente localización permite el viaje rápido, ¡este iniciará el transporte a tu hogar principal!",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE = "Viajar al frente de tu hogar",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T = "Si esta DESACTIVADO, podrás viajar dentro de tu hogar en vez",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Admin Settings --
    SI_PA_MENU_ADMIN_HEADER = "Configuración de Administrador",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end