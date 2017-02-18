--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 12.02.2017
-- Time: 17:02
--

PAHF = {}
PAHF_DEBUG = {}

-- returns a noun for the bagId
function PAHF.getBagName(bagId)
    if (bagId == BAG_WORN) then
        return PALocale.getResourceMessage("NS_Bag_Equipment")
    elseif (bagId == BAG_BACKPACK) then
        return PALocale.getResourceMessage("NS_Bag_Backpack")
    elseif (bagId == BAG_BANK) then
        return PALocale.getResourceMessage("NS_Bag_Bank")
    else
        return PALocale.getResourceMessage("NS_Bag_Unknown")
    end
end


-- returns an adjective for the bagId
function PAHF.getBagNameAdjective(bagId)
    if (bagId == BAG_WORN) then
        return PALocale.getResourceMessage("NS_Bag_Equipped")
    elseif (bagId == BAG_BACKPACK) then
        return PALocale.getResourceMessage("NS_Bag_Backpacked")
    elseif (bagId == BAG_BANK) then
        return PALocale.getResourceMessage("NS_Bag_Banked")
    else
        return PALocale.getResourceMessage("NS_Bag_Unknown")
    end
end


-- returns a fixed/formatted ItemLink
function PAHF.getFormattedItemLink(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
    if itemLink == "" then return end

    local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemName(bagId, slotIndex))
    local itemData = itemLink:match("|H.-:(.-)|h")

    return zo_strformat(SI_TOOLTIP_ITEM_NAME, (("|H%s:%s|h[%s]|h"):format(LINK_STYLE_BRACKETS, itemData, itemName)))
end

function PAHF.hasActiveProfile()
    return not PAMenu_Functions.disabled.PAGeneral.noProfileSelected()
end

-- the same like PAHF.println, except that it only prints it if debug is on
function PAHF_DEBUG.debugln(key, ...)
    if (PA.debug) then
        PAHF.println(key, ...)
    end
end

-- currently supports one text-key and n arguments
function PAHF.println(key, ...)
    local text = PALocale.getResourceMessage(key)
    if text == nil then text = key end
    local unpackedString = PAHF.getFormattedText(text, ...)
    CHAT_SYSTEM:AddMessage(unpackedString)
end

-- same lik PAHF.getFormattedText, but first resolves the key via PALocale
function PAHF.getFormattedKey(key, ...)
    return PAHF.getFormattedText(PALocale.getResourceMessage(key), ...)
end

-- currently supports one text and n arguments
function PAHF.getFormattedText(text, ...)
    local args = {...}
    local unpackedString = string.format(text, unpack(args))
    if (unpackedString == "") then
        unpackedString = text
    end
    return unpackedString
    -- check this out: Singular & plural form using the zo_strformat() function
    -- http://www.esoui.com/forums/showthread.php?p=7988
end