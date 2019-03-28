local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot Menu --
SafeAddString(SI_PA_MENU_LOOT_DESCRIPTION, "PALoot kann dich darüber informieren wenn Gegenstände von speziellem Interesse (wie unbekannte Rezepte, Stile oder Eigenschaften) eingesammelt werden", 1)
-- Loot Recipes
SafeAddString(SI_PA_MENU_LOOT_RECIPES_HEADER, table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", "Beim ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2), " einsammeln"}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG, table.concat({"Informiere bei unbekanntem ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE)}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T, table.concat({"Wann immer ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " eingesammelt wird das von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}), 1)

-- Loot Motifs
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_HEADER, table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", "Beim ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2), " einsammeln"}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG, table.concat({"Informiere bei unbekanntem ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF)}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T, table.concat({"Wann immer ein ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " eingesammelt wird der von diesem Charakter noch nicht gelernt wurde, wird eine Information im Chat ausgegeben"}), 1)

-- Loot Apparel & Weapons
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER, table.concat({" ", PAC.ICONS.CRAFTBAG.WEAPON.NORMAL, "  ", "Beim ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)), " einsammeln"}), 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG, "Informiere bei nicht analysierten Eigenschaften", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T, table.concat({"Wann immer eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), " oder eine ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), " eingesammelt wird und sie eine Eigenschaft hat welche von diesem Charakter noch nicht analysiert wurde, dann wird eine Information im Chat ausgegeben"}), 1)

SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING, "Warne wenn Inventarplätze ausgehen", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T, "Zeige eine Warnung im Chat an wenn dir die Inventarplätze ausgehen", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD, "Schwellenwert für Inventarplätze", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T, "Wenn die verbleibenden freien Inventarplätze auf oder unter diesen Schwellenwert fallen, wird eine Warnung im Chat ausgegeben", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_CHAT_LOOT_RECIPE_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, "%s kann ", PAC.COLORS.ORANGE,"gelernt", PAC.COLORS.DEFAULT, " werden!"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_MOTIF_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, "%s kann ", PAC.COLORS.ORANGE,"gelernt", PAC.COLORS.DEFAULT, " werden!"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_TRAIT_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, "%s hat [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] das analysiert werden kann!"}), 1)

SafeAddString(SI_PA_PATTERN_INVENTORY_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Inventarplätze mehr/Inventarplatz/Inventarplätze]>> übrig!"}), 1)
SafeAddString(SI_PA_PATTERN_REPAIRKIT_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Reparaturmaterialien mehr/Reparaturmaterial/Reparaturmaterialien]>> übrig!"}), 1)
SafeAddString(SI_PA_PATTERN_SOULGEM_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sDu hast <<1[", PAC.COLORS.WHITE,"keine/nur noch ", PAC.COLORS.WHITE, "%d/nur noch ", PAC.COLORS.WHITE, "%d]>> %s<<1[Seelensteine mehr/Seelenstein/Seelensteine]>> übrig!"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_MENU_LOOT_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Ereignisse beim Beute einsammeln"}), 1)