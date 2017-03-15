if ResourceBundle == nil then ResourceBundle = {} end
if ResourceBundle.fr == nil then ResourceBundle.fr = {} end

-- Welcome Messages --                                  -- Type '/pa' for GUI."
ResourceBundle.fr["Welcome_NoSupport"]                  = PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."ersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"..PAC_COL_DEFAULT.." at your service!   -   no localization for (%s) available yet."
ResourceBundle.fr["Welcome_Support"]                    = PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."ersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"..PAC_COL_DEFAULT.." à votre service !"


-- Key Bindings
ResourceBundle.fr["KB_Load_Profile1"]                   = "Active profil 1"
ResourceBundle.fr["KB_Load_Profile2"]                   = "Active profil 2"
ResourceBundle.fr["KB_Load_Profile3"]                   = "Active profil 3"
ResourceBundle.fr["KB_Load_Profile4"]                   = "Active profil 4"
ResourceBundle.fr["KB_Load_Profile5"]                   = "Active profil 5"

-- PAGeneral --
ResourceBundle.fr["PAG_Profile1"]                       = "Profil 1"
ResourceBundle.fr["PAG_Profile2"]                       = "Profil 2"
ResourceBundle.fr["PAG_Profile3"]                       = "Profil 3"
ResourceBundle.fr["PAG_Profile4"]                       = "Profil 4"
ResourceBundle.fr["PAG_Profile5"]                       = "Profil 5"


-- PARepair Chat Output - Full Repair --





-- PARepair Chat Output - Partial Repair --





-- PARepair Chat Output - Weapon Charge --





-- PABanking --
ResourceBundle.fr["PAB_GoldDeposited"]                  = PAC_COLTEXT_PAB.."%d "..PAC_ICON_GOLD.." déposées."
ResourceBundle.fr["PAB_GoldWithdrawn"]                  = PAC_COLTEXT_PAB.."%d "..PAC_ICON_GOLD.." retirées."
ResourceBundle.fr["PAB_GoldWithdrawnInsufficient"]      = PAC_COLTEXT_PAB.."%d / %d "..PAC_ICON_GOLD.." retirées. (Pas assez en banque !)"

ResourceBundle.fr["PAB_ItemMovedTo"]                    = PAC_COLTEXT_PAB.."%d x %s déplacés vers %s."
ResourceBundle.fr["PAB_ItemNotMovedTo"]                 = PAC_COLTEXT_PAB.."%d x %s n'ont PAS été déplacés vers %s."
ResourceBundle.fr["PAB_ItemMovedToFailed"]              = PAC_COLTEXT_PAB..PAC_COL_ORANGE.."ÉCHEC : %s n'ont PAS pu être déplacés vers %s."

ResourceBundle.fr["PAB_NoSpaceInFor"]                   = PAC_COLTEXT_PAB..PAC_COL_ORANGE.."Pas assez d'espace dans %s pour : %s."
ResourceBundle.fr["PAB_NoDeposit"]                      = PAC_COLTEXT_PAB.."Rien à déposer."

ResourceBundle.fr["PAB_ItemType_None"]                  = "-"
ResourceBundle.fr["PAB_ItemType_Deposit"]               = "Déposer"
ResourceBundle.fr["PAB_ItemType_Withdrawal"]            = "Retirer"
ResourceBundle.fr["PAB_ItemType_Inherit"]               = "Selon le type d'objet (ci-dessous)"





-- PALoot --



-- PAJunk --




-- PALoot Chat Output - Loot Gold --





-- PALoot Chat Output - Loot Items --





-- PALoot Chat Output - Loot Items Destroyed--






-- PAJunk --



-- MainMenu --
ResourceBundle.fr["MMenu_Title"]                        = PAC_COLTEXT_PA

-- PAGMenu --
ResourceBundle.fr["PAGMenu_Header"]                     = PAC_COLTEXT_PAG
ResourceBundle.fr["PAGMenu_ActiveProfile"]              = "Profil actif"
ResourceBundle.fr["PAGMenu_ActiveProfile_T"]            = "Sélectionner le profil à utiliser. Changer la sélection chargera automatiquement les paramètres. Les changements ci-dessous seront automatiquement sauvegardés dans le profil."
ResourceBundle.fr["PAGMenu_ActiveProfileRename"]        = "Renommer profil actif"
ResourceBundle.fr["PAGMenu_ActiveProfileRename_T"]      = "Renommer le profil actif"
ResourceBundle.fr["PAGMenu_Welcome"]                    = "Afficher le message d'accueil"
ResourceBundle.fr["PAGMenu_Welcome_T"]                  = "Afficher le message d'accueil de l'addon après un chargement réussi ?"

-- PARMenu --
ResourceBundle.fr["PARMenu_Header"]                     = PAC_COLTEXT_PAR
ResourceBundle.fr["PARMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Activer l'Auto Repair"
ResourceBundle.fr["PARMenu_Enable_T"]                   = "Activer la Réparation Automatique ?"
ResourceBundle.fr["PARMenu_RepairWornGold"]                   = "Réparer les objets équipés"
ResourceBundle.fr["PARMenu_RepairWornGold_T"]                 = "Réparer les objets équipés ?"
ResourceBundle.fr["PARMenu_RepairWornGoldDura"]               = "- Seuil de durabilité en %"
ResourceBundle.fr["PARMenu_RepairWornGoldDura_T"]             = "Réparer les objets équipés s'ils sont en-dessous du seuil de durabilité défini."
















-- PABMenu --
ResourceBundle.fr["PABMenu_Header"]                     = PAC_COLTEXT_PAB
ResourceBundle.fr["PABMenu_Enable"]                     = PAC_COL_LIGHT_BLUE.."Activer l'Auto Banking"
ResourceBundle.fr["PABMenu_Enable_T"]                   = "Activer la dépose et le retrait automatique en banque ?"
ResourceBundle.fr["PABMenu_EnabledGold"]                = "Déposer de l'or"
ResourceBundle.fr["PABMenu_EnabledGold_T"]              = "Déposer automatiquement de l'or en banque ?"
ResourceBundle.fr["PABMenu_GoldTransactionStep"]        = "- Déplacement d'or par tranche de :"
ResourceBundle.fr["PABMenu_GoldTransactionStep_T"]      = "Par tranche de combien l'or doit être déposé ou retiré ?"
ResourceBundle.fr["PABMenu_GoldMinToKeep"]              = "- Or minimum à garder sur soi"
ResourceBundle.fr["PABMenu_GoldMinToKeep_T"]            = "Quantité d'or minimum à toujours conserver sur votre personnage."
ResourceBundle.fr["PABMenu_GoldMinToKeep_W"]            = "Nombre non valide --> Aucun or ne sera conservé sur votre personnage."
ResourceBundle.fr["PABMenu_WithdrawToMinGold"]          = "- Retirer de l'or si en-dessous du minimum"
ResourceBundle.fr["PABMenu_WithdrawToMinGold_T"]        = "Retirer automatiquement de l'or de la banque quand le personnage en a moins que défini ci-dessus ?"
ResourceBundle.fr["PABMenu_EnabledItems"]               = "Déposer et retirer des objets"
ResourceBundle.fr["PABMenu_EnabledItems_T"]             = "Déposer et/ou retirer automatiquement des objets de la banque?"
ResourceBundle.fr["PABMenu_DepItemTypeDesc"]            = "Définir les actions spécifiques (déposer, retirer, ignorer) pour les types d'objets communs et avancés."


ResourceBundle.fr["PABMenu_DepItemType"]                = "Types d'objets communs"
ResourceBundle.fr["PABMenu_DepItemType_T"]              = "Ouvrez le sous-menu pour définir pour chaque type d'objet s'il doit être déposer, retirer, ou ignorer."




ResourceBundle.fr["PABMenu_Advanced_DepItemType"]       = "Types d'objets avancés"
ResourceBundle.fr["PABMenu_Advanced_DepItemType_T"]     = "Ouvrez le sous-menu pour définir de façon avancée quels types d'objets doivent être déposés, retirés ou ignorés."
ResourceBundle.fr["PABMenu_DepItemTimerInterval"]       = "- Intervalle entre les déposes (msecs)"
ResourceBundle.fr["PABMenu_DepItemTimerInterval_T"]     = "Combien de temps en msecs entre deux déposes consécutives d'objets. Si la dépose de beaucoup d'objets ne fonctionne pas, pensez à augmenter cette valeur."
ResourceBundle.fr["PABMenu_ItemType_Header"]            = PAC_COL_LIGHT_BLUE.."TYPES D'OBJET"
ResourceBundle.fr["PABMenu_HideNoDeposit"]              = "Masquer le message 'Rien à déposer'"
ResourceBundle.fr["PABMenu_HideNoDeposit_T"]            = "Masquer le message 'Rien à déposer'. Vous verrez un message s'il a quelque chose à déposer."
ResourceBundle.fr["PABMenu_HideAll"]                    = "Masquer TOUS les messages bancaires"
ResourceBundle.fr["PABMenu_HideAll_T"]                  = "Mode silencieux : Aucun message ne sera affiché. Vous ne verrez pas vos objets/or déposés."  -- TODO: Update translation
ResourceBundle.fr["PABMenu_DepButton"]                  = "Tout déposer"
ResourceBundle.fr["PABMenu_DepButton_T"]                = "Changer toutes les valeurs de menu pour 'Déposer'"
ResourceBundle.fr["PABMenu_WitButton"]                  = "Tout retirer"
ResourceBundle.fr["PABMenu_WitButton_T"]                = "Changer toutes les valeurs de menu pour 'Retirer'"
ResourceBundle.fr["PABMenu_IgnButton"]                  = "Tout ignorer"
ResourceBundle.fr["PABMenu_IgnButton_T"]                = "Changer toutes les valeurs de menu pour '-'"
ResourceBundle.fr["PABMenu_Lockipck_Header"]            = PAC_COL_LIGHT_BLUE.."Crochetages"
ResourceBundle.fr["PABMenu_Keep_in_Backpack"]           = "Quantité à garder dans le sac à dos"
ResourceBundle.fr["PABMenu_Keep_in_Backpack_T"]         = "Definir la quantité qui doit, en fonction du comparateur mathématique, être gardée dans le sac à dos."

-- PALMenu --
ResourceBundle.en["PALMenu_Header"]                     = PAC_COLTEXT_PAL






























-- PAJMenu --
ResourceBundle.fr["PAJMenu_Header"]                     = PAC_COLTEXT_PAJ










-- Name Spaces --
ResourceBundle.fr["NS_Bag_Equipment"]                   = ""    -- not required so far
ResourceBundle.fr["NS_Bag_Equipped"]                    = "équipés"
ResourceBundle.fr["NS_Bag_Backpack"]                    = "le sac à dos"
ResourceBundle.fr["NS_Bag_Backpacked"]                  = "dans le sac à dos"
ResourceBundle.fr["NS_Bag_Bank"]                        = "la banque"
ResourceBundle.fr["NS_Bag_Banked"]                      = ""    -- not required so far
ResourceBundle.fr["NS_Bag_Unknown"]                     = "inconnu"

-- Operators --
ResourceBundle.fr["REL_Operator"]                       = "Comparateur mathématique"
ResourceBundle.fr["REL_None"]                           = "-"
ResourceBundle.fr["REL_Equal"]                          = "égal (=)"
ResourceBundle.fr["REL_LessThan"]                       = "inférieur (<)"        -- not required so far
ResourceBundle.fr["REL_LessThanEqual"]                  = "inférieur ou égal (<=)"
ResourceBundle.fr["REL_GreaterThan"]                    = "supérieur (>)"        -- not required so far
ResourceBundle.fr["REL_GreaterThanEqual"]               = "supérieur ou égal (>=)"

-- Stacking types --




-- Official Item Types --
ResourceBundle.fr[ITEMTYPE_ADDITIVE]                    = "frITEMTYPE_ADDITIVE"
ResourceBundle.fr[ITEMTYPE_ARMOR]                       = "Armure"
ResourceBundle.fr[ITEMTYPE_ARMOR_BOOSTER]               = "frITEMTYPE_ARMOR_BOOSTER"
ResourceBundle.fr[ITEMTYPE_ARMOR_TRAIT]                 = "Caractéristique d'armure"
ResourceBundle.fr[ITEMTYPE_AVA_REPAIR]                  = "frITEMTYPE_AVA_REPAIR"
ResourceBundle.fr[ITEMTYPE_BLACKSMITHING_BOOSTER]       = "Trempe (Forge)"
ResourceBundle.fr[ITEMTYPE_BLACKSMITHING_MATERIAL]      = "Matériau (Forge)"
ResourceBundle.fr[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL]  = "Matériau brut (Forge)"
ResourceBundle.fr[ITEMTYPE_CLOTHIER_BOOSTER]            = "Tanin (Couture)"
ResourceBundle.fr[ITEMTYPE_CLOTHIER_MATERIAL]           = "Matière (Couture)"
ResourceBundle.fr[ITEMTYPE_CLOTHIER_RAW_MATERIAL]       = "Matière brute (Couture)"
ResourceBundle.fr[ITEMTYPE_COLLECTIBLE]                 = "frITEMTYPE_COLLECTIBLE"
ResourceBundle.fr[ITEMTYPE_CONTAINER]                   = "Récipient"
ResourceBundle.fr[ITEMTYPE_COSTUME]                     = "Costume"
ResourceBundle.fr[ITEMTYPE_CROWN_ITEM]                  = "frITEMTYPE_CROWN_ITEM"
ResourceBundle.fr[ITEMTYPE_CROWN_REPAIR]                = "frITEMTYPE_CROWN_REPAIR"
ResourceBundle.fr[ITEMTYPE_DEPRECATED]                  = "frITEMTYPE_DEPRECATED"
ResourceBundle.fr[ITEMTYPE_DISGUISE]                    = "frITEMTYPE_DISGUISE"
ResourceBundle.fr[ITEMTYPE_DRINK]                       = "Boisson"
ResourceBundle.fr[ITEMTYPE_ENCHANTING_RUNE_ASPECT]      = "Runes d'aspect (Enchantement)"
ResourceBundle.fr[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]     = "Runes d'essence (Enchantement)"
ResourceBundle.fr[ITEMTYPE_ENCHANTING_RUNE_POTENCY]     = "Runes de puissance (Enchantement)"
ResourceBundle.fr[ITEMTYPE_ENCHANTMENT_BOOSTER]         = "frITEMTYPE_ENCHANTMENT_BOOSTER"
ResourceBundle.fr[ITEMTYPE_FISH]                        = "Poisson"
ResourceBundle.fr[ITEMTYPE_FLAVORING]                   = "frITEMTYPE_FLAVORING"
ResourceBundle.fr[ITEMTYPE_FOOD]                        = "Nourriture"
ResourceBundle.fr[ITEMTYPE_GLYPH_ARMOR]                 = "Glyphe d'armure (Enchantement)"
ResourceBundle.fr[ITEMTYPE_GLYPH_JEWELRY]               = "Glyphe de bijou (Enchantement)"
ResourceBundle.fr[ITEMTYPE_GLYPH_WEAPON]                = "Glyphe d'arme (Enchantement)"
ResourceBundle.fr[ITEMTYPE_INGREDIENT]                  = "Ingrédient (Cuisine)"
ResourceBundle.fr[ITEMTYPE_LOCKPICK]                    = "Crochetage"
ResourceBundle.fr[ITEMTYPE_LURE]                        = "Appât"
ResourceBundle.fr[ITEMTYPE_MASTER_WRIT]                 = "frITEMTYPE_MASTER_WRIT"
ResourceBundle.fr[ITEMTYPE_MAX_VALUE]                   = "frITEMTYPE_MAX_VALUE"
ResourceBundle.fr[ITEMTYPE_MIN_VALUE]                   = "frITEMTYPE_MIN_VALUE"
ResourceBundle.fr[ITEMTYPE_MOUNT]                       = "frITEMTYPE_MOUNT"
ResourceBundle.fr[ITEMTYPE_NONE]                        = "frITEMTYPE_NONE"
ResourceBundle.fr[ITEMTYPE_PLUG]                        = "frITEMTYPE_PLUG"
ResourceBundle.fr[ITEMTYPE_POISON]                      = "Poison"
ResourceBundle.fr[ITEMTYPE_POISON_BASE]                 = "Solvant à poison (Alchimie)"
ResourceBundle.fr[ITEMTYPE_POTION]                      = "Potion"
ResourceBundle.fr[ITEMTYPE_POTION_BASE]                 = "Solvant pour poison (Alchimie)"
ResourceBundle.fr[ITEMTYPE_RACIAL_STYLE_MOTIF]          = "frITEMTYPE_RACIAL_STYLE_MOTIF"
ResourceBundle.fr[ITEMTYPE_RAW_MATERIAL]                = "Matériau brut"
ResourceBundle.fr[ITEMTYPE_REAGENT]                     = "Réactif (Alchimie)"
ResourceBundle.fr[ITEMTYPE_RECIPE]                      = "Recette (Cuisine)"
ResourceBundle.fr[ITEMTYPE_SIEGE]                       = "frITEMTYPE_SIEGE"
ResourceBundle.fr[ITEMTYPE_SOUL_GEM]                    = "Pierre d'âme"
ResourceBundle.fr[ITEMTYPE_SPELLCRAFTING_TABLET]        = "frITEMTYPE_SPELLCRAFTING_TABLET"
ResourceBundle.fr[ITEMTYPE_SPICE]                       = "frITEMTYPE_SPICE"
ResourceBundle.fr[ITEMTYPE_STYLE_MATERIAL]              = "Matériau de style"
ResourceBundle.fr[ITEMTYPE_TABARD]                      = "frITEMTYPE_TABARD"
ResourceBundle.fr[ITEMTYPE_TOOL]                        = "Outil"
ResourceBundle.fr[ITEMTYPE_TRASH]                       = "Déchet"
ResourceBundle.fr[ITEMTYPE_TREASURE]                    = "frITEMTYPE_TREASURE"
ResourceBundle.fr[ITEMTYPE_TROPHY]                      = "Trophée"
ResourceBundle.fr[ITEMTYPE_WEAPON]                      = "frITEMTYPE_WEAPON"
ResourceBundle.fr[ITEMTYPE_WEAPON_BOOSTER]              = "frITEMTYPE_WEAPON_BOOSTER"
ResourceBundle.fr[ITEMTYPE_WEAPON_TRAIT]                = "Trait d'arme"
ResourceBundle.fr[ITEMTYPE_WOODWORKING_BOOSTER]         = "Résine (Travail du bois)"
ResourceBundle.fr[ITEMTYPE_WOODWORKING_MATERIAL]        = "Matériau (Travail du bois)"
ResourceBundle.fr[ITEMTYPE_WOODWORKING_RAW_MATERIAL]    = "Matériau brut (Travail du bois)"