local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAIntegration Menu --
SafeAddString(SI_PA_MENU_INTEGRATION_DESCRIPTION, "PAIntegration peut faire fonctionner PersonalAssistant avec d'autres add-ons tels que Dolgubon's Lazy Writ Crafter ou FCO ItemSaver", 1)
SafeAddString(SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE, "Aucun add-on supporté par PAIntegration n'a été détecté.", 1)

-- Dolgubon's Lazy Writ Crafter --
SafeAddString(SI_PA_MENU_INTEGRATION_LWC_PRECONDITION, "Note: Pour utiliser les options ci-dessous, il est nécessaire d'activer PABanking.", 1)

SafeAddString(SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY, "Compatibilité avec Dolgubon's Lazy Writ Crafter", 1)
SafeAddString(SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T, "Si vous avez des commandes d'artisanat en cours et que 'Prendre les matériaux de commande' est activé dans Dolgubon's Lazy Writ Crafter, alors ces objets ne seront pas déposés même si vous avez choisi 'Déposer en banque'. Ceci est pour éviter de remettre directement en banque les objets qui viennent d'être retirés.", 1)

-- FCO ItemSaver --
SafeAddString(SI_PA_MENU_INTEGRATION_FCOIS_PRECONDITION, "Note: Pour utiliser les options ci-dessous, il est nécessaire d'activer PAJunk.", 1)

SafeAddString(SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING, "Empêcher la vente automatique des objets verrouillés", 1)
--SafeAddString(SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED, "tbd", 1) -- TODO: Takit


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAIntegration --


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAIntegration Menu --
SafeAddString(SI_PA_MENU_INTEGRATION_PAB_REQUIRED, "PABanking doit être activé", 1)
SafeAddString(SI_PA_MENU_INTEGRATION_PAJ_REQUIRED, "PAJunk doit être activé", 1)

SafeAddString(SI_PA_MENU_INTEGRATION_MORE_TO_COME, "D'autres options d'intégration pour FCO ItemSaver seront ajoutées dans de futures mises à jour.", 1)
