local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk can mark items as junk if they match any of the selectable conditions; except if it just was crafted or retrieved from mail",

    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto-Marking of Items as Junk"}),

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] as junk?"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"Do NOT mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items as junk if . . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("Nibbles and Bits"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following trash items will NOT be marked as Junk:\n[Carapace]\n[Foul Hide]\n[Daedra Husks]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("Morsels and Pecks"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following trash items will NOT be marked as Junk:\n[Elemental Essence]\n[Supple Roots]\n[Ectoplasm]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] items"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Automatically mark items with the indicator [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] as junk?"}),

    SI_PA_MENU_JUNK_TREASURES_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] items"}),
    SI_PA_MENU_JUNK_TREASURES_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] as junk?"}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"Do NOT mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] items as junk if . . ."}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("A Matter of Leisure"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following treasure items will NOT be marked as Junk:\n[Children's Toys]\n[Dolls]\n[Games]"}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("A Matter of Respect"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following treasure items will NOT be marked as Junk:\n[Utensils]\n[Drinkware]\n[Dishes and Cookware]"}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("A Matter of Tributes"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following treasure items will NOT be marked as Junk:\n[Cosmetics]\n[Grooming Items]"}),

    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Auto-Sell Junk at Merchants and Fences?",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "Keybindings",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK = "Show \"Mark / Unmark as Junk\" Keybinding",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM = "Show \"Destroy Item\" Keybinding",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "Auto-Mark %s with quality at or below",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark %s as Junk if they are of the selected quality or lower",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Auto-Mark %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Automatically mark %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait (increased sell price) as junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Also mark %s that are part of a Set",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "If turned OFF, only %s that are NOT belonging to a set will be marked as Junk",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE = table.concat({"Also mark %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] trait"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T = table.concat({"If turned OFF, %s with the [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] trait will NOT be marked as Junk (independent of their quality)"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Also mark %s with unknown Traits",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "If turned OFF, only %s with no Traits or known Traits will be marked as Junk",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Quality", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Merchant", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Treasure", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({PAC.COLORED_TEXTS.PAJ, "Moved %s to junk (", PAC.COLORS.ORANGE, "Manual", PAC.COLORS.DEFAULT, ")"}),
    SI_PA_CHAT_JUNK_SOLD_JUNK_INFO = table.concat({PAC.COLORED_TEXTS.PAJ, "Sold junk items for ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d hours"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d minutes"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({PAC.COLORED_TEXTS.PAJ, "Cannot sell %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM = "Mark / Unmark as Junk",
    SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM = "Destroy Item",


    -- =================================================================================================================
    -- == OTHER STRINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Quest: "A Matter of Leisure"
    SI_PA_TREASURE_ITEM_TAG_DESC_TOYS = "Children's Toys",
    SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS = "Dolls",
    SI_PA_TREASURE_ITEM_TAG_DESC_GAMES = "Games",

    -- Quest: "A Matter of Respect"
    SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS = "Utensils",
    SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE = "Drinkware",
    SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE = "Dishes and Cookware",

    -- Quest: "A Matter of Tributes"
    SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS = "Cosmetics",
    SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING = "Grooming Items",
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

    SI_PA_MENU_JUNK_TRASH_HEADER = GetString("SI_ITEMTYPE", ITEMTYPE_TRASH),
    SI_PA_MENU_JUNK_COLLECTIBLES_HEADER = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COLLECTIBLE)),
    SI_PA_MENU_JUNK_MISCELLANEOUS_HEADER = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_MISCELLANEOUS),
    SI_PA_MENU_JUNK_WEAPONS_HEADER = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)),
    SI_PA_MENU_JUNK_ARMOR_HEADER = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)),
    SI_PA_MENU_JUNK_JEWELRY_HEADER = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
}

for key, value in pairs(PAJGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
