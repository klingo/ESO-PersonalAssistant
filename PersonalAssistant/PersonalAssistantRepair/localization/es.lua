local PAC = PersonalAssistant.Constants
local PARStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair repara tu armadura y recarga tus armas para ti, ya sea con un comerciante o afuera en el campo",

    -- Equipped Items --
    SI_PA_MENU_REPAIR_EQUIPPED_HEADER = "Objetos Equipados",
    SI_PA_MENU_REPAIR_ENABLE = "Activar Auto Reparar para Objetos Equipados",

    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({"Reparar con ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({"Reparar Objetos equipados con ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "Cuando estas visitando un mercader, todos los objetos equipados que son igual o menor al umbral definido serán automáticamente reparados",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Umbral de Durabilidad en %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Reparar objetos equipados solamente si son igual o menor al umbral de durabilidad definido",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({"Reparar con ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({"¿ Quieres reparar Objetos equipados con ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "Cuando estas en campo, todos los objetos equipados que son igual o menor al umbral definido serán automáticamente reparados",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT = "Kit de Reparación por Defecto",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT_T = "Tu kit de reparación por defecto será usado primero cuando repares objetos",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "Umbral de Durabilidad en %",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "Repara los objetos equipados solamente si son igual o menor al umbral definido",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = table.concat({"Advertir cuando tienes pocos ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"Muestra una advertencia en la ventana del chat si tienes pocos ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), ". Si tu no tienes nada, te advertirá una vez cada 10 minutos como máximo."}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "Umbral del Kit de Reparación",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"Si el monto faltante de ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " es menor al umbral, un mensaje se mostrará en la ventana del chat"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({"Recarga Armas con ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({"¿Quieres recargar armas equipadas con ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "?"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "Re-Carga armas equipadas cuando su nivel de carga es cercano a cero. primero usará las Joyas del Alma seleccionada por defecto a continuación.",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM = "Joya del Alma por Defecto",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T = "Tu joya del alma por defecto será usada primero cuando recargues las armas.",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"Advertir cuando tengas pocas ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"Mostrará una advertencia en la ventana del chat si tienes pocas ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". Si no tienes ninguna, advertirá una vez cada 10 minutos como máximo."}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = table.concat({GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM), " umbral"}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"Si el monto faltante de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " es menor a este umbral, un mensaje se mostrará en la ventana del chat"}),

    -- Inventory Items --
    SI_PA_MENU_REPAIR_INVENTORY_HEADER = "Objetos de InventarioInventory Items",
    SI_PA_MENU_REPAIR_INVENTORY_ENABLE = "Activar Auto Reparar para Objetos del Inventario",

    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE = table.concat({"¿Quieres reparar Objetos del inventario con ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T = "Cuando visitas un mercader, todos los objetos en el inventario que son igual o menor al umbral definido serán automáticamente reparados",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY = "Umbral de Durabilidad en %",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T = "Reparar objetos en el inventario solamente si son igual o menor al umbral de durabilidad definido",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = "Los objetos equipados fueron reparados por %s",
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = "Los objetos equipados fueron reparados por %s (esta faltando %s)",

    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL = "Los objetos del inventario fueron reparados por %s",
    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL = "Los objetos del inventario fueron reparados por %s (esta faltando %s)",

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({"Reparado %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " con %s"}),
    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED_ALL = table.concat({"Reparado %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " y todos los otros objetos con %s"}),
}

for key, value in pairs(PARStrings) do
    SafeAddString(_G[key], value, 1)
end
