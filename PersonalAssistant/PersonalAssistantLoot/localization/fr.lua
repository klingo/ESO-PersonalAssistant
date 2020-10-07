local PAC = PersonalAssistant.Constants
local PALStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot peut vous informer sur des objets d'un intérêt particulier tels que des recettes inconnues, des motifs, des traits",

    -- PALoot Loot Events --
    SI_PA_MENU_LOOT_EVENTS_HEADER = "Événements de butin",
    SI_PA_MENU_LOOT_EVENTS_ENABLE = "Activer les événements de butin",

    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({"Sur butin de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = "> une recette est inconnue",
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = table.concat({"Quand une ", zo_strformat("<<1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), 1), " du butin n'est pas encore connue par ce personnage, un message sera affiché dans la fenêtre de chat"}),

    -- Loot Motifs & Style Pages
    SI_PA_MENU_LOOT_STYLES_HEADER = "Sur butin de styles",
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = "> un motif artisanal est inconnu",
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = table.concat({"Quand un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG = "> une page de style est inconnue",
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T = table.concat({"Quand un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}),

    -- Loot Equipment (Apparel, Weapons & Jewelries)
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = "Sur butin d'équipements",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "> un trait n'a pas encore été recherché",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = table.concat({"Quand un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)," ou un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)," du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}),

    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "Avertir si l'espace restant est faible",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T = "Affiche un avertissement dans la fenêtre de chat s'il reste peu d'espace dans votre inventaire",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "Seuil d' “espace faible”",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "Si la place disponible restante dans l'inventaire est plus petite ou égale au seuil, un message sera affiché dans la fenêtre de chat",

    -- PALoot Mark Items --
    SI_PA_MENU_LOOT_ICONS_HEADER = "Icônes des objets",
    SI_PA_MENU_LOOT_ICONS_ENABLE = "Activer les marqueurs sur les objets",
    SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP = "Afficher un pop-up sur l'icone",

    -- Mark Recipes --
    SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER = table.concat({"Marquer les ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "une recette déjà connue"}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "une recette encore inconnue"}),

    -- Mark Motifs and Style Page Containers --
    SI_PA_MENU_LOOT_ICONS_STYLES_HEADER = "Marquer les styles",
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "un motif artisanal déjà connu"}),
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "un motif artisanal encore inconnu"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "une page de style déjà connue"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "une page de style encore inconnue"}),

    -- Mark Equipment (Apparel, Weapons & Jewelries) --
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER = "Marquer les équipements",
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "un trait déjà recherché"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "un trait pas encore recherché"}),

    SI_PA_MENU_LOOT_ICONS_SIZE_LIST = "Taille de l'icone (Vue classique)",
    SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T = "Définir la taille de l'icone connu/inconnu quand l'affichage des objets est en vue classique",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID = "Taille de l'icone (Vue grille)",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T = "Définir la taille de l'icone connu/inconnu quand l'affichage des objets est en vue grille, grâce à l'extension [InventoryGridView]",

    SI_PA_MENU_LOOT_ICONS_POSITION_GRID = "Position de l'icone (Vue grille)",
    SI_PA_MENU_LOOT_ICONS_POSITION_GRID_T = "Définir la position de l'icone connu/inconnu.\nEn 'automatique', PALoot vérifiera si les extensions [Research Assistant] et [ESO Master Recipe List] sont activés, et positionnera l'icone dans un coin libre.",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST = "Décalage de l'icône en X (Vue liste)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T = "Définir le décalage horizontal pour l'icone connu/inconnu en mode de vue \"liste\"",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST = "Décalage de l'icône en Y (Vue liste)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T = "Définir le décalage vertical pour l'icone connu/inconnu en mode de vue \"liste\"",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID = "Décalage de l'icône en X (Vue grille)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T = "Définir le décalage horizontal pour l'icone connu/inconnu en mode de vue \"grille\" avec l'addon [InventoryGridView]\n\nNe fonctionne qu'en choisissant le mode de position de l'icone en \"manuel\"",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID = "Décalage de l'icône en Y (Vue grille)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T = "Définir le décalage vertical pour l'icone connu/inconnu en mode de vue \"grille\" avec l'addon [InventoryGridView]\n\nNe fonctionne qu'en choisissant le mode de position de l'icone en \"manuel\"",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s peut être ", PAC.COLORS.ORANGE,"apprise", PAC.COLORS.DEFAULT, " !"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s peut être ", PAC.COLORS.ORANGE,"appris", PAC.COLORS.DEFAULT, " !"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s a le trait [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] qui peut être recherché !"}),

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({"%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[place dans l'inventaire/place dans l'inventaire/places dans l'inventaire]>> !"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({"%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[nécessaire de réparation/nécessaire de réparation/nécessaires de réparation]>> !"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({"%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[pierre d'âme/pierre d'âme/pierres d'âme]>> !"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_DISPLAY_A_MESSAGE_WHEN = "Afficher un message quand . . .",
    SI_PA_MARK_WITH = "Marquer avec . . .",
    SI_PA_ITEM_KNOWN = "Déjà connu",
    SI_PA_ITEM_UNKNOWN = "Inconnu",
}

for key, value in pairs(PALStrings) do
    SafeAddString(key, value, 1)
end
