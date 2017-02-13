--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Defaults then
    PAMenu_Defaults = {}
end

PAMenu_Defaults.defaultSettings = {
    PALoot = {
        enabled = false,
        lootGoldEnabled = true,
        lootItemsEnabled = true,
        lootGoldChatMode = PA_OUTPUT_TYPE_NORMAL,
        lootItemsChatMode = PA_OUTPUT_TYPE_FULL,
    },
}