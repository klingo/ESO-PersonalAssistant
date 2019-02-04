-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager
local PASV = PA.SavedVars

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantBanking"
local Banking_Defaults = {}


local function _cleanupSavedVarsAdvancedItemIds()
    -- first check if a profile is active
    if not (PA.activeProfile == nil) then
        local globalItemIdTable = {}
        local savedVarsItemIdTable = {}

        -- first, loop through all tables inside [BANKING_ADVANCED]
        for _, groupTable in pairs(PAC.BANKING_ADVANCED) do
            -- then loop through the itemIds of these tables
            for _, itemId in pairs(groupTable) do
                table.insert(globalItemIdTable, itemId)
            end
        end

        -- then loop through the savedVars itemIds and store them in a separate list
        for itemId, _ in pairs(PASV.Banking[PA.activeProfile].Advanced.ItemIdBackpackAmount) do
            table.insert(savedVarsItemIdTable, itemId)
        end

        -- now loop through the stored savedVars list and match them with the globalsList
        -- if there is no match, remove the entry from SavedVars
        for _, savedVarsItemId in pairs(savedVarsItemIdTable) do
            if not PAHF.isValueInTable(globalItemIdTable, savedVarsItemId) then
                -- itemId from the savedVars is not found in the Globals; delete them
                PASV.Banking[PA.activeProfile].Advanced.ItemIdBackpackAmount[savedVarsItemId] = nil
                PASV.Banking[PA.activeProfile].Advanced.ItemIdOperator[savedVarsItemId] = nil
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PABanking
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default vlaues from PAMenuDefaults
        Banking_Defaults[profileNo] = PAMenuDefaults.PABanking
    end
end


-- init saved variables and register Addon
local function initAddon(_, addOnName)
    if addOnName ~= AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(AddonName, EVENT_ADD_ON_LOADED)

    -- initialize the default values
    initDefaults()

    -- gets values from SavedVars, or initialises with default values
    PASV.Banking = ZO_SavedVars:NewAccountWide("PersonalAssistantBanking_SavedVariables", 1, "Banking", Banking_Defaults)

    -- as part of the initialisation, check if the savedVars [Advanced.ItemIdOperator] and [Advanced.ItemIdBackpackAmount]
    -- contain any IDs that are no longer configured in the PAConstants; if there are, remove them
    _cleanupSavedVarsAdvancedItemIds()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Banking = {
    AddonName = AddonName
}