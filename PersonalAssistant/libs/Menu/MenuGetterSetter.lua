--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Functions then
    PAMenu_Functions = {
        getFunc = {
            PALoot = {},
        },
        setFunc = {
            PALoot = {},
        },
        disabled = {
            PALoot = {},
        },
    }
end


--------------------------------------------------------------------------
-- PALoot   enable
---------------------------------
function PAMenu_Functions.getFunc.PALoot.enable()
    return PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PALoot.enable(value)
    PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PALoot   lootGold
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGold()
    return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold
end

function PAMenu_Functions.setFunc.PALoot.lootGold(value)
    PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold = value
end

function PAMenu_Functions.disabled.PALoot.lootGold()
    return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootGoldChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldChatMode()
    return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGoldChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootGoldChatMode(value)
    PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGoldChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldChatMode()
    return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold)
end

--------------------------------------------------------------------------
-- PALoot   lootItems
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItems()
    return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems
end

function PAMenu_Functions.setFunc.PALoot.lootItems(value)
    PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems = value
end

function PAMenu_Functions.disabled.PALoot.lootItems()
    return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootItemsChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsChatMode()
    return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItemsChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootItemsChatMode(value)
    PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItemsChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsChatMode()
    return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems)
end