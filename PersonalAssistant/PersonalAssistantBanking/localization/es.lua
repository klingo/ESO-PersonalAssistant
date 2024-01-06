local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk puede marcar objetos como basura si coinciden con alguna de las condiciones seleccionables; excepto si solo fue elaborado o recuperado del correo",

    -- Standard Items --
    SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER = "Objetos Estándar",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = "Activa el Auto-Marcado de Objetos como Basura",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Es solamente aplicable a 'Objetos Estándar'. Reglas de Basura Personalizada no impactan para esta opción y necesita ser desactivada individualmente si ellos no deberían ser ejecutadas más.",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Auto-Marcar objetos de tipo [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]."}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"¿Quieres automáticamente marcar objetos de tipo [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] como basura?"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"NO marcar los objetos de tipo [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] como basura si es . . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("Bocados y Pedacitos"), "."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Misión en: "), PAC.COLOR.ORANGE:Colorize("Ciudad Mecánica"), "\nSi esta ACTIVO, los siguientes objetos de basura NO serán marcados como Basura:\n[Carapacho]\n[Piel Asquerosa]\n[Cáscara de Daedra]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("Bocados y Picotazos"), "."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Misión en: "), PAC.COLOR.ORANGE:Colorize("Ciudad Mecánica"), "\nSi esta ACTIVO, los siguientes objetos de basura NO serán marcados como Basura:\n[Esencia Elemental]\n[Raíces flexibles]\n[Ectoplasma]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Auto-Marcar objetos de tipo [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"¿Quieres automáticamente marcar objetos de tipo [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] como basura?"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_ITEMS_DESC = table.concat({"NO marcar los objetos de tipo [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] como basura si es . . ."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH = table.concat({"> [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH), "] es necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("Fish Boon Feast"), "."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH_T = table.concat({PAC.COLOR.YELLOW:Colorize("Durante la misión: "), PAC.COLOR.ORANGE:Colorize("Festival de la Nueva Vida"), " que se da algunas veces en invierno.\nSi esta ACTIVO, todo tipo de [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH),"] NO serán marcados como Basura"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK = table.concat({"Auto-Marcar objetos de tipo [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK_T = table.concat({"¿Quieres automáticamente marcar objetos de tipo [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] como basura?"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"NO destruir o marcar los objetos de tipo [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] como basura si es . . ."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({"> necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("Una Cuestión de Ocio"), "."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("Misión en: "), PAC.COLOR.ORANGE:Colorize("Ciudad Mecánica"), "\nSi esta ACTIVO, los siguientes objetos de tipo Tesoro NO serán marcados como Basura:\n[Juguete para Niños]\n[Muñecas]\n[Juegos]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({"> necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("Una Cuestión de Respeto"), "."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("Misión en: "), PAC.COLOR.ORANGE:Colorize("Ciudad Mecánica"), "\nSi esta ACTIVO, los siguientes objetos de tipo Tesoro NO serán marcados como Basura:\n[Utensilios]\n[Vasos]\n[Platos y utensilios de cocina]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("Una Cuestión de Tributos"), "."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("Misión en: "), PAC.COLOR.ORANGE:Colorize("Ciudad Mecánica"), "\nSi esta ACTIVO, los siguientes objetos de tipo Tesoro NO serán marcados como Basura:\n[Cosméticos]\n[Artículos de aseo]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS = table.concat({"> necesario para la misión diaria de ", PAC.COLOR.YELLOW:Colorize("La Condesa Codiciosa"), "."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Misión en: "), PAC.COLOR.ORANGE:Colorize("Gremio de Ladrones"), "\nSi esta ACTIVO, los siguientes objetos de tipo Tesoro NO serán marcados como Basura:\n[Cosméticos]\n[Productos secos (Ropa de cama)]\n[Accesorios de Guardarropa]\n\n[Vasos]\n[Utensilios]\n[Platos y utensilios de cocina]\n\n[Juegos]\n[Muñecas]\n[Estatuas]\n\n[Escritos] & [Suministro para escribanos]\n[Mapas]\n\n[Objetos de Ritual]\n[Rarezas]"}),
 
    -- Stolen Items --
    SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER = "Objetos Robados",
    SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER = "Auto-Marcar objetos robados de tipo [%s]",

    -- Custom Items --
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER = "Objetos Personalizados",
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Quest Items --
    SI_PA_MENU_JUNK_QUEST_ITEMS_HEADER = "Protección de Objeto de Misiones",
    SI_PA_MENU_JUNK_QUEST_CLOCKWORK_CITY_HEADER = "Ciudad Mecánica",
    SI_PA_MENU_JUNK_QUEST_THIEVES_GUILD_HEADER = "Gremio de Ladrones",
    SI_PA_MENU_JUNK_QUEST_NEW_LIFE_FESTIVAL_HEADER = "Festival de la Nueva Vida",

    -- Auto-Sell --
    SI_PA_MENU_JUNK_AUTO_SELL_JUNK_HEADER = "Auto-vender basura",

    -- Auto-Destroy --
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_HEADER = "Auto-destruir basura",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK = "Activar auto-destruir los objetos de tipo basura",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T = "Cuando saqueas un objeto que debería estar marcado como basura y tiene un (Comerciante) valor de venta y la calidad del objeto es igual o menor al elegido, entonces con esta configuración este ACTIVO será destruido. ¡Esto no puede ser revertido!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W = "PELIGRO: Por favor tener en cuenta que al usar esta configuración, NO hay un mensaje de doble-confirmación si el objeto realmente puede ser destruido.\n¡Solamente sera destruido!\n¡Para Siempre!\n¡Úselo bajo tu propio riesgo!",

    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_JUNK_HEADER = "Basura",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD = "SI el valor de venta del mercader is igual o menor a:",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD_T = "Solamente se auto-destruirá los objetos cuando su valor de venta del mercader es igual o menor al elegido. ¡Una vez un objeto es destruido, no puede ser revertido!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD = "Y la calidad del objeto es igual o menor a:",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD_T = "Solamente se auto-destruirá los objetos cuando su nivel de calidad es igual o menor al elegido. ¡Una vez un objeto es destruido, no puede ser revertido!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_EXCLUSION_DISCLAIMER = "Excepto: Cualquier tipo de objeto 'desconocido' (recetas, motivos, paginas de estilo, rasgos, ...) nunca serán auto-destruidos, incluso si coincide con el criterio de valor de venta y calidad del objeto.",

    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_JUNK_HEADER = "Basura Robada",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK = "Activar auto-destruir para objetos robados de tipo basura",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_T = "Cuando robas un objeto que que debería estar marcado como basura y tiene un (Perista) valor de venta y la calidad del objeto es igual o menor al elegido, entonces con esta configuración este ACTIVO será destruido. ¡Esto no puede ser revertido!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD = "SI el valor de venta del perista is igual o menor a:",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD_T = "Solamente auto-destruir los objetos robados cuando su valor de venta del perista is igual o menor al elegido. ¡Una vez un objeto es destruido, no puede ser revertido!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD = "Y la calidad del objeto robado es igual o menor a:",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD_T = "Solamente se auto-destruirá los objetos robados cuando su nivel de calidad es igual o menor al elegido. ¡Una vez un objeto es destruido, no puede ser revertido!",

    -- Other Settings --
    SI_PA_MENU_JUNK_MAILBOX_IGNORE = "Nunca marcar objetos recibidos desde el Correo como Basura",
    SI_PA_MENU_JUNK_MAILBOX_IGNORE_T = "Objetos que son recibidos desde el Correo nunca deberían ser marcados como Basura",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE = "Nunca marcarás objetos que tu hayas creado como Basura",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE_T = "Objetos que tu has creado en la Estación de Elaboración nunca deberían ser marcados como Basura",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "¿Auto-Vender Basura a los Mercaderes y Peristas?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI = "¿También auto-vender a Pirharri? (Asistente Perista)",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI_W = "A diferencia de otros peristas, Pirharri cobra una Tarifa de Contrabandista del 35% por sus servicios",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "Atajos de teclado",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE = "Activar Atajo de \"Marcar como Basura\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW = "Mostrar Atajo de \"Marcar como Basura\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_ENABLE = "Activar Atajo de \"Marcar como Basura perm.\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_SHOW = "Mostrar Atajo de \"Marcar como Basura perm.\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE = "Activar Atajo de \"Destruir Objeto\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W = "PELIGRO: Por favor, ser consciente que usar este atajo, NO hay un mensaje de doble-confirmación si el objeto realmente puede ser destruido.\n¡Solamente sera destruido!\n¡Para Siempre!\n¡Úselo bajo tu propio riesgo!",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW = "Mostrar Atajo de \"Destruir Objeto\"",
    SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION = "Desactivar el Atajo de \"Destruir Objeto\" si el objeto . . .",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD = "> es de una calidad igual o mayor a:",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN = "> puede ser aprendido/investigado y es 'desconocido'",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "Auto-Marcar %s con calidad igual o menor a:",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "Automáticamente marca %s como Basura si tiene una calidad seleccionada igual o menor",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Auto-Marcar %s con el rasgo de [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]."}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"¿Quieres automáticamente marcar %s con el rasgo de [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (incrementa el valor de venta) como basura?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INTRICATE = table.concat({"Auto-Marcar %s con el rasgo de [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]."}),
    SI_PA_MENU_JUNK_AUTOMARK_INTRICATE_T = table.concat({"¿Quieres automáticamente marcar %s con el rasgo de [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "] (incrementa el material obtenido cuando deconstruyes) como basura?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "También marca %s que son parte de un Conjunto",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "Si esta INACTIVO, solamente %s que NO son parte de un conjunto serán marcados como Basura",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS = "También marca %s con un Rasgo conocido",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "Si esta INACTIVO, solamente %s sin Rasgo o Rasgo desconocido serán marcados como Basura",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "También marca %s con un Rasgo desconocido",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "Si esta INACTIVO, solamente %s sin Rasgo o Rasgo conocido serán marcados como Basura",

    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_MAINMENU_JUNK_HEADER = "Reglas de Basura",

    SI_PA_MAINMENU_JUNK_HEADER_ITEM = "Objeto",
    SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT = "Contador de Basura",
    SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK = "Ultima Basura",
    SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED = "Añadir Regla",
    SI_PA_MAINMENU_JUNK_HEADER_ACTIONS = "Acciones",

    SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED = "nunca",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}),
	SI_PA_CHAT_JUNK_MARKED_AS_JUNK_INTRICATE = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize("Calidad"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize("Mercader"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize("Tesoro"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize("Manual"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize("Robado"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT = table.concat({"Movido %s a basura (", PAC.COLOR.ORANGE:Colorize("Regla-perm"), ")"}),

    SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Destruido"), " %d x %s"}),
    SI_PA_CHAT_JUNK_DESTROYED_ALWAYS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Destruido"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Siempre"), ")"}),
    SI_PA_CHAT_JUNK_DESTROYED_CRITERIA_MATCH = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Destruido"), " %d x %s (Valor de venta: %s)"}),

    SI_PA_CHAT_JUNK_DESTROY_ON = table.concat({"Auto-Destruir los objetos de tipo basura ha sido cambiado a ", PAC.COLOR.RED:Colorize("ACTIVADO")}),
    SI_PA_CHAT_JUNK_DESTROY_OFF = table.concat({"Auto-Destruir los objetos de tipo basura ha sido cambiado a ", PAC.COLOR.GREEN:Colorize("DESACTIVADO")}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_ON = table.concat({"Auto-Destruir los objetos robados de tipo basura ha sido cambiado a ", PAC.COLOR.RED:Colorize("ACTIVADO")}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_OFF = table.concat({"Auto-Destruir los objetos robados de tipo basura ha sido cambiado a ", PAC.COLOR.GREEN:Colorize("DESACTIVADO")}),

    SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO = "Objetos vendidos por %s",
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Por favor esperar ~%d horas"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Por favor esperar ~%d minutos"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({"No puede ser vendido %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),
    SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM = "No puede ser vendido %s",

    SI_PA_CHAT_JUNK_RULES_ADDED = table.concat({"¡%s fue ", PAC.COLOR.ORANGE:Colorize("añadido"), " a la lista permanente de basura!"}),
    SI_PA_CHAT_JUNK_RULES_DELETED = table.concat({"¡%s fue ", PAC.COLOR.ORANGE:Colorize("removido"), " de la lista permanente de basura!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Addon Keybindings menu --
    SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM = "Marcar como Basura",
    SI_BINDING_NAME_PA_JUNK_PERMANENT_TOGGLE_ITEM = "Marcar como Basura permanente",
    SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM = "Destruir Objeto",

    -- Actual keybindings --
    SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK = "Marcar como Basura perm.",
    SI_PA_ITEM_ACTION_UNMARK_AS_PERM_JUNK = "Desmarcar como Basura perm.",


    -- =================================================================================================================
    -- == OTHER STRINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Quest: "A Matter of Leisure"
    SI_PA_TREASURE_ITEM_TAG_DESC_TOYS = "Juguetes de niños",
    SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS = "Muñecas",
    SI_PA_TREASURE_ITEM_TAG_DESC_GAMES = "Juegos",

    -- Quest: "A Matter of Respect"
    SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS = "Utensilios",
    SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE = "Vasos",
    SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE = "Platos y Utensilios de cocina",

    -- Quest: "A Matter of Tributes"
    SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS = "Cosméticos",
    SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING = "Artículos de aseo",

    -- Quest: "The Covetous Countess" (only additional tags)
    SI_PA_TREASURE_ITEM_TAG_DESC_LINENS = "Lencería",
    SI_PA_TREASURE_ITEM_TAG_DESC_ACCESSORIES = "Accesorios de Guardarropa",
    SI_PA_TREASURE_ITEM_TAG_DESC_STATUES = "Estatuas",
    SI_PA_TREASURE_ITEM_TAG_DESC_WRITINGS = "Escritos",
    SI_PA_TREASURE_ITEM_TAG_DESC_SCRIVENER = "Suministro para Escribanos",
    SI_PA_TREASURE_ITEM_TAG_DESC_MAPS = "Mapas",
    SI_PA_TREASURE_ITEM_TAG_DESC_RITUAL_OBJECTS = "Objetos de Ritual",
    SI_PA_TREASURE_ITEM_TAG_DESC_ODDITIES = "Rarezas",

    -- OTHERS: Not yet used
    SI_PA_TREASURE_ITEM_TAG_DESC_INSTRUMENTS = "Instrumentos Musicales",
    SI_PA_TREASURE_ITEM_TAG_DESC_ARTWORK = "Obra de Arte",
    SI_PA_TREASURE_ITEM_TAG_DESC_DECOR = "Decoración de Pared",
    SI_PA_TREASURE_ITEM_TAG_DESC_TRIFLES_ORNAMENTS = "Bagatelas y Adornos",
    SI_PA_TREASURE_ITEM_TAG_DESC_DEVICES = "Dispositivos",
    SI_PA_TREASURE_ITEM_TAG_DESC_SMITHING = "Equipo de Herrería",
    SI_PA_TREASURE_ITEM_TAG_DESC_TOOLS = "Herramientas",
    SI_PA_TREASURE_ITEM_TAG_DESC_MEDICAL_SUPPLIES = "Suministros Médicos",
    SI_PA_TREASURE_ITEM_TAG_DESC_CURIOSITIES = "Curiosidades Mágicas",
    SI_PA_TREASURE_ITEM_TAG_DESC_FURNISHINGS = "Mobiliarios",
    SI_PA_TREASURE_ITEM_TAG_DESC_LIGHTS = "Luces",
}

for key, value in pairs(PAJStrings) do
    SafeAddString(_G[key], value, 1)
end
