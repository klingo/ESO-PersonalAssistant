local PAC = PersonalAssistant.Constants
local PABStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking может перемещать валюты, ремесленные и прочие предметы между банком и инвентарём персонажа",

    -- Currencies --
    SI_PA_MENU_BANKING_CURRENCY_HEADER = "Валюты",
    SI_PA_MENU_BANKING_CURRENCY_ENABLE = "Включить перемещение валют",
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Минимальный остаток у персонажа",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Максимальный остаток у персонажа",

    -- Crafting Items --
    SI_PA_MENU_BANKING_CRAFTING_HEADER = "Ремесло",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE = "Включить перемещение ремесленных предметов",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "Включить перемещение между инвентарём и банком ремесленных предметов.",
    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "Задать индивидуальные правила (положить, изъять или игнорировать) для ремесленных предметов",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = "У вас есть подписка ESO Plus, внесение/снятие ремесленных предметов не имеет смысла, поскольку они автоматически попадают в бесконечную ремесленную сумку.",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE = "Заменить правила для всех крафтовых предметов",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T = "Заменить правила для всех крафтовых предметов на 'Переместить в банк', 'Переместить в инвентарь' или 'Ничего не делать'",

    -- Advanced Items --
    SI_PA_MENU_BANKING_ADVANCED_HEADER = "Особые предметы",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE = "Включить перемещение",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "Включить перемещение между инвентарём и банком особых предметов.",
    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "Задать индивидуальные правила (переместить в банк, переместить в инвентарь или ничего не делать) для особых предметов",

    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE = "Заменить правила для всех особых предметов",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T = "Заменить правила для всех особых предметов на 'Переместить в банк', 'Переместить в инвентарь' или 'Ничего не делать'",

    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Известные мотивы"}),
    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Известные рецепты"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Неизвестные мотивы"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Неизвестные рецепты"}),

    -- Individual Items --
    SI_PA_MENU_BANKING_INDIVIDUAL_HEADER = "Настраиваемые предметы",
    SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION = table.concat({"С введением настраиваемых банковских правил, \"Настраиваемые предметы\" были перенесены туда. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- AvA Items --
    SI_PA_MENU_BANKING_AVA_HEADER = "Война альянсов",
    SI_PA_MENU_BANKING_AVA_ENABLE = "Включить перемещение",
    SI_PA_MENU_BANKING_AVA_ENABLE_T = "Включить перемещение между инвентарём и банком предметов войны альянсов.",
    SI_PA_MENU_BANKING_AVA_DESCRIPTION = "Укажите количество различных предметов войны альянсов которые вы хотите оставить в инвентаре",
    SI_PA_MENU_BANKING_AVA_OTHER_HEADER = "Прочее",

    -- Other Settings --
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION = "Автоматически запускать PABanking",
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION_T = "Автоматически запускать перемещение предиметов в банк или из банка при взаимодействии с банкиром? Если выключено вы все еще можете запустить перемещение в интерфейсе банка",

    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING = "Правила объединения при внесении",
    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T = "Определяет будут ли все выбранные предметы перемещены в банк или только лишь дополнены имеющиеся там стеки",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING = "Правила объединения при изъятии",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T = "Определяет будут ли все выбранные предметы перемещены в инвентарь или только лишь дополнены имеющиеся там стеки",

    SI_PA_MENU_BANKING_EXCLUDE_JUNK = "Не перемещать предметы помеченные как хлам",

    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS = "Складывать все предметы в стеки при открытии банка",
    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T = "Автоматически складывать все предметы в стеки в банке и инвентаре при открытии банка. Помогает эффективнее использовать место",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE = "Перемещать %s",

    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK = "Оставлять",
    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T = "Определяет количество (основанное на операторе), которое оставляется в банке или инвентаре",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "Минимальное количество в инвентаре у персонажа; если требуется, %s изымаются из банка",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "Максимальное количество в инвентаре у персонажа; %s сверх этого количества перемещается в банк",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "Не может быть отменено. Все индивидуально заданные значения будут сброшены",

    -- Correct wrong language forms
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_TREASURE_MAPS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ": Карты сокровищ"}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_SURVEY_REPORTS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ": Отчеты об исследовании"}),

    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MAINMENU_BANKING_HEADER = "Банковские правила",

    SI_PA_MAINMENU_BANKING_HEADER_CATEGORY = "K", -- First letter of "Category"
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "Расположение",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "Правило",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "Количество",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "Предмет",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "Действия",


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Add Custom Rule Description --
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_PRE = "%s должен содержать ровно %d выбранного предмета.",
    SI_PA_DIALOG_BANKING_BANK_LESSTHANOREQUAL_PRE = "%s должен содержать не более (максимум) %d выбранного предмета.",
    SI_PA_DIALOG_BANKING_BANK_GREATERTHANOREQUAL_PRE = "%s должен содержать не менее (минимум) %d выбранного предмета.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_NOTHING = "> %d в %s => ничего не делать.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_DEPOSIT = "> %d в %s => перемещать предметы в %s пока их не станет там %d.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_NOTHING = "> %d - %d в %s => ничего не делать.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_DEPOSIT = "> %d - %d в %s => перемещать предметы в %s пока их не станет там %d.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_WITHDRAW = "> %d - %d в %s => перемещать предметы из %s пока там их не останется %d.",

    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_PRE = "%s должен содержать ровно %d выбранного предмета.",
    SI_PA_DIALOG_BANKING_BACKPACK_LESSTHANOREQUAL_PRE = "%s должен содержать не более (максимум) %d выбранного предмета.",
    SI_PA_DIALOG_BANKING_BACKPACK_GREATERTHANOREQUAL_PRE = "%s должен содержать не менее (минимум) %d выбранного предмета.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_NOTHING = "> %d в %s => ничего не делать.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_DEPOSIT = "> %d в %s => перемещать предметы в %s пока их не станет там %d.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_NOTHING = "> %d - %d в %s => ничего не делать.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_DEPOSIT = "> %d - %d в %s => перемещать предметы в %s пока их не станет там %d.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_WITHDRAW = "> %d - %d в %s => перемещать предметы из %s пока там их не останется %d.",

    SI_PA_DIALOG_BANKING_EXPLANATION = "Это значит, если есть . . .",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_FINISHED = "Все предметы перенесены",

    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = "%s изъято",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = "%s / %s изъято (Банк пуст)",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = "%s / %s %s изъято (Нет места в инвентаре)",

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = "%s внесено",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = "%s / %s внесено (Инвентарь пуст)",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = "%s / %s внесено (Нет места в банке)",

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = "%d x %s перемещено в %s",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "Невозможно переместить %s в %s. Нет места!",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "Невозможно переместить %s в %s. Окно было закрыто!",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "Некоторые предметы НЕ БЫЛИ перемещены, чтоб предотвратить потенциальные коллизии с Dolgubon's Lazy Writ Crafter",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("добавлено"), "!"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("обновлено"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("удалено"), "!"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("включено"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("выключено"), "!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS = "Запустить PABanking",
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS_PENDING = "PABanking выполняется...",
}

for key, value in pairs(PABStrings) do
    SafeAddString(_G[key], value, 1)
end
