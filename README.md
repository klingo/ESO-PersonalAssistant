# PersonalAssistant
PersonalAssistant, an Add-on for '[The Elder Scrolls Online](https://www.elderscrollsonline.com/ "Home - The Elder Scrolls Online")'

***

## Download
You can always download the latest version here: http://www.esoui.com/downloads/info381-PersonalAssistant.html


***

## How to use
PersonalAssistant is an Add-on for '[The Elder Scrolls Online](https://www.elderscrollsonline.com/ "Home - The Elder Scrolls Online")' and consists of multiple nested Add-ons that can independently be turned on or off. The following section will explain in more detail how to use the different parts. 

#### PersonalAssistant
tbd

#### PersonalAssistant Banking
tbd

#### PersonalAssistant Junk
tbd

#### PersonalAssistant Loot
tbd

#### PersonalAssistant Repair
tbd


***

## Development ToDo (v2.0.0)

This is my development ToDo list for the initial V2 release of PersonalAssistant

How to read:
* [X] **(1)** Feature is implemented (had priority **(1)**)
* [ ] **(3)** Feature is not yet implemented (has priority **(3)**)

#### General
* [X] **(1)** Update to latest LAM version
* [X] **(1)** Get rid of LibStub (no longer needed due to AddOnVersion)
    * https://www.esoui.com/downloads/info44-LibStub.html
* [X] **(1)** Remove LibAddonMenu out of addon and make it a hard dependency
* [X] **(1)** Make "PersonalAssistant" the top-level-Addon and move others as nested-Addons
  * https://wiki.esoui.com/Addon_Structure
* [X] **(2)** Support ESO Plus Bag: BAG_VIRTUAL (Dark Brotherhood)
    * https://forums.elderscrollsonline.com/en/discussion/261946/dark-brotherhood-api-patch-notes-change-log-pts
* [X] **(2)** Support ESO Plus Bag: BAG_SUBSCRIBER_BANK (Morrowind)
    * https://forums.elderscrollsonline.com/en/discussion/335644/update-14-api-patch-notes-change-log-pts
* [X] **(2)** Check proper initialization of default values on first-time-use
* [X] **(3)** Check Singular/Plural formatting for HelperFunctions.lua
    * http://www.esoui.com/forums/showthread.php?p=7988
    * https://wiki.esoui.com/How_to_format_strings_with_zo_strformat
* [ ] **(4)** Refactoring of EventManager
* [ ] **(4)** Check Currency Formatting
    * https://wiki.esoui.com/Currency_Formatting
* [X] **(5)** Update Addon Manifest
  * https://wiki.esoui.com/Addon_manifest_(.txt)_format
  * AddOnVersion
  * Variable Expansion - $(language)
* [X] **(5)** Update localization to make use of ESO API
    * https://wiki.esoui.com/How_to_add_localization_support
    ```lua
    GetString(string stringVariablePrefix, number contextId)
      Returns: string stringValue 
    ZO_CreateStringId(stringId, stringToAdd)
    SafeAddVersion(stringId, stringVersion) 
    SafeAddString(stringId, stringValue, stringVersion) 
    ```
* [ ] **(4)** Cleanup Localizations and Getter/Setter Functions
* [ ] **(5)** Add German Localization
* [ ] **(5)** Add French Localization (NTakit)
* [ ] **(6)** Check ItemLink Handling in HelperFunctions.lua
  * http://www.esoui.com/forums/showthread.php?t=2054
  * http://www.esoui.com/forums/showthread.php?t=1944
  * https://wiki.esoui.com/ZO_LinkHandler_CreateLink
* [x] **(7)** Update Currency System
  * https://forums.elderscrollsonline.com/en/discussion/200789/imperial-city-api-patch-notes-change-log-live/p1
  * https://forums.elderscrollsonline.com/en/discussion/371967/update-16-api-patch-notes-change-log-pts#latest
* [ ] **(8)** Check new API from patch 4.3 (Wrathstone)
    ```lua
    GetItemLinkTraitType(itemLink) – itemTraitType.
    GetAddOnRootDirectoryPath(addOnIndex) – directoryPath.
    GetAddOnVersion(addOnIndex) – version.
    ```
  
  

#### PARepair
* [X] **(3)** PARepair: Implement Repair Kits
* [X] **(3)** PARepair: Check API
    ```lua
    CanStoreRepair() 
  
    GetItemRepairCost(number Bag bagId, number slotIndex)
          Returns: number repairCost
    GetRepairAllCost()
          Returns: number repairCost
        
    IsItemRepairKit(number Bag bagId, number slotIndex)
          Returns: boolean isRepairKit
    IsItemNonCrownRepairKit(number Bag bagId, number slotIndex)
          Returns: boolean isNonCrownRepairKit
    GetRepairKitTier(number Bag bagId, number slotIndex)
          Returns: number tier
    GetAmountRepairKitWouldRepairItem(number Bag itemToRepairBagId, number itemToRepairSlotIndex, number Bag repairKitToConsumeBagId, number repairKitToConsumeSlotIndex)
          Returns: number amountRepaired
    RepairItemWithRepairKit(number Bag itemToRepairBagId, number itemToRepairSlotIndex, number Bag repairKitToConsumeBagId, number repairKitToConsumeSlotIndex)       
    ```
* [ ] **(5)** PARepair: Add Notification Options (Individual Options & Overall Silent-Mode)

#### PABanking
* [X] **(1)** PABanking: Refactor regarding inventory-loop  
    https://www.esoui.com/forums/showthread.php?t=7053&highlight=GetOrCreateBagCache
    ```lua
    local bagSlots = SHARED_INVENTORY:GetBagCache(BAG_BACKPACK)
    if bagSlots then
        for index, data in pairs(bagSlots) do
            data.stolen
            data.isGemmable
            itemLink = GetItemLink(BAG_BACKPACK, index)
        end
    end
    ```
* [X] **(1)** PABanking: Refactor regarding Item Movement  
    ```lua
    RequestMoveItem (number sourceBag, number sourceSlot, number destBag, number destSlot, number stackCount)
    ```
* [X] **(1)** PABanking: Crafting Material - Add buttons for Deposit/Withdraw/Ignore all
* [X] **(1)** PABanking: Crafting Material - Add Jewelcrafting items
    ```lua
    ITEMTYPE_JEWELRYCRAFTING_BOOSTER
    ITEMTYPE_JEWELRYCRAFTING_MATERIAL
    ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER
    ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL
    ITEMTYPE_JEWELRY_RAW_TRAIT
    ITEMTYPE_JEWELRY_TRAIT
    ```
* [X] **(1)** PABanking: Crafting Material - Add Furnishing items
    ```lua
    ITEMTYPE_FURNISHING
    ITEMTYPE_FURNISHING_MATERIAL 
    ```
* [X] **(2)** PABanking: Individual Item Types - Add Soul gems (empty / filled)
* [X] **(3)** PABanking: Check new function for transferring currencies
    ```lua
    TransferCurrency(currencyType, amount, fromLocation, toLocation).
    ```
* [X] **(3)** PABanking: Support all four currency types
* [X] **(3)** PABanking: Common Item Types - Add Maps (utilizing SpeializedItemTypes)
* [X] **(3)** PABanking: Individual Item Types - Add Repair Kits (only Grand?)
* [X] **(4)** PABanking: Add Bank stacking when opening (or keybind?)
* [ ] **(5)** PABAnking: Add Notification Options (Individual Options & Overall Silent-Mode)

#### PALoot
* [ ] **(4)** PALoot: Inventory Size Warning
* [X] **(4)** PALoot: Harvestable Items - Add Jewelcrafting items --> No longer needed
* [X] **(4)** PALoot: Check API --> No longer needed
    ```lua
    LootAll(boolean ignoreStolenItems)
    LootItemById(number lootId)
    LootCurrency(number CurrencyType type)
    GetLootItemInfo(number lootIndex)
          Returns: number lootId, string name, textureName icon, number count, number quality, number value, boolean isQuest, boolean stolen, number LootItemType itemType
    ```
* [X] **(5)** PALoot: Check if special message for Stealing is added? --> No longer needed
* [ ] **(5)** PALoot: Add Notification Options (Individual Options & Overall Silent-Mode)
* [X] **(7)** PALoot: Loot other currencies than gold  - Still needed?! --> No!
    ```lua
    GetLootCurrency(number CurrencyType type)  
    Returns: number unownedCurrency, number ownedCurrency
  
    CURT_ALLIANCE_POINTS
    CURT_TELVAR_STONES
    ```
* [X] **(8)** PALoot: Check global ESO settings for AutoLoot
    * http://cdn.esoui.com/forums/showthread.php?p=20437
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AOE_LOOT)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_ADD_TO_CRAFT_BAG)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT_STOLEN)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_LOOT_HISTORY)

#### PAJunk
* [X] **(1)** PAJunk: Check if marking as Trash/Ornate works correctly (or implement)
* [X] **(2)** PAJunk: Notification for junk items, even if they are already marked as junk
* [X] **(4)** PAJunk: Auto-Junk Weapons/Armor of quality XYZ and below (unless it is a Set!)
* [ ] **(4)** PAJunk: Auto-Junk "bad" default potions/poisons as well as drinks & food without any buffs 
* [ ] **(5)** PAJunk: Add Notification Options (Individual Options & Overall Silent-Mode)


   
***


## Development ToDo (later)

This is my development ToDo list for the subsequent releases of PersonalAssistant afterwards

#### General
* [ ] **(7)** Add LDoc
    * https://stevedonovan.github.io/ldoc/manual/doc.md.html


#### PARepair
* [ ] **(3)** PARepair: Add option to choose Soul Gem amount for "low-count" warning
* [ ] **(3)** PARepair: Add option to choose Repair Kit amount for "low-count" warning
* [ ] **(4)** PARepair: Logic for Grand Repair Kits vs. Crown Repair Kits


#### PABanking
* [ ] **(4)** PABanking: Add summary after transaction completed
* [ ] **(5)** PAJunk: Add support for FCOItemSaver (i.e. do not deposit/withdraw items that are locked?)
  * http://www.esoui.com/downloads/info630-FCOItemSaver.html
  * www.esoui.com/forums/showthread.php?t=6987
* [ ] **(5)** PABanking: Support Home Storage Banking Bags
    ```lua
    BAG_HOUSE_BANK_ONE through BAG_HOUSE_BANK_TEN
    GetBankingBag() – bankingBag.
    IsHouseBankBag(bag) – isHouseBankBag.
    GetCollectibleForHouseBankBag(houseBankBag) – collectibleId.
    GetCollectibleBankAccessBag(collectibleId) – houseBankBag.
    ```
* [ ] **(7)** PABanking: Add progress bar for stacking


#### PALoot
* [ ] **(3)** PALoot: With ESO-Loot enabled, offer option to auto-loot stolen items only when hidden (if that ESO-setting is disabled)
    ```lua
    GetUnitStealthState(string unitTag)
          Returns: number stealthState
       
    EVENT_LOOT_UPDATED
    GetInteractionType()
          Returns: number InteractionType interactMode 
          INTERACTION_PICKPOCKET
          INTERACTION_LOOT
        
    GetNumLootItems()
          Returns: number count 
    GetLootItemInfo(number lootIndex)
          Returns: number lootId, string name, textureName icon, number count, number quality, number value, boolean isQuest, boolean stolen, number LootItemType lootType 
    LootItemById(number lootId) 
    GetLootMoney()
          Returns: number unownedMoney, number ownedMoney 
    LootMoney() 
    ```
* [ ] **(6)** PALoot: Add option to select certain Sets; if looted show notification and auto-lock item


#### PAJunk
* [ ] **(3)** PAJunk: Add support for ESO internal item-locking
* [ ] **(3)** PAJunk: Add support for FCOItemSaver
  * http://www.esoui.com/downloads/info630-FCOItemSaver.html
  * www.esoui.com/forums/showthread.php?t=6987
* [ ] **(3)** PAJunk: Add item context menu to flag permanently item as junk
* [ ] **(4)** PAJunk: Destroy items with 0g value that are marked as junk


#### PAMail
* [ ] **(8)** PAMail: Rename to PAWorker?
* [X] **(9)** PAMail: Automatically open Mailbox and take items from Hirelings (feasible? interval? at-login?)
* [ ] **(9)** PAMail: Chat notification about looted items from Hirelings 
* [X] **(9)** PAMail: Check API
    ```lua
    IsLocalMailboxFull()
          Returns: boolean isFull
    GetNumMailItems()
          Returns: number numMail
    GetNextMailId(id64:nilable lastMailId)
          Returns: id64:nilable nextMailId
    GetMailItemInfo(id64 mailId)
          Returns: string senderDisplayName, string senderCharacterName, string subject, textureName icon, boolean unread, boolean fromSystem, boolean fromCustomerService, boolean returned, number numAttachments, number attachedMoney, number codAmount, number expiresInDays, number secsSinceReceived
    GetMailSender(id64 mailId)
          Returns: string senderDisplayName, string senderCharacterName
    GetMailAttachmentInfo(id64 mailId)
          Returns: number numAttachments, number attachedMoney, number codAmount
    GetMailFlags(id64 mailId)
          Returns: boolean unread, boolean returned, boolean fromSystem, boolean fromCustomerService
    
    RequestOpenMailbox() 
    ReadMail(id64 mailId)
    TakeMailAttachedItems(id64 mailId)
    TakeMailAttachedMoney(id64 mailId)   
    DeleteMail(id64 mailId, boolean forceDelete)     
    CloseMailbox()            
    ```
* [X] **(9)** PAMail: Check API
    ```lua
    EVENT_NEW_DAILY_LOGIN_REWARD_AVAILABLE (number eventCode)          
    ```

#### PAWorker
* [ ] **(9)** PAWorker:  Add Button at Craft Stations to deconstruct all items of certain quality (except with unknown traits)
* [ ] **(9)** PAWorker:  Add Button at Craft Stations to refine all raw materials

***

## Disclaimer

**Disclaimer:**
This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.
