local PAC = PersonalAssistant.Constants
local PALStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot информирует вас об предметах особого интереса таких как неизвестные рецепты, мотивы или особенности",

    -- PALoot Loot Events --
    SI_PA_MENU_LOOT_EVENTS_HEADER = "Добыча",
    SI_PA_MENU_LOOT_EVENTS_ENABLE = "Включить отслеживание добычи",

    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({"Когда добываются ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = table.concat({"> ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " неизвестен"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = table.concat({"Всякий раз, когда добывается ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " который этот персонаж еще не изучил, в чате отображается сообщение"}),

    -- Loot Motifs & Style Pages
    SI_PA_MENU_LOOT_STYLES_HEADER = "Когда добываются стили",
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = table.concat({"> ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " неизвестен"}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = table.concat({"Всякий раз, когда добывается ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " который этот персонаж еще не изучил, в чате отображается сообщение"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG = table.concat({"> ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " неизвестен"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T = table.concat({"Всякий раз, когда добывается ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " который этот персонаж еще не изучил, в чате отображается сообщение"}),

    -- Loot Equipment (Apparel, Weapons & Jewelries)
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = "Когда добывается экипировка",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "> Особенность еще не исследована",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = table.concat({"Всякий раз, когда добывается ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", a ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", or ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " с особенностью которую этот персонаж еще не исследовал, в чате отображается сообщение"}),

    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "Предупреждать, когда мало места в инвентаре",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T = "Отображать предупреждение в окне чата, если у вас мало места в инвентаре",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "Порог свободного места",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "Если оставшееся свободное место в инвентаре находится на этом пороге или ниже, в окне чата отображается сообщение",

    -- PALoot Mark Items --
    SI_PA_MENU_LOOT_ICONS_HEADER = "Пометка предметов",
    SI_PA_MENU_LOOT_ICONS_ENABLE = "Включить дополнительные метки",
    SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP = "Показывать подсказки у меток",

    -- Mark Recipes --
    SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER = table.concat({"Отмечать ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " уже известен"}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " еще неизвестен"}),

    -- Mark Motifs and Style Page Containers --
    SI_PA_MENU_LOOT_ICONS_STYLES_HEADER = "Пометка стилей",
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " уже известен"}),
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " еще неизвестен"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " уже известен"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " еще неизвестен"}),

    -- Mark Equipment (Apparel, Weapons & Jewelries) --
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER = "Пометка экипировки",
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "если Особенность уже изучена"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "если Особенность еще не изучена"}),

    SI_PA_MENU_LOOT_ICONS_SIZE_LIST = "Размер иконки (В виде списка)",
    SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T = "Задает размер значка известен/неизвестен там, где предметы отображаются в виде списка",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID = "Размер иконки (В виде сетки)",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T = "Задает размер значка известен/неизвестен там, где предметы отображаются аддоном в виде сетки [InventoryGridView]",

    SI_PA_MENU_LOOT_ICONS_POSITION_GRID = "Положение иконки (В виде сетки)",
    SI_PA_MENU_LOOT_ICONS_POSITION_GRID_T = "Задает положение значка известен/неизвестен.\nPALoot «автоматически» определяет, включены ли дополнения [Research Assistant] или [ESO Master Recipe List], и помещает значок в еще не занятый угол",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST = "Смещение иконки по X (В виде списка)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T = "Задает горизонтальное смещение значка известен/неизвестен там, где предметы отображаются в виде списка",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST = "Смещение иконки по Y (В виде списка)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T = "Задает вертикальное смещение значка известен/неизвестен там, где предметы отображаются в виде списка",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID = "Смещение иконки по X (В виде сетки)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T = "Задает горизонтальное смещение значка известен/неизвестен там, где предметы отображаются аддоном в виде сетки [InventoryGridView]\n\nИграет роль только если для позиции иконки выбран ручной режим",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID = "Смещение иконки по Y (В виде сетки)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T = "Задает вертикальное смещение значка известен/неизвестен там, где предметы отображаются аддоном в виде сетки [InventoryGridView]\n\nИграет роль только если для позиции иконки выбран ручной режим",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s может быть ", PAC.COLORS.ORANGE,"изучен", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s может быть ", PAC.COLORS.ORANGE,"изучен", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s с особенностью [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] можно исследовать!"}),

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({"%sУ вас <<1[", PAC.COLORS.WHITE,"нет/осталось ", PAC.COLORS.WHITE, "%d/осталось ", PAC.COLORS.WHITE, "%d]>> %s<<1[свободных мест/свободное место/свободных мест]>>!"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({"%sУ вас <<1[", PAC.COLORS.WHITE,"нет/остался ", PAC.COLORS.WHITE, "%d/осталось ", PAC.COLORS.WHITE, "%d]>> %s<<1[Ремонтных наборов/Ремонтный набор/Ремонтных наборов]>> left!"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({"%sУ вас <<1[", PAC.COLORS.WHITE,"нет/остался ", PAC.COLORS.WHITE, "%d/осталось ", PAC.COLORS.WHITE, "%d]>> %s<<1[Камней душ/Камень душ/Камней душ]>> left!"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_DISPLAY_A_MESSAGE_WHEN = "Вывести сообщение, если . . .",
    SI_PA_MARK_WITH = "Помечать . . .",
    SI_PA_ITEM_KNOWN = "Известен",
    SI_PA_ITEM_UNKNOWN = "Неизвестен",
}

for key, value in pairs(PALStrings) do
    SafeAddString(_G[key], value, 1)
end
