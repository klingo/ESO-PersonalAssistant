local PAC = PersonalAssistant.Constants
PersonalAssistant.Localization = {
    -- Type '/pa' for GUI."
    -- Welcome Messages --
    Welcome_NoSupport = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!   -   no localization for language [%s] available (yet)."}),
    Welcome_Support = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " at your service!"}),
    Welcome_PleaseSelectProfile = table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " welcomes you! In order to get started, please go to the Addon Settings (or type /pa) and select a profile. Thank you :-)"}),

    -- Key Bindings
    KB_Load_Profile1 = "Activate profile 1",
    KB_Load_Profile2 = "Activate profile 2",
    KB_Load_Profile3 = "Activate profile 3",
    KB_Load_Profile4 = "Activate profile 4",
    KB_Load_Profile5 = "Activate profile 5",

    -- =================================================================================================================

    -- PAGeneral --
    PAG_Profile1 = "Profile 1",
    PAG_Profile2 = "Profile 2",
    PAG_Profile3 = "Profile 3",
    PAG_Profile4 = "Profile 4",
    PAG_Profile5 = "Profile 5",
    PAG_PleaseSelectProfile = "<Please select Profile>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Chat Output - Full Repair --
    PAR_FullRepair_ChatMode_None = "<no output>",
    PAR_FullRepair_ChatMode_Min = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    PAR_FullRepair_ChatMode_Normal = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    PAR_FullRepair_ChatMode_Full = table.concat({PAC.COLORED_TEXTS.PAR, "All %s items repaired for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),

    -- PARepair Chat Output - Partial Repair --
    PAR_PartialRepair_ChatMode_None = "<no output>",
    PAR_PartialRepair_ChatMode_Min = table.concat({PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, ")"}),
    PAR_PartialRepair_ChatMode_Normal = table.concat({PAC.COLORED_TEXTS.PAR, PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " missing)"}),
    PAR_PartialRepair_ChatMode_Full = table.concat({PAC.COLORED_TEXTS.PAR, "%d / %d %s items repaired for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " missing for full repair)"}),

    -- PARepair Chat Output - Weapon Charge --
    PAR_ReChargeWeapon_ChatMode_None = "<no output>",
    PAR_ReChargeWeapon_ChatMode_Min = table.concat({PAC.COLORS.DEFAULT, "%s %s (%d%% --> %d%%)"}),
    PAR_ReChargeWeapon_ChatMode_Normal = table.concat({PAC.COLORED_TEXTS.PAR, "%s (%d%% --> %d%%) - %s"}),
    PAR_ReChargeWeapon_ChatMode_Full = table.concat({PAC.COLORED_TEXTS.PAR, "Charged %s %s from %d%% to %d%%  with %s %s"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    PAB_Currency_Withdrawal_Full = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s withdrawn."}),
    PAB_Currency_Withdrawal_Partial_Source = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn. (Bank is empty)"}),
    PAB_Currency_Withdrawal_Partial_Target = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s withdrawn. (Not enough space on character)"}),

    PAB_Currency_Deposit_Full = table.concat({PAC.COLORED_TEXTS.PAB, "%d %s deposited."}),
    PAB_Currency_Deposit_Partial_Source = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited. (Character is empty)"}),
    PAB_Currency_Deposit_Partial_Target = table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s deposited. (Not enough space in bank)"}),

    PAB_Items_MovedTo_Full = table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s moved to %s"}),
    PAB_Items_MovedTo_Partial = table.concat({PAC.COLORED_TEXTS.PAB, "%d/%d x %s moved to %s"}),
    PAB_Items_MovedTo_OutOfSpace = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Not enough space!"}),
    PAB_Items_MovedTo_BankClosed = table.concat({PAC.COLORED_TEXTS.PAB, "Could not move %s to %s. Window was closed!"}),

    PAB_ItemMovedTo = table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s moved to %s."}),
    PAB_ItemNotMovedTo = table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s NOT moved to %s."}),
    PAB_ItemMovedToFailed = table.concat({PAC.COLORED_TEXTS.PAB, PAC.COLORS.ORANGE, "FAILURE: %s could NOT be moved to %s."}),
    PAB_NoSpaceInFor = table.concat({PAC.COLORED_TEXTS.PAB, PAC.COLORS.ORANGE, "Not enough space in %s for: %s."}),

    PAB_MoveTo_DoNothing = "Do Nothing",
    PAB_MoveTo_Bank = "Deposit to Bank",
    PAB_MoveTo_Backpack = "Withdraw to Backpack",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    PAL_ItemType_Ignore = "Ignore",
    PAL_ItemType_AutoLoot = "Auto-Loot",
    PAL_ItemType_LootDestroy = table.concat({"Auto-Loot and ", PAC.COLORS.RED, "Destroy"}),
    PAL_RecipeUnknown_Suffix = "(unknown)",
    PAL_ItemType_Ignore_T = "Nothing happens, the item is ignored",
    PAL_ItemType_AutoLoot_T = "Automatically loots the item",
    PAL_ItemType_LootDestroy_T = table.concat({PAC.COLORS.RED, "CAUTION: USE AT OWN RISK!|r Automatically loots the item, but then immediately destroys the looted amount again."}),

    -- PALoot Chat Output - Loot Gold --
    PAL_Gold_ChatMode_None = "<no output>",
    PAL_Gold_ChatMode_Min = table.concat({PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    PAL_Gold_ChatMode_Normal = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    PAL_Gold_ChatMode_Full = table.concat({PAC.COLORED_TEXTS.PAL, "Looted ", PAC.COLORS.GREEN, "+ %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " Gold"}),

    -- PALoot Chat Output - Loot Items --
    PAL_Items_ChatMode_None = "<no output>",
    PAL_Items_ChatMode_Min = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s"}),
    PAL_Items_ChatMode_Normal = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s %s"}),
    PAL_Items_ChatMode_Full = table.concat({PAC.COLORED_TEXTS.PAL, "%d x %s %s %s"}),

    -- PALoot Chat Output - Loot Items Destroyed--
    PAL_ItemsDestroy_Min = table.concat({PAC.COLORS.DEFAULT, "%d x %s destroyed"}),
    PAL_ItemsDestroy_Normal = table.concat({PAC.COLORS.DEFAULT, "%d x %s %s destroyed"}),
    PAL_ItemsDestroy_Full = table.concat({PAC.COLORED_TEXTS.PAL, "%d x %s %s have been destroyed"}),
    PAL_ItemsDestroy_MoveFailed = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.ORANGE, "FAILURE: Could NOT split %d/%d %s %s into seperate stack to destroy safely"}),
    PAL_ItemsDestroy_DestroyFailed = table.concat({PAC.COLORED_TEXTS.PAL, PAC.COLORS.ORANGE, "FAILURE: No free inventory slot to safely destroy %d/%d %s %s"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    PAJ_MarkedAsJunk = table.concat({PAC.COLORED_TEXTS.PAJ, "Marked %s as junk"}),
    PAJ_SoldJunkInfo = table.concat({PAC.COLORED_TEXTS.PAJ, "Sold junk items for ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),

    -- =================================================================================================================

    -- MainMenu --
    MMenu_Title = PAC.COLORED_TEXTS.PA,

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGMenu --
    PAGMenu_Header = PAC.COLORED_TEXTS.PAG,
    PAGMenu_ActiveProfile = "Active profile",
    PAGMenu_ActiveProfile_T = "Select the profile settings that shall be used. Changing the selection will automatically load the settings. Changes below will automatically be stored under the profile.",
    PAGMenu_ActiveProfileRename = "Rename active profile",
    PAGMenu_ActiveProfileRename_T = "Rename the active profile",
    PAGMenu_Welcome = "Show welcome message",
    PAGMenu_Welcome_T = "Display a welcome message from the addon upon successfully starting?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PARMenu --
    PARMenu_Header = PAC.COLORED_TEXTS.PAR,
    PARMenu_Enable = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Repair"}),
    PARMenu_Enable_T = "Enable Auto Repair?",
    PARMenu_RepairWornGold = "Repair equipped items",
    PARMenu_RepairWornGold_T = "Repair equipped items at a merchant?",
    PARMenu_RepairWornGoldDura = "- Durability threshold in %",
    PARMenu_RepairWornGoldDura_T = "Repair equipped items only if they are at or below the defined durability threshold.",
    PARMenu_RepairWornKit = "Use Repair Kits",
    PARMenu_RepairWornKit_T = "Repair equipped items with repair kits when out in the field? (Common repair kits will be used before greater ones)",
    PARMenu_RepairWornKitDura = "- Durability threshold in %",
    PARMenu_RepairWornKitDura_T = "Equipped items will only be repaired with a repair kit when their durability is at or below the defined threshold",
    PARMenu_RepairFullChatMode = "Chat display: Full repairs",
    PARMenu_RepairFullChatMode_T = "How to display the information of a full repair in the chat window",
    PARMenu_RepairPartialChatMode = "Chat display: Partial/incomplete repairs",
    PARMenu_RepairPartialChatMode_T = "How to display the information of an incomplet or parcial repair i.e. due to insufficient gold) in the chat window",
    PARMenu_ChargeWeapons = "Re-Charge Weapons",
    PARMenu_ChargeWeapons_T = "Re-Charge equipped weapons?",
    PARMenu_ChargeWeaponsDura = "- Re-Charge threshold in %",
    PARMenu_ChargeWeaponsDura_T = "Re-Charge equipped weapons when their charge level is at or below the defined threshold. (Lesser soul gems will be used before common ones)",
    PARMenu_ChargeWeaponsChatMode = "Chat display: Charging weapons",
    PARMenu_ChargeWeaponsChatMode_T = "How to display the information of a re-charged weapon in the chat window",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABMenu --
    PABMenu_Header = PAC.COLORED_TEXTS.PAB,
    PABMenu_Currency_Enable = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Currencies"}),
    PABMenu_Currency_Enable_T = "Enable Auto Bank Deposit and Withdrawal for the different Currencies?",

    PABMenu_Currency_Gold_Header = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", "Gold"}),
    PABMenu_Currency_Gold_Enabled = "Deposit/Withdraw Gold",
    PABMenu_Currency_Gold_Enabled_T = "Automatically deposit excess Gold to the bank, or withdraw when needed?",
    PABMenu_Currency_Gold_MinToKeep = "Mininum to keep on character",
    PABMenu_Currency_Gold_MinToKeep_T = "Minimum amount of Gold to always keep on the character; if necessary with additional withdrawals from te bank",
    PABMenu_Currency_Gold_MaxToKeep = "Maximum to keep on character",
    PABMenu_Currency_Gold_MaxToKeep_T = "Maximum amount of Gold to always keep on the character; everything above this amount is deposited to the bank",

    PABMenu_Currency_AlliancePoints_Header = table.concat({" ", PAC.ICONS.CURRENCY[CURT_ALLIANCE_POINTS].NORMAL, "  ", "Alliance Points"}),
    PABMenu_Currency_AlliancePoints_Enabled = "Deposit/Withdraw Alliance Points",
    PABMenu_Currency_AlliancePoints_Enabled_T = "Automatically deposit excess Alliance Points to the bank, or withdraw when needed?",
    PABMenu_Currency_AlliancePoints_MinToKeep = "Mininum to keep on character",
    PABMenu_Currency_AlliancePoints_MinToKeep_T = "Minimum amount of Alliance Points to always keep on the character; if necessary with additional withdrawals from te bank",
    PABMenu_Currency_AlliancePoints_MaxToKeep = "Maximum to keep on character",
    PABMenu_Currency_AlliancePoints_MaxToKeep_T = "Maximum amount of Alliance Points to always keep on the character; everything above this amount is deposited to the bank",

    PABMenu_Currency_TelVar_Header = table.concat({" ", PAC.ICONS.CURRENCY[CURT_TELVAR_STONES].NORMAL, "  ", "Tel Var Stones"}),
    PABMenu_Currency_TelVar_Enabled = "Deposit/Withdraw Tel Var Stones",
    PABMenu_Currency_TelVar_Enabled_T = "Automatically deposit excess Tel Var Stones to the bank, or withdraw when needed?",
    PABMenu_Currency_TelVar_MinToKeep = "Mininum to keep on character",
    PABMenu_Currency_TelVar_MinToKeep_T = "Minimum amount of Tel Var Stones to always keep on the character; if necessary with additional withdrawals from te bank",
    PABMenu_Currency_TelVar_MaxToKeep = "Maximum to keep on character",
    PABMenu_Currency_TelVar_MaxToKeep_T = "Maximum amount of Tel Var Stones to always keep on the character; everything above this amount is deposited to the bank",

    PABMenu_Currency_WritVouchers_Header = table.concat({" ", PAC.ICONS.CURRENCY[CURT_WRIT_VOUCHERS].NORMAL, "  ", "Writ Vouchers"}),
    PABMenu_Currency_WritVouchers_Enabled = "Deposit/Withdraw Writ Vouchers",
    PABMenu_Currency_WritVouchers_Enabled_T = "Automatically deposit excess Writ Vouchers to the bank, or withdraw when needed?",
    PABMenu_Currency_WritVouchers_MinToKeep = "Mininum to keep on character",
    PABMenu_Currency_WritVouchers_MinToKeep_T = "Minimum amount of Writ Vouchers to always keep on the character; if necessary with additional withdrawals from te bank",
    PABMenu_Currency_WritVouchers_MaxToKeep = "Maximum to keep on character",
    PABMenu_Currency_WritVouchers_MaxToKeep_T = "Maximum amount of Writ Vouchers to always keep on the character; everything above this amount is deposited to the bank",

    PABMenu_Crafting_ESOPlusDesc = table.concat({PAC.COLORS.LIGHT_BLUE, "As an ESO Plus Member, the deposit/withdrawal of Crafting Materials is not relevant since all of them can be carried with an infinite amount in the Craft Bag."}),

    PABMenu_Crafting_Enable = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Crafting Items"}),
    PABMenu_Crafting_Enable_T = "Enable Auto Bank Deposit and Withdrawal for the different Crafting Items?",

    PABMenu_Crafting_Description = "Define an individual behaviour (deposit, withdraw, or do nothing) for Crafting Items",

    PABMenu_Crafting_GlobalMoveMode = "Change all above Crafting Item dropdowns to",
    PABMenu_Crafting_GlobalMoveMode_T = "Change all above Crafting Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",
    PABMenu_Crafting_GlobalMoveMode_W = "This cannot be undone; all individually selected values will be lost",

    PABMenu_Crafting_Blacksmithing_Header = table.concat({PAC.ICONS.CRAFTBAG.BLACKSMITHING.LARGE, " ", "Blacksmithing"}),
    PABMenu_Crafting_Blacksmithing_Enabled = "Deposit/Withdraw Blacksmithing Items",
    PABMenu_Crafting_Blacksmithing_Enabled_T = "Automatically deposit Blacksmithing Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Clothing_Header = table.concat({PAC.ICONS.CRAFTBAG.CLOTHING.LARGE, " ", "Clothing"}),
    PABMenu_Crafting_Clothing_Enabled = "Deposit/Withdraw Clothing Items",
    PABMenu_Crafting_Clothing_Enabled_T = "Automatically deposit Clothing Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Woodworking_Header = table.concat({PAC.ICONS.CRAFTBAG.WOODWORKING.LARGE, " ", "Woodworking"}),
    PABMenu_Crafting_Woodworking_Enabled = "Deposit/Withdraw Woodworking Items",
    PABMenu_Crafting_Woodworking_Enabled_T = "Automatically deposit Woodworking Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Jewelcrafting_Header = table.concat({PAC.ICONS.CRAFTBAG.JEWELCRAFTING.LARGE, " ", "Jewelry Crafting"}),
    PABMenu_Crafting_Jewelcrafting_Enabled = "Deposit/Withdraw Jewelry Crafting Items",
    PABMenu_Crafting_Jewelcrafting_Enabled_T = "Automatically deposit Jewelry Crafting Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Alchemy_Header = table.concat({PAC.ICONS.CRAFTBAG.ALCHEMY.LARGE, " ", "Alchemy"}),
    PABMenu_Crafting_Alchemy_Enabled = "Deposit/Withdraw Alchemy Items",
    PABMenu_Crafting_Alchemy_Enabled_T = "Automatically deposit Alchemy Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Enchanting_Header = table.concat({PAC.ICONS.CRAFTBAG.ENCHANTING.LARGE, " ", "Enchanting"}),
    PABMenu_Crafting_Enchanting_Enabled = "Deposit/Withdraw Enchanting Items",
    PABMenu_Crafting_Enchanting_Enabled_T = "Automatically deposit Enchanting Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Provisioning_Header = table.concat({PAC.ICONS.CRAFTBAG.PROVISIONING.LARGE, " ", "Provisioning"}),
    PABMenu_Crafting_Provisioning_Enabled = "Deposit/Withdraw Provisioning Items",
    PABMenu_Crafting_Provisioning_Enabled_T = "Automatically deposit Provisioning Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_StyleMaterials_Header = table.concat({PAC.ICONS.CRAFTBAG.STYLEMATERIALS.LARGE, " ", "Style Materials"}),
    PABMenu_Crafting_StyleMaterials_Enabled = "Deposit/Withdraw Style Material Items",
    PABMenu_Crafting_StyleMaterials_Enabled_T = "Automatically deposit Style Material Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_TraitItems_Header = table.concat({PAC.ICONS.CRAFTBAG.TRAITITEMS.LARGE, " ", "Trait Items"}),
    PABMenu_Crafting_TraitItems_Enabled = "Deposit/Withdraw Trait Items",
    PABMenu_Crafting_TraitItems_Enabled_T = "Automatically deposit Trait Items to the bank, or withdraw when needed?",

    PABMenu_Crafting_Furnishing_Header = table.concat({PAC.ICONS.CRAFTBAG.FURNISHING.LARGE, " ", "Furnishing"}),
    PABMenu_Crafting_Furnishing_Enabled = "Deposit/Withdraw Furnishing Items",
    PABMenu_Crafting_Furnishing_Enabled_T = "Automatically deposit Furnishing Items to the bank, or withdraw when needed?",

    PABMenu_Advanced_Enable = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Special Items"}),
    PABMenu_Advanced_Enable_T = "Enable Auto Bank Deposit and Withdrawal for the different Special Items?",

    PABMenu_Advanced_Description = "Define an individual behaviour (deposit, withdraw, or do nothing) for Special Items",

    PABMenu_Advanced_GlobalMoveMode = "Change all above Special Item dropdowns to",
    PABMenu_Advanced_GlobalMoveMode_T = "Change all above Special Item dropdown values to 'Deposit to Bank', 'Withdraw to Backpack, or to 'Do Nothing'",
    PABMenu_Advanced_GlobalMoveMode_W = "This cannot be undone; all individually selected values will be lost",

    PABMenu_Advanced_Motif_Header = table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", "Motif"}),
    PABMenu_Advanced_Motif_Enabled = "Deposit/Withdraw Motif Items",
    PABMenu_Advanced_Motif_Enabled_T = "Automatically deposit Motif Items to the bank, or withdraw when needed?",

    PABMenu_Advanced_Recipe_Header = table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", "Recipe"}),
    PABMenu_Advanced_Recipe_Enabled = "Deposit/Withdraw Recipes",
    PABMenu_Advanced_Recipe_Enabled_T = "Automatically deposit Recipes to the bank, or withdraw when needed?",

    PABMenu_Advanced_Glyphs_Header = table.concat({" ", PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.NORMAL, "  ", "Glyphs"}),
    PABMenu_Advanced_Glyphs_Enabled = "Deposit/Withdraw Glyphs",
    PABMenu_Advanced_Glyphs_Enabled_T = "Automatically deposit Glyphs to the bank, or withdraw when needed?",

    PABMenu_Advanced_Liquids_Header = table.concat({" ", PAC.ICONS.ITEMS.POTION.NORMAL, "  ", "Liquids"}),
    PABMenu_Advanced_Liquids_Enabled = "Deposit/Withdraw Liquids",
    PABMenu_Advanced_Liquids_Enabled_T = "Automatically deposit Liquids to the bank, or withdraw when needed?",

    PABMenu_Advanced_Trophies_Header = table.concat({" ", PAC.ICONS.ITEMS.TREASURE_MAP.NORMAL, "  ", "Trophies"}),
    PABMenu_Advanced_Trophies_Enabled = "Deposit/Withdraw Trophies",
    PABMenu_Advanced_Trophies_Enabled_T = "Automatically deposit Trophies to the bank, or withdraw when needed?",

    PABMenu_Individual_Enable = table.concat({" ", PAC.COLORS.LIGHT_BLUE, "Enable Auto Banking for Individual Items"}),
    PABMenu_Individual_Enable_T = "Enable Auto Bank Deposit and Withdrawal for the different Individual Items?",

    PABMenu_Individual_Description = "Define an individual behaviour (deposit, withdraw, or do nothing) for Individual Items",

    PABMenu_Individual_Lockpick_Header = table.concat({" ", PAC.ICONS.ITEMS.LOCKPICK.NORMAL, "  ", "Lockpicks"}), -- TODO: replace with SI_ITEMTYMPE ?
    PABMenu_Individual_Lockpick_Enabled = "Deposit/Withdraw Lockpicks", -- TODO: replace with SI_ITEMTYMPE ?
    PABMenu_Individual_Lockpick_Enabled_T = "Automatically deposit Lockpicks to the bank, or withdraw when needed?", -- TODO: replace with SI_ITEMTYMPE ?

    PABMenu_Individual_SoulGem_Header = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", "Soul Gems"}), -- TODO: replace with SI_ITEMTYMPE ?
    PABMenu_Individual_SoulGem_Enabled = "Deposit/Withdraw Soul Gems", -- TODO: replace with SI_ITEMTYMPE ?
    PABMenu_Individual_SoulGem_Enabled_T = "Automatically deposit Soul Gems to the bank, or withdraw when needed?", -- TODO: replace with SI_ITEMTYMPE ?

    PABMenu_Individual_RepairKit_Header = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", "Repair Kits"}), -- TODO: replace with SI_ITEMTYMPE ?
    PABMenu_Individual_RepairKit_Enabled = "Deposit/Withdraw Repair Kits", -- TODO: replace with SI_ITEMTYMPE ?
    PABMenu_Individual_RepairKit_Enabled_T = "Automatically deposit Repair Kits to the bank, or withdraw when needed?", -- TODO: replace with SI_ITEMTYMPE ?

    PABMenu_Individual_Generic_Header = table.concat({" ", PAC.ICONS.ITEMS.GENERIC_HELP.NORMAL, "  ", "Other Items"}),
    PABMenu_Individual_Generic_Enabled = "Deposit/Withdraw Other Items",
    PABMenu_Individual_Generic_Enabled_T = "Automatically deposit Other Items to the bank, or withdraw when needed?",

    PABMenu_Individual_Keep_in_Backpack = "Amount to keep in backpack",
    PABMenu_Individual_Keep_in_Backpack_T = "Define the amount which shall together with the mathematical operator be kept in the backpack.",

    -- -----------------------------------------------------------------------------------------------------------------

    PABMenu_DepositStacking = "Stacking rule when depositing",
    PABMenu_DepositStacking_T = "Define whether all Items shall be deposited, or only when there are existing stacks that can be completed.",
    PABMenu_WithdrawalStacking = "Stacking rule when withdrawing",
    PABMenu_WithdrawalStacking_T = "Define whether all Items shall be withdrawn, or only when there are existing stacks that can be completed.",

    PABMenu_Transaction_Interval = "Interval between item transactions (msecs)",
    PABMenu_Transaction_Interval_T = "The time in milliseconds between two consecutive item transactions. If too many item moves don't work, consider increasing this value.",

    PABMenu_AutoStackBank = "Auto-Stack all items when opening the bank",
    PABMenu_AutoStackBank_T = "Automatically stack all items in the bank when opening it? Helps to keep everything better organized.",

    -- -----------------------------------------------------------------------------------------------------------------



    PABMenu_HideNoDeposit = "Hide 'Nothing to Deposit' message",
    PABMenu_HideNoDeposit_T = "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though.",
    PABMenu_HideAll = "Hide ALL banking messages",
    PABMenu_HideAll_T = "Silent-Mode: No banking message will be displayed. You also won't see your deposited gold/items.",
    PABMenu_DepButton = "Deposit all",
    PABMenu_DepButton_T = "Change all dropdown values to 'Deposit'",
    PABMenu_WitButton = "Withdraw all",
    PABMenu_WitButton_T = "Change all dropdown values to 'Withdraw'",
    PABMenu_IgnButton = "Ignore all",
    PABMenu_IgnButton_T = "Change all dropdown values to '-'",
    PABMenu_Lockipck_Header = table.concat({PAC.COLORS.LIGHT_BLUE, "Lockpicks"}),
    PABMenu_Keep_in_Backpack = "Amount to keep in backpack",
    PABMenu_Keep_in_Backpack_T = "Define the amount which shall together with the mathematical operator be kept in the backpack.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PALMenu --
    PALMenu_Header = PAC.COLORED_TEXTS.PAL,
    PALMenu_ESOAutoLootDesc = table.concat({PAC.COLORS.LIGHT_BLUE, "Because the Auto Loot option of ESO is turned on, PALoot has been disabled. Everything is already automatically looted."}),
    PALMenu_Enable = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Loot"}),
    PALMenu_Enable_T = "Enable Auto Loot?",
    PALMenu_LootGold = "Auto-Loot gold",
    PALMenu_LootGold_T = "Automatically loot gold?",
    PALMenu_LootGoldChatMode = "Chat Display of Auto-Looted Gold",
    PALMenu_LootGoldChatMode_T = "How to display the information of looted gold in the chat window",
    PALMenu_LootItems = "Auto-Loot items",
    PALMenu_LootItems_T = "Automatically loot items?",
    PALMenu_LootItemsChatMode = "Chat Display of Auto-Looted Items",
    PALMenu_LootItemsChatMode_T = "How to display the information of looted items in the chat window",
    PALMenu_LootStolenItems = "Auto-Steal items",
    PALMenu_LootStolenItems_T = "Include (to be) stolen items for the Auto-Loot?",
    PALMenu_HarvestableItems = "Harvestable items",
    PALMenu_HarvestableItems_T = "Open the sub-menu to define for each harvestable item type whether it shall be auto-looted or not.",
    PALMenu_HarvestableItemsDesc = "Enable and disable auto-loot for harvestable items such as ores, herbs, woods, runestones, or fishing holes.",
    PALMenu_HarvestableItems_Bait_Header = table.concat({PAC.COLORS.LIGHT_BLUE, "BAIT HANDLING"}),
    PALMenu_HarvestableItems_Bait = "Handling of [Bait] items",
    PALMenu_HarvestableItems_Bait_T = "When looting harvestable items, sometimes there also is bait which prevents the node from re-spawning when not looted. Define here what should happen in such cases.",
    PALMenu_HarvestableItems_Header = table.concat({PAC.COLORS.LIGHT_BLUE, "ITEM TYPES"}),
    PALMenu_LootableItems = "Lootable items",
    PALMenu_LootableItems_T = "Open the sub-menu to define for each lootable item type whether it shall be auto-looted or not.",
    PALMenu_LootableItemsDesc = "Enable and disable auto-loot for lootable items such as clothing raw materials from animals.",
    PALMenu_LootableItems_Header = table.concat({PAC.COLORS.LIGHT_BLUE, "ITEM TYPES"}),
    PALMenu_AutoLootQuestItems = "Quest Items",
    PALMenu_AutoLootLockpicks = "Lockpick",
    PALMenu_AutoLootAllButton = "Auto-Loot all",
    PALMenu_AutoLootAllButton_T = "Change all dropdown values to 'Auto-Loot'",
    PALMenu_IgnButton = "Ignore all",
    PALMenu_IgnButton_T = "Change all dropdown values to 'Ignore'",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJMenu --
    PAJMenu_Header = PAC.COLORED_TEXTS.PAJ,
    PAJMenu_Enable = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Junk"}),
    PAJMenu_Enable_T = "Enable Auto Junk?",
    PAJMenu_ItemTypeDesc = "Enable and disable the automatic marking as junk for different item types.",
    PAJMenu_AutoSellJunk = "Auto-Sell Junk?",
    PAJMenu_AutoSellJunk_T = "Automatically sell all items marked as junk?",
    PAJMenu_AutoMarkTrash = "Auto-Mark [Trash]",
    PAJMenu_AutoMarkTrash_T = "Automatically mark items of type [Trash] as junk?",
    PAJMenu_AutoMarkOrnate = "Auto-Mark [Ornate] trait",
    PAJMenu_AutoMarkOrnate_T = "Automatically mark items with [Ornate] trait as junk?",

    -- =================================================================================================================
    -- Name Spaces --
    NS_Bag_Equipment = "", -- not required so far
    NS_Bag_Equipped = "equipped",
    NS_Bag_Backpack = "Backpack",
    NS_Bag_Backpacked = "backpack",
    NS_Bag_Bank = "Bank",
    NS_Bag_Banked = "", -- not required so far
    NS_Bag_Subscriber_Bank = "Subscriber Bank",
    NS_Bag_Subscriber_Banked = "", -- not required so far
    NS_Bag_Unknown = "Unknown",

    -- Operators --
    REL_Operator = "> %s",
    REL_Operator_T = "Select the Mathematical Operator for this item.",
    REL_None = "-",
    REL_Equal = "equals (=)",
    REL_LessThan = "less than (<)", -- not required so far
    REL_LessThanEqual = "less than or equal to (<=)",
    REL_GreaterThan = "greater than (>)", -- not required so far
    REL_GreaterThanEqual = "greater than or equal to (>=)",

    -- Stacking types --
    ST_FullMove = "Move everything", -- 0: Full deposit
    ST_IncompleteStacksOnly = "Only fill up existing stacks", -- 1: Fill existing stacks

    -- Official Item Types --
    -- TODO: fixme; problem is we need resolved value of "ITEMTYPE_ADDITIVE" as key and not the string itself
    ITEMTYPE_ADDITIVE = "enITEMTYPE_ADDITIVE",
    ITEMTYPE_ARMOR = "Armor (any)",
    ITEMTYPE_ARMOR_BOOSTER = "enITEMTYPE_ARMOR_BOOSTER",
    ITEMTYPE_ARMOR_TRAIT = "Armor Trait",
    ITEMTYPE_AVA_REPAIR = "enITEMTYPE_AVA_REPAIR",
    ITEMTYPE_BLACKSMITHING_BOOSTER = "Temper (Blacksmithing)",
    ITEMTYPE_BLACKSMITHING_MATERIAL = "Material (Blacksmithing)",
    ITEMTYPE_BLACKSMITHING_RAW_MATERIAL = "Raw Material (Blacksmithing)",
    ITEMTYPE_CLOTHIER_BOOSTER = "Tannin (Clothing)",
    ITEMTYPE_CLOTHIER_MATERIAL = "Material (Clothing)",
    ITEMTYPE_CLOTHIER_RAW_MATERIAL = "Raw Material (Clothing)",
    ITEMTYPE_COLLECTIBLE = "Collectible",
    ITEMTYPE_CONTAINER = "Container",
    ITEMTYPE_COSTUME = "Costume",
    ITEMTYPE_CROWN_ITEM = "enITEMTYPE_CROWN_ITEM",
    ITEMTYPE_CROWN_REPAIR = "enITEMTYPE_CROWN_REPAIR",
    ITEMTYPE_DEPRECATED = "enITEMTYPE_DEPRECATED",
    ITEMTYPE_DISGUISE = "enITEMTYPE_DISGUISE",
    ITEMTYPE_DRINK = "Drink",
    ITEMTYPE_ENCHANTING_RUNE_ASPECT = "Aspect Runestone (Enchanting)",
    ITEMTYPE_ENCHANTING_RUNE_ESSENCE = "Essence Runestone (Enchanting)",
    ITEMTYPE_ENCHANTING_RUNE_POTENCY = "Potency Runestone (Enchanting)",
    ITEMTYPE_ENCHANTMENT_BOOSTER = "enITEMTYPE_ENCHANTMENT_BOOSTER",
    ITEMTYPE_FISH = "Fish",
    ITEMTYPE_FLAVORING = "enITEMTYPE_FLAVORING",
    ITEMTYPE_FOOD = "Food",
    ITEMTYPE_FURNISHING_MATERIAL = "Furnishing Material",
    ITEMTYPE_GLYPH_ARMOR = "Armor Glyph (Enchanting)",
    ITEMTYPE_GLYPH_JEWELRY = "Jewelry Glyph (Enchanting)",
    ITEMTYPE_GLYPH_WEAPON = "Weapon Glyph (Enchanting)",
    ITEMTYPE_INGREDIENT = "Ingredient (Provisioning)",
    ITEMTYPE_LOCKPICK = "enITEMTYPE_LOCKPICK",
    ITEMTYPE_LURE = "Bait",
    ITEMTYPE_MASTER_WRIT = "enITEMTYPE_MASTER_WRIT",
    ITEMTYPE_MAX_VALUE = "enITEMTYPE_MAX_VALUE",
    ITEMTYPE_MIN_VALUE = "enITEMTYPE_MIN_VALUE",
    ITEMTYPE_MOUNT = "enITEMTYPE_MOUNT",
    ITEMTYPE_NONE = "enITEMTYPE_NONE",
    ITEMTYPE_PLUG = "enITEMTYPE_PLUG",
    ITEMTYPE_POISON = "Poison",
    ITEMTYPE_POISON_BASE = "Poison Solvent (Alchemy)",
    ITEMTYPE_POTION = "Potion",
    ITEMTYPE_POTION_BASE = "Potion Solvent (Alchemy)",
    ITEMTYPE_RACIAL_STYLE_MOTIF = "Motif",
    ITEMTYPE_RAW_MATERIAL = "Raw Material",
    ITEMTYPE_REAGENT = "Reagent (Alchemy)",
    ITEMTYPE_RECIPE = "Recipe (Provisioning)",
    ITEMTYPE_SIEGE = "enITEMTYPE_SIEGE",
    ITEMTYPE_SOUL_GEM = "Soul Gem",
    ITEMTYPE_SPELLCRAFTING_TABLET = "enITEMTYPE_SPELLCRAFTING_TABLET",
    ITEMTYPE_SPICE = "enITEMTYPE_SPICE",
    ITEMTYPE_STYLE_MATERIAL = "Style Material",
    ITEMTYPE_TABARD = "enITEMTYPE_TABARD",
    ITEMTYPE_TOOL = "Tool",
    ITEMTYPE_TRASH = "Trash",
    ITEMTYPE_TREASURE = "enITEMTYPE_TREASURE",
    ITEMTYPE_TROPHY = "Trophy",
    ITEMTYPE_WEAPON = "Weapon (any)",
    ITEMTYPE_WEAPON_BOOSTER = "enITEMTYPE_WEAPON_BOOSTER",
    ITEMTYPE_WEAPON_TRAIT = "Weapon Trait",
    ITEMTYPE_WOODWORKING_BOOSTER = "Resin (Woodworking)",
    ITEMTYPE_WOODWORKING_MATERIAL = "Material (Woodworking)",
    ITEMTYPE_WOODWORKING_RAW_MATERIAL = "Raw Material (Woodworking)"
}
