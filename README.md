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

## Future Development Ideas

This is my development ToDo list for the subsequent releases of PersonalAssistant after the release of V2

How to read:
* [X] **(1)** Feature is implemented (had priority **(1)**)
* [ ] **(3)** Feature is not yet implemented (has priority **(3)**)

#### General
* [ ] **(4)** Check Currency Formatting
    * https://wiki.esoui.com/Currency_Formatting
* [ ] **(6)** Check ItemLink Handling in HelperFunctions.lua
  * http://www.esoui.com/forums/showthread.php?t=2054
  * http://www.esoui.com/forums/showthread.php?t=1944
  * https://wiki.esoui.com/ZO_LinkHandler_CreateLink
* [ ] **(7)** Add LDoc
    * https://stevedonovan.github.io/ldoc/manual/doc.md.html
* [ ] **(8)** Check new API from patch 4.3 (Wrathstone)
    ```lua
    GetItemLinkTraitType(itemLink) – itemTraitType.
    GetAddOnRootDirectoryPath(addOnIndex) – directoryPath.
    GetAddOnVersion(addOnIndex) – version.
    ```

#### PARepair
* [ ] **(4)** PARepair: Logic for Grand Repair Kits vs. Crown Repair Kits


#### PABanking
* [ ] **(4)** PABanking: Add summary after transaction completed
* [ ] **(5)** PAJunk: Add support for FCOItemSaver (i.e. do not deposit/withdraw items that are locked?)
  * http://www.esoui.com/downloads/info630-FCOItemSaver.html
  * www.esoui.com/forums/showthread.php?t=6987
* [ ] **(5)** PABanking: Support Home Storage Banking Bags?
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
* [ ] **(3)** PAJunk: Add support for FCOItemSaver
  * http://www.esoui.com/downloads/info630-FCOItemSaver.html
  * www.esoui.com/forums/showthread.php?t=6987
* [ ] **(3)** PAJunk: Add item context menu to flag permanently item as junk
* [ ] **(4)** PAJunk: Destroy items with 0g value (or non-sellable ones) that are marked as junk
* [ ] **(4)** PAJunk: Auto-Junk "bad" default potions/poisons as well as drinks & food without any buffs 


#### PAMail
* [ ] **(9)** PAMail: Automatically open Mailbox and take items from Hirelings (feasible? interval? at-login?)
* [ ] **(9)** PAMail: Chat notification about looted items from Hirelings 
* [ ] **(9)** PAMail: Check API
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
