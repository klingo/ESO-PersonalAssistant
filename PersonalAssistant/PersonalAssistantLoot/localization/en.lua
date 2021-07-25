local PAC = PersonalAssistant.Constants
local PALStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot can inform you about items of special interest such as unknown recipes, motifs, or traits",

    -- PALoot Loot Events --
    SI_PA_MENU_LOOT_EVENTS_HEADER = "Loot Events",
    SI_PA_MENU_LOOT_EVENTS_ENABLE = "Enable Loot Events",

    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({"When Looting ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = table.concat({"> a ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " is unknown"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = table.concat({"Whenever a ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " is looted that is not yet known by this character, a message is displayed in the chat"}),

    -- Loot Motifs & Style Pages
    SI_PA_MENU_LOOT_STYLES_HEADER = "When Looting Styles",
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = table.concat({"> a ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " is unknown"}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = table.concat({"Whenever a ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " is looted that is not yet known by this character, a message is displayed in the chat"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG = table.concat({"> a ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " is unknown"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T = table.concat({"Whenever a ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " is looted that is not yet known by this character, a message is displayed in the chat"}),

    -- Loot Equipment (Apparel, Weapons & Jewelries)
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = "When Looting Equipment",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "> a Trait is not yet researched",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = table.concat({"Whenever an ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", a ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", or ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " is looted that has a trait that is not yet researched by this character, a message is displayed in the chat"}),
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG = "> a Set item is not yet collected",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG_T = table.concat({"Whenever an ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", a ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", or ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " is looted that is part of a set and is not yet added to the set collection, a message is displayed in the chat"}),

    -- Loot Companion Items
    SI_PA_MENU_LOOT_COMPANION_ITEMS_HEADER = table.concat({"When Looting ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD = table.concat({"> looting ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " with quality at or above"}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD_T = table.concat({"Whenever ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " are looted that are of the selected quality level or higher, a message is displayed in the chat"}),

    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "Warn when low on inventory space",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T = "Display a warning in the chat window if you are low on inventory space",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "Inventory space threshold",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "If the remaining free inventory space is at or below this threshold, a message is displayed in the chat window",

    -- PALoot Mark Items --
    SI_PA_MENU_LOOT_ICONS_HEADER = "Item Icons",
    SI_PA_MENU_LOOT_ICONS_ENABLE = "Enable Item Icons",
    SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP = "Display icon tooltip",

    -- Mark Recipes --
    SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER = table.concat({"Marking ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "when a ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " is already known"}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "when a ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " is still unknown"}),

    -- Mark Motifs and Style Page Containers --
    SI_PA_MENU_LOOT_ICONS_STYLES_HEADER = "Marking Styles",
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "when a ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " is already known"}),
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "when a ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " is still unknown"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "when a ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " is already known"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "when a ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " is still unknown"}),

    -- Mark Equipment (Apparel, Weapons & Jewelries) --
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER = "Marking Equipment",
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "when an Item Trait is already researched"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "when an Item Trait is still unknown"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SET_UNCOLLECTED = table.concat({">", PAC.ICONS.OTHERS.UNCOLLECTED.NORMAL, "when an Item is missing in the Set collection"}),

    -- Mark Companion Items --
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_HEADER = table.concat({"Marking ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_SHOW_ALL = table.concat({">", PAC.ICONS.OTHERS.COMPANION.NORMAL, "when an item is a companion item"}),

    -- Item Icon Positioning --
    SI_PA_MENU_LOOT_ICONS_POSITIONING_DESCRIPTION = "Below you can adjust the positioning and size of the item icons",
    SI_PA_MENU_LOOT_ICONS_KNOWN_UNKNOWN_HEADER = "Known/Unknown",
    SI_PA_MENU_LOOT_ICONS_SET_COLLECTION_HEADER = "Uncollected Sets",
    SI_PA_MENU_LOOT_ICONS_COMPANION_ITEMS_HEADER = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION),

    SI_PA_MENU_LOOT_ICONS_SIZE_LIST = "Icon Size (List View)",
    SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T = "Define the size of the known/unknown icons in places where items are displayed in a list view",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID = "Icon Size (Grid View)",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T = "Define the size of the known/unknown icons in places where items are displayed in a grid view",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST = "Icon X Offset (List View)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T = "Define the horizontal offset of the known/unknown icon in the list view",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST = "Icon Y Offset (List View)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T = "Define the vertical offset of the known/unknown icon in the list view",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID = "Icon X Offset (Grid View)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T = "Define the horizontal offset of the known/unknown icon in the grid view",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID = "Icon Y Offset (Grid View)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T = "Define the vertical offset of the known/unknown icon in the grid view",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s can be ", PAC.COLORS.ORANGE,"learned", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s can be ", PAC.COLORS.ORANGE,"learned", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s has [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] that can be researched!"}),
    SI_PA_CHAT_LOOT_SET_UNCOLLECTED = table.concat({PAC.ICONS.OTHERS.UNCOLLECTED.SMALL, "%s is missing in set collection!"}),
    SI_PA_CHAT_LOOT_COMPANION_ITEM = table.concat({PAC.ICONS.OTHERS.COMPANION.SMALL, "%s new companion item with ", PAC.COLOR.WHITE:Colorize("%s"), " trait!"}),

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({"%sYou have <<1[", PAC.COLORS.WHITE,"no/only ", PAC.COLORS.WHITE, "%d/only ", PAC.COLORS.WHITE, "%d]>> %s<<1[inventory space/inventory space/inventory spaces]>> left!"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({"%sYou have <<1[", PAC.COLORS.WHITE,"no/only ", PAC.COLORS.WHITE, "%d/only ", PAC.COLORS.WHITE, "%d]>> %s<<1[Repair Kits/Repair Kit/Repair Kits]>> left!"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({"%sYou have <<1[", PAC.COLORS.WHITE,"no/only ", PAC.COLORS.WHITE, "%d/only ", PAC.COLORS.WHITE, "%d]>> %s<<1[Soul Gems/Soul Gem/Soul Gems]>> left!"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_DISPLAY_A_MESSAGE_WHEN = "Display a message when . . .",
    SI_PA_MARK_WITH = "Mark with . . .",
    SI_PA_ITEM_KNOWN = "Already known",
    SI_PA_ITEM_UNKNOWN = "Unknown",
    SI_PA_ITEM_UNCOLLECTED = "Uncollected",
    SI_PA_ITEM_COMPANION_ITEM = "Companion Item"
}

for key, value in pairs(PALStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
