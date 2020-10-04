local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk can mark items as junk if they match any of the selectable conditions; except if it just was crafted or retrieved from mail",

    -- Standard Items --
    SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER = "Standard Items",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = "Enable Auto-Marking of Items as Junk",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Only applicable to 'Standard Items'. Custom Junk Rules are not impacted by this toggle and need to be deactivated individually if they should not be executed anymore.",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] as junk?"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"Do NOT mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] items as junk if . . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("Nibbles and Bits"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following trash items will NOT be marked as Junk:\n[Carapace]\n[Foul Hide]\n[Daedra Husks]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("Morsels and Pecks"), " Daily Quest"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following trash items will NOT be marked as Junk:\n[Elemental Essence]\n[Supple Roots]\n[Ectoplasm]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] items"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Automatically mark items with the indicator [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] as junk?"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_ITEMS_DESC = table.concat({"Do NOT mark [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] items as junk if . . ."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH = table.concat({"> [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH), "] needed for ", PAC.COLOR.YELLOW:Colorize("Fish Boon Feast"), " Daily Quest"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest during: "), PAC.COLOR.ORANGE:Colorize("New Life Festival"), " that happens sometime in winter\nIf turned ON, all [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH),"] will NOT be marked as Junk"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK = table.concat({"Auto-Mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] items"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK_T = table.concat({"Automatically mark items of type [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] as junk?"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"Do NOT destroy or mark [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] items as junk if . . ."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("A Matter of Leisure"), " Daily Quest"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following treasure items will NOT be marked as Junk:\n[Children's Toys]\n[Dolls]\n[Games]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("A Matter of Respect"), " Daily Quest"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following treasure items will NOT be marked as Junk:\n[Utensils]\n[Drinkware]\n[Dishes and Cookware]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> needed for ", PAC.COLOR.YELLOW:Colorize("A Matter of Tributes"), " Daily Quest"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Clockwork City"), "\nIf turned ON, the following treasure items will NOT be marked as Junk:\n[Cosmetics]\n[Grooming Items]"}),

    -- Stolen Items --
    SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER = "Stolen Items",
    SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER = "When stealing [%s]",

    -- Quest Items --
    SI_PA_MENU_JUNK_QUEST_ITEMS_HEADER = "Protecting Quest Items",
    SI_PA_MENU_JUNK_QUEST_CLOCKWORK_CITY_HEADER = "Clockwork City",
    SI_PA_MENU_JUNK_QUEST_NEW_LIFE_FESTIVAL_HEADER = "New Life Festival",

    -- Custom Items --
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER = "Custom Items",
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Auto-Destroy --
    SI_PA_MENU_JUNK_AUTO_DESTORY_JUNK_HEADER = "Auto-Destroy Junk",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK = "Enable Auto-Destroy of worthles Junk items",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T = "When looting a worthless item (sell value = 0g) that would automatically be marked as junk, with this setting turned ON it will be destroyed instead. This cannot be reverted!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W = "WARNING: Please be aware that using this setting, there is NO prompt message to double-confirm if the item really can be destroyed.\nIt is just going to be destroyed!\nForever!\nUse at your own risk!",

    -- Other Settings --
    SI_PA_MENU_JUNK_MAILBOX_IGNORE = "Never mark items received from Mailbox as Junk",
    SI_PA_MENU_JUNK_MAILBOX_IGNORE_T = "Items that are received from Mailbox should never be marked as Junk",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE = "Never mark items you have crafted as Junk",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE_T = "Item that you have crafted at a Crafting Station should never be marked as Junk",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Auto-Sell Junk at Merchants and Fences?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI = "Also auto-sell to Pirharri? (Fence Assistant)",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI_W = "Unlike other fences, Pirharri charges a Smuggler's Fee of 35% for availing of her service",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "Keybindings",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE = "Enable \"Mark / Unmark as Junk\" Keybinding",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW = "Show \"Mark / Unmark as Junk\" Keybinding",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE = "Enable \"Destroy Item\" Keybinding",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W = "WARNING: Please be aware that using this keybinding, there is NO prompt message to double-confirm if the item really can be destroyed.\nIt is just going to be destroyed!\nForever!\nUse at your own risk!",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW = "Show \"Destroy Item\" Keybinding",
    SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION = "Disable the  \"Destroy Item\" Keybinding if the item . . .",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD = "> is of the selected quality or higher",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN = "> can be learned/researched and is unknown",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "Auto-Mark %s with quality at or below",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically mark %s as Junk if they are of the selected quality or lower",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Auto-Mark %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Automatically mark %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait (increased sell price) as junk?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Also mark %s that are part of a Set",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "If turned OFF, only %s that are NOT belonging to a set will be marked as Junk",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE = table.concat({"Also mark %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] trait"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T = table.concat({"If turned OFF, %s with the [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] trait will NOT be marked as Junk (independent of their quality)"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS = "Also mark %s with known Traits",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "If turned OFF, only %s with no Traits or unknown Traits will be marked as Junk",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Also mark %s with unknown Traits",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "If turned OFF, only %s with no Traits or known Traits will be marked as Junk",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_MAINMENU_JUNK_HEADER = "Junk Rules",

    SI_PA_MAINMENU_JUNK_HEADER_ITEM = "Item",
    SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT = "Junk Count",
    SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK = "Last junk",
    SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED = "Rule added",
    SI_PA_MAINMENU_JUNK_HEADER_ACTIONS = "Actions",

    SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED = "never",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize("Quality"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize("Merchant"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize("Treasure"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize("Manual"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize("Stolen"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT = table.concat({"Moved %s to junk (", PAC.COLOR.ORANGE:Colorize("Perm-Rule"), ")"}),

    SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Destroyed"), " %d x %s"}),
    SI_PA_CHAT_JUNK_DESTROYED_ALWAYS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Destroyed"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Always"), ")"}),
    SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Destroyed"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Worthless"), ")"}),
    SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_ON = table.concat({"Auto-Destroy of worthless Junk items has been turned ", PAC.COLOR.RED:Colorize("ON")}),
    SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_OFF = table.concat({"Auto-Destroy of worthless Junk items has been turned ", PAC.COLOR.GREEN:Colorize("OFF")}),

    SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO = "Sold items for %s",
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d hours"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Please wait ~%d minutes"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({"Cannot sell %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),
    SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM = "Cannot sell %s",

    SI_PA_CHAT_JUNK_RULES_ADDED = table.concat({"%s was ", PAC.COLOR.ORANGE:Colorize("added"), " to permanent junk list!"}),
    SI_PA_CHAT_JUNK_RULES_DELETED = table.concat({"%s was ", PAC.COLOR.ORANGE:Colorize("removed"), " from permanent junk list!"}),


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
