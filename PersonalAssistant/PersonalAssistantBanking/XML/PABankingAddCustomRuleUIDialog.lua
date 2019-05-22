-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
local window = PABankingAddCustomRuleWindow
local initDone = false


local function showAddCustomRuleUIDialog(itemLink)
--    ZO_Dialogs_ShowDialog("PA_BANKING_ADD_CUSTOM_RULE_DIALOG", {})
    window:SetHidden(not window:IsHidden())
end

local function initAddCustomRuleUIDIalog(itemLink)
    if not initDone then
        initDone = true

        window:SetHandler("OnMoveStop", function(control)
            local x, y = control:GetScreenRect()
            df("move stopped at %d/%d", x, y)
        end)
--
--        local itemControl = PABankingAddCustomRuleWindow:GetNamedChild("ItemIcon")
--        itemControl:SetHandler('OnMouseEnter', function()
--            d("onmousenter")
----            MasterMerchant.ShowToolTip(actualItem.itemLink, control.itemName)
--        end)

        local itemControl = window:GetNamedChild("Item")
        local itemIconControl = itemControl:GetNamedChild("ItemIcon")

        itemIconControl:SetHandler('OnMouseEnter', function()
            d("onmousenter222")

            local itemName = ZO_LinkHandler_CreateLink("Godlike", nil, ITEM_LINK_TYPE, 45336, 7, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 1, 10000, 0)
            local itemButton = "gugus"

            InitializeTooltip(ItemTooltip, itemIconControl)
--            ItemTooltip:SetLink(itemName)
            ItemTooltip:SetBagItem(1, 87)


            --            MasterMerchant.ShowToolTip(actualItem.itemLink, control.itemName)
        end)

        itemIconControl:SetHandler('OnMouseExit', function()
            ClearTooltip(ItemTooltip)
        end)



    end


--    local control = PABankingAddCustomRuleUIDialogXML
--
--    local content   = GetControl(control, "Content")
--    local acceptBtn = GetControl(control, "Accept")
--    local cancelBtn = GetControl(control, "Cancel")
--    local descLabel = GetControl(content, "Text")
--
--    local titleText = "PABanking - Add custom rule"
--
--    ZO_Dialogs_RegisterCustomDialog("PA_BANKING_ADD_CUSTOM_RULE_DIALOG", {
--        customControl = control,
--        title = { text = titleText  },
--        mainText = { text = "" },
--        setup = function(_, data)
--            local formattedText = "some formatted text comes here"
--            descLabel:SetText(formattedText)
--        end,
--        noChoiceCallback = function()
--            --Todo: Re-Register the reloadui dialog again to show in 10 Minutes.
--            d("noChoiceCallback")
--        end,
--        buttons = {
--            {
--                control = acceptBtn,
--                text = SI_DIALOG_ACCEPT,
--                keybind = "DIALOG_PRIMARY",
--                callback = function(dialog)
--                    d("acceptBtn")
--                end,
--            },
--            {
--                control = cancelBtn,
--                text = SI_DIALOG_CANCEL,
--                keybind = "DIALOG_NEGATIVE",
--                callback = function()
--                    d("cancelBtn")
--                end,
--            },
--        },
--    })
end

local function showTooltip(control)
    InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -5)
    SetTooltipText(InformationTooltip, "test")

end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initAddCustomRuleUIDIalog = initAddCustomRuleUIDIalog
PA.CustomDialogs.showAddCustomRuleUIDialog = showAddCustomRuleUIDialog
PA.CustomDialogs.showTooltip = showTooltip
