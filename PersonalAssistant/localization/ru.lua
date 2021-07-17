local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Profile Settings --
    SI_PA_MENU_PROFILE_PLEASE_SELECT = "<Выберите профиль>",
    SI_PA_MENU_PROFILE_ACTIVE = "Текущий профиль",
    SI_PA_MENU_PROFILE_ACTIVE_T = "Выберите профиль для PersonalAssistant. Он автоматически загрузит все настройки, сохраненные в этом профиле, и все изменения будут сохранены в том же месте.",
    SI_PA_MENU_PROFILE_ACTIVE_RENAME = "Переименовать",

    -- Create Profiles --
    SI_PA_MENU_PROFILE_CREATE_NEW = "Создать новый профиль",
    SI_PA_MENU_PROFILE_CREATE_NEW_DESC = table.concat({"Примечание: У вас может быть максимум ", PAC.GENERAL.MAX_PROFILES, " профилей."}),

    -- Copy Profiles --
    SI_PA_MENU_PROFILE_COPY_FROM_DESC = "Копировать настройки в текущий профиль из другого имеющегося у вас.",
    SI_PA_MENU_PROFILE_COPY_FROM = "Профиль источник",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM = "Копировать",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W = "Все настройки текущего профиля будут заменены на настройки выбранного профиля. Вы уверены что хотите сделать это? \n\nПримечание: Копируются настройки только включенных модулей PersonalAssistant",

    -- Delete Profiles --
    SI_PA_MENU_PROFILE_DELETE_DESC = "Удаляет имеющийся и не используемый профиль из базы для очистки места, также удаляет его данные из файлов сохранений.",
    SI_PA_MENU_PROFILE_DELETE = "Удаляемый профиль",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM = "Удалить",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM_W = "Удалить выбранный профиль для всех персонажей. Вы уверены что хотите сделать это?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Rules Menu --
    SI_PA_MENU_RULES_HOW_TO_ADD_PAB = "Чтобы создать новое правило для ввода и вывода предметов, просто щелкните правой кнопкой мыши на предмете в вашем инвентаре или банке и выберите в контекстном меню:\nPA Banking > Добавить новое правило",
    SI_PA_MENU_RULES_HOW_TO_ADD_PAJ = "Чтобы создать новое правило для постоянной пометки элемента как хлам, просто щелкните правой кнопкой мыши на предмете в вашем инвентаре или банке и выберите в контекстном меню:\nPA Junk > Пометить как хлам",
    SI_PA_MENU_RULES_HOW_TO_FIND_MENU = table.concat({"Вы можете увидеть все активные правила нажав на иконку в главном меню, которое вы можете открыть с помощью клавиши [Alt], через команду ", PAC.COLOR.YELLOW:Colorize("/parules"), " или нажав на эту кнопку:"}),
    SI_PA_MENU_RULES_HOW_TO_CREATE = "Как создать новое правило?",

    SI_PA_MENU_DANGEROUS_SETTING = "ВНИМАНИЕ: Опасная настройка! Используйте на свой страх и риск!",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_OTHER_SETTINGS_HEADER = "Другие настройки",

    SI_PA_MENU_SILENT_MODE = "Тихий режим (отключить ВСЕ сообщения чата)",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "Еще не реализовано!"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED = table.concat({" новый профиль ", PAC.COLOR.WHITE:Colorize("%s"), " создан и активирован!"}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED = table.concat({" настройки профиля ", PAC.COLOR.WHITE:Colorize("%s"), " были ", PAC.COLOR.ORANGE_RED:Colorize("скопированы"), " в профиль ", PAC.COLOR.WHITE:Colorize("%s")}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED = table.concat({" выбранный профиль ", PAC.COLOR.WHITE:Colorize("%s"), " был ", PAC.COLOR.ORANGE_RED:Colorize("удален!")}),

    --SI_PA_CHAT_GENERAL_TELEPORT_NO_PRIMARY_HOUSE = table.concat({}),
    --SI_PA_CHAT_GENERAL_TELEPORT_ZONE_PREVENTED = table.concat({}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "Профиль",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "", -- not required so far
    SI_PA_NS_BAG_BACKPACK = "Инвентарь",
    SI_PA_NS_BAG_BANK = "Банк",
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "ESO Plus банк",
    SI_PA_NS_BAG_VIRTUAL = "Ремесленная сумка",
    SI_PA_NS_BAG_HOUSE_BANK = "Домашнее хранилище",
    SI_PA_NS_BAG_HOUSE_BANK_NR = "Домашнее хранилище (%d)",
    SI_PA_NS_BAG_UNKNOWN = "Неизвестно",

    -- -----------------------------------------------------------------------------------------------------------------
    -- ItemTypes (Custom Singluar/Plural definition) --
    SI_PA_ITEMTYPE4 = "<<1[Еда/Еда]>>", -- ITEMTYPE_FOOD
    SI_PA_ITEMTYPE5 = "<<1[Трофей/Трофеи]>>", -- ITEMTYPE_TROPHY
    SI_PA_ITEMTYPE7 = "<<1[Зелье/Зелья]>>", -- ITEMTYPE_POTION
    SI_PA_ITEMTYPE8 = "<<1[Мотив/Мотивы]>>", -- ITEMTYPE_RACIAL_STYLE_MOTIF
    SI_PA_ITEMTYPE10 = "<<1[Ингридиент/Ингредиенты]>>", -- ITEMTYPE_INGREDIENT
    SI_PA_ITEMTYPE12 = "<<1[Напиток/Напитки]>>", -- ITEMTYPE_DRINK
    SI_PA_ITEMTYPE16 = "<<1[Наживка/Наживка]>>", -- ITEMTYPE_LURE
    SI_PA_ITEMTYPE19 = "<<1[Камень душ/Камни душ]>>", -- ITEMTYPE_SOUL_GEM
    SI_PA_ITEMTYPE22 = "<<1[Отмычка/Отмычки]>>", -- NOTE: unused
    SI_PA_ITEMTYPE29 = "<<1[Рецепт/Рецепты]>>", -- ITEMTYPE_RECIPE
    SI_PA_ITEMTYPE30 = "<<1[Яд/Яды]>>", -- ITEMTYPE_POISON
    SI_PA_ITEMTYPE33 = "<<1[Растворитель/Растворители]>>",
    SI_PA_ITEMTYPE34 = "<<1[Коллекционный предмет/Коллекционные предметы]>>", -- ITEMTYPE_COLLECTIBLE
    SI_PA_ITEMTYPE47 = "<<1[Ремонтный набор войны альянсов/Ремонтные наборы войны альянсов]>>", -- NOTE: unused
    SI_PA_ITEMTYPE56 = "<<1[Сокровище/Сокровища]>>", -- ITEMTYPE_TREASURE
    SI_PA_ITEMTYPE60 = "<<1[Мастерский заказ/Мастерские заказы]>>", -- ITEMTYPE_MASTER_WRIT

    -- -----------------------------------------------------------------------------------------------------------------
    -- SpecializedItemTypes (Custom Singluar/Plural definition) --
    SI_PA_SPECIALIZEDITEMTYPE102 = "<<1[Фрагмент/Фрагменты]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Master Writs based on CraftingType (Custom definition) --
    SI_PA_MASTERWRIT_CRAFTINGTYPE0 = table.concat({"Другие заказы (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}),
    SI_PA_MASTERWRIT_CRAFTINGTYPE1 = "Запечатанный заказ кузнецу",
    SI_PA_MASTERWRIT_CRAFTINGTYPE2 = "Запечатанный заказ портному",
    SI_PA_MASTERWRIT_CRAFTINGTYPE3 = "Запечатанный заказ зачарователю",
    SI_PA_MASTERWRIT_CRAFTINGTYPE4 = "Запечатанный заказ алхимику",
    SI_PA_MASTERWRIT_CRAFTINGTYPE5 = "Запечатанный заказ снабженцу",
    SI_PA_MASTERWRIT_CRAFTINGTYPE6 = "Запечатанный заказ столяру",
    SI_PA_MASTERWRIT_CRAFTINGTYPE7 = "Запечатанный заказ ювелиру",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Ничего не делать",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Переместить в банк",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Переместить в инвентарь",

    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Глифы",
    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS = "Предметы с особенностью Intricate",

    SI_PA_MENU_BANKING_REPAIRKIT = "Ремонтные наборы",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "Выберите математический оператор для этого предмета",
    SI_PA_REL_BACKPACK_EQUAL = "В ИНВЕНТАРЕ ==",
    SI_PA_REL_BACKPACK_LESSTHAN = "В ИНВЕНТАРЕ <", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANEQUAL = "В ИНВЕНТАРЕ <=",
    SI_PA_REL_BACKPACK_GREATERTHAN = "В ИНВЕНТАРЕ >", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANEQUAL = "В ИНВЕНТАРЕ >=",
    SI_PA_REL_BANK_EQUAL = "В БАНКЕ ==",
    SI_PA_REL_BANK_LESSTHAN = "В БАНКЕ <", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL = "В БАНКЕ <=",
    SI_PA_REL_BANK_GREATERTHAN = "В БАНКЕ >", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL = "В БАНКЕ >=",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operator Tooltip --
    SI_PA_REL_BACKPACK_EQUAL_T = "В ИНВЕНТАРЕ ровно (==)",
    SI_PA_REL_BACKPACK_LESSTHAN_T = "В ИНВЕНТАРЕ менее (<)", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T = "В ИНВЕНТАРЕ менее или равно (<=)",
    SI_PA_REL_BACKPACK_GREATERTHAN_T = "В ИНВЕНТАРЕ более (>)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T = "В ИНВЕНТАРЕ более или равно (>=)",
    SI_PA_REL_BANK_EQUAL_T = "В БАНКЕ ровно (==)",
    SI_PA_REL_BANK_LESSTHAN_T = "В БАНКЕ менее (<)", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL_T = "В БАНКЕ менее или равно (<=)",
    SI_PA_REL_BANK_GREATERTHAN_T = "В БАНКЕ более (>)", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL_T = "В БАНКЕ более или равно (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Text Operators --
    SI_PA_REL_TEXT_OPERATOR0 = "-",
    SI_PA_REL_TEXT_OPERATOR1 = "точно",
    SI_PA_REL_TEXT_OPERATOR2 = "менее чем", -- not used so far
    SI_PA_REL_TEXT_OPERATOR3 = "не более чем",
    SI_PA_REL_TEXT_OPERATOR = "более чем",-- not used so far
    SI_PA_REL_TEXT_OPERATOR5 = "не менее чем",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Переместить всё", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Заполнить только существующие стеки", -- 1: Fill existing stacks

    -- -----------------------------------------------------------------------------------------------------------------
    -- Icon Positions --
    SI_PA_POSITION_AUTO = "Автоматически",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_ITEM_ACTION_NOTHING = "Ничего не делать",
    SI_PA_ITEM_ACTION_LAUNDER = "Отмывать у скупщика", -- not used so far
    SI_PA_ITEM_ACTION_MARK_AS_JUNK = "Пометить как хлам",
    SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS = "В хлам или уничтожить, если цена 0з",
    SI_PA_ITEM_ACTION_DESTROY_ALWAYS = "Всегда уничтожать",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB_ADD_RULE = "Добавить новое правило",
    SI_PA_SUBMENU_PAB_EDIT_RULE = "Изменить правило",
    SI_PA_SUBMENU_PAB_DELETE_RULE = "Удалить правило",
    SI_PA_SUBMENU_PAB_ENABLE_RULE = "Включить правило",
    SI_PA_SUBMENU_PAB_DISABLE_RULE = "Выключить правило",
    SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON = "Добавить",
    SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON = "Сохранить",
    SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON = "Удалить",
    SI_PA_SUBMENU_PAB_NO_RULES = "Не задано правил для банкинга",
    SI_PA_SUBMENU_PAB_DISCLAIMER = "Замечание: эти пользовательские правила будут обработаны после всех автоматических правил (ремесленных предметов, особых предметов и предметов войны альянсов).",

    SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK = "Пометить как хлам",
    SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK = "Убрать пометку как хлам",
    SI_PA_SUBMENU_PAJ_NO_RULES = "Не задано фиксированных правил для хлама",


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_PROFILES = "|cFFD700P|rersonal|cFFD700A|rssistant Профили",
    SI_KEYBINDINGS_CATEGORY_PA_MENU = "|cFFD700P|rersonal|cFFD700A|rssistant Меню",

    SI_BINDING_NAME_PA_RULES_MAIN_MENU = "PersonalAssistant Правила",
    SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW = "Переключить меню правил Банкинга/Хлама",
    --SI_BINDING_NAME_PA_TRAVEL_TO_HOUSE = "",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
