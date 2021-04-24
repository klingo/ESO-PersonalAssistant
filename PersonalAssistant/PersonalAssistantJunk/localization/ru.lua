local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk может помечать предметы как хлам, если они соответствуют любому из выбираемых условий; кроме случаев, когда предмет был создан или получен по почте",

    -- Standard Items --
    SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER = "Обычные предметы",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = "Включить пометку предметов как хлам",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Применимо только к «Стандартным предметам». Правила из настраиваемого списка хлама не затрагиваются этим переключателем и должны быть деактивированы по отдельности, если они больше не должны выполняться.",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Помечать предметы типа [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Автоматически помечать предметы типа [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] как хлам."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"НЕ помечать [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] как хлам если . . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> он нужен для дейлика ", PAC.COLOR.YELLOW:Colorize("Nibbles and Bits")}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Панцирь]\n[Грязная шкура]\n[Оболочка даэдра]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> он нужен для дейлика ", PAC.COLOR.YELLOW:Colorize("Morsels and Pecks")}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Сущность элементаля]\n[Гибкие корни]\n[Эктоплазма]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Помечать предметы типа [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Автоматически помечать предмет с типом [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] как хлам."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_ITEMS_DESC = table.concat({"Не помечать предмет с пометкой [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] как хлам если . . ."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH = table.concat({"> [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH), "] нужна для ежедневного квеста", PAC.COLOR.YELLOW:Colorize("Пир рыбьего блага")}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH_T = table.concat({PAC.COLOR.YELLOW:Colorize("Временные рамки: "), PAC.COLOR.ORANGE:Colorize("Фестиваль Новой Жизни"), ", который проводится зимой\nЕсли ВКЛЮЧЕНО, любая [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH),"] НЕ БУДЕТ помечена как хлам"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK = table.concat({"Помечать предметы типа [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK_T = table.concat({"Автоматически помечать предмет с типом [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] как хлам"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"НЕ уничтожать и НЕ помечать [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] как хлам если . . ."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("A Matter of Leisure")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Детские игрушки]\n[Куклы]\n[Игры]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("A Matter of Respect")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Аксессуары]\n[Посуда]\n[Кухонные принадлежности]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("A Matter of Tributes")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Заводной город"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Косметика]\n[Товары для ухода]"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS = table.concat({"> оно нужно для дейлика ", PAC.COLOR.YELLOW:Colorize("The Covetous Countess")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Локация: "), PAC.COLOR.ORANGE:Colorize("Thieves Guild"), "\nЕсли включено - следующие предметы не будут помечаться как хлам:\n[Косметика]\n[Галантерея (белье)]\n[Предметы гардероба]\n\n[Питьевая посуда]\n[Посуда]\n[Кухоная утварь]\n[Кухонные принадлежности]\n\n[Игрушки]\n[Куклы]\n[Статуи]\n\n[Рукописи] & [Письменные принадлежности]\n[Карты]\n\n[Ритуальные предметы]\n[Редкости]"}),

    -- Stolen Items --
    SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER = "Украденные вещи",
    SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER = "%s",

    -- Custom Items --
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER = "Настраиваемые предметы",
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Quest Items --
    SI_PA_MENU_JUNK_QUEST_ITEMS_HEADER = "Защита квестовых предметов",
    SI_PA_MENU_JUNK_QUEST_CLOCKWORK_CITY_HEADER = "Заводной город",
    SI_PA_MENU_JUNK_QUEST_THIEVES_GUILD_HEADER = "Гильдия воров",
    SI_PA_MENU_JUNK_QUEST_NEW_LIFE_FESTIVAL_HEADER = "Фестиваль Новой Жизни",

    -- Auto-Sell --
    SI_PA_MENU_JUNK_AUTO_SELL_JUNK_HEADER = "Автоматичесая продажа хлама",

    -- Auto-Destroy --
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_HEADER = "Автоматическое уничтожение хлама",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK = "Включить уничтожение мусора",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T = "При получении предмета, который автоматически будет помечен как мусор, а его стоимость продажи (Торговцу) и качество равно или ниже порогового значения, то при ВКЛЮЧЕНИИ этого параметра он будет уничтожен. Это не может быть отменено!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W = "ВНИМАНИЕ: Обратите внимание, что при использовании этой настройки, никакого сообщения для подтверждения действия не будет!\nПросто будет уничтожен!\nНасовсем!\nИспользуйте на свой страх и риск!",

    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_JUNK_HEADER = "Мусор",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD = "ЕСЛИ стоимость продажи ниже или равна",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD_T = "Автоматически уничтожать предметы только тогда, когда стоимость их продажи торговцу равна или ниже этого значения. После того, как предмет уничтожен, его нельзя вернуть!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD = "И качество ниже или равно",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD_T = "Автоматически уничтожать предметы только тогда, когда их уровень качества равен или ниже этого значения. После того, как предмет уничтожен, его нельзя вернуть!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_EXCLUSION_DISCLAIMER = "Исключение: любые «неизвестные» предметы (рецепты, мотивы, страницы стилей, особенности и т. д.) никогда не будут автоматически уничтожены, даже если они соответствуют критериям стоимости и качества.",

    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_JUNK_HEADER = "Украденный мусор",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK = "Включить уничтожение украденного мусора",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_T = "При краже предмета, который автоматически будет помечен как мусор, а его стоимость продажи (Торговцу краденным) и качество равно или ниже порогового значения, то при ВКЛЮЧЕНИИ этого параметра он будет уничтожен. Это не может быть отменено!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD = "ЕСЛИ стоимость продажи ниже или равна",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD_T = "Автоматически уничтожать предметы только тогда, когда стоимость их продажи торговцу краденным равна или ниже этого значения. После того, как предмет уничтожен, его нельзя вернуть!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD = "И качество ниже или равно",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD_T = "Автоматически уничтожать предметы только тогда, когда их уровень качества равен или ниже этого значения. После того, как предмет уничтожен, его нельзя вернуть!",

    -- Other Settings --
    SI_PA_MENU_JUNK_MAILBOX_IGNORE = "Никогда не помечать полученное по почте как хлам",
    SI_PA_MENU_JUNK_MAILBOX_IGNORE_T = "Предметы полученные по почте никогда не будут помечены как хлам",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE = "Никогда не помечать как хлам созданные предметы",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE_T = "Предмет который вы создали на ремесленной станции не будет помечаться как хлам",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Авто-продажа у торговцев и скупщиков краденного",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI = "Использовать авто-продажу у Пирарри?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI_W = "В отличии от прочих скупщиков, контрабандистка Пирарри взымает 35% налог за свои услуги",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "Сочетания клавиш",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE = "Включить сочетание \"Хлам/Не хлам\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW = "Показывать переключение \"Хлам/Не хлам\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_ENABLE = "Включить сочетание \"В список хлама/Из списка хлама\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_SHOW = "Показывать переключение \"В список хлама/Из списка хлама\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE = "Включить сочетание \"Уничтожить предмет\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W = "ВНИМАНИЕ: Пожалуйста, имейте в виду, что при использовании этого сочетания клавиш НЕТ подтверждения, действительно ли вы хотите уничтожить предмет.\nОн просто будет уничтожен!\nНасовсем!\nИспользуйте на свой страх и риск!",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW = "Показывать переключение \"Уничтожить предмет\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION = "Отключить сочетание \"Уничтожить предмет\" если он . . .",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD = "> по качеству выше или равен",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN = "> может быть изучен/исследован и неизвестен",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "Помечать предметы такого качества и ниже",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "Автоматически помечать как хлам, если предмет указанного качества или ниже",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Помечать предметы с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Автоматически помечать предметы с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (повышенная цена продажи) как хлам."}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Помечать части сетов",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "Если ВЫКЛЮЧЕНО, то только предметы не являющиеся частью сета могут быть помечены как хлам",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE = table.concat({"Помечать экипировку с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T = table.concat({"Если ВЫКЛЮЧЕНО, то экипировка с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] не может быть помечена как хлам (независимо от качества)"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS = "Помечать экипировку с исследованной особенностью",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "Если ВЫКЛЮЧЕНО, то только экипировка без особенности или с неисследованной особенностью может быть помечена как хлам.",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Помечать экипировку с неисследованной особенностью",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "Если ВЫКЛЮЧЕНО, то только экипировка без особенности или с исследованной особенностью может быть помечена как хлам.",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_MAINMENU_JUNK_HEADER = "Правила для хлама",

    SI_PA_MAINMENU_JUNK_HEADER_ITEM = "Предмет",
    SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT = "Количество",
    SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK = "Последний раз",
    SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED = "Добавлено",
    SI_PA_MAINMENU_JUNK_HEADER_ACTIONS = "Действия",

    SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED = "никогда",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Качество"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Продажа"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Сокровище"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Ручное"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Краденое"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT = table.concat({"Отправили %s в хлам (", PAC.COLOR.ORANGE:Colorize("Постоянная пометка"), ")"}),

    SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Уничтожен"), " %d x %s"}),
    SI_PA_CHAT_JUNK_DESTROYED_ALWAYS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Уничтожен"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Постоянная пометка"), ")"}),
    SI_PA_CHAT_JUNK_DESTROYED_CRITERIA_MATCH = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Уничтожен"), " %d x %s (Стоимость продажи: %s)"}),

    SI_PA_CHAT_JUNK_DESTROY_ON = table.concat({"Автоматическое уничтожение мусора было ", PAC.COLOR.RED:Colorize("ВКЛЮЧЕНО")}),
    SI_PA_CHAT_JUNK_DESTROY_OFF = table.concat({"Автоматическое уничтожение мусора было ", PAC.COLOR.GREEN:Colorize("ВЫКЛЮЧЕНО")}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_ON = table.concat({"Автоматическое уничтожение украденного мусора было ", PAC.COLOR.RED:Colorize("ВКЛЮЧЕНО")}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_OFF = table.concat({"Автоматическое уничтожение украденного мусора было ", PAC.COLOR.GREEN:Colorize("ВЫКЛЮЧЕНО")}),

    SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO = "Продано предметов на %s",
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Пожалуйста, подождите ~%d часов"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Пожалуйста, подождите ~%d минут"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({"Невозможно продать %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),
    SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM = "Невозможно продать %s",

    SI_PA_CHAT_JUNK_RULES_ADDED = table.concat({"Предмет %s был ", PAC.COLOR.ORANGE:Colorize("добавлен"), " в настраиваемый список хлама!"}),
    SI_PA_CHAT_JUNK_RULES_DELETED = table.concat({"Предмет %s был ", PAC.COLOR.ORANGE:Colorize("удален"), " из настраиваемого списка хлама!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Addon Keybindings menu --
    SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM = "Переключить Хлам/Не хлам",
    SI_BINDING_NAME_PA_JUNK_PERMANENT_TOGGLE_ITEM = "Переключить В список хлама/Из списка хлама",
    SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM = "Уничтожить предмет",

    -- Actual keybindings --
    SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK = "Добавить в список хлама",
    SI_PA_ITEM_ACTION_UNMARK_AS_PERM_JUNK = "Убрать из списка хлама",


    -- =================================================================================================================
    -- == OTHER STRINGS == --   !!! NEED TO BE AN EXACT MATCH WITH THE "TAG" ON THE ITEM !!!
    -- -----------------------------------------------------------------------------------------------------------------
    -- Quest: "A Matter of Leisure"
    SI_PA_TREASURE_ITEM_TAG_DESC_TOYS = "Детские игрушки",
    SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS = "Куклы",
    SI_PA_TREASURE_ITEM_TAG_DESC_GAMES = "Игры",

    -- Quest: "A Matter of Respect"
    SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS = "Посуда",
    SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE = "Питьевая посуда",
    SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE = "Кухонная утварь",

    -- Quest: "A Matter of Tributes"
    SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS = "Косметика",
    SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING = "Товары для ухода",

    -- Quest: "The Covetous Countess" (only additional tags)
    SI_PA_TREASURE_ITEM_TAG_DESC_LINENS = "Белье",
    SI_PA_TREASURE_ITEM_TAG_DESC_ACCESSORIES = "Аксессуары",
    SI_PA_TREASURE_ITEM_TAG_DESC_STATUES = "Статуи",
    SI_PA_TREASURE_ITEM_TAG_DESC_WRITINGS = "Рукописи",
    SI_PA_TREASURE_ITEM_TAG_DESC_SCRIVENER = "Расписки",
    SI_PA_TREASURE_ITEM_TAG_DESC_MAPS = "Карты",
    SI_PA_TREASURE_ITEM_TAG_DESC_RITUAL_OBJECTS = "Ритуальные предметы",
    SI_PA_TREASURE_ITEM_TAG_DESC_ODDITIES = "Редкости",

    -- OTHERS: Not yet used
    SI_PA_TREASURE_ITEM_TAG_DESC_INSTRUMENTS = "Музыкальные инструмены",
    SI_PA_TREASURE_ITEM_TAG_DESC_ARTWORK = "Предметы искусства",
    SI_PA_TREASURE_ITEM_TAG_DESC_DECOR = "Предметы декора",
    SI_PA_TREASURE_ITEM_TAG_DESC_TRIFLES_ORNAMENTS = "Безделушки и украшения",
    SI_PA_TREASURE_ITEM_TAG_DESC_DEVICES = "Устройства",
    SI_PA_TREASURE_ITEM_TAG_DESC_SMITHING = "Ремесленные инструменты",
    SI_PA_TREASURE_ITEM_TAG_DESC_TOOLS = "Инструменты",
    SI_PA_TREASURE_ITEM_TAG_DESC_MEDICAL_SUPPLIES = "Медикаменты",
    SI_PA_TREASURE_ITEM_TAG_DESC_CURIOSITIES = "Волшебные диковинки",
    SI_PA_TREASURE_ITEM_TAG_DESC_FURNISHINGS = "Предметы обстановки",
    SI_PA_TREASURE_ITEM_TAG_DESC_LIGHTS = "Светильники",


    -- =================================================================================================================
    -- PAJunk Menu --
    -- Fix wrong endings of headers and fix unused collectibles translation
    SI_PA_MENU_JUNK_COLLECTIBLES_HEADER = zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_COLLECTIBLE), 2),
    SI_PA_MENU_JUNK_WEAPONS_HEADER = zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), 1),
    SI_PA_MENU_JUNK_ARMOR_HEADER= zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR),1 ),
    SI_PA_MENU_JUNK_JEWELRY_HEADER = zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), 1),
}

for key, value in pairs(PAJStrings) do
    SafeAddString(_G[key], value, 1)
end
