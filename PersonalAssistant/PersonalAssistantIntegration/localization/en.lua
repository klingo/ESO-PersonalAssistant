local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration can integrate functionality of PersonalAssistant addons with other third-party addons such as Dolgubon's Lazy Writ Crafter or FCO ItemSaver",
    SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE = "You currently do not have any addons installed/enabled that are supported by PAIntegration",

    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_PRECONDITION = "Note: In order to make use of below setting, you must enable PABanking first",

    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Compatibility with Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "When you have active Writ Crafting quests and 'Withdraw writ items' is enabled in Dolgubon's Lazy Writ Crafter, then for these items the 'Deposit to Bank' setting is ignored. This is to avoid having withdrawn items immediately re-deposited",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_PRECONDITION = "Note: In order to make use of below settings, you must enable PAJunk first",

    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "Prevent Auto-Sell of items that are Locked",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Auto-Sell marked items at Merchants/Fences?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "Requires PABanking to be enabled",
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "Requires PAJunk to be enabled",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "More FCO ItemSaver integrations will come with future updates",
}

for key, value in pairs(PAIStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAIGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_HEADER = "Dolgubon's Lazy Writ Crafter",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_HEADER = "FCO Item Saver",
}

for key, value in pairs(PAIGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
