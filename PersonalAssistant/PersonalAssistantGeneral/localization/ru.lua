local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = "к вашим услугам!  -  [%s] локализация пока не поддерживается",
    SI_PA_WELCOME_SUPPORT = "к вашим услугам!",
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({"приветствую вас! Прежде чем начать, перейдите в меню настроек дополнений и выберите профиль. Спасибо :-)"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant представляет собой набор различных функций, цель которых сделать игру более удобной для вас.\n\nКаждый модуль имеет свой собственный список профилей, общий для вашей учетной записи и вы можете выбрать для каждого персонажа, какой из них должен быть активен.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- General Settings --
    SI_PA_MENU_GENERAL_HEADER = "Основные настройки",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "Показывать приветственное сообщение",

    SI_PA_MENU_GENERAL_TELEPORT_HEADER = "Жилье",
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " домой"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "Если текущее местоположение допускает быстрые перемещения, это инициирует телепорт в ваш основной дом!",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE = "Переместится к дому",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T = "Если этот параметр ВЫКЛЮЧЕН, вы переместитесь внутрь дома",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Admin Settings --
    SI_PA_MENU_ADMIN_HEADER = "Административные настройки",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
