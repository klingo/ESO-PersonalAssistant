local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration kann Funktionalität von PersonalAssistant AddOns mit anderen Addons wie z.B. Dolgubon's Lazy Writ Crafter oder FCO ItemSaver integrieren",
    SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE = "Es sind derzeit keine AddOns installiert/aktiviert die von PAIntegration unterstützt werden",

    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_PRECONDITION = "Anmerkung: Um untenstehende Einstellung verwenden zu können muss zuerst PABanking aktiviert werden",

    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Kompatibilität mit Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "Wenn du aktive Schrieb Quests hast und 'Gegenstände entnehmen' in Dolgubon's Lazy Writ Crafter aktiviert ist, dann wird für diese Gegenstände  die 'In Truhe einlagern' Einstellung ignoriert. Dadurch sollen eben entnommene Gegenstände nicht wieder direkt eingelagert werden",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_PRECONDITION = "Anmerkung: Um untenstehende Einstellungen verwenden zu können muss zuerst PAJunk aktiviert werden",

    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "Verhindere Verkauf von gesperrten Gegenständen",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Direkt an Händler/Hehler verkaufen?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "PABanking muss aktiviert sein",
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "PAJunk muss aktiviert sein",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "Weitere FCO ItemSaver Integrationen werden mit zukünftigen Updates dazukommen",
}

for key, value in pairs(PAIStrings) do
    SafeAddString(key, value, 1)
end
