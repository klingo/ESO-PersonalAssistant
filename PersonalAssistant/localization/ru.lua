local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- Language specific texts that need to be translated --

-- Welcome Messages --
SafeAddString(SI_PA_WELCOME_NO_SUPPORT, table.concat({PAC.COLORS.DEFAULT, " к вашим услугам!  -  [%s] локализация пока не поддерживается"}), 1)
SafeAddString(SI_PA_WELCOME_SUPPORT, table.concat({PAC.COLORS.DEFAULT, " к вашим услугам!"}), 1)
SafeAddString(SI_PA_WELCOME_PLEASE_SELECT_PROFILE, table.concat({PAC.COLORS.DEFAULT, " приветствую вас! Прежде чем начать, перейдите в меню настроек дополнений и выберите профиль (или введите ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, "). Спасибо :-)"}), 1)

SafeAddString(SI_PA_LAM_OUTDATED, table.concat({PAC.COLORS.ORANGE_RED, " требуется более свежая версия '", PAC.COLORS.WHITE, "LibAddonMenu-2.0", PAC.COLORS.ORANGE_RED, "' чем в настоящее время установлена. Пожалуйста, скачайте и установите последнюю версию с ", PAC.COLORS.WHITE, "http://esoui.com"}), 1)


-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_GENERAL_DESCRIPTION, "PersonalAssistant представляет собой набор различных функций, цель которых сделать игру более удобной для вас", 1)

-- Profiles --
SafeAddString(SI_PA_MENU_PROFILE_HEADER, "Профили", 1)
SafeAddString(SI_PA_MENU_PROFILE_PLEASE_SELECT, "<Выберите профиль>", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE, "Текущий профиль", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE_T, "Выберите профиль для PersonalAssistant. Он автоматически загрузит все настройки, сохраненные в этом профиле, и все изменения будут сохранены в том же месте.", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE_RENAME, "Переименовать", 1)

-- General --
SafeAddString(SI_PA_MENU_GENERAL_SHOW_WELCOME, "Показывать приветственное сообщение", 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE, table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Домой"}), 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W, "Если текущее местоположение допускает быстрые перемещения, это инициирует телепорт в ваш основной дом!", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Rules Menu --
SafeAddString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB, "Чтобы создать новое правило для ввода и вывода предметов, просто щелкните правой кнопкой мыши на предмете в вашем инвентаре или банке и выберите в контекстном меню:\nPA Banking > Добавить новое правило", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ, "Чтобы создать новое правило для постоянной пометки элемента как хлам, просто щелкните правой кнопкой мыши на предмете в вашем инвентаре или банке и выберите в контекстном меню:\nPA Junk > Пометить как хлам", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU, table.concat({"Вы можете увидеть все активные правила нажав на иконку в главном меню, которое вы можете открыть с помощью клавиши [Alt], через команду ", PAC.COLOR.YELLOW:Colorize("/parules"), " или нажав на эту кнопку:"}), 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_CREATE, "Как создать новое правило?", 1)

SafeAddString(SI_PA_MENU_DANGEROUS_SETTING, "ВНИМАНИЕ: Опасная настройка! Используйте на свой страх и риск!", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Generic Menu --
SafeAddString(SI_PA_MENU_OTHER_SETTINGS_HEADER, "Другие настройки", 1)

SafeAddString(SI_PA_MENU_SILENT_MODE, "Тихий режим (отключить ВСЕ сообщения чата)", 1)

SafeAddString(SI_PA_MENU_NOT_YET_IMPLEMENTED, table.concat({PAC.COLORS.RED, "Еще не реализовано!"}), 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral --
SafeAddString(SI_PA_CHAT_GENERAL_ACTIVE_PROFILE_ACTIVE, table.concat({PAC.COLORS.DEFAULT, " текущий профиль: ", PAC.COLORS.ORANGE_RED, "%s"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral --
SafeAddString(SI_PA_PROFILE, "Профиль", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Name Spaces --
SafeAddString(SI_PA_NS_BAG_EQUIPMENT, "", 1) -- not required so far
SafeAddString(SI_PA_NS_BAG_BACKPACK, "Инвентарь", 1)
SafeAddString(SI_PA_NS_BAG_BANK, "Банк", 1)
SafeAddString(SI_PA_NS_BAG_SUBSCRIBER_BANK, "ESO Plus банк", 1)
SafeAddString(SI_PA_NS_BAG_UNKNOWN, "Неизвестно", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- ItemTypes (Custom Singluar/Plural definition) --
SafeAddString(SI_PA_ITEMTYPE4, "<<1[Еда/Еда]>>", 1) -- ITEMTYPE_FOOD
SafeAddString(SI_PA_ITEMTYPE5, "<<1[Трофей/Трофеи]>>", 1) -- ITEMTYPE_TROPHY
SafeAddString(SI_PA_ITEMTYPE7, "<<1[Зелье/Зелья]>>", 1) -- ITEMTYPE_POTION
SafeAddString(SI_PA_ITEMTYPE8, "<<1[Мотив/Мотивы]>>", 1) -- ITEMTYPE_RACIAL_STYLE_MOTIF
SafeAddString(SI_PA_ITEMTYPE10, "<<1[Ингридиент/Ингредиенты]>>", 1) -- ITEMTYPE_INGREDIENT
SafeAddString(SI_PA_ITEMTYPE12, "<<1[Напиток/Напитки]>>", 1) -- ITEMTYPE_DRINK
SafeAddString(SI_PA_ITEMTYPE16, "<<1[Наживка/Наживка]>>", 1) -- ITEMTYPE_LURE
SafeAddString(SI_PA_ITEMTYPE19, "<<1[Камень душ/Камни душ]>>", 1) -- ITEMTYPE_SOUL_GEM
SafeAddString(SI_PA_ITEMTYPE22, "<<1[Отмычка/Отмычки]>>", 1) -- NOTE: unused
SafeAddString(SI_PA_ITEMTYPE29, "<<1[Рецепт/Рецепты]>>", 1) -- ITEMTYPE_RECIPE
SafeAddString(SI_PA_ITEMTYPE30, "<<1[Яд/Яды]>>", 1) -- ITEMTYPE_POISON
SafeAddString(SI_PA_ITEMTYPE34, "<<1[Коллекционный предмет/Коллекционные предметы]>>", 1) -- ITEMTYPE_COLLECTIBLE
SafeAddString(SI_PA_ITEMTYPE47, "<<1[Ремонтный набор войны альянсов/Ремонтные наборы войны альянсов]>>", 1) -- NOTE: unused
SafeAddString(SI_PA_ITEMTYPE56, "<<1[Сокровище/Сокровища]>>", 1) -- ITEMTYPE_TREASURE
SafeAddString(SI_PA_ITEMTYPE60, "<<1[Мастерский заказ/Мастерские заказы]>>", 1) -- ITEMTYPE_MASTER_WRIT

-- -----------------------------------------------------------------------------------------------------------------
-- Master Writs based on CraftingType (Custom definition) --
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE0, table.concat({"Другие заказы (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}), 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE1, "Запечатанный заказ кузнецу", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE2, "Запечатанный заказ портному", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE3, "Запечатанный заказ зачарователю", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE4, "Запечатанный заказ алхимику", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE5, "Запечатанный заказ снабженцу", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE6, "Запечатанный заказ столяру", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE7, "Запечатанный заказ ювелиру", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_BANKING_MOVE_MODE_DONOTHING, "Ничего не делать", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBANK, "Переместить в банк", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK, "Переместить в инвентарь", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Глифы", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS, "Предметы с особенностью Intricate", 1)

SafeAddString(SI_PA_MENU_BANKING_REPAIRKIT, "Ремонтные наборы", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operators --
SafeAddString(SI_PA_REL_OPERATOR_T, "Выберите математический оператор для этого предмета", 1)
SafeAddString(SI_PA_REL_BACKPACK_EQUAL, "В ИНВЕНТАРЕ ==", 1)
SafeAddString(SI_PA_REL_BACKPACK_LESSTHAN, "В ИНВЕНТАРЕ <", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_LESSTHANEQUAL, "В ИНВЕНТАРЕ <=", 1)
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHAN, "В ИНВЕНТАРЕ >", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHANEQUAL, "В ИНВЕНТАРЕ >=", 1)
SafeAddString(SI_PA_REL_BANK_EQUAL, "В БАНКЕ ==", 1)
SafeAddString(SI_PA_REL_BANK_LESSTHAN, "В БАНКЕ <", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_LESSTHANOREQUAL, "В БАНКЕ <=", 1)
SafeAddString(SI_PA_REL_BANK_GREATERTHAN, "В БАНКЕ >", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_GREATERTHANOREQUAL, "В БАНКЕ >=", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operator Tooltip --
SafeAddString(SI_PA_REL_BACKPACK_EQUAL_T, "В ИНВЕНТАРЕ ровно (==)", 1)
SafeAddString(SI_PA_REL_BACKPACK_LESSTHAN_T, "В ИНВЕНТАРЕ менее (<)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T, "В ИНВЕНТАРЕ менее или равно (<=)", 1)
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHAN_T, "В ИНВЕНТАРЕ более (>)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T, "В ИНВЕНТАРЕ более или равно (>=)", 1)
SafeAddString(SI_PA_REL_BANK_EQUAL_T, "В БАНКЕ ровно (==)", 1)
SafeAddString(SI_PA_REL_BANK_LESSTHAN_T, "В БАНКЕ менее (<)", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_LESSTHANOREQUAL_T, "В БАНКЕ менее или равно (<=)", 1)
SafeAddString(SI_PA_REL_BANK_GREATERTHAN_T, "В БАНКЕ более (>)", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_GREATERTHANOREQUAL_T, "В БАНКЕ более или равно (>=)", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Stacking types --
SafeAddString(SI_PA_ST_MOVE_FULL, "Переместить всё", 1) -- 0: Full deposit
SafeAddString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY, "Заполнить только существующие стеки", 1) -- 1: Fill existing stacks

-- -----------------------------------------------------------------------------------------------------------------
-- Icon Positions --
SafeAddString(SI_PA_POSITION_AUTO, "Автоматически", 1)


-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_ITEM_ACTION_NOTHING, "Ничего не делать", 1)
SafeAddString(SI_PA_ITEM_ACTION_LAUNDER, "Отмывать у скупщика", 1) -- not used so far
SafeAddString(SI_PA_ITEM_ACTION_MARK_AS_JUNK, "Пометить как хлам", 1)
SafeAddString(SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS, "В хлам или уничтожить, если цена 0з", 1)
SafeAddString(SI_PA_ITEM_ACTION_DESTROY_ALWAYS, "Всегда уничтожать", 1)


-- =================================================================================================================
-- == CUSTOM SUB MENU == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_SUBMENU_PAB_ADD_RULE, "Добавить новое правило", 1)
SafeAddString(SI_PA_SUBMENU_PAB_EDIT_RULE, "Изменить правило", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DELETE_RULE, "Удалить правило", 1)
SafeAddString(SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON, "Добавить", 1)
SafeAddString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON, "Сохранить", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON, "Удалить", 1)
SafeAddString(SI_PA_SUBMENU_PAB_NO_RULES, "Не задано правил для банкинга", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DISCLAIMER, "Замечание: эти пользовательские правила будут обработаны после всех автоматических правил (ремесленных предметов, особых предметов и предметов войны альянсов).", 1)

SafeAddString(SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK, "Пометить как хлам", 1)
SafeAddString(SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK, "Убрать пометку как хлам", 1)
SafeAddString(SI_PA_SUBMENU_PAJ_NO_RULES, "Не задано правил для хлама", 1)


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_KEYBINDINGS_CATEGORY_PA_PROFILES, "|cFFD700P|rersonal|cFFD700A|rssistant Профили", 1)
SafeAddString(SI_KEYBINDINGS_CATEGORY_PA_MENU, "|cFFD700P|rersonal|cFFD700A|rssistant Меню", 1)

SafeAddString(SI_BINDING_NAME_PA_RULES_MAIN_MENU, "PersonalAssistant Правила", 1)
SafeAddString(SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW, "Переключить меню правил Банкинга/Хлама", 1)

SafeAddString(SI_KEYBINDINGS_PA_LOAD_PROFILE, "Активировать профиль", 1)

-- =================================================================================================================
-- == CUSTOM SUB MENU == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_SUBMENU_PAB, "|cFFD700PA|r Banking", 1)
SafeAddString(SI_PA_SUBMENU_PAJ, "|cFFD700PA|r Junk", 1)
