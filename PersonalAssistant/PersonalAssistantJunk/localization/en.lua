local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    -- TODO: Refactor all texts below for PAJunk!
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk can directly mark items as junk if they match any of the configurable rules; except if it just was created or retrieved from mail",

    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = table.concat({" ", PAC.COLORS.LIGHT_BLUE, "Enable Auto-Marking of Items as Junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Automatically mark Items as Junk, depending on various different conditions?",

    SI_PA_MENU_JUNK_TRASH_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.JUNK.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] as junk?"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.COLLECTIBLES.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_COLLECTIBLE)}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] items"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Automatically mark items of with the indicator [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] as junk?"}),

    SI_PA_MENU_JUNK_WEAPONS_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.WEAPON.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON))}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON))}),
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_T = "???", -- TODO: add tooltip
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD = "If Weapon quality level is at or below",
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Weapons as Junk if they are of the selected quality or lower",

    SI_PA_MENU_JUNK_ARMOR_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.ARMOR.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_ARMOR))}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_ARMOR))}),
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_T = "???", -- TODO: add tooltip
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD = "If Armor quality level is at or below",
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Armor as Junk if it is of the selected quality or lower",

    SI_PA_MENU_JUNK_JEWELRY_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.JEWELRY.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))}), -- TODO: move to generic section
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY = table.concat({"Auto-Mark "}, zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))),
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_T = "???",  -- TODO: add tooltip
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD = "If Jewelry quality level is at or below",
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Jewelry as Junk if it is of the selected quality or lower",

    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Auto-Sell Junk at Merchants and Fences?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_T = "Automatically sell all items marked as junk when visiting a Merchant or a Fence?",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Auto-Mark [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait items"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Automatically mark items with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait (increased sell price) as junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Also mark Items that are part of a Set",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "If turned OFF, only items that are NOT belonging to a set will be marked as Junk\nRecommendation: OFF",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Also mark Items with unknown Traits",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "If turned OFF, only items with no Traits or known Traits will be marked as Junk\nRecommendation: OFF",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Quality", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Merchant", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_SOLD_JUNK_INFO = table.concat({PAC.COLORED_TEXTS.PAJ, "Sold junk items for ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d hours"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d minutes"}),
}

for key, value in pairs(PAJStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAJGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_HEADER = PAC.COLORED_TEXTS.PAJ,

    SI_PA_MENU_BANKING_CURRENCY = GetString(SI_INVENTORY_CURRENCIES),

    SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_ALLIANCE_POINTS].NORMAL, "  ", GetCurrencyName(CURT_ALLIANCE_POINTS)}),
    SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_TELVAR_STONES].NORMAL, "  ", GetCurrencyName(CURT_TELVAR_STONES)}),
    SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_WRIT_VOUCHERS].NORMAL, "  ", GetCurrencyName(CURT_WRIT_VOUCHERS)}),

    SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.BLACKSMITHING.LARGE, " ",  GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_BLACKSMITHING)}),
    SI_PA_MENU_BANKING_CRAFTING_CLOTHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.CLOTHING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_CLOTHING)}),
    SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.WOODWORKING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WOODWORKING)}),
    SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.JEWELCRAFTING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRYCRAFTING)}),
    SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ALCHEMY.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ALCHEMY)}),
    SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.ENCHANTING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ENCHANTING)}),
    SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.PROVISIONING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_PROVISIONING)}),
    SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.STYLEMATERIALS.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_STYLE_MATERIALS)}),
    SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_HEADER = table.concat({PAC.ICONS.CRAFTBAG.TRAITITEMS.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_TRAIT_ITEMS)}),
    SI_PA_MENU_BANKING_CRAFTING_FURNISHING_HEADER = table.concat({PAC.ICONS.CRAFTBAG.FURNISHING.LARGE, " ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_FURNISHING)}),

    SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF))}),
    SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE))}),
    SI_PA_MENU_BANKING_ADVANCED_WRITS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.MASTER_WRIT.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_MASTER_WRIT))}),
    SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)}),
    SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.POTION.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_POTION)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_POISON))}),
    SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER = table.concat({" ", PAC.ICONS.ITEMS.FOOD.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_FOOD)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_DRINK))}),

    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER = table.concat({" ", PAC.ICONS.ITEMS.TROPHY.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_TROPHY))}),

    SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER = table.concat({" ", PAC.ICONS.ITEMS.LOCKPICK.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_LOCKPICK))}),
    SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM))}),
    SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER = table.concat({" ", PAC.ICONS.ITEMS.GENERIC_HELP.NORMAL, "  ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC)}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR = "> %s",
    SI_PA_REL_NONE = "-",
}

for key, value in pairs(PAJGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
