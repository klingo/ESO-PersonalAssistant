local PAC = PersonalAssistant.Constants
local PALStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot puede informarte sobre objetos de especial interés como recetas desconocidas, motivos, o rasgos",

    -- PALoot Loot Events --
    SI_PA_MENU_LOOT_EVENTS_HEADER = "Eventos de Botín",
    SI_PA_MENU_LOOT_EVENTS_ENABLE = "Activar Eventos de Botín",

    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({"Cuando Saqueas ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = table.concat({"> una ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " es desconocida"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = table.concat({"Siempre que una ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " es un botín que no es todavía conocido por este personaje, un mensaje es mostrado en el chat"}),
    
	SI_PA_MENU_LOOT_AUTO_LEARN_RECIPES = table.concat({"Auto-aprende la ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE)}),
    SI_PA_MENU_LOOT_AUTO_LEARN_RECIPES_T = table.concat({"Siempre que una ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " es un botín que no es todavía conocido por este personaje, lo auto-aprenderá"}),

    -- Loot Motifs & Style Pages
    SI_PA_MENU_LOOT_STYLES_HEADER = "Cuando Saqueas Estilos",
	
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = table.concat({"> un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " es desconocido"}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = table.concat({"Siempre que un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " es un botín que no es todavía conocido por este personaje, un mensaje es mostrado en el chat"}),
 
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG = table.concat({"> un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " es desconocido"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T = table.concat({"Siempre que un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " es un botín que no es todavía conocido por este personaje, un mensaje es mostrado en el chat"}),
	
	SI_PA_MENU_LOOT_AUTO_LEARN_MOTIFS = table.concat({"Auto-aprende el ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF)}),
	SI_PA_MENU_LOOT_AUTO_LEARN_MOTIFS_T = table.concat({"Siempre que un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " es un botín que no es todavía conocido por este personaje, lo auto-aprenderá"}),

    SI_PA_MENU_LOOT_AUTO_LEARN_STYLEPAGES = table.concat({"Auto-aprende el ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE)}),
	SI_PA_MENU_LOOT_AUTO_LEARN_STYLEPAGES_T = table.concat({"Siempre que un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " es un botín que no es todavía conocido por este personaje, lo auto-aprenderá"}),


    -- Loot Equipment (Apparel, Weapons & Jewelries)
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = "Cuando Saqueas Equipo",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "> un Rasgo no esta todavía investigado",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = table.concat({"Siempre que un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", o una ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " es un botín que no tiene un rasgo que no es todavía investigado por este personaje, un mensaje es mostrado en el chat"}),
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG = "> un Objeto de un Conjunto no esta en tu colección",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG_T = table.concat({"Siempre que un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ", o una ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), " es un botín que es parte de un conjunto y no esta todavía añadido a tu colección de atuendos, un mensaje es mostrado en el chat"}),

    -- Loot Companion Items
    SI_PA_MENU_LOOT_COMPANION_ITEMS_HEADER = table.concat({"Cuando Saqueas ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD = table.concat({"> saqueando ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " con calidad igual o menor a:"}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD_T = table.concat({"Siempre que un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), " es un botín que es del nivel de calidad seleccionado o mayor, un mensaje es mostrado en el chat"}),

    -- Auto Fillet common fish
    SI_PA_MENU_LOOT_AUTO_FILLET_HEADER = table.concat({"Cuando Saqueas un ", GetString("SI_ITEMTYPE", ITEMTYPE_FISH)}),
    SI_PA_MENU_LOOT_AUTO_FILLET = "Auto filetea el pescado común",
    SI_PA_MENU_LOOT_AUTO_FILLET_T = "Auto filetea el pescado común para obtener un Pescado o Huevas Perfectas",


    -- Inventory space warning --
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "Advertir cuando hay poco espacio en el inventario",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T = "Muestra una advertencia en la ventana del chat si tu tienes poco espacio en el inventario",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "Umbral para advertir el espacio del inventario",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "Si el espacio del inventario libre es igual o menor al umbral, un mensaje es mostrado en la ventana del chat",

    -- PALoot Mark Items --
    SI_PA_MENU_LOOT_ICONS_HEADER = "Iconos de Objetos",
    SI_PA_MENU_LOOT_ICONS_ENABLE = "Activar los Iconos de los Objetos",
    SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP = "Mostrar un texto de información del icono",

    -- Mark Recipes --
    SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER = table.concat({"Marcar una ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "cuando un ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " es ya conocido"}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "cuando un ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " es todavía desconocido"}),

    -- Mark Motifs and Style Page Containers --
    SI_PA_MENU_LOOT_ICONS_STYLES_HEADER = "Marcar un Estilo",
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "cuando un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " es ya conocido"}),
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "cuando un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " es todavía desconocido"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "cuando un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " es ya conocido"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "cuando un ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), " es todavía desconocido"}),

    -- Mark Equipment (Apparel, Weapons & Jewelries) --
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER = "Marcar un Equipo",
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "cuando un Objeto con Rasgo esta ya investigado"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "cuando un Objeto con Rasgo es todavía desconocido"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SET_UNCOLLECTED = table.concat({">", PAC.ICONS.OTHERS.UNCOLLECTED.NORMAL, "cuando un Objeto esta faltando en la Colección de Atuendos"}),

    -- Mark Companion Items --
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_HEADER = table.concat({"Marca un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_SHOW_ALL = table.concat({">", PAC.ICONS.OTHERS.COMPANION.NORMAL, "cuando un objeto es un objeto de compañero"}),

    -- Item Icon Positioning --
    SI_PA_MENU_LOOT_ICONS_POSITIONING_DESCRIPTION = "Debajo de ti puedes ajustar la posición y el tamaño de los iconos de los objetos",
    SI_PA_MENU_LOOT_ICONS_KNOWN_UNKNOWN_HEADER = "Conocido/Desconocido",
    SI_PA_MENU_LOOT_ICONS_SET_COLLECTION_HEADER = "Atuendo no Coleccionado",
    SI_PA_MENU_LOOT_ICONS_COMPANION_ITEMS_HEADER = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION),

    SI_PA_MENU_LOOT_ICONS_SIZE_LIST = "Tamaño del Icono (Vista de la Lista)",
    SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T = "Define el tamaño de los iconos de conocidos/desconocidos en los lugares donde los objetos son mostrados en una vista de la lista",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID = "Tamaño del Icono (Vista de la Cuadrícula)",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T = "Define el tamaño de los iconos de conocidos/desconocidos en los lugares donde los objetos son mostrados en una vista de la cuadrícula",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST = "Desplazamiento del Icono en el Eje X (Vista de la Lista)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T = "Define el desplazamiento horizontal de los iconos de conocidos/desconocidos en una vista de la lista",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST = "Desplazamiento del Icono en el Eje Y (Vista de la Lista)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T = "Define el desplazamiento vertical de los iconos de conocidos/desconocidos en una vista de la lista",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID = "Desplazamiento del Icono en el Eje X (Vista de la Cuadrícula)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T = "Define el desplazamiento horizontal de los iconos de conocidos/desconocidos en una vista de la cuadrícula",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID = "Desplazamiento del Icono en el Eje Y (Vista de la Cuadrícula)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T = "Define el desplazamiento vertical de los iconos de conocidos/desconocidos en una vista de la cuadrícula",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({"¡", PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s puede ser ", PAC.COLORS.ORANGE,"aprendido", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({"¡", PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s puede ser ", PAC.COLORS.ORANGE,"aprendido", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({"¡", PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s tiene [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] que puede ser investigado!"}),
    SI_PA_CHAT_LOOT_SET_UNCOLLECTED = table.concat({"¡", PAC.ICONS.OTHERS.UNCOLLECTED.SMALL, "%s esta faltando en tu colección de atuendos!"}),
    SI_PA_CHAT_LOOT_COMPANION_ITEM = table.concat({"¡", PAC.ICONS.OTHERS.COMPANION.SMALL, "%s nuevo objeto de compañero con rasgo de tipo ", PAC.COLOR.WHITE:Colorize("%s"), "!"}),
	SI_PA_CHAT_LOOT_AUTO_FILLET = "%s esta siendo auto fileteado.",
	

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({"%sTienes <<1[", PAC.COLORS.WHITE,"no/solamente ", PAC.COLORS.WHITE, "%d/solamente ", PAC.COLORS.WHITE, "%d]>> %s<<1[espacio del inventario faltante/espacio del inventario faltante/espacios del inventario faltantes]>>!"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({"%sTienes <<1[", PAC.COLORS.WHITE,"no/solamente ", PAC.COLORS.WHITE, "%d/solamente ", PAC.COLORS.WHITE, "%d]>> %s<<1[Kits de Reparación/Kits de Reparación/Kits de Reparación]>> faltantes!"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({"%sTienes <<1[", PAC.COLORS.WHITE,"no/solamente ", PAC.COLORS.WHITE, "%d/solamente ", PAC.COLORS.WHITE, "%d]>> %s<<1[Joyas del Alma faltantes/Joya del Alma faltante/Joyas del Alma faltante]>>!"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_DISPLAY_A_MESSAGE_WHEN = "Muestra un mensaje cuando . . .",
    SI_PA_MARK_WITH = "Marcar con . . .",
    SI_PA_ITEM_KNOWN = "Ya conocido",
    SI_PA_ITEM_UNKNOWN = "Desconocido",
    SI_PA_ITEM_UNCOLLECTED = "No Coleccionado",
    SI_PA_ITEM_COMPANION_ITEM = "Objetos de Compañero"
}

for key, value in pairs(PALStrings) do
    SafeAddString(_G[key], value, 1)
end
