-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACO = PA.Consume
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function NextPoison()

   local slotIndex = nil
   local maxedPoisonStacks = 0

	for i = 1, GetBagSize(BAG_BACKPACK) do
		local itemType, _ = GetItemType(BAG_BACKPACK, i)
		local itemStacks, _ = GetSlotStackSize(BAG_BACKPACK, i)
		if itemType == ITEMTYPE_POISON then
            if itemStacks > maxedPoisonStacks then
			   maxedPoisonStacks = itemStacks
			   slotIndex = i
			end
		end
	end
    return slotIndex
end

-- --------------------------------------------------------------------------------------------------------------------

function CheckPoison()

    if not IsPlayerActivated() then return end
	
	local level = GetUnitLevel("player")

	
	if IsUnitInCombat("player") then
		return
	else
		-- check if poison slots are equipped after combat
          local _, stack, _, _, _, _, _, _ = GetItemInfo(BAG_WORN, EQUIP_SLOT_POISON)
	      local _, backStack, _, _, _, _, _, _ = GetItemInfo(BAG_WORN, EQUIP_SLOT_BACKUP_POISON)

		  if stack and stack ~= 0 then
		      if backStack and backStack ~= 0 then
			  elseif level >= 15 then
			       if NextPoison() then
				       local next = NextPoison()
				       local itemLink = PAHF.getFormattedItemLink(BAG_BACKPACK, next)
					   local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
					   local stacks = GetSlotStackSize(BAG_BACKPACK, next)
				       EquipItem(BAG_BACKPACK, next, EQUIP_SLOT_BACKUP_POISON)
					   PACO.println(GetString(SI_PA_CHAT_CONSUME_POISON_BACKUP)..stacks.." x "..itemLinkExt)
				   end
			  end
		  else
		      if NextPoison() then
				   local next = NextPoison()
				   local itemLink = PAHF.getFormattedItemLink(BAG_BACKPACK, next)
				   local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
				   local stacks = GetSlotStackSize(BAG_BACKPACK, next)
			       EquipItem(BAG_BACKPACK, next, EQUIP_SLOT_POISON)
				   PACO.println(GetString(SI_PA_CHAT_CONSUME_POISON_MAIN)..stacks.." x "..itemLinkExt)
			  end
		  end
		
	end
	
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Consume = PA.Consume or {}
PA.Consume.CheckPoison = CheckPoison
