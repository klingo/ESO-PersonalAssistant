if ResourceBundle == nil then ResourceBundle = {} end
if ResourceBundle.de == nil then ResourceBundle.de = {} end

-- Welcome Messages --                                  -- Type '/pa' for GUI."
ResourceBundle.de["Welcome_NoSupport"]                  = PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."ersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"..PAC_COL_DEFAULT.." zu Deinen Diensten!   -   (noch) keine Lokalisierung für (%s) vorhanden."
ResourceBundle.de["Welcome_Support"]                    = PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."ersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"..PAC_COL_DEFAULT.." zu Deinen Diensten!"


-- Key Bindings
ResourceBundle.de["KB_Load_Profile1"]                   = "Aktiviere Profil 1"
ResourceBundle.de["KB_Load_Profile2"]                   = "Aktiviere Profil 2"
ResourceBundle.de["KB_Load_Profile3"]                   = "Aktiviere Profil 3"
ResourceBundle.de["KB_Load_Profile4"]                   = "Aktiviere Profil 4"
ResourceBundle.de["KB_Load_Profile5"]                   = "Aktiviere Profil 5"

-- PAGeneral --
ResourceBundle.de["PAG_Profile1"]                       = "Profil 1"
ResourceBundle.de["PAG_Profile2"]                       = "Profil 2"
ResourceBundle.de["PAG_Profile3"]                       = "Profil 3"
ResourceBundle.de["PAG_Profile4"]                       = "Profil 4"
ResourceBundle.de["PAG_Profile5"]                       = "Profil 5"


-- PARepair Chat Output - Full Repair --





-- PARepair Chat Output - Partial Repair --





-- PABanking --
ResourceBundle.de["PAB_GoldDeposited"]                  = PAC_COLTEXT_PAB.."%d "..PAC_ICON_GOLD.." eingelagert."
ResourceBundle.de["PAB_GoldWithdrawn"]                  = PAC_COLTEXT_PAB.."%d "..PAC_ICON_GOLD.." abgehoben."
ResourceBundle.de["PAB_GoldWithdrawnInsufficient"]      = PAC_COLTEXT_PAB.."%d / %d "..PAC_ICON_GOLD.." abgehoben. (Nicht genug Gold in Truhe)"

ResourceBundle.de["PAB_ItemMovedTo"]                    = PAC_COLTEXT_PAB.."%d x %s wurde in %s übertragen."
ResourceBundle.de["PAB_ItemNotMovedTo"]                 = PAC_COLTEXT_PAB.."%d x %s wurde NICHT in %s übertragen."
ResourceBundle.de["PAB_ItemMovedToFailed"]              = PAC_COLTEXT_PAB..PAC_COL_ORANGE.."FEHLER: %s konnte NICHT in %s übertragen werden."

ResourceBundle.de["PAB_NoSpaceInFor"]                   = PAC_COLTEXT_PAB..PAC_COL_ORANGE.."Nicht genug Platz in %s für: %s."
ResourceBundle.de["PAB_NoDeposit"]                      = PAC_COLTEXT_PAB.."Nichts zum Einlagern."

ResourceBundle.de["PAB_ItemType_None"]                  = "-"
ResourceBundle.de["PAB_ItemType_Deposit"]               = "Einlagern"
ResourceBundle.de["PAB_ItemType_Withdrawal"]            = "Abheben"
ResourceBundle.de["PAB_ItemType_Inherit"]               = "Abhängig vom Gegenstandstyp (unten)"

-- PALoot --

ResourceBundle.de["PAL_ItemType_AutoLoot"]              = "Autom. Plündern"






-- PALoot Chat Output - Loot Gold --





-- PALoot Chat Output - Loot Items --





-- PALoot Chat Output - Loot Items Destroyed--






-- PAJunk --



-- MainMenu --
ResourceBundle.de["MMenu_Title"]                        = PAC_COLTEXT_PA

-- PAGMenu --
ResourceBundle.de["PAGMenu_Header"]                     = PAC_COLTEXT_PAG
ResourceBundle.de["PAGMenu_ActiveProfile"]              = "Aktives Profil"
ResourceBundle.de["PAGMenu_ActiveProfile_T"]            = "Wähle die Profil-Einstellungen welche verwendet werden sollen. Eine Änderung der Auswahl lädt auomtatisch dessen Einstellungen. Änderungen unten werden automatisch unter dem Profil abgespeichert."
ResourceBundle.de["PAGMenu_ActiveProfileRename"]        = "Aktives Profil umbenennen"
ResourceBundle.de["PAGMenu_ActiveProfileRename_T"]      = "Das aktive Profil umbennenen"
ResourceBundle.de["PAGMenu_Welcome"]                    = "Zeige Wilkommensnachricht"
ResourceBundle.de["PAGMenu_Welcome_T"]                  = "Soll eine Willkommensnachricht nach Starten des Addons angezeigt werden?"

-- PARMenu --
ResourceBundle.de["PARMenu_Header"]                     = PAC_COLTEXT_PAR
ResourceBundle.de["PARMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Aktiviere automatische Reparatur"
ResourceBundle.de["PARMenu_Enable_T"]                   = "Soll die automatische Reparatur aktiviert werden?"
ResourceBundle.de["PARMenu_RepairWornGold"]                   = "Repariere ausgerüstete Gegenstände"
ResourceBundle.de["PARMenu_RepairWornGold_T"]                 = "Sollen ausgerüstete Gegenstände repariert werden?"
ResourceBundle.de["PARMenu_RepairWornGoldDura"]               = "- Haltbarkeitsschwelle in %"
ResourceBundle.de["PARMenu_RepairWornGoldDura_T"]             = "Repariere ausgerüstete Gegenstände nur, wenn sie genau auf oder unter der definierten Haltbarkeitsschwelle sind."













-- PABMenu --
ResourceBundle.de["PABMenu_Header"]                     = PAC_COLTEXT_PAB
ResourceBundle.de["PABMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Aktiviere automatisches Banking"
ResourceBundle.de["PABMenu_Enable_T"]                   = "Aktiviere automatisches Einlagern in und Abheben von der Bank?"
ResourceBundle.de["PABMenu_EnabledGold"]                = "Gold einlagen"
ResourceBundle.de["PABMenu_EnabledGold_T"]              = "Soll automatisch Gold in die Truhe eingelagert werden?"

ResourceBundle.de["PABMenu_GoldTransactionStep"]        = "- Gold Transaktionen in Schritten von"
ResourceBundle.de["PABMenu_GoldTransactionStep_T"]      = "In welchen Schritten soll Gold eingelagert und abgehoben werden?"
ResourceBundle.de["PABMenu_GoldMinToKeep"]              = "- Min. Gold im Inventar behalten"
ResourceBundle.de["PABMenu_GoldMinToKeep_T"]            = "Minimalmenge an Gold die immer im Inventar behalten werden soll."
ResourceBundle.de["PABMenu_GoldMinToKeep_W"]            = "Ungültige Eingabe --> Kein Gold soll im Inventar behalten werden."
ResourceBundle.de["PABMenu_WithdrawToMinGold"]          = "- Hebe Gold ab wenn unter Minimum"
ResourceBundle.de["PABMenu_WithdrawToMinGold_T"]        = "Soll automatisch Gold von der Truhe abgehoben werden, wenn weniger Gold im Inventar ist wie oben als Minimum definiert wurde."
ResourceBundle.de["PABMenu_EnabledItems"]               = "Gegenstände einlagern und abheben"
ResourceBundle.de["PABMenu_EnabledItems_T"]             = "Sollen Gegenstände automatisch in die Truhe eingelagert bzw. von der Truhe abgehoben werden?"
ResourceBundle.de["PABMenu_DepItemTypeDesc"]            = "Definiere ein individuelles Verhalten (Einlagern, Abheben, Ignorieren) für reguläre wie auch erweiterte Gegenstandstypen."
ResourceBundle.de["PABMenu_DepItemType"]                = "Reguläre Gegenstandstypen"
ResourceBundle.de["PABMenu_DepItemType_T"]              = "Öffnet das Untermenu um für jeden Typ von Gegenstand zu definieren ob er eingelagert, abgehoben oder ignoriert werden soll."
ResourceBundle.de["PABMenu_DepStackOnly"]               = "Stapelungsart (Einlagern)"
ResourceBundle.de["PABMenu_DepStackOnly_T"]             = "Definiere ob alle Gegenstände komplett eingelagert werden sollen, nur solche die bereits im Zielbehälter vorhanden sind, oder sollen sogar nur bestehende Stapel aufgefüllt werden."
ResourceBundle.de["PABMenu_WitStackOnly"]               = "Stapelungsart (Abheben)"
ResourceBundle.de["PABMenu_WitStackOnly_T"]             = "Definiere ob alle Gegenstände komplett abgehoben werden sollen, nur solche die bereits im Zielbehälter vorhanden sind, oder sollen sogar nur bestehende Stapel aufgefüllt werden."
ResourceBundle.de["PABMenu_Advanced_DepItemType"]       = "Erweiterte Gegenstandstypen"
ResourceBundle.de["PABMenu_Advanced_DepItemType_T"]     = "Öffnet das Untermenu um für andere Typen von Gegenständen auf einer erweiterten Stufe zu definieren ob sie eingelagert, abgehoben oder ignoriert werden sollen."
ResourceBundle.de["PABMenu_DepItemTimerInterval"]       = "- Einlagerungs Intervall (ms)"
ResourceBundle.de["PABMenu_DepItemTimerInterval_T"]     = "Anzahl Millisekunden zwischen zwei Einlagerungen. Wenn zu viele Einlagerungen nicht funktionieren, sollte dieser Wert erhöht werden."
ResourceBundle.de["PABMenu_ItemType_Header"]            = PAC_COL_LIGHT_BLUE.."TYPEN VON GEGENSTÄNDEN"
ResourceBundle.de["PABMenu_HideNoDeposit"]              = "Blende 'Nichts zum Einlagern' aus"
ResourceBundle.de["PABMenu_HideNoDeposit_T"]            = "Blendet die Meldung 'Nichts zum Einlagern' aus. Eingelagerte Gegenstände werden jedoch weiterhin ausgegeben."
ResourceBundle.de["PABMenu_HideAll"]                    = "Blende ALLE Banking Meldungen aus"
ResourceBundle.de["PABMenu_HideAll_T"]                  = "Ruhe-Modus: Keine Banking Meldungen werden mehr angezeigt. Die eingelagerten/abgehobenen Gegenstände werden nicht mehr ausgegeben."
ResourceBundle.de["PABMenu_DepButton"]                  = "Alles einlagern"
ResourceBundle.de["PABMenu_DepButton_T"]                = "Ändert alle Dropdown Werte zu 'Einlagern'"
ResourceBundle.de["PABMenu_WitButton"]                  = "Alles abheben"
ResourceBundle.de["PABMenu_WitButton_T"]                = "Ändert alle Dropdown Werte zu 'Abheben'"
ResourceBundle.de["PABMenu_IgnButton"]                  = "Alles ignorieren"
ResourceBundle.de["PABMenu_IgnButton_T"]                = "Ändert alle Dropdown Werte zu '-'"
ResourceBundle.de["PABMenu_Lockipck_Header"]            = PAC_COL_LIGHT_BLUE.."Dietriche"
ResourceBundle.de["PABMenu_Keep_in_Backpack"]           = "Zielmenge im Inventar"
ResourceBundle.de["PABMenu_Keep_in_Backpack_T"]         = "Definiere die Menge welche unter Berücksichtigung des mathematischen Operators im Inventar behalten werden soll."

-- PALMenu --
ResourceBundle.de["PALMenu_Header"]                     = PAC_COLTEXT_PAL
ResourceBundle.de["PALMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Aktiviere automatisches Plündern"
ResourceBundle.de["PALMenu_Enable_T"]                   = "Aktiviere automatisches Plündern?"
ResourceBundle.de["PALMenu_LootGold"]                   = "Automatisch Gold plündern?"
ResourceBundle.de["PALMenu_LootGold_T"]                 = "Automatisches Plündern von Gold?"


ResourceBundle.de["PALMenu_LootItems"]                  = "Automatisch Gegenstände plündern"
ResourceBundle.de["PALMenu_LootItems_T"]                = "Automatisches Plündern von Gegenständen?"


ResourceBundle.de["PALMenu_HarvestableItems"]           = "Erntbare Gegenstände"
ResourceBundle.de["PALMenu_HarvestableItems_T"]         = "Öffnet das Untermenu um für erntbare Typen von Gegenständen das automatische Plündern zu de-/aktivieren."
ResourceBundle.de["PALMenu_HarvestableItemsDesc"]       = "Aktiviere und deaktiviere das automatische Plündern von erntbaren Gegenständen wie Erzen, Kräutern, Hölzer, Runensteinen oder Fischgründen."



ResourceBundle.de["PALMenu_HarvestableItems_Header"]    = PAC_COL_LIGHT_BLUE.."TYPEN VON GEGENSTÄNDEN"




ResourceBundle.de["PALMenu_AutoLootAllButton"]          = "Alles autom. Plündern"
ResourceBundle.de["PALMenu_AutoLootAllButton_T"]        = "Ändert alle Dropdown Werte zu 'Autom. Plündern'"
ResourceBundle.de["PALMenu_IgnButton"]                  = "Alles ignorieren"
ResourceBundle.de["PALMenu_IgnButton_T"]                = "Ändert alle Dropdown Werte zu  'Ignorieren'"

-- PAJMenu --
ResourceBundle.de["PAJMenu_Header"]                     = PAC_COLTEXT_PAJ
ResourceBundle.de["PAJMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Aktiviere Auto Trödel"
ResourceBundle.de["PAJMenu_Enable_T"]                   = "Aktiviere automatischer Trödel?"
ResourceBundle.de["PAJMenu_ItemTypeDesc"]               = "Aktiviere und deaktiviere das automatische als trödel Markieren von verschiedenen Gegenstandstypen."
ResourceBundle.de["PAJMenu_AutoSellJunk"]               = "Automatisch Trödel verkaufen?"
ResourceBundle.de["PAJMenu_AutoSellJunk_T"]             = "Automatisch alle als Trödel markierte Gegenstände verkaufen."
ResourceBundle.de["PAJMenu_AutoMarkTrash"]              = "Automatisches markieren von [Plunder]"
ResourceBundle.de["PAJMenu_AutoMarkTrash_T"]            = "Automatisch Gegenstände vom Typ [Plunder] als Trödel markieren?"
ResourceBundle.de["PAJMenu_HideAll"]                    = "Blende ALLE Trödel-Meldungen aus"
ResourceBundle.de["PAJMenu_HideAll_T"]                  = "Ruhe-Modus: Keine Trödel-Meldungen werden mehr angezeigt."

-- Name Spaces --
ResourceBundle.de["NS_Bag_Equipment"]                   = ""    -- soweit nicht benötigt
ResourceBundle.de["NS_Bag_Equipped"]                    = "ausgerüstete"
ResourceBundle.de["NS_Bag_Backpack"]                    = "Inventar"
ResourceBundle.de["NS_Bag_Backpacked"]                  = "abgelegte"
ResourceBundle.de["NS_Bag_Bank"]                        = "Truhe"
ResourceBundle.de["NS_Bag_Banked"]                      = ""    -- soweit nicht benötigt
ResourceBundle.de["NS_Bag_Unknown"]                     = "unbekannt"

-- Operators --
ResourceBundle.de["REL_Operator"]                       = "Mathematischer Operator"
ResourceBundle.de["REL_None"]                           = "-"
ResourceBundle.de["REL_Equal"]                          = "gleich (=)"
ResourceBundle.de["REL_LessThan"]                       = "kleiner als (<)"        -- soweit nicht benötigt
ResourceBundle.de["REL_LessThanEqual"]                  = "kleiner als oder gleich (<=)"
ResourceBundle.de["REL_GreaterThan"]                    = "grösser als (>)"        -- soweit nicht benötigt
ResourceBundle.de["REL_GreaterThanEqual"]               = "grösser als oder gleich (>=)"

-- Stacking types --
ResourceBundle.de["ST_MoveAllFull"]                     = "Verschiebe alles"            -- 0: Full deposit
ResourceBundle.de["ST_MoveExistingFull"]                = "Verschiebe alles wenn bereits vorhanden"        -- 1: Deposit if existing
ResourceBundle.de["ST_FillIncompleteOnly"]              = "Nur vorhandene Stapel auffüllen"        -- 2: Fill existing stacks

-- Official Item Types --
ResourceBundle.de[ITEMTYPE_ADDITIVE]                    = "deITEMTYPE_ADDITIVE"
ResourceBundle.de[ITEMTYPE_ARMOR]                       = "Rüstung (unbekannt)"
ResourceBundle.de[ITEMTYPE_ARMOR_BOOSTER]               = "deITEMTYPE_ARMOR_BOOSTER"
ResourceBundle.de[ITEMTYPE_ARMOR_TRAIT]                 = "Rüstungseigenschaft"
ResourceBundle.de[ITEMTYPE_AVA_REPAIR]                  = "deITEMTYPE_AVA_REPAIR"
ResourceBundle.de[ITEMTYPE_BLACKSMITHING_BOOSTER]       = "Härter (Schmiedekunst)"
ResourceBundle.de[ITEMTYPE_BLACKSMITHING_MATERIAL]      = "Material (Schmiedekunst)"
ResourceBundle.de[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]  = "Rohmaterial (Schmiedekunst)"
ResourceBundle.de[ITEMTYPE_CLOTHIER_BOOSTER]            = "Gerbstoff (Schneiderei)"
ResourceBundle.de[ITEMTYPE_CLOTHIER_MATERIAL]           = "Material (Schneiderei)"
ResourceBundle.de[ITEMTYPE_CLOTHIER_RAW_MATERIAL]       = "Rohmaterial (Schneiderei)"
ResourceBundle.de[ITEMTYPE_COLLECTIBLE]                 = "deITEMTYPE_COLLECTIBLE" -- TODO: translate
ResourceBundle.de[ITEMTYPE_CONTAINER]                   = "Behälter"
ResourceBundle.de[ITEMTYPE_COSTUME]                     = "deITEMTYPE_COSTUME" -- TODO: translate
ResourceBundle.de[ITEMTYPE_CROWN_ITEM]                  = "deITEMTYPE_CROWN_ITEM"
ResourceBundle.de[ITEMTYPE_CROWN_REPAIR]                = "deITEMTYPE_CROWN_REPAIR"
ResourceBundle.de[ITEMTYPE_DEPRECATED]                  = "deITEMTYPE_DEPRECATED"
ResourceBundle.de[ITEMTYPE_DISGUISE]                    = "deITEMTYPE_DISGUISE"
ResourceBundle.de[ITEMTYPE_DRINK]                       = "Getränk"
ResourceBundle.de[ITEMTYPE_ENCHANTING_RUNE_ASPECT]      = "Aspektrunenstein (Verzaubern)"
ResourceBundle.de[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]     = "Essenzrunenstein (Verzaubern)"
ResourceBundle.de[ITEMTYPE_ENCHANTING_RUNE_POTENCY]     = "Machtrunenstein (Verzaubern)"
ResourceBundle.de[ITEMTYPE_ENCHANTMENT_BOOSTER]         = "deITEMTYPE_ENCHANTMENT_BOOSTER"
ResourceBundle.de[ITEMTYPE_FISH]                        = "Fisch"
ResourceBundle.de[ITEMTYPE_FLAVORING]                   = "deITEMTYPE_FLAVORING"
ResourceBundle.de[ITEMTYPE_FOOD]                        = "Nahrung"
ResourceBundle.de[ITEMTYPE_GLYPH_ARMOR]                 = "Rüstungsglyphe (Verzaubern)"
ResourceBundle.de[ITEMTYPE_GLYPH_JEWELRY]               = "Schmuckglyphe (Verzaubern)"
ResourceBundle.de[ITEMTYPE_GLYPH_WEAPON]                = "Waffenglyphe (Verzaubern)"
ResourceBundle.de[ITEMTYPE_INGREDIENT]                  = "Material (Versorgen)"
ResourceBundle.de[ITEMTYPE_LOCKPICK]                    = "deITEMTYPE_LOCKPICK"
ResourceBundle.de[ITEMTYPE_LURE]                        = "Köder"
ResourceBundle.de[ITEMTYPE_MASTER_WRIT]                 = "deITEMTYPE_MASTER_WRIT"
ResourceBundle.de[ITEMTYPE_MAX_VALUE]                   = "deITEMTYPE_MAX_VALUE"
ResourceBundle.de[ITEMTYPE_MIN_VALUE]                   = "deITEMTYPE_MIN_VALUE"
ResourceBundle.de[ITEMTYPE_MOUNT]                       = "deITEMTYPE_MOUNT"
ResourceBundle.de[ITEMTYPE_NONE]                        = "deITEMTYPE_NONE"
ResourceBundle.de[ITEMTYPE_PLUG]                        = "deITEMTYPE_PLUG"
ResourceBundle.de[ITEMTYPE_POISON]                      = "Gift"
ResourceBundle.de[ITEMTYPE_POISON_BASE]                 = "Giftlösungsmittel (Alchemie)"
ResourceBundle.de[ITEMTYPE_POTION]                      = "Trank"
ResourceBundle.de[ITEMTYPE_POTION_BASE]                 = "Tranklösungsmittel (Alchemie)"
ResourceBundle.de[ITEMTYPE_RACIAL_STYLE_MOTIF]          = "deITEMTYPE_RACIAL_STYLE_MOTIF" -- TODO: translate
ResourceBundle.de[ITEMTYPE_RAW_MATERIAL]                = "deITEMTYPE_RAW_MATERIAL" -- TODO: translate
ResourceBundle.de[ITEMTYPE_REAGENT]                     = "Reagenz (Alchemie)"
ResourceBundle.de[ITEMTYPE_RECIPE]                      = "Rezept (Versorgen)"
ResourceBundle.de[ITEMTYPE_SIEGE]                       = "deITEMTYPE_SIEGE"
ResourceBundle.de[ITEMTYPE_SOUL_GEM]                    = "Seelenstein"
ResourceBundle.de[ITEMTYPE_SPELLCRAFTING_TABLET]        = "deITEMTYPE_SPELLCRAFTING_TABLET"
ResourceBundle.de[ITEMTYPE_SPICE]                       = "deITEMTYPE_SPICE"
ResourceBundle.de[ITEMTYPE_STYLE_MATERIAL]              = "Stilmaterial"
ResourceBundle.de[ITEMTYPE_TABARD]                      = "deITEMTYPE_TABARD"
ResourceBundle.de[ITEMTYPE_TOOL]                        = "Werkzeug"
ResourceBundle.de[ITEMTYPE_TRASH]                       = "Plunder"
ResourceBundle.de[ITEMTYPE_TREASURE]                    = "deITEMTYPE_TREASURE"
ResourceBundle.de[ITEMTYPE_TROPHY]                      = "Trophäe"
ResourceBundle.de[ITEMTYPE_WEAPON]                      = "deITEMTYPE_WEAPON" -- TODO: translate
ResourceBundle.de[ITEMTYPE_WEAPON_BOOSTER]              = "deITEMTYPE_WEAPON_BOOSTER" -- TODO: translate
ResourceBundle.de[ITEMTYPE_WEAPON_TRAIT]                = "Waffeneigenschaft"
ResourceBundle.de[ITEMTYPE_WOODWORKING_BOOSTER]         = "Harz (Schreinerei)"
ResourceBundle.de[ITEMTYPE_WOODWORKING_MATERIAL]        = "Material (Schreinerei)"
ResourceBundle.de[ITEMTYPE_WOODWORKING_RAW_MATERIAL]    = "Rohmaterial (Schreinerei)"