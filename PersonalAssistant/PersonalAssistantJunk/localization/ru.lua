local PAC = PersonalAssistant.Constants

-- =================================================================================================================
-- Language specific texts that need to be translated --

-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk может помечать предметы как хлам, если они соответствуют любому из выбираемых условий; кроме случаев, когда предмет был создан или получен по почте", 1)

-- Standard Items --
SafeAddString(SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER, "Обычные предметы", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, "Включить пометку предметов как хлам", 1)

SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK, table.concat({"Помечать предметы типа [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T, table.concat({"Автоматически помечать предметы типа [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] как хлам."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC, table.concat({"НЕ помечать [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] как хлам если . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS, table.concat({"> он нужен для дейлика ", PAC.COLOR.YELLOW:Colorize("Nibbles and Bits")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Панцирь]\n[Грязная шкура]\n[Оболочка даэдра]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS, table.concat({"> он нужен для дейлика ", PAC.COLOR.YELLOW:Colorize("Morsels and Pecks")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Сущность элементаля]\n[Гибкие корни]\n[Эктоплазма]"}), 1)


SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK, table.concat({"Помечать предметы типа [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T, table.concat({"Автоматически помечать предмет с типом [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] как хлам."}), 1)

-- Stolen Items --
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER, "Украденные вещи", 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER, "%s", 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_ITEMS_DESC, table.concat({"НЕ уничтожать и НЕ помечать [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] как хлам если . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE, table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("A Matter of Leisure")}), 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T, table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Детские игрушки]\n[Куклы]\n[Игры]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT, table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("A Matter of Respect")}), 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T, table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Аксессуар]\n[Посуда]\n[Кухонные принадлежности]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES, table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("A Matter of Tributes")}), 1)
SafeAddString(SI_PA_MENU_JUNK_ACTION_STOLEN_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T, table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Косметика]\n[Товары для ухода]"}), 1)

-- Custom Items --
SafeAddString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER, "Настраиваемые предметы", 1)
SafeAddString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION, table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}), 1)

-- Auto-Destroy --
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTORY_JUNK_HEADER, "Автоматически уничтожать мусор", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK, "Включить уничтожение ненужных предметов", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T, "При добыче бесполезного предмета (стоимость продажи - 0з) при включенном данном параметре - предмет будет уничтожен. Это не может быть отменено!", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W, "ВНИМАНИЕ: Обратите внимание, что при использовании этой настройки, никакого сообщения для подтверждения действия не будет!\nПросто будет уничтожен!\nНасовсем!\nИспользуйте на свой страх и риск!", 1)

-- Other Settings --
SafeAddString(SI_PA_MENU_JUNK_AUTOSELL_JUNK, "Продажа хлама у торговцев и скупщиков краденного", 1)

SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_HEADER, "Сочетания клавиш", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE, "Включить сочетание \"Хлам/Не хлам\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW, "Показывать переключение \"Хлам/Не хлам\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE, "Включить сочетание \"Уничтожить предмет\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W, "ВНИМАНИЕ: Пожалуйста, имейте в виду, что при использовании этого сочетания клавиш НЕТ подтверждения, действительно ли вы хотите уничтожить предмет.\nОн просто будет уничтожен!\nНасовсем!\nИспользуйте на свой страх и риск!", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW, "Показывать переключение \"Уничтожить предмет\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION, "Отключить сочетание \"Уничтожить предмет\" если он . . .", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD, "> по качеству выше или равен", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN, "> может быть изучен/исследован и неизвестен", 1)

-- General texts used across: Weapons, Armor, Jewelry
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, "Помечать экипировку такого качества и ниже", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, "Автоматически помечать как хлам, если экипировка указанного качества или ниже", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, table.concat({"Помечать экипировку с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, table.concat({"Автоматически помечать экипировку с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (повышенная цена продажи) как хлам."}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, "Помечать части сетов", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, "Если ВЫКЛЮЧЕНО, то только предметы не являющиеся частью сета могут быть помечены как хлам", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE, table.concat({"Помечать экипировку с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T, table.concat({"Если ВЫКЛЮЧЕНО, то экипировка с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] не может быть помечена как хлам (независимо от качества)"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, "Помечать экипировку с неисследованной особенностью", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, "Если ВЫКЛЮЧЕНО, то только экипировка без особенности или с исследованной особенностью может быть помечена как хлам.", 1)


-- =================================================================================================================
-- == MAIN MENU TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER, "Правила для хлама", 1)

SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_ITEM, "Предмет", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT, "Количество", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK, "Последний раз", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED, "Добавлено", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_ACTIONS, "Действия", 1)

SafeAddString(SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED, "никогда", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Качество"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Продажа"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Сокровище"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Ручное"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Краденое"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT, table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Постоянная пометка"), ")"}), 1)

SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Уничтожен"), " %d x %s"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_ALWAYS, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Уничтожен"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Постоянная пометка"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Уничтожен"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Мусор"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_ON, table.concat({"Автоматическое уничтожение мусора было ", PAC.COLOR.RED:Colorize("ВКЛЮЧЕНО")}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_OFF, table.concat({"Автоматическое уничтожение мусора было ", PAC.COLOR.GREEN:Colorize("ВЫКЛЮЧЕНО")}), 1)

SafeAddString(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, "Продано предметов на %s", 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Пожалуйста, подождите ~%d часов"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Пожалуйста, подождите ~%d минут"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, table.concat({"Невозможно продать %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}), 1)
SafeAddString(SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM, "Невозможно продать %s", 1)

SafeAddString(SI_PA_CHAT_JUNK_RULES_ADDED, table.concat({"Предмет %s был ", PAC.COLOR.ORANGE:Colorize("добавлен"), " в настраиваемый список хлама!"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_RULES_DELETED, table.concat({"Предмет %s был ", PAC.COLOR.ORANGE:Colorize("удален"), " из настраиваемого списка хлама!"}), 1)

-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM, "Пометка Хлам/Не хлам", 1)
SafeAddString(SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM, "Уничтожить предмет", 1)


-- =================================================================================================================
-- == OTHER STRINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- Quest: "A Matter of Leisure"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_TOYS, "Детские игрушки", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS, "Куклы", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_GAMES, "Игры", 1)

-- Quest: "A Matter of Respect"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS, "Посуда", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE, "Питьевая посуда", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE, "Кухонная утварь", 1)

-- Quest: "A Matter of Tributes"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS, "Косметика", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING, "Товары для ухода", 1)


-- =================================================================================================================
-- PAJunk Menu --
-- Fix wrong endings of headers and fix unused collectibles translation
SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_HEADER, zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_COLLECTIBLE), 2), 1)
SafeAddString(SI_PA_MENU_JUNK_WEAPONS_HEADER, zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), 1), 1)
SafeAddString(SI_PA_MENU_JUNK_ARMOR_HEADER, zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR),1 ), 1)
SafeAddString(SI_PA_MENU_JUNK_JEWELRY_HEADER, zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), 1), 1)
