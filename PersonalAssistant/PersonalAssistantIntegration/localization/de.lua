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
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Kompatibilität mit Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "Wenn du aktive Schrieb Quests hast und 'Gegenstände entnehmen' in Dolgubon's Lazy Writ Crafter aktiviert ist, dann wird für diese Gegenstände  die 'In Truhe einlagern' Einstellung ignoriert. Dadurch sollen eben entnommene Gegenstände nicht wieder direkt eingelagert werden",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "Verhindere Verkauf von gesperrten Gegenständen",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING = "Verhindere Verschieben von gesperrten Gegenständen",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING_T = "Wenn EINgeschaltet, werden Gegenstände die durch FCO ItemSaver gesperrt sind weder in die Truhe eingelagert, noch davon entnommen",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Direkt an Händler/Hehler verkaufen?",
    SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED = "Verschieben von markierten Gegenständen?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "Weitere Einstellungen werden sichtbar wenn PABanking aktiviert ist",
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "Weitere Einstellungen werden sichtbar wenn PAJunk aktiviert ist",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "Weitere FCO ItemSaver Integrationen werden mit zukünftigen Updates dazukommen",
}

for key, value in pairs(PAIStrings) do
    SafeAddString(_G[key], value, 1)
end
