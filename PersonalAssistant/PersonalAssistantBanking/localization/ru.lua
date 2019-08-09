local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- Language specific texts that need to be translated --

-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking может перемещать валюты, ремесленные и прочие предметы между банком и инвентарём персонажа", 1)

-- Currencies --
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_HEADER, "Валюты", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_ENABLE, "Включить перемещение валют", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Минимальный остаток у персонажа", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Максимальный остаток у персонажа", 1)


-- Crafting Items --
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_HEADER, "Ремесло", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE, "Включить перемещение ремесленных предметов", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T, "Включить перемещение между инвентарём и банком ремесленных предметов.", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Задать индивидуальные правила (положить, изъять или игнорировать) для ремесленных предметов", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, "У вас есть подписка ESO Plus, внесение/снятие ремесленных предметов не имеет смысла, поскольку они автоматически попадают в бесконечную ремесленную сумку.", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE, "Заменить правила для всех крафтовых предметов", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T, "Заменить правила для всех крафтовых предметов на 'Переместить в банк', 'Переместить в инвентарь' или 'Ничего не делать'", 1)

-- Advanced Items --
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_HEADER, "Особые предметы", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE, "Включить перемещение", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T, "Включить перемещение между инвентарём и банком особых предметов.", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Задать индивидуальные правила (переместить в банк, переместить в инвентарь или ничего не делать) для особых предметов", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE, "Заменить правила для всех особых предметов", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T, "Заменить правила для всех особых предметов на 'Переместить в банк', 'Переместить в инвентарь' или 'Ничего не делать'", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Известные мотивы"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Известные рецепты"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Неизвестные мотивы"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Неизвестные рецепты"}), 1)

-- Individual Items --
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_HEADER, "Настраиваемые предметы", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE, "Включить перемещение", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION, table.concat({"С введением настраиваемых банковских правил, \"Настраиваемые предметы\" были перенесены туда. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}), 1)

-- AvA Items --
SafeAddString(SI_PA_MENU_BANKING_AVA_HEADER, "Война альянсов", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE, "Включить перемещение", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE_T, "Включить перемещение между инвентарём и банком предметов войны альянсов.", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_DESCRIPTION, "Укажите количество различных предметов войны альянсов которые вы хотите оставить в инвентаре", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_OTHER_HEADER, "Прочее", 1)

-- Other Settings --
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING, "Правила объединения при внесении", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T, "Определяет будут ли все выбранные предметы перемещены в банк или только лишь дополнены имеющиеся там стеки", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING, "Правила объединения при изъятии", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T, "Определяет будут ли все выбранные предметы перемещены в инвентарь или только лишь дополнены имеющиеся там стеки", 1)

SafeAddString(SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS, "Складывать все предметы в стеки при открытии банка", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T, "Автоматически складывать все предметы в стеки в банке и инвентаре при открытии банка. Помогает эффективнее использовать место", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, "Перемещать %s", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK, "Оставлять", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T, "Определяет количество (основанное на операторе), которое оставляется в банке или инвентаре", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Минимальное количество в инвентаре у персонажа; если требуется, %s изымаются из банка", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Максимальное количество в инвентаре у персонажа; %s сверх этого количества перемещается в банк", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W, "Не может быть отменено. Все индивидуально заданные значения будут сброшены", 1)


-- =================================================================================================================
-- == MAIN MENU TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER, "Банковские правила", 1)

SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_BAG, "Расположение", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_OPERATOR, "Оператор", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_AMOUNT, "Количество", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ITEM, "Предмет", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ACTIONS, "Действия", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, "%s изъято", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, "%s / %s изъято (Банк пуст)", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, "%s / %s %s изъято (Нет места в инвентаре)", 1)

SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, "%s внесено", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, "%s / %s внесено (Инвентарь пуст)", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, "%s / %s внесено (Нет места в банке)", 1)

SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, "%d x %s перемещено в %s", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, "%d/%d x %s перемещено в %s", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, "Невозможно переместить %s в %s. Нет места!", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, "Невозможно переместить %s в %s. Окно было закрыто!", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC, "Некоторые предметы НЕ БЫЛИ перемещены, чтоб предотвратить потенциальные коллизии с Dolgubon's Lazy Writ Crafter", 1)

SafeAddString(SI_PA_CHAT_BANKING_RULES_ADDED, table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("добавлено"), "!"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_RULES_UPDATED, table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("обновлено"), "!"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_RULES_DELETED, table.concat({"Правило для %s было ", PAC.COLOR.ORANGE:Colorize("удалено"), "!"}), 1)
