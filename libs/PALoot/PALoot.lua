--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
-- To change this template use File | Settings | File Templates.
--

PALo = {}

PALo.alreadyHarvesting = false

function PALo.OnReticleTargetChanged()

    local type = GetInteractionType()
    local active = IsPlayerInteractingWithObject()
    local isHarvesting = (active and (type == INTERACTION_HARVEST))


    if (PALo.alreadyHarvesting) then
        if (not isHarvesting) then
            -- stopped harvesting
            PALo.alreadyHarvesting = false
            PALo.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
        end
    else
        if (isHarvesting) then
            -- started harvesting
            PALo.alreadyHarvesting = true
            PALo.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
        end
    end
end

function PALo.OnLootUpdated()


    local lootCount =  GetNumLootItems()
    for i = 1, lootCount do
        local lootId, name, _, _, _, _, _, _, lootItemType = GetLootItemInfo(i)

        CHAT_SYSTEM:AddMessage("lootItemType = " .. lootItemType)

        local link = GetLootItemLink(lootId)
        local itemType = GetItemLinkItemType(link)

        CHAT_SYSTEM:AddMessage("itemType = " .. itemType)
    end

--    local lootCount =  GetNumLootItems()
--    for i = 1, lootCount do
--        local lootId, name, _, count, _, _, _, _, lootItemType = GetLootItemInfo(i)
--        local strItemType = PAL.getResourceMessage(lootItemType)
--
--        CHAT_SYSTEM:AddMessage("lootId = " .. tostring(lootId))
--
--        local link = GetLootItemLink(lootId)
--        local nItemType = GetItemLinkItemType(link)
--        local nStrItemType = PAL.getResourceMessage(nItemType)
--
--
--        PALo.println("lootItemType (%s): %s. ---> %d x %s <--- or itemType (%s): %s", lootItemType, strItemType, count, name, nItemType, nStrItemType)
--    end


    -- GetItemLinkItemType(string itemLink)
    -- LootAll(boolean ignoreStolenItems)

    -- GetLootItemLink(number lootId, number LinkStyle linkStyle)
    -- Returns: string link

    -- GetLootItemType(number lootId)
    -- Returns: number LootItemType itemType

    -- LootItemById(number lootId)

    -- LootCurrency(number CurrencyType type)

    -- LootMoney()

    -- GetLootTargetInfo()
    -- Returns: string name, number InteractTargetType targetType, string actionName, boolean isOwned

    -- GetLootItemInfo(number lootIndex)
    -- Returns: number lootId, string name, textureName icon, number count, number quality, number value, boolean isQuest, boolean stolen, number LootItemType itemType

    end

function PALo.println(key, ...)
--    if (not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideAllMsg) then
        local args = {...}
        PA.println(key, unpack(args))
--    end
end

