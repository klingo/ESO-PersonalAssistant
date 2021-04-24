local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk peut marquer des objets comme rebuts s'ils remplissent l'une des conditions possible ; exceptés s'ils ont été fait en artisanat ou récupérés du courrier",

    -- Standard Items --
    SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER = "Objets standards",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = "Marquer automatiquement comme rebuts",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Appliquer seulement aux “Objets standard”. Les règles de mise aux rebuts personnalisées ne sont pas impactées par cette option et doivent être désactivées individuellement si elles ne doivent plus être exécutées.",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Marquer les objets [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Marquer les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] comme rebuts ?"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"Ne PAS marquer comme rebuts les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] si nécessaire . . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Petites bouchées")}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets camelote suivants ne seront PAS marqués comme rebuts:\n[Carapace]\n[Peau Infâme]\n[Enveloppe de Daedra]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Morceaux de choix")}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets camelote suivants ne seront PAS marqués comme rebuts:\n[Essence Élémentaire]\n[Racine Souple]\n[Ectoplasme]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Marquer les objets [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Marquer automatiquement les objets avec l'indicateur [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] comme rebuts ?"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_ITEMS_DESC = table.concat({"Ne PAS marquer comme rebuts les objets de type [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] si nécessaire . . ."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Festin de la Manne poissonneuse")}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH_T = table.concat({PAC.COLOR.YELLOW:Colorize("Une quête durant le "), PAC.COLOR.ORANGE:Colorize("Festival de la Nouvelle vie"), " qui arrive parfois en hiver\nSi activé, tous les [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH),"] ne seront PAS marqués comme rebuts"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK = table.concat({"Marquer les objets [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK_T = table.concat({"Marquer les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] comme rebuts ?"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"Ne PAS détruire ou marquer comme rebuts les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] si nécessaire . . ."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Une affaire de loisirs")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Jouets d'enfants]\n[Poupées]\n[Jeux]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Une histoire de respect")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Ustensiles]\n[Récipients à boire]\n[Plats et moules]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Une affaire de tributs")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Produits cosmétiques]\n[Ustensiles de toilette]"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS = table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("La comtesse avide")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quête de: "), PAC.COLOR.ORANGE:Colorize("La guilde des voleurs"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Produits cosmétiques]\n[Denrées sèches]\n[Accessoires vestimentaires]\n\n[Récipients à boire]\n[Ustensiles]\n[Plats et moules]\n\n[Jeux]\n[Poupées]\n[Statues]\n\n[Écrits] & [Fournitures de scribe]\n[Cartes]\n\n[Objets rituel]\n[Curiosités]"}),

    -- Stolen Items --
    SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER = "Objets volés",
    --SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER = "",

    -- Custom Items --
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER = "Objets personnalisés",
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Quest Items --
    SI_PA_MENU_JUNK_QUEST_ITEMS_HEADER = "Protection des objets de quête",
    SI_PA_MENU_JUNK_QUEST_CLOCKWORK_CITY_HEADER = "La Cité mécanique",
    SI_PA_MENU_JUNK_QUEST_THIEVES_GUILD_HEADER = "La guilde des voleurs",
    SI_PA_MENU_JUNK_QUEST_NEW_LIFE_FESTIVAL_HEADER = "Festival de la Nouvelle vie",

    -- Auto-Sell --
    --SI_PA_MENU_JUNK_AUTO_SELL_JUNK_HEADER = "",

    -- Auto-Destroy --
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_HEADER = "Détruire automatiquement les rebuts",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T = "",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W = "ATTENTION: Soyez conscient en utilisant cette option, il n'y a PAS de fenêtre de confirmation qui s'ouvrira pour permettre de confirmer que l'objet doit être vraiment détruit.\nIl sera immédiatement détruit !\nPour toujours !\nUtilisez à vos risques et périls !",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD_T = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD_T = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_EXCLUSION_DISCLAIMER = "",

    --SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_T = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD_T = "!",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD = "",
    --SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD_T = "",

    -- Other Settings --
    SI_PA_MENU_JUNK_MAILBOX_IGNORE = "Ne pas mettre aux rebuts si reçu par courrier",
    SI_PA_MENU_JUNK_MAILBOX_IGNORE_T = "Les objets reçus par courrier ne seront jamais mis aux rebuts",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE = "Ne pas mettre aux rebuts mes objets craftés",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE_T = "Les objets que vous avez créés en artisanat ne seront jamais mis aux rebuts",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Vente/Recel auto. des rebuts aux marchands",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI = "Recel automatique à l'assistante Pirharri",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI_W = "Contrairement aux autres receleurs, Pirharri taxe l'utilisation de ses services à hauteur de 35%",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "Commandes",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE = "Activer la commande \"Mettre aux / Sortir des rebuts\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW = "Afficher la commande \"Mettre aux / Sortir des rebuts\"",
    --SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_ENABLE = "",
    --SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_SHOW = "",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE = "Activer la commande \"Détruire l'objet\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W = "ATTENTION: Soyez conscient en utilisant cette commande, il n'y a PAS de fenêtre de confirmation qui s'ouvrira pour permettre de confirmer que l'objet doit être vraiment détruit.\nIl sera immédiatement détruit !\nPour toujours !\nUtilisez à vos risques et périls !",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW = "Afficher la commande \"Détruire l'objet\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION = "Désactiver la commande  \"Détruire l'objet\" si l'objet . . .",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD = "> est de qualité supérieure ou égale à",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN = "> peut-être appris/recherché et est inconnu",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "Marquer les %s de qualité inférieure ou égale à",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "Marquer automatiquement comme rebuts les %s de qualité inférieure ou égale à celle sélectionnée",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Marquer les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Marquer automatiquement comme rebuts les %s avec le trait [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (prix de vente accru) ?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Marquer même les %s d'un ensemble",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "Si désactivé, seuls les objets %s qui ne font PAS partie d'un ensemble seront marqués comme rebuts",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE = table.concat({"Marquer même les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "]"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T = table.concat({"Si désactivé, les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "] ne seront PAS marqués comme rebuts (indépendamment de leur qualité)."}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS = "Marquer même les %s avec un trait connu",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "Si désactivé, seuls les objets %s sans traits ou au traits inconnus seront marqués comme rebuts",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Marquer même les %s avec un trait inconnu",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "Si désactivé, seuls les objets %s sans traits ou au traits connus seront marqués comme rebuts",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_MAINMENU_JUNK_HEADER = "Règles de mise aux rebuts",

    SI_PA_MAINMENU_JUNK_HEADER_ITEM = "Objet ciblé par la règle",
    SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT = "Nb. d'usages",
    SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK = "Dernier usage",
    SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED = "Créée depuis",
    SI_PA_MAINMENU_JUNK_HEADER_ACTIONS = "Gérer",

    SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED = "Jamais",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("qualité"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Marchand"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Trésor"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Manuel"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Volé"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT = table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Rebut permanent"), ")"}),

    SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Détruit"), " %d x %s"}),
    SI_PA_CHAT_JUNK_DESTROYED_ALWAYS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Détruit"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Toujours"), ")"}),
    --SI_PA_CHAT_JUNK_DESTROYED_CRITERIA_MATCH = "",

    SI_PA_CHAT_JUNK_DESTROY_ON = table.concat({"La destruction automatique des rebuts a été changée en ", PAC.COLOR.RED:Colorize("OUI")}),
    SI_PA_CHAT_JUNK_DESTROY_OFF = table.concat({"La destruction automatique des rebuts a été changée en ", PAC.COLOR.GREEN:Colorize("NON")}),
    --SI_PA_CHAT_JUNK_DESTROY_STOLEN_ON = table.concat({"", PAC.COLOR.RED:Colorize("OUI")}),
    --SI_PA_CHAT_JUNK_DESTROY_STOLEN_OFF = table.concat({"", PAC.COLOR.GREEN:Colorize("NON")}),

    SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO = "Objets vendus pour %s",
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d heures"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d minutes"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({"Impossible de vendre %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),
    SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM = "Impossible de vendre %s",

    SI_PA_CHAT_JUNK_RULES_ADDED = table.concat({"%s a été ", PAC.COLOR.ORANGE:Colorize("ajouté"), " à la liste des rebuts permanents!"}),
    SI_PA_CHAT_JUNK_RULES_DELETED = table.concat({"%s a été ", PAC.COLOR.ORANGE:Colorize("retiré"), " de la liste des rebuts permanents!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Addon Keybindings menu --
    SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM = "Mettre aux / Sortir des rebuts",
    --SI_BINDING_NAME_PA_JUNK_PERMANENT_TOGGLE_ITEM = "",
    SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM = "Détruire l'objet",

    -- Actual keybindings --
    --SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK = "",
    --SI_PA_ITEM_ACTION_UNMARK_AS_PERM_JUNK = "",


    -- =================================================================================================================
    -- == OTHER STRINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Quest: "A Matter of Leisure"
    SI_PA_TREASURE_ITEM_TAG_DESC_TOYS = "Jouets d'enfants",
    SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS = "Poupées",
    SI_PA_TREASURE_ITEM_TAG_DESC_GAMES = "Jeux",

    -- Quest: "A Matter of Respect"
    SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS = "Ustensiles",
    SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE = "Récipients à boire",
    SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE = "Plats et moules",

    -- Quest: "A Matter of Tributes"
    SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS = "Produits cosmétiques",
    SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING = "Ustensiles de toilette",

    -- Quest: "The Covetous Countess" (only additional tags)
    SI_PA_TREASURE_ITEM_TAG_DESC_LINENS = "Denrées sèches",
    SI_PA_TREASURE_ITEM_TAG_DESC_ACCESSORIES = "Accessoires vestimentaires",
    SI_PA_TREASURE_ITEM_TAG_DESC_STATUES = "Statues",
    SI_PA_TREASURE_ITEM_TAG_DESC_WRITINGS = "Écrits",
    SI_PA_TREASURE_ITEM_TAG_DESC_SCRIVENER = "Fournitures de scribe",
    SI_PA_TREASURE_ITEM_TAG_DESC_MAPS = "Cartes",
    SI_PA_TREASURE_ITEM_TAG_DESC_RITUAL_OBJECTS = "Objets rituels",
    SI_PA_TREASURE_ITEM_TAG_DESC_ODDITIES = "Curiosités",

    -- OTHERS: Not yet used
    SI_PA_TREASURE_ITEM_TAG_DESC_INSTRUMENTS = "Instruments de musique",
    SI_PA_TREASURE_ITEM_TAG_DESC_ARTWORK = "Œuvre d'art",
    SI_PA_TREASURE_ITEM_TAG_DESC_DECOR = "Décoration murale",
    SI_PA_TREASURE_ITEM_TAG_DESC_TRIFLES_ORNAMENTS = "Babioles et ornements",
    SI_PA_TREASURE_ITEM_TAG_DESC_DEVICES = "Appareils",
    SI_PA_TREASURE_ITEM_TAG_DESC_SMITHING = "Équipment de forge",
    SI_PA_TREASURE_ITEM_TAG_DESC_TOOLS = "Outils",
    SI_PA_TREASURE_ITEM_TAG_DESC_MEDICAL_SUPPLIES = "Fournitures médicales",
    SI_PA_TREASURE_ITEM_TAG_DESC_CURIOSITIES = "Curiosités magiques",
    SI_PA_TREASURE_ITEM_TAG_DESC_FURNISHINGS = "Meubles",
    SI_PA_TREASURE_ITEM_TAG_DESC_LIGHTS = "Lumières",
}

for key, value in pairs(PAJStrings) do
    SafeAddString(_G[key], value, 1)
end
