local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    -- TODO: Refactor all texts below for PAJunk!
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk can mark items as junk if they match any of the configurable rules; except if it just was crafted or retrieved from mail",

    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto-Marking of Items as Junk"}),
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Automatically mark Items as Junk, depending on various different conditions?",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] as junk?"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] items"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Automatically mark items of with the indicator [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] as junk?"}),

    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON)), " with quality at or below"}),
    SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Weapons as Junk if they are of the selected quality or lower",

    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_ARMOR)), " with quality at or below"}),
    SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Armor as Junk if it is of the selected quality or lower",

    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD = table.concat({"Auto-Mark ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)), " with quality at or below"}),
    SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark Jewelry as Junk if it is of the selected quality or lower",

    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Auto-Sell Junk at Merchants and Fences?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_T = "Automatically sell all items marked as junk when visiting a Merchant or a Fence?",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Auto-Mark Items with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait"}),
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

    SI_PA_MENU_JUNK_TRASH_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.JUNK.NORMAL, "  ", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)}),
    SI_PA_MENU_JUNK_COLLECTIBLES_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.COLLECTIBLES.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_COLLECTIBLE))}),
    SI_PA_MENU_JUNK_WEAPONS_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.WEAPON.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_WEAPON))}),
    SI_PA_MENU_JUNK_ARMOR_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.ARMOR.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", ITEMTYPE_ARMOR))}),
    SI_PA_MENU_JUNK_JEWELRY_HEADER = table.concat({" ", PAC.ICONS.CRAFTBAG.JEWELRY.NORMAL, "  ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
}

for key, value in pairs(PAJGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
