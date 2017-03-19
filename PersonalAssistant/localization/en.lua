if ResourceBundle == nil then ResourceBundle = {} end
if ResourceBundle.en == nil then ResourceBundle.en = {} end

-- Welcome Messages --                                  -- Type '/pa' for GUI."
ResourceBundle.en["Welcome_NoSupport"]                  = PAC_COLTEXT_PA..PAC_COL_DEFAULT.." at your service!   -   no localization for language [%s] available (yet)."
ResourceBundle.en["Welcome_Support"]                    = PAC_COLTEXT_PA..PAC_COL_DEFAULT.." at your service!"
ResourceBundle.en["Welcome_PleaseSelectProfile"]        = PAC_COLTEXT_PA..PAC_COL_DEFAULT.." welcomes you! In order to get started, please go to the Addon Settings (or type /pa) and select a profile. Thank you :-)"

-- Key Bindings
ResourceBundle.en["KB_Load_Profile1"]                   = "Activate profile 1"
ResourceBundle.en["KB_Load_Profile2"]                   = "Activate profile 2"
ResourceBundle.en["KB_Load_Profile3"]                   = "Activate profile 3"
ResourceBundle.en["KB_Load_Profile4"]                   = "Activate profile 4"
ResourceBundle.en["KB_Load_Profile5"]                   = "Activate profile 5"

-- PAGeneral --
ResourceBundle.en["PAG_Profile1"]                       = "Profile 1"
ResourceBundle.en["PAG_Profile2"]                       = "Profile 2"
ResourceBundle.en["PAG_Profile3"]                       = "Profile 3"
ResourceBundle.en["PAG_Profile4"]                       = "Profile 4"
ResourceBundle.en["PAG_Profile5"]                       = "Profile 5"
ResourceBundle.en["PAG_PleaseSelectProfile"]            = "<Please select Profile>"

-- PARepair Chat Output - Full Repair --
ResourceBundle.en["PAR_FullRepair_ChatMode_None"]       = "<no output>"
ResourceBundle.en["PAR_FullRepair_ChatMode_Min"]        = PAC_COL_RED.."- %d "..PAC_ICON_GOLD
ResourceBundle.en["PAR_FullRepair_ChatMode_Normal"]     = PAC_COLTEXT_PAR..PAC_COL_RED.."- %d "..PAC_ICON_GOLD
ResourceBundle.en["PAR_FullRepair_ChatMode_Full"]       = PAC_COLTEXT_PAR.."All %s items repaired for "..PAC_COL_RED.."- %d "..PAC_ICON_GOLD

-- PARepair Chat Output - Partial Repair --
ResourceBundle.en["PAR_PartialRepair_ChatMode_None"]    = "<no output>"
ResourceBundle.en["PAR_PartialRepair_ChatMode_Min"]     = PAC_COL_RED.."- %d "..PAC_ICON_GOLD..PAC_COL_DEFAULT.." (%d "..PAC_ICON_GOLD..")"
ResourceBundle.en["PAR_PartialRepair_ChatMode_Normal"]  = PAC_COLTEXT_PAR..PAC_COL_RED.."- %d "..PAC_ICON_GOLD..PAC_COL_DEFAULT.." (%d "..PAC_ICON_GOLD.." missing)"
ResourceBundle.en["PAR_PartialRepair_ChatMode_Full"]    = PAC_COLTEXT_PAR.."%d / %d %s items repaired for "..PAC_COL_RED.."- %d "..PAC_ICON_GOLD..PAC_COL_DEFAULT.." (%d "..PAC_ICON_GOLD.." missing for full repair)"

-- PARepair Chat Output - Weapon Charge --
ResourceBundle.en["PAR_ReChargeWeapon_ChatMode_None"]   = "<no output>"
ResourceBundle.en["PAR_ReChargeWeapon_ChatMode_Min"]    = PAC_COL_DEFAULT.."%s %s (%d%% --> %d%%)"
ResourceBundle.en["PAR_ReChargeWeapon_ChatMode_Normal"] = PAC_COLTEXT_PAR.."%s (%d%% --> %d%%) - %s"
ResourceBundle.en["PAR_ReChargeWeapon_ChatMode_Full"]   = PAC_COLTEXT_PAR.."Charged %s %s from %d%% to %d%%  with %s %s"

-- PABanking --
ResourceBundle.en["PAB_GoldDeposited"]                  = PAC_COLTEXT_PAB.."%d "..PAC_ICON_GOLD.." deposited."
ResourceBundle.en["PAB_GoldWithdrawn"]                  = PAC_COLTEXT_PAB.."%d "..PAC_ICON_GOLD.." withdrawn."
ResourceBundle.en["PAB_GoldWithdrawnInsufficient"]      = PAC_COLTEXT_PAB.."%d / %d "..PAC_ICON_GOLD.." withdrawn. (not enough gold in bank!)"

ResourceBundle.en["PAB_ItemMovedTo"]                    = PAC_COLTEXT_PAB.."%d x %s moved to %s."
ResourceBundle.en["PAB_ItemNotMovedTo"]                 = PAC_COLTEXT_PAB.."%d x %s NOT moved to %s."
ResourceBundle.en["PAB_ItemMovedToFailed"]              = PAC_COLTEXT_PAB..PAC_COL_ORANGE.."FAILURE: %s could NOT be moved to %s."

ResourceBundle.en["PAB_NoSpaceInFor"]                   = PAC_COLTEXT_PAB..PAC_COL_ORANGE.."Not enough space in %s for: %s."
ResourceBundle.en["PAB_NoDeposit"]                      = PAC_COLTEXT_PAB.."Nothing to deposit."

ResourceBundle.en["PAB_ItemType_None"]                  = "-"
ResourceBundle.en["PAB_ItemType_Deposit"]               = "Deposit"
ResourceBundle.en["PAB_ItemType_Withdrawal"]            = "Withdraw"
ResourceBundle.en["PAB_ItemType_Inherit"]               = "Depending on item type (below)"

ResourceBundle.en["PAB_MoveTo_Ignore"]                  = "Ignore"
ResourceBundle.en["PAB_MoveTo_Bank"]                    = "Deposit to Bank"
ResourceBundle.en["PAB_MoveTo_Backpack"]                = "Withdraw to Backpack"

-- PALoot --
ResourceBundle.en["PAL_ItemType_Ignore"]                = "Ignore"
ResourceBundle.en["PAL_ItemType_AutoLoot"]              = "Auto-Loot"
ResourceBundle.en["PAL_ItemType_LootDestroy"]           = "Auto-Loot and "..PAC_COL_RED.."Destroy"

ResourceBundle.en["PAL_RecipeUnknown_Suffix"]           = "(unknown)"

ResourceBundle.en["PAL_ItemType_Ignore_T"]              = "Nothing happens, the item is ignored"
ResourceBundle.en["PAL_ItemType_AutoLoot_T"]            = "Automatically loots the item"
ResourceBundle.en["PAL_ItemType_LootDestroy_T"]         = PAC_COL_RED.."CAUTION: USE AT OWN RISK!|r Automatically loots the item, but then immediately destroys the looted amount again."

-- PALoot Chat Output - Loot Gold --
ResourceBundle.en["PAL_Gold_ChatMode_None"]             = "<no output>"
ResourceBundle.en["PAL_Gold_ChatMode_Min"]              = PAC_COL_GREEN.."+ %d "..PAC_ICON_GOLD
ResourceBundle.en["PAL_Gold_ChatMode_Normal"]           = PAC_COLTEXT_PAL..PAC_COL_GREEN.."+ %d "..PAC_ICON_GOLD
ResourceBundle.en["PAL_Gold_ChatMode_Full"]             = PAC_COLTEXT_PAL.."Looted "..PAC_COL_GREEN.."+ %d "..PAC_ICON_GOLD..PAC_COL_DEFAULT.." Gold"

-- PALoot Chat Output - Loot Items --
ResourceBundle.en["PAL_Items_ChatMode_None"]            = "<no output>"
ResourceBundle.en["PAL_Items_ChatMode_Min"]             = PAC_COL_DEFAULT.."%d x %s %s"
ResourceBundle.en["PAL_Items_ChatMode_Normal"]          = PAC_COL_DEFAULT.."%d x %s %s %s"
ResourceBundle.en["PAL_Items_ChatMode_Full"]            = PAC_COLTEXT_PAL.."%d x %s %s %s"

-- PALoot Chat Output - Loot Items Destroyed--
ResourceBundle.en["PAL_ItemsDestroy_Min"]               = PAC_COL_DEFAULT.."%d x %s destroyed"
ResourceBundle.en["PAL_ItemsDestroy_Normal"]            = PAC_COL_DEFAULT.."%d x %s %s destroyed"
ResourceBundle.en["PAL_ItemsDestroy_Full"]              = PAC_COLTEXT_PAL.."%d x %s %s have been destroyed"
ResourceBundle.en["PAL_ItemsDestroy_MoveFailed"]        = PAC_COLTEXT_PAL..PAC_COL_ORANGE.."FAILURE: Could NOT split %d/%d %s %s into seperate stack to destroy safely"
ResourceBundle.en["PAL_ItemsDestroy_DestroyFailed"]     = PAC_COLTEXT_PAL..PAC_COL_ORANGE.."FAILURE: No free inventory slot to safely destroy %d/%d %s %s"

-- PAJunk --
ResourceBundle.en["PAJ_MarkedAsJunk"]                   = PAC_COLTEXT_PAJ.."Marked %s as junk"
ResourceBundle.en["PAJ_SoldJunkInfo"]                   = PAC_COLTEXT_PAJ.."Sold junk items for "..PAC_COL_GREEN.."%d "..PAC_ICON_GOLD

-- MainMenu --
ResourceBundle.en["MMenu_Title"]                        = PAC_COLTEXT_PA

-- PAGMenu --
ResourceBundle.en["PAGMenu_Header"]                     = PAC_COLTEXT_PAG
ResourceBundle.en["PAGMenu_ActiveProfile"]              = "Active profile"
ResourceBundle.en["PAGMenu_ActiveProfile_T"]            = "Select the profile settings that shall be used. Changing the selection will automatically load the settings. Changes below will automatically be stored under the profile."
ResourceBundle.en["PAGMenu_ActiveProfileRename"]        = "Rename active profile"
ResourceBundle.en["PAGMenu_ActiveProfileRename_T"]      = "Rename the active profile"
ResourceBundle.en["PAGMenu_Welcome"]                    = "Show welcome message"
ResourceBundle.en["PAGMenu_Welcome_T"]                  = "Display a welcome message from the addon upon successfully starting?"

-- PARMenu --
ResourceBundle.en["PARMenu_Header"]                     = PAC_COLTEXT_PAR
ResourceBundle.en["PARMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Enable Auto Repair"
ResourceBundle.en["PARMenu_Enable_T"]                   = "Enable Auto Repair?"
ResourceBundle.en["PARMenu_RepairWornGold"]             = "Repair equipped items"
ResourceBundle.en["PARMenu_RepairWornGold_T"]           = "Repair equipped items at a merchant?"
ResourceBundle.en["PARMenu_RepairWornGoldDura"]         = "- Durability threshold in %"
ResourceBundle.en["PARMenu_RepairWornGoldDura_T"]       = "Repair equipped items only if they are at or below the defined durability threshold."
ResourceBundle.en["PARMenu_RepairWornKit"]              = "Use Repair Kits"
ResourceBundle.en["PARMenu_RepairWornKit_T"]            = "Repair equipped items with repair kits when out in the field? (Common repair kits will be used before greater ones)"
ResourceBundle.en["PARMenu_RepairWornKitDura"]          = "- Durability threshold in %"
ResourceBundle.en["PARMenu_RepairWornKitDura_T"]        = "Equipped items will only be repaired with a repair kit when their durability is at or below the defined threshold"
ResourceBundle.en["PARMenu_RepairFullChatMode"]         = "Chat display: Full repairs"
ResourceBundle.en["PARMenu_RepairFullChatMode_T"]       = "How to display the information of a full repair in the chat window"
ResourceBundle.en["PARMenu_RepairPartialChatMode"]      = "Chat display: Partial/incomplete repairs"
ResourceBundle.en["PARMenu_RepairPartialChatMode_T"]    = "How to display the information of an incomplet or parcial repair i.e. due to insufficient gold) in the chat window"

ResourceBundle.en["PARMenu_ChargeWeapons"]              = "Re-Charge Weapons"
ResourceBundle.en["PARMenu_ChargeWeapons_T"]            = "Re-Charge equipped weapons?"
ResourceBundle.en["PARMenu_ChargeWeaponsDura"]          = "- Re-Charge threshold in %"
ResourceBundle.en["PARMenu_ChargeWeaponsDura_T"]        = "Re-Charge equipped weapons when their charge level is at or below the defined threshold. (Lesser soul gems will be used before common ones)"
ResourceBundle.en["PARMenu_ChargeWeaponsChatMode"]      = "Chat display: Charging weapons"
ResourceBundle.en["PARMenu_ChargeWeaponsChatMode_T"]    = "How to display the information of a re-charged weapon in the chat window"

-- PABMenu --
ResourceBundle.en["PABMenu_Header"]                     = PAC_COLTEXT_PAB
ResourceBundle.en["PABMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Enable Auto Banking"
ResourceBundle.en["PABMenu_Enable_T"]                   = "Enable Auto Bank Deposit and Withdrawal?"
ResourceBundle.en["PABMenu_EnabledGold"]                = "Deposit Gold"
ResourceBundle.en["PABMenu_EnabledGold_T"]              = "Auto deposit gold to bank?"
ResourceBundle.en["PABMenu_GoldTransactionStep"]        = "- Gold transactions in steps of "
ResourceBundle.en["PABMenu_GoldTransactionStep_T"]      = "In what steps shall gold be deposited and withdrawn?"
ResourceBundle.en["PABMenu_GoldMinToKeep"]              = "- Min gold to keep on character"
ResourceBundle.en["PABMenu_GoldMinToKeep_T"]            = "Minimum amount of gold to always keep on the character."
ResourceBundle.en["PABMenu_GoldMinToKeep_W"]            = "Invalid number --> No gold shall be kept on the character."
ResourceBundle.en["PABMenu_WithdrawToMinGold"]          = "- Withdraw gold if below minimum"
ResourceBundle.en["PABMenu_WithdrawToMinGold_T"]        = "Automatically withdraw gold from the bank if there is less gold on the character than defined above?"
ResourceBundle.en["PABMenu_EnabledItems"]               = "Deposit and withdraw items"
ResourceBundle.en["PABMenu_EnabledItems_T"]             = "Auto deposit and/or withdraw items to and from the bank?"
ResourceBundle.en["PABMenu_DepItemTypeDesc"]            = "Define an individual behaviour (deposit, withdraw, ignore) for common item types as well as more advanced ones."
ResourceBundle.en["PABMenu_ItemTypeMaterialSubmenu"]    = "Crafting Material"
ResourceBundle.en["PABMenu_ItemTypeMaterialESOPlusDesc"]= PAC_COL_LIGHT_BLUE.."As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag."
ResourceBundle.en["PABMenu_DepItemType"]                = "Common item types"
ResourceBundle.en["PABMenu_DepItemType_T"]              = "Open the sub-menu to define for each item type whether it shall be deposited, withdrawn or ignored."
ResourceBundle.en["PABMenu_DepStackOnly"]               = "Stacking type (Deposit)"
ResourceBundle.en["PABMenu_DepStackOnly_T"]             = "Define whether all matching items shall be deposited completely, if only items that exist in the target container shall be deposited or if only existing stacks shall be filled up to their max size."
ResourceBundle.en["PABMenu_WitStackOnly"]               = "Stacking type (Withdraw)"
ResourceBundle.en["PABMenu_WitStackOnly_T"]             = "Define whether all matching items shall be withdrawn completely, if only items that exist in the target container shall be withdrawn or if only existing stacks shall be filled up to their max size."
ResourceBundle.en["PABMenu_Advanced_DepItemType"]       = "Advanced item types"
ResourceBundle.en["PABMenu_Advanced_DepItemType_T"]     = "Open the sub-menu to define for other item types on an advanced level whether they shall be deposited, withdrawn or ignored."
ResourceBundle.en["PABMenu_DepItemTimerInterval"]       = "- Interval between item deposits (msecs)"
ResourceBundle.en["PABMenu_DepItemTimerInterval_T"]     = "How many msecs shall pass between two consecutive item deposits. If too many item deposits don't work, consider increasing this value."
ResourceBundle.en["PABMenu_ItemType_Header"]            = PAC_COL_LIGHT_BLUE.."ITEM TYPES"
ResourceBundle.en["PABMenu_HideNoDeposit"]              = "Hide 'Nothing to Deposit' message"
ResourceBundle.en["PABMenu_HideNoDeposit_T"]            = "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though."
ResourceBundle.en["PABMenu_HideAll"]                    = "Hide ALL banking messages"
ResourceBundle.en["PABMenu_HideAll_T"]                  = "Silent-Mode: No banking message will be displayed. You also won't see your deposited gold/items."
ResourceBundle.en["PABMenu_DepButton"]                  = "Deposit all"
ResourceBundle.en["PABMenu_DepButton_T"]                = "Change all dropdown values to 'Deposit'"
ResourceBundle.en["PABMenu_WitButton"]                  = "Withdraw all"
ResourceBundle.en["PABMenu_WitButton_T"]                = "Change all dropdown values to 'Withdraw'"
ResourceBundle.en["PABMenu_IgnButton"]                  = "Ignore all"
ResourceBundle.en["PABMenu_IgnButton_T"]                = "Change all dropdown values to '-'"
ResourceBundle.en["PABMenu_Lockipck_Header"]            = PAC_COL_LIGHT_BLUE.."Lockpicks"
ResourceBundle.en["PABMenu_Keep_in_Backpack"]           = "Amount to keep in backpack"
ResourceBundle.en["PABMenu_Keep_in_Backpack_T"]         = "Define the amount which shall together with the mathematical operator be kept in the backpack."

-- PALMenu --
ResourceBundle.en["PALMenu_Header"]                     = PAC_COLTEXT_PAL
ResourceBundle.en["PALMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Enable Auto Loot"
ResourceBundle.en["PALMenu_Enable_T"]                   = "Enable Auto Loot?"
ResourceBundle.en["PALMenu_LootGold"]                   = "Auto-Loot gold"
ResourceBundle.en["PALMenu_LootGold_T"]                 = "Automatically loot gold?"
ResourceBundle.en["PALMenu_LootGoldChatMode"]           = "Chat Display of Auto-Looted Gold"
ResourceBundle.en["PALMenu_LootGoldChatMode_T"]         = "How to display the information of looted gold in the chat window"
ResourceBundle.en["PALMenu_LootItems"]                  = "Auto-Loot items"
ResourceBundle.en["PALMenu_LootItems_T"]                = "Automatically loot items?"
ResourceBundle.en["PALMenu_LootItemsChatMode"]          = "Chat Display of Auto-Looted Items"
ResourceBundle.en["PALMenu_LootItemsChatMode_T"]        = "How to display the information of looted items in the chat window"
ResourceBundle.en["PALMenu_LootStolenItems"]            = "Auto-Steal items"
ResourceBundle.en["PALMenu_LootStolenItems_T"]          = "Include (to be) stolen items for the Auto-Loot?"
ResourceBundle.en["PALMenu_HarvestableItems"]           = "Harvestable items"
ResourceBundle.en["PALMenu_HarvestableItems_T"]         = "Open the sub-menu to define for each harvestable item type whether it shall be auto-looted or not."
ResourceBundle.en["PALMenu_HarvestableItemsDesc"]       = "Enable and disable auto-loot for harvestable items such as ores, herbs, woods, runestones, or fishing holes."
ResourceBundle.en["PALMenu_HarvestableItems_Bait_Header"] = PAC_COL_LIGHT_BLUE.."BAIT HANDLING"
ResourceBundle.en["PALMenu_HarvestableItems_Bait"]      = "Handling of [Bait] items"
ResourceBundle.en["PALMenu_HarvestableItems_Bait_T"]    = "When looting harvestable items, sometimes there also is bait which prevents the node from re-spawning when not looted. Define here what should happen in such cases."
ResourceBundle.en["PALMenu_HarvestableItems_Header"]    = PAC_COL_LIGHT_BLUE.."ITEM TYPES"
ResourceBundle.en["PALMenu_LootableItems"]              = "Lootable items"
ResourceBundle.en["PALMenu_LootableItems_T"]            = "Open the sub-menu to define for each lootable item type whether it shall be auto-looted or not."
ResourceBundle.en["PALMenu_LootableItemsDesc"]          = "Enable and disable auto-loot for lootable items such as clothing raw materials from animals."
ResourceBundle.en["PALMenu_LootableItems_Header"]       = PAC_COL_LIGHT_BLUE.."ITEM TYPES"
ResourceBundle.en["PALMenu_AutoLootQuestItems"]         = "Quest Items"
ResourceBundle.en["PALMenu_AutoLootLockpicks"]          = "Lockpick"
ResourceBundle.en["PALMenu_AutoLootAllButton"]          = "Auto-Loot all"
ResourceBundle.en["PALMenu_AutoLootAllButton_T"]        = "Change all dropdown values to 'Auto-Loot'"
ResourceBundle.en["PALMenu_IgnButton"]                  = "Ignore all"
ResourceBundle.en["PALMenu_IgnButton_T"]                = "Change all dropdown values to 'Ignore'"

-- PAJMenu --
ResourceBundle.en["PAJMenu_Header"]                     = PAC_COLTEXT_PAJ
ResourceBundle.en["PAJMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Enable Auto Junk"
ResourceBundle.en["PAJMenu_Enable_T"]                   = "Enable Auto Junk?"
ResourceBundle.en["PAJMenu_ItemTypeDesc"]               = "Enable and disable the automatic marking as junk for different item types."
ResourceBundle.en["PAJMenu_AutoSellJunk"]               = "Auto-Sell Junk?"
ResourceBundle.en["PAJMenu_AutoSellJunk_T"]             = "Automatically sell all items marked as junk?"
ResourceBundle.en["PAJMenu_AutoMarkTrash"]              = "Auto-Mark [Trash]"
ResourceBundle.en["PAJMenu_AutoMarkTrash_T"]            = "Automatically mark items of type [Trash] as junk?"
ResourceBundle.en["PAJMenu_AutoMarkOrnate"]             = "Auto-Mark [Ornate] trait"
ResourceBundle.en["PAJMenu_AutoMarkOrnate_T"]           = "Automatically mark items with [Ornate] trait as junk?"

-- Name Spaces --
ResourceBundle.en["NS_Bag_Equipment"]                   = ""    -- not required so far
ResourceBundle.en["NS_Bag_Equipped"]                    = "equipped"
ResourceBundle.en["NS_Bag_Backpack"]                    = "backpack"
ResourceBundle.en["NS_Bag_Backpacked"]                  = "backpack"
ResourceBundle.en["NS_Bag_Bank"]                        = "bank"
ResourceBundle.en["NS_Bag_Banked"]                      = ""    -- not required so far
ResourceBundle.en["NS_Bag_Unknown"]                     = "unknown"

-- Operators --
ResourceBundle.en["REL_Operator"]                       = "Mathematical Operator"
ResourceBundle.en["REL_None"]                           = "-"
ResourceBundle.en["REL_Equal"]                          = "equals (=)"
ResourceBundle.en["REL_LessThan"]                       = "less than (<)"        -- not required so far
ResourceBundle.en["REL_LessThanEqual"]                  = "less than or equal to (<=)"
ResourceBundle.en["REL_GreaterThan"]                    = "greater than (>)"    -- not required so far
ResourceBundle.en["REL_GreaterThanEqual"]               = "greater than or equal to (>=)"

-- Stacking types --
ResourceBundle.en["ST_MoveAllFull"]                     = "Move everything"                -- 0: Full deposit
ResourceBundle.en["ST_MoveExistingFull"]                = "Move all if a stack exists"    -- 1: Deposit if existing
ResourceBundle.en["ST_FillIncompleteOnly"]              = "Only fill up existing stacks"-- 2: Fill existing stacks

-- Official Item Types --
ResourceBundle.en[ITEMTYPE_ADDITIVE]                    = "enITEMTYPE_ADDITIVE"
ResourceBundle.en[ITEMTYPE_ARMOR]                       = "Armor (any)"
ResourceBundle.en[ITEMTYPE_ARMOR_BOOSTER]               = "enITEMTYPE_ARMOR_BOOSTER"
ResourceBundle.en[ITEMTYPE_ARMOR_TRAIT]                 = "Armor Trait"
ResourceBundle.en[ITEMTYPE_AVA_REPAIR]                  = "enITEMTYPE_AVA_REPAIR"
ResourceBundle.en[ITEMTYPE_BLACKSMITHING_BOOSTER]       = "Temper (Blacksmithing)"
ResourceBundle.en[ITEMTYPE_BLACKSMITHING_MATERIAL]      = "Material (Blacksmithing)"
ResourceBundle.en[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]  = "Raw Material (Blacksmithing)"
ResourceBundle.en[ITEMTYPE_CLOTHIER_BOOSTER]            = "Tannin (Clothing)"
ResourceBundle.en[ITEMTYPE_CLOTHIER_MATERIAL]           = "Material (Clothing)"
ResourceBundle.en[ITEMTYPE_CLOTHIER_RAW_MATERIAL]       = "Raw Material (Clothing)"
ResourceBundle.en[ITEMTYPE_COLLECTIBLE]                 = "Collectible"
ResourceBundle.en[ITEMTYPE_CONTAINER]                   = "Container"
ResourceBundle.en[ITEMTYPE_COSTUME]                     = "Costume"
ResourceBundle.en[ITEMTYPE_CROWN_ITEM]                  = "enITEMTYPE_CROWN_ITEM"
ResourceBundle.en[ITEMTYPE_CROWN_REPAIR]                = "enITEMTYPE_CROWN_REPAIR"
ResourceBundle.en[ITEMTYPE_DEPRECATED]                  = "enITEMTYPE_DEPRECATED"
ResourceBundle.en[ITEMTYPE_DISGUISE]                    = "enITEMTYPE_DISGUISE"
ResourceBundle.en[ITEMTYPE_DRINK]                       = "Drink"
ResourceBundle.en[ITEMTYPE_ENCHANTING_RUNE_ASPECT]      = "Aspect Runestone (Enchanting)"
ResourceBundle.en[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]     = "Essence Runestone (Enchanting)"
ResourceBundle.en[ITEMTYPE_ENCHANTING_RUNE_POTENCY]     = "Potency Runestone (Enchanting)"
ResourceBundle.en[ITEMTYPE_ENCHANTMENT_BOOSTER]         = "enITEMTYPE_ENCHANTMENT_BOOSTER"
ResourceBundle.en[ITEMTYPE_FISH]                        = "Fish"
ResourceBundle.en[ITEMTYPE_FLAVORING]                   = "enITEMTYPE_FLAVORING"
ResourceBundle.en[ITEMTYPE_FOOD]                        = "Food"
ResourceBundle.en[ITEMTYPE_GLYPH_ARMOR]                 = "Armor Glyph (Enchanting)"
ResourceBundle.en[ITEMTYPE_GLYPH_JEWELRY]               = "Jewelry Glyph (Enchanting)"
ResourceBundle.en[ITEMTYPE_GLYPH_WEAPON]                = "Weapon Glyph (Enchanting)"
ResourceBundle.en[ITEMTYPE_INGREDIENT]                  = "Ingredient (Provisioning)"
ResourceBundle.en[ITEMTYPE_LOCKPICK]                    = "enITEMTYPE_LOCKPICK"
ResourceBundle.en[ITEMTYPE_LURE]                        = "Bait"
ResourceBundle.en[ITEMTYPE_MASTER_WRIT]                 = "enITEMTYPE_MASTER_WRIT"
ResourceBundle.en[ITEMTYPE_MAX_VALUE]                   = "enITEMTYPE_MAX_VALUE"
ResourceBundle.en[ITEMTYPE_MIN_VALUE]                   = "enITEMTYPE_MIN_VALUE"
ResourceBundle.en[ITEMTYPE_MOUNT]                       = "enITEMTYPE_MOUNT"
ResourceBundle.en[ITEMTYPE_NONE]                        = "enITEMTYPE_NONE"
ResourceBundle.en[ITEMTYPE_PLUG]                        = "enITEMTYPE_PLUG"
ResourceBundle.en[ITEMTYPE_POISON]                      = "Poison"
ResourceBundle.en[ITEMTYPE_POISON_BASE]                 = "Poison Solvent (Alchemy)"
ResourceBundle.en[ITEMTYPE_POTION]                      = "Potion"
ResourceBundle.en[ITEMTYPE_POTION_BASE]                 = "Potion Solvent (Alchemy)"
ResourceBundle.en[ITEMTYPE_RACIAL_STYLE_MOTIF]          = "Motif"
ResourceBundle.en[ITEMTYPE_RAW_MATERIAL]                = "Raw Material"
ResourceBundle.en[ITEMTYPE_REAGENT]                     = "Reagent (Alchemy)"
ResourceBundle.en[ITEMTYPE_RECIPE]                      = "Recipe (Provisioning)"
ResourceBundle.en[ITEMTYPE_SIEGE]                       = "enITEMTYPE_SIEGE"
ResourceBundle.en[ITEMTYPE_SOUL_GEM]                    = "Soul Gem"
ResourceBundle.en[ITEMTYPE_SPELLCRAFTING_TABLET]        = "enITEMTYPE_SPELLCRAFTING_TABLET"
ResourceBundle.en[ITEMTYPE_SPICE]                       = "enITEMTYPE_SPICE"
ResourceBundle.en[ITEMTYPE_STYLE_MATERIAL]              = "Style Material"
ResourceBundle.en[ITEMTYPE_TABARD]                      = "enITEMTYPE_TABARD"
ResourceBundle.en[ITEMTYPE_TOOL]                        = "Tool"
ResourceBundle.en[ITEMTYPE_TRASH]                       = "Trash"
ResourceBundle.en[ITEMTYPE_TREASURE]                    = "enITEMTYPE_TREASURE"
ResourceBundle.en[ITEMTYPE_TROPHY]                      = "Trophy"
ResourceBundle.en[ITEMTYPE_WEAPON]                      = "Weapon (any)"
ResourceBundle.en[ITEMTYPE_WEAPON_BOOSTER]              = "enITEMTYPE_WEAPON_BOOSTER"
ResourceBundle.en[ITEMTYPE_WEAPON_TRAIT]                = "Weapon Trait"
ResourceBundle.en[ITEMTYPE_WOODWORKING_BOOSTER]         = "Resin (Woodworking)"
ResourceBundle.en[ITEMTYPE_WOODWORKING_MATERIAL]        = "Material (Woodworking)"
ResourceBundle.en[ITEMTYPE_WOODWORKING_RAW_MATERIAL]    = "Raw Material (Woodworking)"