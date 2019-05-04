local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot Loot Events --
SafeAddString(SI_PA_MENU_LOOT_DESCRIPTION, "PALoot peut vous informer sur des objets d'un intérêt particulier tels que des recettes inconnues, des motifs, des traits", 1)
SafeAddString(SI_PA_MENU_LOOT_EVENTS_ENABLE, "Activer les événements de butin", 1)

-- Loot Recipes
SafeAddString(SI_PA_MENU_LOOT_RECIPES_HEADER, table.concat({"Sur butin de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG, table.concat({"Avertir si la ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), 1), " n'est pas connue"}), 1) -- zo_strformat needed to avoid "Recette^f"
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T, table.concat({"Quand une ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), 1), " du butin n'est pas encore connue par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

-- Loot Motifs
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_HEADER, table.concat({"Sur butin de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG, table.concat({"Avertir si le ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " n'est pas connu"}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

-- Loot Equipment (Apparel, Weapons & Jewelries)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER, "Sur butin d'équipements", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG, "Avertir si le Trait n'est pas connu", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), " ou un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1) -- TODO: Takit update with [ITEMFILTERTYPE_JEWELRY]

SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING, "Avertir si l'espace restant est faible", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T, "Affiche un avertissement dans la fenêtre de chat s'il reste peu d'espace dans votre inventaire", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD, "Seuil d' “espace faible”", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T, "Si la place disponible restante dans l'inventaire est plus petite ou égale au seuil, un message sera affiché dans la fenêtre de chat", 1)

-- PALoot Mark Items --
SafeAddString(SI_PA_MENU_LOOT_ICONS_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Activer les marqueurs sur les objets"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP, "Afficher un pop-up sur l'icone", 1)

-- Mark Recipes --
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER, table.concat({"Marquer les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN, table.concat({"Afficher ", PAC.ICONS.OTHERS.KNOWN.NORMAL, " pur les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2), " inconnues"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN, table.concat({"Afficher ", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " pour les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2), " connues"}), 1)

-- Mark Motifs --
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_HEADER, table.concat({"Marquer les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN, table.concat({"Afficher ", PAC.ICONS.OTHERS.KNOWN.NORMAL, " pour les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2), " inconnus"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN, table.concat({"Afficher ", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " pour les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2), " connus"}), 1)

-- Mark Equipment (Apparel, Weapons & Jewelries) --
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER, "Marquer les équipements", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN, table.concat({"Afficher ", PAC.ICONS.OTHERS.KNOWN.NORMAL," pour les traits inconnus"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN, table.concat({"Afficher ", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " pour les traits connus"}), 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST, "Taille de l'icone (Vue classique)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T, "Définir la taille de l'icone connu/inconnu quand l'affichage des objets est en vue classique", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID, "Taille de l'icone (Vue grille)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T, "Définir la taille de l'icone connu/inconnu quand l'affichage des objets est en vue grille, grâce à l'extension [InventoryGridView]", 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION, "Position de l'icone", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION_T, "Définir la position de l'icone connu/inconnu.\nEn 'automatique', PALoot vérifiera si les extensions [Research Assistant] et [ESO Master Recipe List] sont activés, et positionnera l'icone dans un coin libre.", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_CHAT_LOOT_RECIPE_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s peut être ", PAC.COLORS.ORANGE,"apprise", PAC.COLORS.DEFAULT, " !"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_MOTIF_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s peut être ", PAC.COLORS.ORANGE,"appris", PAC.COLORS.DEFAULT, " !"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_TRAIT_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s a le trait [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] qui peut être recherché !"}), 1)

SafeAddString(SI_PA_PATTERN_INVENTORY_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[place dans l'inventaire/place dans l'inventaire/places dans l'inventaire]>> !"}), 1)
SafeAddString(SI_PA_PATTERN_REPAIRKIT_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[nécessaire de réparation/nécessaire de réparation/nécessaires de réparation]>> !"}), 1)
SafeAddString(SI_PA_PATTERN_SOULGEM_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[pierre d'âme/pierre d'âme/pierres d'âme]>> !"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_ITEM_KNOWN, "Déjà connu", 1)
SafeAddString(SI_PA_ITEM_UNKNOWN, "Inconnu", 1)