local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration peut faire fonctionner PersonalAssistant avec d'autres add-ons tels que Dolgubon's Lazy Writ Crafter ou FCO ItemSaver",
    SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE = "Aucun add-on supporté par PAIntegration n'a été détecté.",

    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Compatibilité avec Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "Si vous avez des commandes d'artisanat en cours et que 'Prendre les matériaux de commande' est activé dans Dolgubon's Lazy Writ Crafter, alors ces objets ne seront pas déposés même si vous avez choisi 'Déposer en banque'. Ceci est pour éviter de remettre directement en banque les objets qui viennent d'être retirés.",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "Empêcher la vente auto. des objets verrouillés",
    --SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING = "",
    --SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING_T = "",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Vente/Recel auto. des marqués aux marchands",
    --SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED = "",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    --SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "",
    --SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "D'autres options d'intégration pour FCO ItemSaver seront ajoutées dans de futures mises à jour.",
}

for key, value in pairs(PAIStrings) do
    SafeAddString(_G[key], value, 1)
end
