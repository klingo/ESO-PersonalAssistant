local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_LOOT_DESCRIPTION, "PALoot kann dich über Gegenstände von speziellem Interesse wie unbekannte Rezepte, Stile oder Eigenschaften informieren", 1)

-- PALoot Loot Events --
SafeAddString(SI_PA_MENU_LOOT_EVENTS_HEADER, "Beute einsammeln", 1)
SafeAddString(SI_PA_MENU_LOOT_EVENTS_ENABLE, "Aktiviere Ereignisse beim Beute einsammeln", 1)

-- Loot Recipes
SafeAddString(SI_PA_MENU_LOOT_RECIPES_HEADER, table.concat({"Beim ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2), " einsammeln"}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG, table.concat({"> ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " unbekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T, table.concat({"Wann immer ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " eingesammelt wird das von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}), 1)

-- Loot Motifs & Style Pages
SafeAddString(SI_PA_MENU_LOOT_STYLES_HEADER, "Beim Stile einsammeln", 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG, table.concat({"> ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " unbekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T, table.concat({"Wann immer ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " eingesammelt wird der von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}), 1)
SafeAddString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG, table.concat({"> ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " unbekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T, table.concat({"Wann immer ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " eingesammelt wird der von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}), 1)

-- Loot Equipment (Apparel, Weapons & Jewelries)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER, "Beim Ausrüstungsgegenstände einsammeln", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG, "> eine Eigenschaft noch nicht analysiert wurde", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T, table.concat({"Wann immer eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", oder ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " eingesammelt wird und sie eine Eigenschaft hat welche von diesem Charakter noch nicht analysiert wurde, dann wird eine Information im Chat ausgegeben"}), 1)

SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING, "Warne wenn Inventarplätze ausgehen", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T, "Zeige eine Warnung im Chat an wenn dir die Inventarplätze ausgehen", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD, "Schwellenwert für Inventarplätze", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T, "Wenn die verbleibenden freien Inventarplätze auf oder unter diesen Schwellenwert fallen, wird eine Warnung im Chat ausgegeben", 1)

-- PALoot Mark Items --
SafeAddString(SI_PA_MENU_LOOT_ICONS_HEADER, "Gegenstands Icons", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ENABLE, "Aktiviere Icons bei Gegenständen", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP, "Zeige Icons Tooltips an", 1)

-- Mark Recipes --
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER, table.concat({"Markiere ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " bereits bekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " noch unbekannt ist"}), 1)

-- Mark Motifs and Style Page Containers --
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLES_HEADER, "Markiere Stile", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " bereits bekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " noch unbekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " bekannt ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn ein ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " unbekannt ist"}), 1)

-- Mark Equipment (Apparel, Weapons & Jewelries) --
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER, "Markiere Ausrüstungsgegenstände", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "wenn die Eigenschaften bereits analysiert ist"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "wenn die Eigenschaften noch unbekannt ist"}), 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST, "Icon Grösse (Anzeige als Liste)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T, "Definiere die Grösse des bekannt/unbekannt Icons an Stellen wo Gegenstände in einer Liste angezeigt werden", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID, "Icon Grösse (Anzeige als Gitter)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T, "Definiere die Grösse des bekannt/unbekannt Icons an Stellen wo Gegenstände durch das Addon [Inventory Grid View] in einem Gitter angezeigt werden", 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION, "Icon Positionierung", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION_T, "Definiere die Position des bekannt/unbekannt Icons.\nMit 'Automatisch' prüft PALoot ob die Addons [Research Assistant] und [ESO Master Recipe List] aktiviert sind und positioniert das Icon in einer noch nicht belegten Ecke", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_CHAT_LOOT_RECIPE_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s kann ", PAC.COLORS.ORANGE,"gelernt", PAC.COLORS.DEFAULT, " werden!"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_MOTIF_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s kann ", PAC.COLORS.ORANGE,"gelernt", PAC.COLORS.DEFAULT, " werden!"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_TRAIT_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s hat [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] das analysiert werden kann!"}), 1)

SafeAddString(SI_PA_PATTERN_INVENTORY_COUNT, table.concat({"%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Inventarplätze mehr/Inventarplatz/Inventarplätze]>> übrig!"}), 1)
SafeAddString(SI_PA_PATTERN_REPAIRKIT_COUNT, table.concat({"%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Reparaturmaterialien mehr/Reparaturmaterial/Reparaturmaterialien]>> übrig!"}), 1)
SafeAddString(SI_PA_PATTERN_SOULGEM_COUNT, table.concat({"%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Seelensteine mehr/Seelenstein/Seelensteine]>> übrig!"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_DISPLAY_A_MESSAGE_WHEN, "Zeige eine Meldung wenn . . .", 1)
SafeAddString(SI_PA_MARK_WITH, "Markiere mit . . .", 1)
SafeAddString(SI_PA_ITEM_KNOWN, "Bereits bekannt", 1)
SafeAddString(SI_PA_ITEM_UNKNOWN, "Unbekannt", 1)