local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_LOOT_DESCRIPTION, "PALoot peut vous informer sur des objets d'un intérêt particulier tels que des recettes inconnues, des motifs, des traits", 1)

-- PALoot Loot Events --
SafeAddString(SI_PA_MENU_LOOT_EVENTS_HEADER, "Événements de butin", 1)
SafeAddString(SI_PA_MENU_LOOT_EVENTS_ENABLE, "Activer les événements de butin", 1)

-- Loot Recipes
SafeAddString(SI_PA_MENU_LOOT_RECIPES_HEADER, table.concat({"Sur butin de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG, "> une recette est inconnue", 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T, table.concat({"Quand une ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), 1), " du butin n'est pas encore connue par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

-- Loot Motifs & Style Pages
SafeAddString(SI_PA_MENU_LOOT_STYLES_HEADER, "Sur butin de styles", 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG, "> un motif artisanal est inconnu", 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)
SafeAddString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG, "> une page de style est inconnue", 1)
SafeAddString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

-- Loot Equipment (Apparel, Weapons & Jewelries)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER, "Sur butin d'équipements", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG, "> un trait n'a pas encore été recherché", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), " ou un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1) -- TODO: Takit update with [ITEMFILTERTYPE_JEWELRY]

SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING, "Avertir si l'espace restant est faible", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T, "Affiche un avertissement dans la fenêtre de chat s'il reste peu d'espace dans votre inventaire", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD, "Seuil d' “espace faible”", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T, "Si la place disponible restante dans l'inventaire est plus petite ou égale au seuil, un message sera affiché dans la fenêtre de chat", 1)

-- PALoot Mark Items --
SafeAddString(SI_PA_MENU_LOOT_ICONS_HEADER, "Icônes des objets", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ENABLE, "Activer les marqueurs sur les objets", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP, "Afficher un pop-up sur l'icone", 1)

-- Mark Recipes --
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER, table.concat({"Marquer les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "une recette déjà connue"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "une recette encore inconnue"}), 1)

-- Mark Motifs and Style Page Containers --
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLES_HEADER, "Marquer les styles", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "un motif artisanal déjà connu"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "un motif artisanal encore inconnu"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "une page de style déjà connue"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "une page de style encore inconnue"}), 1)

-- Mark Equipment (Apparel, Weapons & Jewelries) --
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER, "Marquer les équipements", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN, table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "un trait déjà recherché"}), 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN, table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "un trait pas encore recherché"}), 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST, "Taille de l'icone (Vue classique)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T, "Définir la taille de l'icone connu/inconnu quand l'affichage des objets est en vue classique", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID, "Taille de l'icone (Vue grille)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T, "Définir la taille de l'icone connu/inconnu quand l'affichage des objets est en vue grille, grâce à l'extension [InventoryGridView]", 1)

SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION_GRID, "Position de l'icone (Vue grille)", 1)
SafeAddString(SI_PA_MENU_LOOT_ICONS_POSITION_GRID_T, "Définir la position de l'icone connu/inconnu.\nEn 'automatique', PALoot vérifiera si les extensions [Research Assistant] et [ESO Master Recipe List] sont activés, et positionnera l'icone dans un coin libre.", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_CHAT_LOOT_RECIPE_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s peut être ", PAC.COLORS.ORANGE,"apprise", PAC.COLORS.DEFAULT, " !"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_MOTIF_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s peut être ", PAC.COLORS.ORANGE,"appris", PAC.COLORS.DEFAULT, " !"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_TRAIT_UNKNOWN, table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s a le trait [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] qui peut être recherché !"}), 1)

SafeAddString(SI_PA_PATTERN_INVENTORY_COUNT, table.concat({"%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[place dans l'inventaire/place dans l'inventaire/places dans l'inventaire]>> !"}), 1)
SafeAddString(SI_PA_PATTERN_REPAIRKIT_COUNT, table.concat({"%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[nécessaire de réparation/nécessaire de réparation/nécessaires de réparation]>> !"}), 1)
SafeAddString(SI_PA_PATTERN_SOULGEM_COUNT, table.concat({"%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[pierre d'âme/pierre d'âme/pierres d'âme]>> !"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_DISPLAY_A_MESSAGE_WHEN, "Afficher un message quand . . .", 1)
SafeAddString(SI_PA_MARK_WITH, "Marquer avec . . .", 1)
SafeAddString(SI_PA_ITEM_KNOWN, "Déjà connu", 1)
SafeAddString(SI_PA_ITEM_UNKNOWN, "Inconnu", 1)