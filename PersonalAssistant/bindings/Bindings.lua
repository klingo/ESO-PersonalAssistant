-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function loadProfile(profileNo)
    if profileNo > 0 and profileNo <= PAC.GENERAL.MAX_PROFILES then
        local activeProfile = PAMF.PAGeneral.getActiveProfile()
        if activeProfile ~= profileNo then
            PAMF.PAGeneral.setActiveProfile(profileNo)
            -- then inform player
            PAHF.println(SI_PA_CHAT_GENERAL_ACTIVE_PROFILE_ACTIVE, PA.SavedVars.General[PA.activeProfile].name)
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Bindings = {
    loadProfile = loadProfile
}

for i = 1, PAC.GENERAL.MAX_PROFILES do
    ZO_CreateStringId(table.concat({"SI_BINDING_NAME_PA_ACTIVATE_PROFILE_", tostring(i)}), table.concat({GetString(SI_KEYBINDINGS_PA_LOAD_PROFILE), " ", tostring(i)}))
end
