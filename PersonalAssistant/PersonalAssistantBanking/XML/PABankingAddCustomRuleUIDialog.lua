-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
local window = PABankingAddCustomRuleWindow
local initDone = false


local function initPABAddCustomRuleUIDialog()
    if not initDone then
        initDone = true

        -- just for testing purposes
--        window:SetHandler("OnMoveStop", function(control)
--            local x, y = control:GetScreenRect()
--            df("move stopped at %d/%d", x, y)
--        end)

        local itemControl = window:GetNamedChild("Item")
        local itemIconControl = itemControl:GetNamedChild("ItemIcon")

        -- set generic handler for mouse exit
        itemIconControl:SetHandler("OnMouseExit", function(self)
            ClearTooltip(ItemTooltip)
        end)
    end
end

local function showPABAddCustomRuleUIDIalog(itemLink)
    local itemControl = window:GetNamedChild("Item")
    local itemIconControl = itemControl:GetNamedChild("ItemIcon")

    itemIconControl:SetHandler('OnMouseEnter', function()
        InitializeTooltip(ItemTooltip, itemIconControl)
        ItemTooltip:SetLink(itemLink)
    end)

    local itemIcon = GetItemLinkIcon(itemLink)
    itemIconControl:SetTexture(itemIcon)

    window:SetHidden(false)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initPABAddCustomRuleUIDialog = initPABAddCustomRuleUIDialog
PA.CustomDialogs.showPABAddCustomRuleUIDIalog = showPABAddCustomRuleUIDIalog