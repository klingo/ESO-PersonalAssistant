local PAC = PersonalAssistant.Constants
local PALStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot kann dich über Gegenstände von speziellem Interesse wie unbekannte Rezepte, Stile oder Eigenschaften informieren",

    -- PALoot Loot Events --
    SI_PA_MENU_LOOT_EVENTS_HEADER = "Beute einsammeln",
    SI_PA_MENU_LOOT_EVENTS_ENABLE = "Aktiviere Ereignisse beim Beute einsammeln",

    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({"Beim ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2), " einsammeln"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = table.concat({"> ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " unbekannt ist"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = table.concat({"Wann immer ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " eingesammelt wird das von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}),

    -- Loot Motifs & Style Pages
    SI_PA_MENU_LOOT_STYLES_HEADER = "Beim Stile einsammeln",
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = table.concat({"> ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " unbekannt ist"}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = table.concat({"Wann immer ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " eingesammelt wird der von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG = table.concat({"> ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " unbekannt ist"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T = table.concat({"Wann immer ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " eingesammelt wird der von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}),

    -- Loot Equipment (Apparel, Weapons & Jewelries)
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = "Beim Ausrüstungsgegenstände einsammeln",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "> eine Eigenschaft noch nicht analysiert wurde",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = table.concat({"Wann immer eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", oder ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " eingesammelt wird und sie eine Eigenschaft hat welche von diesem Charakter noch nicht analysiert wurde, dann wird eine Information im Chat ausgegeben"}),
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG = "> ein Gegenstand in der Setsammlung fehlt",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG_T = table.concat({"Wann immer eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", oder ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " eingesammelt wird das noch in der Setsammlung fehlt, dann wird eine Information im Chat ausgegeben"}),

    -- Loot Companion Items
    SI_PA_MENU_LOOT_COMPANION_ITEMS_HEADER = table.concat({"Beim ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " einsammeln"}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD = table.concat({"> ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " mind. diese Qualität haben"}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD_T = table.concat({"Wann immer ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " eingesammelt werden, deren Qualität höher oder gleich der ausgewählten Qualität ist, wird eine Information im Chat ausgegeben"}),

    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "Warne wenn Inventarplätze ausgehen",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T = "Zeige eine Warnung im Chat an wenn dir die Inventarplätze ausgehen",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "Schwellenwert für Inventarplätze",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "Wenn die verbleibenden freien Inventarplätze auf oder unter diesen Schwellenwert fallen, wird eine Warnung im Chat ausgegeben",

    -- PALoot Mark Items --
    SI_PA_MENU_LOOT_ICONS_HEADER = "Gegenstands Icons",
    SI_PA_MENU_LOOT_ICONS_ENABLE = "Aktiviere Icons bei Gegenständen",
    SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP = "Zeige Icon Tooltips an",

    -- Mark Recipes --
    SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER = table.concat({"Markiere ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " bereits bekannt ist"}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " noch unbekannt ist"}),

    -- Mark Motifs and Style Page Containers --
    SI_PA_MENU_LOOT_ICONS_STYLES_HEADER = "Markiere Stile",
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " bereits bekannt ist"}),
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " noch unbekannt ist"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " bekannt ist"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " unbekannt ist"}),

    -- Mark Equipment (Apparel, Weapons & Jewelries) --
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER = "Markiere Ausrüstungsgegenstände",
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn die Eigenschaften bereits analysiert ist"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn die Eigenschaften noch unbekannt ist"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SET_UNCOLLECTED = table.concat({">", PAC.ICONS.OTHERS.UNCOLLECTED.NORMAL, "wenn ein Gegenstand in der Setsammlung fehlt"}),

    -- Mark Companion Items --
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_HEADER = table.concat({"Markiere ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_SHOW_ALL = table.concat({">", PAC.ICONS.OTHERS.COMPANION.NORMAL, "wenn es ein Gefährtengegenstand ist"}),

    -- Item Icon Positioning --
    SI_PA_MENU_LOOT_ICONS_POSITIONING_DESCRIPTION = "Nachfolgend kann die Grösse und Position der Gegenstands Icons angepasst werden",
    SI_PA_MENU_LOOT_ICONS_KNOWN_UNKNOWN_HEADER = "Bekannt/Unbekannt",
    SI_PA_MENU_LOOT_ICONS_SET_COLLECTION_HEADER = "Nicht gesammelte Sets",
    SI_PA_MENU_LOOT_ICONS_COMPANION_ITEMS_HEADER = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION),

    SI_PA_MENU_LOOT_ICONS_SIZE_LIST = "Icon Grösse (Listenanzeige)",
    SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T = "Definiere die Grösse des bekannt/unbekannt Icons an Stellen wo Gegenstände in einer Liste angezeigt werden",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID = "Icon Grösse (Gitteranzeige)",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T = "Definiere die Grösse des bekannt/unbekannt Icons an Stellen wo Gegenstände in einem Gitter angezeigt werden",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST = "Icon versetzt X-Achse (Listenanzeige)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T = "Definiert die horizontale Versetzung des bekannt/unbekannt Icons in der Listenanzeige",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST = "Icon versetzt Y-Achse (Listenanzeige)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T = "Definiert die vertikale Versetzung des bekannt/unbekannt Icons in der Listenanzeige",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID = "Icon versetzt X-Achse (Gitteranzeige)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T = "Definiert die horizontale Versetzung des bekannt/unbekannt Icons in der Gitteranzeige.",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID = "Icon versetzt Y-Achse (Gitteranzeige)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T = "Definiert die vertikale Versetzung des bekannt/unbekannt Icons in der Gitteranzeige.",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s kann ", PAC.COLORS.ORANGE,"gelernt", PAC.COLORS.DEFAULT, " werden!"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s kann ", PAC.COLORS.ORANGE,"gelernt", PAC.COLORS.DEFAULT, " werden!"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s hat [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] das analysiert werden kann!"}),
    SI_PA_CHAT_LOOT_SET_UNCOLLECTED = table.concat({PAC.ICONS.OTHERS.UNCOLLECTED.SMALL, "%s fehlt in der Setsammlung!"}),
    SI_PA_CHAT_LOOT_COMPANION_ITEM = table.concat({PAC.ICONS.OTHERS.COMPANION.SMALL, "%s neuer Gefährtengegenstand mit Eigenschaft ", PAC.COLOR.WHITE:Colorize("%s"), "!"}),

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({"%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Inventarplätze mehr/Inventarplatz/Inventarplätze]>> übrig!"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({"%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Reparaturmaterialien mehr/Reparaturmaterial/Reparaturmaterialien]>> übrig!"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({"%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Seelensteine mehr/Seelenstein/Seelensteine]>> übrig!"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_DISPLAY_A_MESSAGE_WHEN = "Zeige eine Meldung wenn . . .",
    SI_PA_MARK_WITH = "Markiere mit . . .",
    SI_PA_ITEM_KNOWN = "Bereits bekannt",
    SI_PA_ITEM_UNKNOWN = "Unbekannt",
    SI_PA_ITEM_UNCOLLECTED = "Nicht gesammelt",
    SI_PA_ITEM_COMPANION_ITEM = "Gefährtengegenstand"
}

for key, value in pairs(PALStrings) do
    SafeAddString(_G[key], value, 1)
end
