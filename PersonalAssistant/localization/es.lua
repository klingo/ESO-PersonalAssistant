local PAC = PersonalAssistant.Constants
local PAStrings = PAStrings or {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Profile Settings --
    SI_PA_MENU_PROFILE_PLEASE_SELECT = "<Por favor, selecciona el Perfil>",
    SI_PA_MENU_PROFILE_ACTIVE = "Perfil Activo",
    SI_PA_MENU_PROFILE_ACTIVE_T = "Selecciona el perfil activo para el PersonalAssistant. Automáticamente cargará todas las configuraciones guardadas bajo el perfil y los cambios que hagas serán guardados en el mismo lugar.",
    SI_PA_MENU_PROFILE_ACTIVE_RENAME = "Renombra el perfil activo",

    -- Create Profiles --
    SI_PA_MENU_PROFILE_CREATE_NEW = "Crear nuevo perfil",
    SI_PA_MENU_PROFILE_CREATE_NEW_DESC = table.concat({"Nota: Puedes tener un máximo de ", PAC.GENERAL.MAX_PROFILES, " perfiles."}),

    -- Copy Profiles --
    SI_PA_MENU_PROFILE_COPY_FROM_DESC = "Copia las configuraciones desde uno de los perfiles existentes dentro del perfil activo.",
    SI_PA_MENU_PROFILE_COPY_FROM = "Copiar este perfil",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM = "Confirmar copia",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W = "Este reemplazará las configuraciones del perfil activo con las siguientes configuraciones del perfil seleccionado. ¿Estás seguro que quieres hacer esto? \n\nNota: Solamente las configuraciones que estén activadas en el modulo de PersonalAssistant serán copiadas",

    -- Delete Profiles --
    SI_PA_MENU_PROFILE_DELETE_DESC = "Borra el perfil existente y no usado desde la base de datos para guardar espacio, y limpia el archivo SavedVariables.",
    SI_PA_MENU_PROFILE_DELETE = "Borrar un perfil",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM = "Confirmar borrado",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM_W = "Esto borrará los perfiles seleccionados de todos los personajes. ¿Estás seguro de que quieres hacer esto?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Rules Menu --
    SI_PA_MENU_RULES_HOW_TO_ADD_PAB = "En orden para crear una nueva regla para depositar y retirar objetos, simplemente haz click derecho dentro del objeto en tu inventario o banco y selecciona en el menú de contexto:\n> PA Bancario > Añadir nueva regla",
    SI_PA_MENU_RULES_HOW_TO_ADD_PAJ = "En orden para crear una nueva regla para marcar permanentemente como basura a un objeto, simplemente haz click derecho dentro del objeto en tu inventario o banco y selecciona en el menú de contexto:\n> PA Basura > Marcar como basura permanente",
    SI_PA_MENU_RULES_HOW_TO_FIND_MENU = table.concat({"Puedes buscar todas las reglas activas via el icono en la parte de arriba del menu principal que tu puedes abrir con la tecla [Alt], con ", PAC.COLOR.YELLOW:Colorize("/parules"), " o haciendo click sobre este boton:"}),
    SI_PA_MENU_RULES_HOW_TO_CREATE = "¿Cómo crear una nueva regla?",

    SI_PA_MENU_DANGEROUS_SETTING = "PELIGRO: ¡Esta es una configuración sensible! ¡Modificalo bajo tu propio riesgo!",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_OTHER_SETTINGS_HEADER = "Otras Configuraciones",

    SI_PA_MENU_SILENT_MODE = "Modo Silencioso (Desactiva todos los mensajes del chat)",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "¡Todavía no se ha implementado!"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED = table.concat({" nuevo perfil ", PAC.COLOR.WHITE:Colorize("%s"), " creado y activado!"}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED = table.concat({" la configuración del perfil ", PAC.COLOR.WHITE:Colorize("%s"), " ha sido ", PAC.COLOR.ORANGE_RED:Colorize("copiado"), " al perfil activo ", PAC.COLOR.WHITE:Colorize("%s")}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED = table.concat({" el perfil seleccionado ", PAC.COLOR.WHITE:Colorize("%s"), " ha sido ", PAC.COLOR.ORANGE_RED:Colorize("borrado!")}),

    SI_PA_CHAT_GENERAL_TELEPORT_NO_PRIMARY_HOUSE = table.concat({"Necesitas seleccionar una casa como tu ", PAC.COLOR.ORANGE_RED:Colorize("Casa Primaria"), " antes de usar esta opción"}),
    SI_PA_CHAT_GENERAL_TELEPORT_ZONE_PREVENTED = table.concat({"Tu localización actual ", PAC.COLOR.ORANGE_RED:Colorize("no permite"), " el viaje rapido a tu casa"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "Perfil",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "", -- not required so far
    SI_PA_NS_BAG_BACKPACK = "Mochila",
    SI_PA_NS_BAG_BANK = "Banco",
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "Banco ESO Plus",
    SI_PA_NS_BAG_VIRTUAL = "Bolsa de Artesanía",
    SI_PA_NS_BAG_HOUSE_BANK = "Almacenamiento de tu Casa",
    SI_PA_NS_BAG_HOUSE_BANK_NR = "Almacenamiento de tu Casa (%d)",
    SI_PA_NS_BAG_UNKNOWN = "Desconocido",

    -- -----------------------------------------------------------------------------------------------------------------
    -- ItemTypes (Custom Singluar/Plural definition) --
    SI_PA_ITEMTYPE4 = "<<1[Comida/Comidas]>>",
    SI_PA_ITEMTYPE5 = "<<1[Trofeo/Trofeos]>>",
    SI_PA_ITEMTYPE7 = "<<1[Poción/Pociones]>>",
    SI_PA_ITEMTYPE8 = "<<1[Motivo/Motivos]>>",
    SI_PA_ITEMTYPE10 = "<<1[Ingrediente/Ingredientes]>>",
    SI_PA_ITEMTYPE12 = "<<1[Bebida/Bebidas]>>",
    SI_PA_ITEMTYPE16 = "<<1[Cebo/Cebos]>>",
    SI_PA_ITEMTYPE19 = "<<1[Gema del alma/Gemas del alma]>>",
    SI_PA_ITEMTYPE22 = "<<1[Ganzúa/Ganzúas]>>",
    SI_PA_ITEMTYPE29 = "<<1[Receta/Recetas]>>",
    SI_PA_ITEMTYPE30 = "<<1[Veneno/Venenos]>>",
    SI_PA_ITEMTYPE33 = "<<1[Disolvente/Disolventes]>>",
    SI_PA_ITEMTYPE34 = "<<1[Coleccionable/Coleccionables]>>",
    SI_PA_ITEMTYPE47 = "<<1[Reparación AvA/Reparaciones AvA]>>",
    SI_PA_ITEMTYPE56 = "<<1[Tesoro/Tesoros]>>",
    SI_PA_ITEMTYPE60 = "<<1[Encargos Magistrales/Encargos Magistrales]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- SpecializedItemTypes (Custom Singluar/Plural definition) --
    SI_PA_SPECIALIZEDITEMTYPE102 = "<<1[Fragmento/Fragmentos]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Master Writs based on CraftingType (Custom definition) --
    SI_PA_MASTERWRIT_CRAFTINGTYPE0 = table.concat({"Otras escrituras (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}),
    SI_PA_MASTERWRIT_CRAFTINGTYPE1 = "Escritura de Herrería sellado",
    SI_PA_MASTERWRIT_CRAFTINGTYPE2 = "Escritura de Sastrería sellado",
    SI_PA_MASTERWRIT_CRAFTINGTYPE3 = "Escritura de Encantamiento sellado",
    SI_PA_MASTERWRIT_CRAFTINGTYPE4 = "Escritura de Alquimia sellado",
    SI_PA_MASTERWRIT_CRAFTINGTYPE5 = "Escritura de Cocina sellado",
    SI_PA_MASTERWRIT_CRAFTINGTYPE6 = "Escritura de Carpintería sellado",
    SI_PA_MASTERWRIT_CRAFTINGTYPE7 = "Escritura de Joyería sellado",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "No hacer nada",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "Depositar al banco",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Retirar a la mochila",

    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Glifos",
    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS = "Objetos intrincados",
    SI_PA_MENU_BANKING_ADVANCED_ORNATE_ITEMS = "Objetos ornamentados",

    SI_PA_MENU_BANKING_REPAIRKIT = "Kits de reparación",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "Selecciona el Operador Matemático para este objeto",
    SI_PA_REL_BACKPACK_EQUAL = "MOCHILA ==",
    SI_PA_REL_BACKPACK_LESSTHAN = "MOCHILA <", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANEQUAL = "MOCHILA <=",
    SI_PA_REL_BACKPACK_GREATERTHAN = "MOCHILA >", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANEQUAL = "MOCHILA >=",
    SI_PA_REL_BANK_EQUAL = "BANCO ==",
    SI_PA_REL_BANK_LESSTHAN = "BANCO <", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL = "BANCO <=",
    SI_PA_REL_BANK_GREATERTHAN = "BANCO >", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL = "BANCO >=",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operator Tooltip --
    SI_PA_REL_BACKPACK_EQUAL_T = "MOCHILA igual a (==)",
    SI_PA_REL_BACKPACK_LESSTHAN_T = "MOCHILA menor que (<)", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T = "MOCHILA menor que o igual a (<=)",
    SI_PA_REL_BACKPACK_GREATERTHAN_T = "MOCHILA mayor que (>)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T = "MOCHILA mayor que o igual a (>=)",
    SI_PA_REL_BANK_EQUAL_T = "BANCO igual a (==)",
    SI_PA_REL_BANK_LESSTHAN_T = "BANCO menor que (<)", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL_T = "BANCO menor que o igual a (<=)",
    SI_PA_REL_BANK_GREATERTHAN_T = "BANCO mayor que (>)", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL_T = "BANCO mayor que o igual a (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Text Operators --
    SI_PA_REL_TEXT_OPERATOR0 = "-",
    SI_PA_REL_TEXT_OPERATOR1 = "tiene exactamente",
    SI_PA_REL_TEXT_OPERATOR2 = "tiene menos que", -- not used so far
    SI_PA_REL_TEXT_OPERATOR3 = "tiene como máximo",
    SI_PA_REL_TEXT_OPERATOR4 = "tiene mas que", -- not used so far
    SI_PA_REL_TEXT_OPERATOR5 = "tiene al menos",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Mover todo", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Solamente llenar las acumulaciones existentes", -- 1: Fill existing stacks

    -- -----------------------------------------------------------------------------------------------------------------
    -- Icon Positions --
    SI_PA_POSITION_AUTO = "Automático",
    SI_PA_POSITION_MANUAL = "Manual",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_ITEM_ACTION_NOTHING = "No hacer nada",
    SI_PA_ITEM_ACTION_LAUNDER = "Lavado de objetos robados a Fences", -- not used so far
    SI_PA_ITEM_ACTION_MARK_AS_JUNK = "Marcar como basura",
    SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS = "Basura o Destruir sino tiene valor",
    SI_PA_ITEM_ACTION_DESTROY_ALWAYS = "Destruir de todas formas",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB_ADD_RULE = "Añadir nueva regla",
    SI_PA_SUBMENU_PAB_EDIT_RULE = "Modificar la regla",
    SI_PA_SUBMENU_PAB_DELETE_RULE = "Borrar la regla",
    SI_PA_SUBMENU_PAB_ENABLE_RULE = "Activar la regla",
    SI_PA_SUBMENU_PAB_DISABLE_RULE = "Desactivar la regla",
    SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON = "Añadir",
    SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON = "Guardar",
    SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON = "Borrar",
    SI_PA_SUBMENU_PAB_NO_RULES = "No se han definido reglas de banca todavía",
    SI_PA_SUBMENU_PAB_DISCLAIMER = "A tener en cuenta: Estas reglas personalizadas de banca serán corridas después de que todas las otras reglas de Auto Banco (Creación, Especiales, y objetos AvA) serán ejecutadas primero.",

    SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK = "Marcar como basura permanente",
    SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK = "Desmarcar como basura permanente",
    SI_PA_SUBMENU_PAJ_NO_RULES = "No se ha definido reglas de basura todavía",


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_PROFILES = "Perfiles |cFFD700P|rersonal|cFFD700A|rssistant",
    SI_KEYBINDINGS_CATEGORY_PA_MENU = "Menu de |cFFD700P|rersonal|cFFD700A|rssistant",

    SI_BINDING_NAME_PA_RULES_MAIN_MENU = "Reglas de PersonalAssistant",
    SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW = "Alternar Menu de Reglas de Banco/Basura",
    SI_BINDING_NAME_PA_TRAVEL_TO_HOUSE = "Viajar a mi Casa Principal",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
