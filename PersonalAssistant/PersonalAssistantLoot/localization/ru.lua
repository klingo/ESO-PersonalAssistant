local PAC = PersonalAssistant.Constants

-- =================================================================================================================
-- Language specific texts that need to be translated --

-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_LOOT_DESCRIPTION, "PALoot информирует вас об предметах особого интереса таких как неизвестные рецепты, мотивы или особенности", 1)

-- PALoot Loot Events --
SafeAddString(SI_PA_MENU_LOOT_EVENTS_HEADER, "Добыча", 1)
SafeAddString(SI_PA_MENU_LOOT_EVENTS_ENABLE, "Включить отслеживание добычи", 1)

-- Loot Recipes
SafeAddString(SI_PA_MENU_LOOT_RECIPES_HEADER, table.concat({"Когда добываются ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG, table.concat({"> ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " неизвестен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T, table.concat({"Всякий раз, когда добывается ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " который этот персонаж еще не изучил, в чате отображается сообщение"}), 1)

-- Loot Motifs & Style Pages
SafeAddString(SI_PA_MENU_LOOT_STYLES_HEADER, "Когда добываются стили", 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG, table.concat({"> ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " неизвестен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T, table.concat({"Всякий раз, когда добывается ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " который этот персонаж еще не изучил, в чате отображается сообщение"}), 1)
SafeAddString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG, table.concat({"> ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " неизвестен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T, table.concat({"Всякий раз, когда добывается ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " который этот персонаж еще не изучил, в чате отображается сообщение"}), 1)

-- Loot Equipment (Apparel, Weapons & Jewelries)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER, "Когда добывается экипировка", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG, "> Особенность еще не исследована", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T, table.concat({"Всякий раз, когда добывается ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", a ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", or ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " с особенностью которую этот персонаж еще не исследовал, в чате отображается сообщение"}), 1)

SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING, "Предупреждать, когда мало места в инвентаре", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T, "Отображать предупреждение в окне чата, если у вас мало места в инвентаре", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD, "Порог свободного места", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T, "Если оставшееся свободное место в инвентаре находится на этом пороге или ниже, в окне чата отображается сообщение", 1)

-- PALoot Mark Items --
SafeAddString(SI_PA_MENU_LOOT_ICONS_HEADER, "Пометка предметов", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ENABLE, "Включить дополнительные метки", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP, "Показывать подсказки у меток", 1)

-- Mark Recipes --
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER, table.concat({"Отмечать ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " уже известен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " еще неизвестен"}), 1)

-- Mark Motifs and Style Page Containers --
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLES_HEADER, "Пометка стилей", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " уже известен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " еще неизвестен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " уже известен"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " еще неизвестен"}), 1)

-- Mark Equipment (Apparel, Weapons & Jewelries) --
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER, "Пометка экипировки", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если Особенность уже изучена"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если Особенность еще не изучена"}), 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST, "Размер иконки (В виде списка)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T, "Задает размер значка известен/неизвестен там, где предметы отображаются в виде списка", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID, "Размер иконки (В виде сетки)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T, "Задает размер значка известен/неизвестен там, где предметы отображаются аддоном в виде сетки [InventoryGridView]", 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION_GRID, "Положение иконки (В виде сетки)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION_GRID_T, "Задает положение значка известен/неизвестен.\nPALoot «автоматически» определяет, включены ли дополнения [Research Assistant] или [ESO Master Recipe List], и помещает значок в еще не занятый угол", 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST, "Смещение иконки по X (В виде списка)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T, "Задает горизонтальное смещение значка известен/неизвестен там, где предметы отображаются в виде списка", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST, "Смещение иконки по Y (В виде списка)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T, "Задает вертикальное смещение значка известен/неизвестен там, где предметы отображаются в виде списка", 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID, "Смещение иконки по X (В виде сетки)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T, "Задает горизонтальное смещение значка известен/неизвестен там, где предметы отображаются аддоном в виде сетки [InventoryGridView]\n\nИграет роль только если для позиции иконки выбран ручной режим", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID, "Смещение иконки по Y (В виде сетки)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T, "Задает вертикальное смещение значка известен/неизвестен там, где предметы отображаются аддоном в виде сетки [InventoryGridView]\n\nИграет роль только если для позиции иконки выбран ручной режим", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_CHAT_LOOT_RECIPE_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s может быть ", PAC.COLORS.ORANGE,"изучен", PAC.COLORS.DEFAULT, "!"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_MOTIF_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s может быть ", PAC.COLORS.ORANGE,"изучен", PAC.COLORS.DEFAULT, "!"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_TRAIT_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s с особенностью [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] можно исследовать!"}), 1)

SafeAddString(SI_PA_PATTERN_INVENTORY_COUNT, table.concat({"%sУ вас <<1[", PAC.COLORS.WHITE,"нет/осталось ", PAC.COLORS.WHITE, "%d/осталось ", PAC.COLORS.WHITE, "%d]>> %s<<1[свободных мест/свободное место/свободных мест]>>!"}), 1)
SafeAddString(SI_PA_PATTERN_REPAIRKIT_COUNT, table.concat({"%sУ вас <<1[", PAC.COLORS.WHITE,"нет/остался ", PAC.COLORS.WHITE, "%d/осталось ", PAC.COLORS.WHITE, "%d]>> %s<<1[Ремонтных наборов/Ремонтный набор/Ремонтных наборов]>> left!"}), 1)
SafeAddString(SI_PA_PATTERN_SOULGEM_COUNT, table.concat({"%sУ вас <<1[", PAC.COLORS.WHITE,"нет/остался ", PAC.COLORS.WHITE, "%d/осталось ", PAC.COLORS.WHITE, "%d]>> %s<<1[Камней душ/Камень душ/Камней душ]>> left!"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_DISPLAY_A_MESSAGE_WHEN, "Вывести сообщение, если . . .", 1)
SafeAddString(SI_PA_MARK_WITH, "Помечать . . .", 1)
SafeAddString(SI_PA_ITEM_KNOWN, "Известен", 1)
SafeAddString(SI_PA_ITEM_UNKNOWN, "Неизвестен", 1)
