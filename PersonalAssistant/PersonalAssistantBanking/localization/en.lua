local PAC = PersonalAssistant.Constants
local PABStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking can move Currencies, Crafting- and other Items between your character's backpack and the bank",

    SI_PA_MENU_BANKING_CURRENCY_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for ", GetString(SI_INVENTORY_CURRENCIES)}),
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Mininum to keep on character",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Maximum to keep on character",

    SI_PA_MENU_BANKING_CRAFTING = "Crafting",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Crafting Items"}),
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Crafting Items?",
    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Crafting Items",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = table.concat({PAC.COLORS.LIGHT_BLUE, "As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag"}),

    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING), " Items"}),
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS)}),
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS)}),
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_ITEMS_ENABLE = table.concat({"Deposit/Withdraw ", GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING)}),

    SI_PA_MENU_BANKING_ADVANCED = "Special",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Special Items"}),
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Special Items?",
    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Special Items",
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Glyphs",

    SI_PA_MENU_BANKING_INDIVIDUAL = "Individual",
    SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Individual Items"}),
    SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE_T = "Enable Auto Bank Deposit and Withdrawal for the different Individual Items?",
    SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION = "Define an individual behaviour (deposit, withdraw, or do nothing) for Individual Items",
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC = "Other",

    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK = "Amount to keep in backpack",
    SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T = "Define the amount which (based on the mathematical operator) shall be kept in the backpack",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_TYPE_ENABLE = "Deposit/Withdraw %s",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "Minimum amount of %s to always keep on the character; if necessary with additional withdrawals from the bank",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "Maximum amount of %s to always keep on the character; everything above this amount is deposited to the bank",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE = "Change all above %s Item dropdowns to",
    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_T = "Change all above %s Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",
    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "This cannot be undone; all individually selected values will be lost",

    SI_PA_MENU_BANKING_DEPOSIT_STACKING = "Stacking rule when depositing",
    SI_PA_MENU_BANKING_DEPOSIT_STACKING_T = "Define whether all Items shall be deposited, or only when there are existing stacks that can be completed",
    SI_PA_MENU_BANKING_WITHDRAWAL_STACKING = "Stacking rule when withdrawing",
    SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T = "Define whether all Items shall be withdrawn, or only when there are existing stacks that can be completed",

    SI_PA_MENU_BANKING_TRANSACTION_INTERVAL = "Interval between item transactions (msecs)",
    SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T = "The time in milliseconds between two consecutive item transactions. If too many item moves don't work, consider increasing this value.",

    SI_PA_MENU_BANKING_AUTOSTACKBAGS = "Auto-Stack all items when opening the bank",
    SI_PA_MENU_BANKING_AUTOSTACKBAGS_T = "Automatically stack all items in the bank and in the backpack when accessing the bank? Helps to keep everything better organized",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s withdrawn"}),
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn (Bank is empty)"}),
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn (Not enough space on character)"}),

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s deposited"}),
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited (Character is empty)"}),
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited (Not enough space in bank)"}),

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s moved to %s"}),
    SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAB, "%d/%d x %s moved to %s"}),
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Not enough space!"}),
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Window was closed!"}),
}

for key, value in pairs(PABStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PABGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_HEADER = PAC.COLORED_TEXTS.PAB,

    SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_ALLIANCE_POINTS].NORMAL, "  ", GetCurrencyName(CURT_ALLIANCE_POINTS)}),
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_TELVAR_STONES].NORMAL, "  ", GetCurrencyName(CURT_TELVAR_STONES)}),
    SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_WRIT_VOUCHERS].NORMAL, "  ", GetCurrencyName(CURT_WRIT_VOUCHERS)}),

    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.BLACKSMITHING.LARGE, " ",  GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING)}),
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.CLOTHING.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING)}),
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.WOODWORKING.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING)}),
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.JEWELCRAFTING.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING)}),
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ALCHEMY.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY)}),
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ENCHANTING.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING)}),
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.PROVISIONING.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING)}),
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.STYLEMATERIALS.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS)}),
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.TRAITITEMS.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS)}),
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.FURNISHING.LARGE, " ", GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING)}),

    SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_WRITS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MASTER_WRIT.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_MASTER_WRIT), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)}),
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.POTION.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_POTION), 2), " & ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_POISON), 2)}),
    SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.FOOD.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_FOOD), 2), " & ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_DRINK), 2)}),

    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER = table.concat({" ", PAC.ICONS.ITEMS.TROPHY.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2)}),

    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER = table.concat({" ", PAC.ICONS.ITEMS.LOCKPICK.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_LOCKPICK), 2)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GENERIC_HELP.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC)}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
}

for key, value in pairs(PABGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
