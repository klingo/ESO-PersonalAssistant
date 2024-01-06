local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration puede integrar funcionalidad de addons de PersonalAssistant con addons de terceros como Dolgubon's Lazy Writ Crafter o FCO ItemSaver",
    SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE = "Recientemente no tienes ningún addon instalado/activado que estén soportados por PAIntegration",
	
    -- Character Knowledge --
    SI_PA_MENU_INTEGRATION_CK_CHARACTER = "Considere conocido si es conocido por",
    SI_PA_MENU_INTEGRATION_CK_ENABLE = "Activar la integración de Character Knowledge",
    SI_PA_MENU_INTEGRATION_CK_ENABLE_T = table.concat({"Usa Character Knowledge para determinar si un ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " o ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " es conocido"}),
    SI_PA_MENU_INTEGRATION_CK_INITIALIZING = "Character Knowledge inicializando ...",

    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Compatibilidad con Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "Cuando tu tienes activo las Misiones de Elaboración de Escrituras y 'Retirar los objetos necesarios para el encargo' esta activado en Dolgubon's Lazy Writ Crafter, entonces para estos objetos la configuración 'Deposito a Banco' es ignorada. Esto evita tener que los objetos retirados se vuelvan a depositar nuevamente.",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "Previene el Auto-Venta de objetos que están Bloqueados",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING = "Previene mover objetos que están Bloqueados",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING_T = "Si esta ACTIVADO, los objetos que son Bloqueados con FCO ItemSaver no serán depositados al banco, ni retirado de ella.",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Los objetos marcados con Auto-Venta para los Comerciantes/Peristas?",
    SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED = "¿Mover los objetos marcados cuando accedas al banco?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "Configuraciones Adicionales se volverán visibles cuando PABanking este activado",
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "Configuraciones Adicionales se volverán visibles cuando PAJunk este activado",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "Mas integraciones de FCO ItemSaver vendrán con futuras actualizaciones",
}

for key, value in pairs(PAIStrings) do
    SafeAddString(_G[key], value, 1)
end
