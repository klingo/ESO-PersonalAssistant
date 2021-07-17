local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Profile Settings --
    SI_PA_MENU_PROFILE_PLEASE_SELECT = "<Sélectionner un profil>",
    SI_PA_MENU_PROFILE_ACTIVE = "Profil actif",
    SI_PA_MENU_PROFILE_ACTIVE_T = "Selectionner le profil actif pour PersonalAssistant. Il chargera automatiquement tous les paramètres stockés sous ce profil, et enregistrera les changements au même endroit.",
    SI_PA_MENU_PROFILE_ACTIVE_RENAME = "Renommer le profil actif",

    -- Create Profiles --
    SI_PA_MENU_PROFILE_CREATE_NEW = "Créer un nouveau profil",
    SI_PA_MENU_PROFILE_CREATE_NEW_DESC = table.concat({"Note : Vous pouvez avoir un maximum de ", PAC.GENERAL.MAX_PROFILES, " profils."}),

    -- Copy Profiles --
    SI_PA_MENU_PROFILE_COPY_FROM_DESC = "Copier les paramètres depuis un profil existant vers le profil courant.",
    SI_PA_MENU_PROFILE_COPY_FROM = "Copier depuis profil",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM = "Confirmer la copie",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W = "Cela remplacera les paramètres du profil actif par ceux du profil sélectionné. Êtes-vous sûr de vouloir continuer ? \n\nNote : Seulement les paramètres des modules actifs de PersonalAssitant seront copiés.",

    -- Delete Profiles --
    SI_PA_MENU_PROFILE_DELETE_DESC = "Supprimer les profils existants et inutilisés de la base de données pour sauver de l'espace, et nettoyer le fichier SavedVariables.",
    SI_PA_MENU_PROFILE_DELETE = "Supprimer un profil",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM = "Confirmer la suppression",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM_W = "Cela supprimera le profil sélectionné pour tous les personnages. Êtes-vous sûr de vouloir continuer ?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Rules Menu --
    SI_PA_MENU_RULES_HOW_TO_ADD_PAB = "Pour créer une nouvelle règle de dépôt ou retrait d'objets, il suffit de cliquer droit sur un objet dans votre inventaire ou en banque, et de sélectionner dans le menu contextuel :\n> PA Banking > Ajouter une nouvelle règle",
    SI_PA_MENU_RULES_HOW_TO_ADD_PAJ = "Pour créer une nouvelle règle de mise aux rebuts permanente, il suffit de cliquer droit sur un objet dans votre inventaire ou en banque, et de sélectionner dans le menu contextuel :\n> PA Junk > Marquer en tant que rebut permanent",
    SI_PA_MENU_RULES_HOW_TO_FIND_MENU = table.concat({"Toutes les règles actives peuvent être retrouvées en cliquant sur l'icône qui se trouve dans le menu principal, en tapant ", PAC.COLOR.YELLOW:Colorize("/parules"), " ou en cliquant sur ce bouton :"}),
    SI_PA_MENU_RULES_HOW_TO_CREATE = "Comment créer de nouvelles règles?",

    SI_PA_MENU_DANGEROUS_SETTING = "ATTENTION : Paramètres dangereux ! Utilisez à vos risques et périls !",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_OTHER_SETTINGS_HEADER = "Autres paramètres",

    SI_PA_MENU_SILENT_MODE = "Mode silencieux (Ne RIEN afficher dans le chat)",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "Pas encore implémenté !"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED = table.concat({" nouveau profil ", PAC.COLOR.WHITE:Colorize("%s"), " créé et activé !"}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED = table.concat({" Le profil ", PAC.COLOR.WHITE:Colorize("%s"), " sélectionné a été ", PAC.COLOR.ORANGE_RED:Colorize("copié"), " vers le profil ", PAC.COLOR.WHITE:Colorize("%s")}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED = table.concat({" Le profil ", PAC.COLOR.WHITE:Colorize("%s"), " sélectionné a été ", PAC.COLOR.ORANGE_RED:Colorize("supprimé !")}),

    --SI_PA_CHAT_GENERAL_TELEPORT_NO_PRIMARY_HOUSE = table.concat({}),
    --SI_PA_CHAT_GENERAL_TELEPORT_ZONE_PREVENTED = table.concat({}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "Profil",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "Équipement", -- not required so far
    SI_PA_NS_BAG_BACKPACK = "Inventaire",
    SI_PA_NS_BAG_BANK = "Banque",
--    SI_PA_NS_BAG_SUBSCRIBER_BANK = "",
    SI_PA_NS_BAG_VIRTUAL = "Sac d'artisanat",
    SI_PA_NS_BAG_HOUSE_BANK = "Banque attitrée",
    SI_PA_NS_BAG_HOUSE_BANK_NR = "Banque attitrée (%d)",
    SI_PA_NS_BAG_UNKNOWN = "Inconnu",

    -- -----------------------------------------------------------------------------------------------------------------
    -- ItemTypes (Custom Singluar/Plural definition) --
    SI_PA_ITEMTYPE4 = "<<1[Nourriture/Nourriture]>>",
    SI_PA_ITEMTYPE5 = "<<1[Trophées/Trophées]>>",
    SI_PA_ITEMTYPE7 = "<<1[Potion/Potions]>>",
    SI_PA_ITEMTYPE8 = "<<1[Motif/Motifs]>>",
    SI_PA_ITEMTYPE10 = "<<1[Ingrédient/Ingrédients]>>",
    SI_PA_ITEMTYPE12 = "<<1[Boisson/Boissons]>>",
    SI_PA_ITEMTYPE16 = "<<1[Appât/Appâts]>>",
    SI_PA_ITEMTYPE19 = "<<1[Pierre d'Âme/Pierres d'Âme]>>",
    SI_PA_ITEMTYPE22 = "<<1[Crochetage/Crochetages]>>",
    SI_PA_ITEMTYPE29 = "<<1[Recette/Recettes]>>",
    SI_PA_ITEMTYPE30 = "<<1[Poison/Poisons]>>",
    SI_PA_ITEMTYPE33 = "<<1[Solvant/Solvants]>>",
    SI_PA_ITEMTYPE34 = "<<1[Objet de collection/Objets de collection]>>",
    --SI_PA_ITEMTYPE47 = "<<1[]>>",
    SI_PA_ITEMTYPE56 = "<<1[Trésor/Trésors]>>",
    SI_PA_ITEMTYPE60 = "<<1[Commande de maître/Commandes de maître]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- SpecializedItemTypes (Custom Singluar/Plural definition) --
    --SI_PA_SPECIALIZEDITEMTYPE102 = "<<1[/]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Master Writs based on CraftingType (Custom definition) --
    SI_PA_MASTERWRIT_CRAFTINGTYPE0 = table.concat({"Autres commandes (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}),
    SI_PA_MASTERWRIT_CRAFTINGTYPE1 = "Commande de forge scellée",
    SI_PA_MASTERWRIT_CRAFTINGTYPE2 = "Commande scellée de couture",
    SI_PA_MASTERWRIT_CRAFTINGTYPE3 = "Commande d'enchantement scellée",
    SI_PA_MASTERWRIT_CRAFTINGTYPE4 = "Commande scellée d'alchimie",
    SI_PA_MASTERWRIT_CRAFTINGTYPE5 = "Commande scellée de cuisine",
    SI_PA_MASTERWRIT_CRAFTINGTYPE6 = "Commande de travail du bois scellée",
    SI_PA_MASTERWRIT_CRAFTINGTYPE7 = "Commande scellée de joaillier",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Ne rien faire",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Déposer en banque",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Prendre dans le sac",

    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Glyphes",
    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS = "Objets complexes",

    SI_PA_MENU_BANKING_REPAIRKIT = "Nécessaires de réparation",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "Sélectionner l'opérateur mathématique pour cet objet",
    SI_PA_REL_BACKPACK_EQUAL = "INVENTAIRE ==",
    SI_PA_REL_BACKPACK_LESSTHAN = "INVENTAIRE <", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANEQUAL = "INVENTAIRE <=",
    SI_PA_REL_BACKPACK_GREATERTHAN = "INVENTAIRE >", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANEQUAL = "INVENTAIRE >=",
    SI_PA_REL_BANK_EQUAL = "BANQUE ==",
    SI_PA_REL_BANK_LESSTHAN = "BANQUE <", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL = "BANQUE <=",
    SI_PA_REL_BANK_GREATERTHAN = "BANQUE >", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL = "BANQUE >=",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operator Tooltip --
    SI_PA_REL_BACKPACK_EQUAL_T = "INVENTAIRE égal (=)",
    SI_PA_REL_BACKPACK_LESSTHAN_T = "INVENTAIRE inférieur à (<)", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T = "INVENTAIRE inférieur ou égal à (<=)",
    SI_PA_REL_BACKPACK_GREATERTHAN_T = "INVENTAIRE supérieur à (>)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T = "INVENTAIRE supérieur ou égal à (>=)",
    SI_PA_REL_BANK_EQUAL_T = "BANQUE égal (=)",
    SI_PA_REL_BANK_LESSTHAN_T = "BANQUE inférieur à (<)", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL_T = "BANQUE inférieur ou égal à (<=)",
    SI_PA_REL_BANK_GREATERTHAN_T = "BANQUE supérieur à (>)", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL_T = "BANQUE supérieur ou égal à (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Text Operators --
    SI_PA_REL_TEXT_OPERATOR0 = "-",
    SI_PA_REL_TEXT_OPERATOR1 = "a exactement",
    SI_PA_REL_TEXT_OPERATOR2 = "a moins que", -- not used so far
    SI_PA_REL_TEXT_OPERATOR3 = "a au plus",
    SI_PA_REL_TEXT_OPERATOR4 = "a plus que", -- not used so far
    SI_PA_REL_TEXT_OPERATOR5 = "a au moins",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Tout déplacer",
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "N'ajouter qu'aux piles existantes",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Icon Positions --
    SI_PA_POSITION_AUTO = "Automatique",
    SI_PA_POSITION_MANUAL = "Manuel",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_ITEM_ACTION_NOTHING = "Ne rien faire",
    SI_PA_ITEM_ACTION_LAUNDER = "Blanchir",
    SI_PA_ITEM_ACTION_MARK_AS_JUNK = "Mettre aux rebuts",
    SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS = "Rebuts ou Détruire si sans valeur",
    SI_PA_ITEM_ACTION_DESTROY_ALWAYS = "Toujours détruire",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB_ADD_RULE = "Ajouter une nouvelle règle",
    SI_PA_SUBMENU_PAB_EDIT_RULE = "Éditer une règle",
    SI_PA_SUBMENU_PAB_DELETE_RULE = "Supprimer une règle",
    SI_PA_SUBMENU_PAB_ENABLE_RULE = "Activer la règle",
    SI_PA_SUBMENU_PAB_DISABLE_RULE = "Désactiver la règle",
    SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON = "Ajouter",
    SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON = "Sauvegarder",
    SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON = "Supprimer",
    SI_PA_SUBMENU_PAB_NO_RULES = "Aucune règle de mise en banque définie",
    SI_PA_SUBMENU_PAB_DISCLAIMER = "Note: Ces règles de mise en banque seront exécutées après toutes les autres règles de mise en banque automatiques (Artisanat, Spécial, Objets AvA).",

    SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK = "Marquer en tant que rebut permanent",
    SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK = "Ne plus marquer en tant que rebut permanent",
    SI_PA_SUBMENU_PAJ_NO_RULES = "Aucune règle de mise aux rebuts définie",


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_PROFILES = "|cFFD700P|rersonal|cFFD700A|rssistant Profils",
    SI_KEYBINDINGS_CATEGORY_PA_MENU = "Menu de |cFFD700P|rersonal|cFFD700A|rssistant",

    SI_BINDING_NAME_PA_RULES_MAIN_MENU = "Règles de PersonalAssistant",
    SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW = "Afficher/Cacher le menu des règles de mise en banque et aux rebuts",
    --SI_BINDING_NAME_PA_TRAVEL_TO_HOUSE = "",


    -- =================================================================================================================
    -- Overriding the ItemFilterTypes because they are wrong in French --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING = "Coûture",
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING = "Enchantement",
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING = "Ameublement",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
