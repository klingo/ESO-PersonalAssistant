-- Local instances of Global tables --
local PA = PersonalAssistant
local PAEM = PA.EventManager
local PASV = PA.SavedVars

-- Local constants --
local AddonName = "PersonalAssistantBanking"
local Banking_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PABanking
    for profileNo = 1, PAG_MAX_PROFILES do
        -- get default vlaues from PAMenuDefaults
        Banking_Defaults[profileNo] = PAMenuDefaults.PABanking

        -- default values for ItemTypesMaterial (only prepare defaults for enabled itemTypes)
        for _, itemType in pairs(PABItemTypesMaterial) do
            Banking_Defaults[profileNo].ItemTypesMaterial[itemType] = PAC_ITEMTYPE_IGNORE
        end

        -- default values for ItemTypes (only prepare defaults for enabled itemTypes)
        for _, itemType in pairs(PABItemTypes) do
            Banking_Defaults[profileNo].ItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
        end

        -- default values for advanced ItemTypes
        for _, itemType in pairs(PABItemTypesAdvanced) do
            Banking_Defaults[profileNo].ItemTypesAdvanced[itemType] = {
                Operator = PAC_OPERATOR_NONE,
                Value = 50, -- Currently sets the value to 50 for ALL itemtypes!
            }
        end
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
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Banking = {
    AddonName = AddonName
}