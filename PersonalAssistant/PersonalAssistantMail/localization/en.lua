local PAC = PersonalAssistant.Constants
local PAMStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail Menu --
    SI_PA_MENU_MAIL_DESCRIPTION = "PAMail hopefully will be able to independently collect the materials sent to you by the Crafting Hirelings ;-)",

    SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Mail for Hireling Materials?"}),
    SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE_T = "Enable Auto Mail (read, loot, and delete) for Mails with Raw Materials from Hirelings?",
    SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS = "Delete empty Hireling Mails afterwards?",
    SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T = "After mails from Hirelings have been processed and their items looted, automatically delete the empty mails?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail --
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_ENCHANTING = "Raw Enchanter Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_WOODWORKING = "Raw Woodworker Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_CLOTHING = "Raw Clothier Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_BLACKSMITHING = "Raw Blacksmith Materials",
    SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_PROVISIONING = "Raw Provisioner Materials",
}

for key, value in pairs(PAMStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAMGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAMail Menu --
    SI_PA_MENU_MAIL_HEADER = PAC.COLORED_TEXTS.PAM,
}

for key, value in pairs(PAMGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
