local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration позволяет использовать в дополнении PersonalAssistant функциональные возможности прочих дополнений, таких как Dolgubon's Lazy Writ Crafter или FCO ItemSaver",
    SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE = "В настоящее время у вас нет установленных/включенных дополнений, которые поддерживаются PAIntegration",

    -- Character Knowledge --
    SI_PA_MENU_INTEGRATION_CK_CHARACTER = "Считать известным, если известно",
    SI_PA_MENU_INTEGRATION_CK_ENABLE = "Включить Character Knowledge интеграцию",
    SI_PA_MENU_INTEGRATION_CK_ENABLE_T = table.concat({"Использовать Character Knowledge для определения того, что ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " или ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " известен"}),
    SI_PA_MENU_INTEGRATION_CK_INITIALIZING = "Character Knowledge инициализируется ...",

    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Совместимость с Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "Если у вас есть активные мастерские заказы и включено изъятие предметов в «Dolgubon's Lazy Writ Crafter», тогда для этих предметов параметр «Переместить в банк» игнорируется. Это необходимо для того, чтобы избежать немедленного повторного перемещения в банк снятых предметов",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "Не продавать заблокированные предметы",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING = "Не перемещать заблокированные предметы",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING_T = "Если Включено, предметы заблокированные FCO ItemSaver не будут перемешены в банк или из банка",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Продавать предметы отмеченные для продажи",
    SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED = "Перемещать отмеченные предметы при взаимодействии с банком?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "Дополнительные настройки появятся если PABanking будет включен",
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "Дополнительные настройки появятся если PAJunk будет включен",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "Больше возможностей с FCO ItemSaver появятся в будущих версиях",
}

for key, value in pairs(PAIStrings) do
    SafeAddString(_G[key], value, 1)
end
