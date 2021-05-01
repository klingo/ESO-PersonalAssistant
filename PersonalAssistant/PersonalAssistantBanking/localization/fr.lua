local PAC = PersonalAssistant.Constants
local PABStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking peut déplacer les devises, les matériaux d'artisanat, et d'autres objets entre l'inventaire et la banque",

    -- Currencies --
    SI_PA_MENU_BANKING_CURRENCY_HEADER = GetString(SI_INVENTORY_CURRENCIES),
    SI_PA_MENU_BANKING_CURRENCY_ENABLE = table.concat({"Dépot/Retrait automatique des ", GetString(SI_INVENTORY_CURRENCIES)}),
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Minimum à garder sur soi",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Maximum à garder sur soi",

    -- Crafting Items --
    SI_PA_MENU_BANKING_CRAFTING_HEADER = "Objets d'artisanat",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE = "Dépot/Retrait automatique des objets d'artisanat",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "Activer la mise en banque ou le retrait automatique pour les objets d'Artisanat ?",
    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "Définir l'action à exécuter (dépose, retrait, aucune action) pour les matériaux d'artisanat",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = "En tant que membre ESO Plus, the dépot/retrait de matériaux d'artisanat n'est pas utile puisqu'ils peuvent être tous transportés dans le sac d'artisanat",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE = "Changer tous les menus des objets d'artisanat en :",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T = "Changer tous les menus des objets d'artisanat précédents en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'",

    -- Advanced Items --
    SI_PA_MENU_BANKING_ADVANCED_HEADER = "Objets spéciaux",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE = "Dépot/Retrait automatique des objets spéciaux",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "Activer la mise en banque ou le retrait automatique pour les objets spéciaux ?",
    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "Définir l'action à exécuter (dépose, retrait, aucune action) pour les objets spéciaux",

    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE = "Changer tous les menus des objets spéciaux en :",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T = "Changer tous les menus des objets spéciaux précédents en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'",

    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Motifs connus"}),
    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Recettes connues"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Motifs inconnus"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Recettes inconnues"}),

    -- Individual Items --
    SI_PA_MENU_BANKING_INDIVIDUAL_HEADER = "Objets utilitaires",
    SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION = table.concat({"Avec la mise en place des règles de mise en banque personnalisées, les anciens paramètres pour les “Objets utilitaires” ont été migrés vers ce nouveau système. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- AvA Items --
    SI_PA_MENU_BANKING_AVA_HEADER = "Objets d'AcA",
    SI_PA_MENU_BANKING_AVA_ENABLE = "Dépot/Retrait automatique des objets d'AcA",
    SI_PA_MENU_BANKING_AVA_ENABLE_T = "Activer la mise en banque ou le retrait automatique pour les objets de Guerre d'Alliances ?",
    SI_PA_MENU_BANKING_AVA_DESCRIPTION = "Définir la quantité d'Objets de Guerre d'Alliances (AcA) qui doit être conservée dans l'inventaire",
    SI_PA_MENU_BANKING_AVA_OTHER_HEADER = "Autre",

    -- Other Settings --
--    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION = "",
--    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION_T = "",

    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING = "Règle d'empilement à la dépose",
    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T = "Définir si tous les objets doivent être déposés, ou seulement quand il y a des piles existantes à compléter",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING = "Règle d'empilement au retrait",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T = "Définir si tous les objets doivent être retirés, ou seulement quand il y a des piles existantes à compléter",

    SI_PA_MENU_BANKING_EXCLUDE_JUNK = "Ne pas déplacer les objets marqués comme rebuts",

    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS = "Empiler les objets à l'ouverture de la banque",
    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T = "Empiler automatiquement tous les objets dans la banque et l'inventaire à l'ouverture de la banque ? Cela permet une meilleure organisation",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE = "Déposer/Retirer cette devise", -- changed "les %s" because it wasn't working with "Or"

    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK = "Quantité à conserver",
    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T = "Définir la quantité qui (basée sur l'opérateur mathématique) doit être conservée dans l'inventaire ou la banque",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "Quantité minimum de %s à conserver sur ce personnage ; si nécessaire en retirant de la banque",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "Quantité maximum de %s à conserver sur ce personnage ; tout surplus sera déposé en banque",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "Ceci ne peut pas être annulé ; toutes les valeurs actuelles seront perdues",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MAINMENU_BANKING_HEADER = "Règles de mise en banque",

    SI_PA_MAINMENU_BANKING_HEADER_CATEGORY = "C", -- First letter of "Catégorie"
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "Emplacement",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "Règle",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "Quantité",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "Objet ciblé par la règle",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "Gérer",


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Add Custom Rule Description --
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_PRE = "Le %s doit contenir exactement %d pièces de l'objet",
    SI_PA_DIALOG_BANKING_BANK_LESSTHANOREQUAL_PRE = "Le %s doit avoir au maximum %d pièces de l'objet",
    SI_PA_DIALOG_BANKING_BANK_GREATERTHANOREQUAL_PRE = "Le %s doit avoir au minimum %d pièces de l'objet",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_NOTHING = "> %d dans votre %s => rien n'arrive.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_DEPOSIT = "> %d dans votre %s => des objets sont ajoutés au %s jusqu'à atteindre %d.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_NOTHING = "> %d - %d dans votre %s => rien n'arrive.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_DEPOSIT = "> %d - %d dans votre %s => des objets sont ajoutés au %s jusqu'à atteindre %d.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_WITHDRAW = "> %d - %d dans votre %s => des objets sont retirés du %s jusqu'à ce qu'il en reste %d.",

    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_PRE = "Le %s doit contenir exactement %d pièces de l'objet",
    SI_PA_DIALOG_BANKING_BACKPACK_LESSTHANOREQUAL_PRE = "Le %s doit avoir au maximum %d pièces de l'objet",
    SI_PA_DIALOG_BANKING_BACKPACK_GREATERTHANOREQUAL_PRE = "Le %s doit avoir au minimum %d pièces de l'objet",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_NOTHING = "> %d dans votre %s => rien n'arrive.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_DEPOSIT = "> %d dans votre %s => des objets sont ajoutés au %s jusqu'à atteindre %d.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_NOTHING = "> %d - %d dans votre %s => rien n'arrive.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_DEPOSIT = "> %d - %d dans votre %s => des objets sont ajoutés au %s jusqu'à atteindre %d.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_WITHDRAW = "> %d - %d dans votre %s => des objets sont retirés du %s jusqu'à ce qu'il en reste %d.",

    SI_PA_DIALOG_BANKING_EXPLANATION = "Cela signifie, que si vous avez . . .",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
--    SI_PA_CHAT_BANKING_FINISHED = "",

    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = "%s retirés",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = "%s / %s retirés (La banque est vide)",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = "%s / %s retirés (Pas assez d'espace sur le personnage)",

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = "%s déposés",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = "%s / %s déposés (Plus rien sur le personnage)",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = "%s / %s déposés (Pas assez d'espace en banque)",

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = "%d x %s déplacés vers %s",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "Impossible de déplacer %s vers %s. Pas assez d'espace !",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "Impossible de déplacer %s vers %s. La fenêtre a été fermée !",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "Certains matériaux n'ont PAS été déposés pour éviter de potentielles interférences avec Dolgubon's Lazy Writ Crafter",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("ajoutée"), " !"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("modifiée"), " !"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("supprimée"), " !"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("activée"), " !"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("désactivée"), " !"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
--    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS = "",
--    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS_PENDING = "",


    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages ; except in French ;-P --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER = "pièces d'or",
}

for key, value in pairs(PABStrings) do
    SafeAddString(_G[key], value, 1)
end
