if ResourceBundle == nil then ResourceBundle = {} end
if ResourceBundle.fr == nil then ResourceBundle.fr = {} end

-- Welcome Messages --								-- Type '/pa' for GUI."
ResourceBundle.fr["Welcome_NoSupport"] 				= PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."ersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"..PAC_COL_DEFAULT.." at your service!   -   no localization for (%s) available yet."
ResourceBundle.fr["Welcome_Support"] 				= PAC_COL_YELLOW.."P"..PAC_COL_WHITE.."ersonal"..PAC_COL_YELLOW.."A"..PAC_COL_WHITE.."ssistant"..PAC_COL_DEFAULT.." à votre service !"

-- Key Bindings
ResourceBundle.fr["KB_Load_Profile1"]				= "Active profil 1"
ResourceBundle.fr["KB_Load_Profile2"]				= "Active profil 2"
ResourceBundle.fr["KB_Load_Profile3"]				= "Active profil 3"
ResourceBundle.fr["KB_Load_Profile4"]				= "Active profil 4"
ResourceBundle.fr["KB_Load_Profile5"]				= "Active profil 5"

-- PAGeneral --
ResourceBundle.fr["PAG_Profile1"]					= "Profil 1"
ResourceBundle.fr["PAG_Profile2"]					= "Profil 2"
ResourceBundle.fr["PAG_Profile3"]					= "Profil 3"
ResourceBundle.fr["PAG_Profile4"]					= "Profil 4"
ResourceBundle.fr["PAG_Profile5"]					= "Profil 5"

-- PARepair --
ResourceBundle.fr["PAR_FullRepair"] 				= PAC_COLTEXT_PAR.."Tous les objets %s ont été réparés pour %d %s"
ResourceBundle.fr["PAR_PartialRepair"] 				= PAC_COLTEXT_PAR.."%d / %d objets %s réparés pour %d %s. (Pas assez d'or)"
ResourceBundle.fr["PAR_NoGoldToRepair"] 			= PAC_COLTEXT_PAR.."Pas assez d'or pour réparer les %d objets %s."
ResourceBundle.fr["PAR_NoRepair"] 					= PAC_COLTEXT_PAR.."Rien à réparer."

-- PABanking --
ResourceBundle.fr["PAB_GoldDepositet"] 				= PAC_COLTEXT_PAB.."%d %s déposées."
ResourceBundle.fr["PAB_GoldWithdrawn"] 				= PAC_COLTEXT_PAB.."%d %s retirées."
ResourceBundle.fr["PAB_GoldWithdrawnInsufficient"] 	= PAC_COLTEXT_PAB.."%d / %d %s retirées. (Pas assez en banque !)"

ResourceBundle.fr["PAB_ItemMovedTo"] 				= PAC_COLTEXT_PAB.."%d x %s déplacés vers %s."
ResourceBundle.fr["PAB_ItemNotMovedTo"] 			= PAC_COLTEXT_PAB.."%d x %s n'ont PAS été déplacés vers %s."
ResourceBundle.fr["PAB_ItemMovedToFailed"] 			= PAC_COLTEXT_PAB..PAC_COL_ORANGE.."ÉCHEC : %s n'ont PAS pu être déplacés vers %s."

ResourceBundle.fr["PAB_NoSpaceInFor"] 				= PAC_COLTEXT_PAB..PAC_COL_ORANGE.."Pas assez d'espace dans %s pour : %s."
ResourceBundle.fr["PAB_NoSpaceToOpen"] 				= PAC_COLTEXT_PAB.."Pas assez d'espace dans %s pour ouvrir %s."
ResourceBundle.fr["PAB_NoDeposit"] 					= PAC_COLTEXT_PAB.."Rien à déposer."

ResourceBundle.fr["PAB_ItemType_None"] 				= "-"
ResourceBundle.fr["PAB_ItemType_Deposit"]			= "Déposer"
ResourceBundle.fr["PAB_ItemType_Withdrawal"]		= "Retirer"
ResourceBundle.fr["PAB_ItemType_Inherit"]			= "Selon le type d'objet (ci-dessous)"

-- PALoot --
ResourceBundle.fr["PALo_ItemLooted"] 				= PAC_COLTEXT_PALo.."%d x %s %s"
ResourceBundle.fr["PALo_GoldLooted"] 				= PAC_COLTEXT_PALo.."%d %s"  -- TODO: translate

ResourceBundle.fr["PALo_ItemType_None"] 		    = "-"
ResourceBundle.fr["PALo_ItemType_Loot"]             = "* Auto-Piller" -- TODO: translate

-- PAJunk --
ResourceBundle.fr["PAJ_MovedToJunk"]                = PAC_COLTEXT_PAJ.."* Déplacé %s à la jonque" -- TODO: translate
ResourceBundle.fr["PAJ_SoldJunkInfo"]               = PAC_COLTEXT_PAJ.."* Vendu des objets indésirables pour %d %s" -- TODO: translate

-- MainMenu --
ResourceBundle.fr["MMenu_Title"] 					= "|cFFD700P|rersonal|cFFD700A|rssistant"

-- PAGMenu --
ResourceBundle.fr["PAGMenu_Header"]					= "|cFFD700PA G|réneral"
ResourceBundle.fr["PAGMenu_ActiveProfile"]			= "Profil actif"
ResourceBundle.fr["PAGMenu_ActiveProfile_T"]		= "Sélectionner le profil à utiliser. Changer la sélection chargera automatiquement les paramètres. Les changements ci-dessous seront automatiquement sauvegardés dans le profil."
ResourceBundle.fr["PAGMenu_ActiveProfileRename"]	= "Renommer profil actif"
ResourceBundle.fr["PAGMenu_ActiveProfileRename_T"]	= "Renommer le profil actif (forcera un rechargement de l'interface)"
ResourceBundle.fr["PAGMenu_ActiveProfileRename_W"]	= "|cff0000(forcera un rechargement de l'interface)|r"
ResourceBundle.fr["PAGMenu_Welcome"] 				= "Afficher le message d'accueil"
ResourceBundle.fr["PAGMenu_Welcome_T"] 				= "Afficher le message d'accueil de l'addon après un chargement réussi ?"

-- PARMenu --
ResourceBundle.fr["PARMenu_Header"] 				= "|cFFD700PA R|repair"
ResourceBundle.fr["PARMenu_Enable"] 				= "|cB0B0FFActiver l'Auto Repair|r"
ResourceBundle.fr["PARMenu_Enable_T"] 				= "Activer la Réparation Automatique ?"
ResourceBundle.fr["PARMenu_RepairEq"] 				= "Réparer les objets équipés"
ResourceBundle.fr["PARMenu_RepairEq_T"] 			= "Réparer les objets équipés ?"
ResourceBundle.fr["PARMenu_RepairEqDura"] 			= "- Seuil de durabilité en %"
ResourceBundle.fr["PARMenu_RepairEqDura_T"] 		= "Réparer les objets équipés s'ils sont en-dessous du seuil de durabilité défini."
ResourceBundle.fr["PARMenu_RepairBa"]				= "Réparer les objets dans le sac"
ResourceBundle.fr["PARMenu_RepairBa_T"] 			= "Réparer les objets dans le sac à dos ?"
ResourceBundle.fr["PARMenu_RepairBaDura"] 			= "- Seuil de durabilité en %"
ResourceBundle.fr["PARMenu_RepairBaDura_T"] 		= "Réparer les objets dans le sac s'ils sont en-dessous du seuil de durabilité défini."
ResourceBundle.fr["PARMenu_HideNoRepair"] 			= "Masquer le message 'Rien à réparer'"
ResourceBundle.fr["PARMenu_HideNoRepair_T"] 		= "Masquer le message 'Rien à réparer'. Vous verrez toujours un message s'il y a quelque chose à réparer."
ResourceBundle.fr["PARMenu_HideAll"] 				= "Masquer TOUS les messagesde réparation"
ResourceBundle.fr["PARMenu_HideAll_T"] 				= "Mode silencieux : Aucun message ne sera affiché. Vous ne verrez pas le coût de vos réparations." -- TODO: Update translation

-- PABMenu --
ResourceBundle.fr["PABMenu_Header"] 				= "|cFFD700PA B|ranking"
ResourceBundle.fr["PABMenu_Enable"] 				= "|cB0B0FFActiver l'Auto Banking|r"
ResourceBundle.fr["PABMenu_Enable_T"] 				= "Activer la dépose et le retrait automatique en banque ?"
ResourceBundle.fr["PABMenu_DepGold"] 				= "Déposer de l'or"
ResourceBundle.fr["PABMenu_DepGold_T"] 				= "Déposer automatiquement de l'or en banque ?"
ResourceBundle.fr["PABMenu_DepInterval"] 			= "- Intervalle entre deux déposes (sec)"
ResourceBundle.fr["PABMenu_DepInterval_T"] 			= "Temps minimum en secondes entre deux déposes automatiques d'or."
ResourceBundle.fr["PABMenu_DepInterval_W"] 			= "Nombre non valide --> Pas de temps minimum entre les déposes."
ResourceBundle.fr["PABMenu_DepGoldPerc"] 			= "- Or à déposer en %"
ResourceBundle.fr["PABMenu_DepGoldPerc_T"] 			= "Pourcentage maximum de votre or à déposer."
ResourceBundle.fr["PABMenu_DepGoldSteps"] 			= "- Déplacement d'or par tranche de :"
ResourceBundle.fr["PABMenu_DepGoldSteps_T"] 		= "Par tranche de combien l'or doit être déposé ou retiré ?"
ResourceBundle.fr["PABMenu_DepGoldKeep"] 			= "- Or minimum à garder sur soi"
ResourceBundle.fr["PABMenu_DepGoldKeep_T"] 			= "Quantité d'or minimum à toujours conserver sur votre personnage."
ResourceBundle.fr["PABMenu_DepGoldKeep_W"] 			= "Nombre non valide --> Aucun or ne sera conservé sur votre personnage."
ResourceBundle.fr["PABMenu_WitGoldMin"] 			= "- Retirer de l'or si en-dessous du minimum"
ResourceBundle.fr["PABMenu_WitGoldMin_T"] 			= "Retirer automatiquement de l'or de la banque quand le personnage en a moins que défini ci-dessus ?"
ResourceBundle.fr["PABMenu_DepWitItem"] 			= "Déposer et retirer des objets"
ResourceBundle.fr["PABMenu_DepWitItem_T"] 			= "Déposer et/ou retirer automatiquement des objets de la banque?"
ResourceBundle.fr["PABMenu_DepItemTypeDesc"] 		= "Définir les actions spécifiques (déposer, retirer, ignorer) pour les types d'objets communs et avancés."
ResourceBundle.fr["PABMenu_DepItemType"] 			= "Types d'objets communs"
ResourceBundle.fr["PABMenu_DepItemType_T"] 			= "Ouvrez le sous-menu pour définir pour chaque type d'objet s'il doit être déposer, retirer, ou ignorer."
ResourceBundle.fr["PABMenu_DepStackOnly"]			= "* Ouvrez le sous-menu pour définir pour chaque type d'élément s'il doit être déposé, retiré ou ignoré." -- TODO: translate
ResourceBundle.fr["PABMenu_DepStackOnly_T"]			= "* Type d'empilement (Dépôt)"
ResourceBundle.fr["PABMenu_WitStackOnly"]			= "* Type d'empilement (Retirer)"
ResourceBundle.fr["PABMenu_WitStackOnly_T"]			= "* Définir si tous les éléments correspondants doivent être retirés complètement, si seuls les éléments qui existent dans le conteneur cible doivent être retirés ou si seules les piles existantes doivent être remplies jusqu'à leur taille maximale."
ResourceBundle.fr["PABMenu_Advanced_DepItemType"]	= "Types d'objets avancés"
ResourceBundle.fr["PABMenu_Advanced_DepItemType_T"]	= "Ouvrez le sous-menu pour définir de façon avancée quels types d'objets doivent être déposés, retirés ou ignorés."
ResourceBundle.fr["PABMenu_DepItemTimerInterval"]	= "- Intervalle entre les déposes (msecs)"
ResourceBundle.fr["PABMenu_DepItemTimerInterval_T"]	= "Combien de temps en msecs entre deux déposes consécutives d'objets. Si la dépose de beaucoup d'objets ne fonctionne pas, pensez à augmenter cette valeur."
ResourceBundle.fr["PABMenu_ItemJunk_Header"]		= PAC_COL_LIGHT_BLUE.."OBJETS NOTÉS AU REBUT"
ResourceBundle.fr["PABMenu_DepItemJunk"] 			= "Objets au rebut"
ResourceBundle.fr["PABMenu_DepItemJunk_T"] 			= "Est-ce que tous les items au rebut, seulement ceux de type d'objets ci-dessous ou aucun doivent être retirés ou déposés en banque ?"
ResourceBundle.fr["PABMenu_ItemType_Header"]		= PAC_COL_LIGHT_BLUE.."TYPES D'OBJET"
ResourceBundle.fr["PABMenu_HideNoDeposit"] 			= "Masquer le message 'Rien à déposer'"
ResourceBundle.fr["PABMenu_HideNoDeposit_T"] 		= "Masquer le message 'Rien à déposer'. Vous verrez un message s'il a quelque chose à déposer."
ResourceBundle.fr["PABMenu_HideAll"] 				= "Masquer TOUS les messages bancaires"
ResourceBundle.fr["PABMenu_HideAll_T"] 				= "Mode silencieux : Aucun message ne sera affiché. Vous ne verrez pas vos objets/or déposés."  -- TODO: Update translation
ResourceBundle.fr["PABMenu_DepButton"] 				= "Tout déposer"
ResourceBundle.fr["PABMenu_DepButton_T"] 			= "Changer toutes les valeurs de menu pour 'Déposer'"
ResourceBundle.fr["PABMenu_WitButton"] 				= "Tout retirer"
ResourceBundle.fr["PABMenu_WitButton_T"] 			= "Changer toutes les valeurs de menu pour 'Retirer'"
ResourceBundle.fr["PABMenu_IgnButton"] 				= "Tout ignorer"
ResourceBundle.fr["PABMenu_IgnButton_T"] 			= "Changer toutes les valeurs de menu pour '-'"
ResourceBundle.fr["PABMenu_Lockipck_Header"]        = PAC_COL_LIGHT_BLUE.."Crochetages"
ResourceBundle.fr["PABMenu_Keep_in_Backpack"]       = "Quantité à garder dans le sac à dos"
ResourceBundle.fr["PABMenu_Keep_in_Backpack_T"]     = "Definir la quantité qui doit, en fonction du comparateur mathématique, être gardée dans le sac à dos."

-- PALoMenu --
ResourceBundle.fr["PALoMenu_Header"] 				= "|cFFD700PA L|root" -- TODO: translate
ResourceBundle.fr["PALoMenu_Enable"] 				= "|cB0B0FF* Activer le pillage automatique|r" -- TODO: translate
ResourceBundle.fr["PALoMenu_Enable_T"] 				= "* Activer le pillage automatique?" -- TODO: translate
ResourceBundle.fr["PALoMenu_LootGold"]              = "* Piller automatique pièces d'or" -- TODO: translate
ResourceBundle.fr["PALoMenu_LootGold_T"]            = "* Piller automatique pièces d'or?" -- TODO: translate
ResourceBundle.fr["PALoMenu_LootItems"]             = "* Pillage automatique d'articles récoltables" -- TODO: translate
ResourceBundle.fr["PALoMenu_LootItems_T"]           = "* Pillage automatique d'articles récoltables?" -- TODO: translate
ResourceBundle.fr["PALoMenu_ItemTypeDesc"] 	        = "* Activer et désactiver auto-loot pour les articles récoltables à partir de minerais, herbes, bois, runesones, ou des trous de pêche." -- TODO: translate
ResourceBundle.fr["PALoMenu_ItemType"]              = "* Type d'article récoltable" -- TODO: translate
ResourceBundle.fr["PALoMenu_ItemType_T"]            = "* Ouvrez le sous-menu pour définir pour chaque type d'élément récoltable s'il doit être auto-pillé ou non." -- TODO: translate
ResourceBundle.fr["PALoMenu_ItemType_Header"]		= PAC_COL_LIGHT_BLUE.."TYPES D'OBJET"
ResourceBundle.fr["PALoMenu_LootButton"] 			= "* Piller automatique tous" -- TODO: translate
ResourceBundle.fr["PALoMenu_LootButton_T"] 			= "* Changer toutes les valeurs de liste déroulante à 'Piller automatique'" -- TODO: translate
ResourceBundle.fr["PALoMenu_IgnButton"] 			= "* Désactiver tous les" -- TODO: translate
ResourceBundle.fr["PALoMenu_IgnButton_T"] 			= "Changer toutes les valeurs de menu pour '-'"
ResourceBundle.fr["PALoMenu_HideItemLoot"] 			= "* Masquer le message 'Objet pillé'" -- TODO: translate
ResourceBundle.fr["PALoMenu_HideItemLoot_T"] 		= "* Masquer le message 'Objet volé'. Vous ne verrez plus quels articles ont été automatiquement pillés." -- TODO: translate
ResourceBundle.fr["PALoMenu_HideGoldLoot"] 			= "* Masquer le message 'Or pillé'" -- TODO: translate
ResourceBundle.fr["PALoMenu_HideGoldLoot_T"] 		= "* Masquer le message 'Où j'ai été pillé'. Vous ne verrez plus combien d'or a été automatiquement pillé." -- TODO: translate
ResourceBundle.fr["PALoMenu_HideAll"] 				= "* Masquer TOUS les messages de butin" -- TODO: translate
ResourceBundle.fr["PALoMenu_HideAll_T"] 			= "* Mode silencieux: aucun message de pillage (articles et devises) s'affiche." -- TODO: translate

-- PAJMenu --
ResourceBundle.fr["PAJMenu_Header"]                 = "|cFFD700PA J|runk"
ResourceBundle.fr["PAJMenu_Enable"] 				= "|cB0B0FF* Activer l'annulation automatique|r" -- TODO: translate
ResourceBundle.fr["PAJMenu_Enable_T"] 				= "* Akctiver l'annulation automatique?" -- TODO: translate
ResourceBundle.fr["PAJMenu_ItemTypeDesc"]           = "* Activer et désactiver le marquage automatique comme indésirable pour différents types d'éléments." -- TODO: translate
ResourceBundle.fr["PAJMenu_AutoSellJunk"]           = "* Vente automatique d'ordures?" -- TODO: translate
ResourceBundle.fr["PAJMenu_AutoSellJunk_T"]         = "* Vendez automatiquement tous les articles marqués comme junk?" -- TODO: translate
ResourceBundle.fr["PAJMenu_AutoMarkTrash"]          = "* Marquage automatique [Corbeille]" -- TODO: translate
ResourceBundle.fr["PAJMenu_AutoMarkTrash_T"]        = "* Marquer automatiquement les éléments du type [Trash] comme junk?" -- TODO: translate
ResourceBundle.fr["PAJMenu_HideAll"] 				= "* Masquer tous les messages indésirables" -- TODO: translate
ResourceBundle.fr["PAJMenu_HideAll_T"] 			    = "* Mode silencieux: Aucun message indésirable ne sera affiché." -- TODO: translate

-- Name Spaces --
ResourceBundle.fr["NS_Bag_Equipment"]				= ""	-- not required so far
ResourceBundle.fr["NS_Bag_Equipped"]				= "équipés"
ResourceBundle.fr["NS_Bag_Backpack"]				= "le sac à dos"
ResourceBundle.fr["NS_Bag_Backpacked"]				= "dans le sac à dos"
ResourceBundle.fr["NS_Bag_Bank"]					= "la banque"
ResourceBundle.fr["NS_Bag_Banked"]					= ""	-- not required so far
ResourceBundle.fr["NS_Bag_Unknown"]					= "inconnu"

-- Operators --
ResourceBundle.fr["REL_Operator"]                   = "Comparateur mathématique"
ResourceBundle.fr["REL_None"]                       = "-"
ResourceBundle.fr["REL_Equal"]                      = "égal (=)"
ResourceBundle.fr["REL_LessThan"]                   = "inférieur (<)"		-- not required so far
ResourceBundle.fr["REL_LessThanEqual"]              = "inférieur ou égal (<=)"
ResourceBundle.fr["REL_GreaterThan"]                = "supérieur (>)"		-- not required so far
ResourceBundle.fr["REL_GreaterThanEqual"]           = "supérieur ou égal (>=)"

-- Stacking types --
ResourceBundle.fr["ST_MoveAllFull"]					= "* Déplacer tout"			-- 0: Full deposit   -- TODO: translate
ResourceBundle.fr["ST_MoveExistingFull"]			= "* Tout déplacer si une pile existe"		-- 1: Deposit if existing    -- TODO: translate
ResourceBundle.fr["ST_FillIncompleteOnly"]			= "* Remplir uniquement les piles existantes"		-- 2: Fill existing stacks   -- TODO: translate

-- Official Item Types --
ResourceBundle.fr[ITEMTYPE_ADDITIVE] 				= "frITEMTYPE_ADDITIVE"
ResourceBundle.fr[ITEMTYPE_ARMOR] 					= "Armure"
ResourceBundle.fr[ITEMTYPE_ARMOR_BOOSTER] 			= "frITEMTYPE_ARMOR_BOOSTER"
ResourceBundle.fr[ITEMTYPE_ARMOR_TRAIT] 			= "Caractéristique d'armure"
ResourceBundle.fr[ITEMTYPE_AVA_REPAIR] 				= "frITEMTYPE_AVA_REPAIR"
ResourceBundle.fr[ITEMTYPE_BLACKSMITHING_BOOSTER] 	= "Trempe (Forge)"
ResourceBundle.fr[ITEMTYPE_BLACKSMITHING_MATERIAL] 	= "Matériau (Forge)"
ResourceBundle.fr[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL] = "Matériau brut (Forge)"
ResourceBundle.fr[ITEMTYPE_CLOTHIER_BOOSTER] 		= "Tanin (Couture)"
ResourceBundle.fr[ITEMTYPE_CLOTHIER_MATERIAL] 		= "Matière (Couture)"
ResourceBundle.fr[ITEMTYPE_CLOTHIER_RAW_MATERIAL] 	= "Matière brute (Couture)"
ResourceBundle.fr[ITEMTYPE_COLLECTIBLE] 			= "frITEMTYPE_COLLECTIBLE"
ResourceBundle.fr[ITEMTYPE_CONTAINER] 				= "Récipient"
ResourceBundle.fr[ITEMTYPE_COSTUME] 				= "Costume"
ResourceBundle.fr[ITEMTYPE_CROWN_ITEM]              = "frITEMTYPE_CROWN_ITEM"
ResourceBundle.fr[ITEMTYPE_CROWN_REPAIR]            = "frITEMTYPE_CROWN_REPAIR"
ResourceBundle.fr[ITEMTYPE_DEPRECATED]              = "frITEMTYPE_DEPRECATED"
ResourceBundle.fr[ITEMTYPE_DISGUISE] 				= "frITEMTYPE_DISGUISE"
ResourceBundle.fr[ITEMTYPE_DRINK] 					= "Boisson"
ResourceBundle.fr[ITEMTYPE_ENCHANTING_RUNE_ASPECT]	= "Runes d'aspect (Enchantement)"
ResourceBundle.fr[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]	= "Runes d'essence (Enchantement)"
ResourceBundle.fr[ITEMTYPE_ENCHANTING_RUNE_POTENCY]	= "Runes de puissance (Enchantement)"
ResourceBundle.fr[ITEMTYPE_ENCHANTMENT_BOOSTER] 	= "frITEMTYPE_ENCHANTMENT_BOOSTER"
ResourceBundle.fr[ITEMTYPE_FISH]                    = "Poisson"
ResourceBundle.fr[ITEMTYPE_FLAVORING] 				= "frITEMTYPE_FLAVORING"
ResourceBundle.fr[ITEMTYPE_FOOD] 					= "Nourriture"
ResourceBundle.fr[ITEMTYPE_GLYPH_ARMOR] 			= "Glyphe d'armure (Enchantement)"
ResourceBundle.fr[ITEMTYPE_GLYPH_JEWELRY] 			= "Glyphe de bijou (Enchantement)"
ResourceBundle.fr[ITEMTYPE_GLYPH_WEAPON] 			= "Glyphe d'arme (Enchantement)"
ResourceBundle.fr[ITEMTYPE_INGREDIENT] 				= "Ingrédient (Cuisine)"
ResourceBundle.fr[ITEMTYPE_LOCKPICK] 				= "Crochetage"
ResourceBundle.fr[ITEMTYPE_LURE] 					= "Appât"
--ResourceBundle.fr[ITEMTYPE_MASTER_WRIT]             = "frITEMTYPE_MASTER_WRIT"
ResourceBundle.fr[ITEMTYPE_MAX_VALUE]               = "frITEMTYPE_MAX_VALUE"
ResourceBundle.fr[ITEMTYPE_MIN_VALUE]               = "frITEMTYPE_MIN_VALUE"
ResourceBundle.fr[ITEMTYPE_MOUNT]					= "frITEMTYPE_MOUNT"
ResourceBundle.fr[ITEMTYPE_NONE] 					= "frITEMTYPE_NONE"
ResourceBundle.fr[ITEMTYPE_PLUG] 					= "frITEMTYPE_PLUG"
ResourceBundle.fr[ITEMTYPE_POISON] 					= "Poison"
ResourceBundle.fr[ITEMTYPE_POISON_BASE]             = "Solvant à poison (Alchimie)"
ResourceBundle.fr[ITEMTYPE_POTION] 					= "Potion"
ResourceBundle.fr[ITEMTYPE_POTION_BASE]             = "Solvant pour poison (Alchimie)"
ResourceBundle.fr[ITEMTYPE_RACIAL_STYLE_MOTIF] 		= "frITEMTYPE_RACIAL_STYLE_MOTIF"
ResourceBundle.fr[ITEMTYPE_RAW_MATERIAL] 			= "Matériau brut"
ResourceBundle.fr[ITEMTYPE_REAGENT] 				= "Réactif (Alchimie)"
ResourceBundle.fr[ITEMTYPE_RECIPE] 					= "Recette (Cuisine)"
ResourceBundle.fr[ITEMTYPE_SIEGE] 					= "frITEMTYPE_SIEGE"
ResourceBundle.fr[ITEMTYPE_SOUL_GEM] 				= "Pierre d'âme"
ResourceBundle.fr[ITEMTYPE_SPELLCRAFTING_TABLET]    = "frITEMTYPE_SPELLCRAFTING_TABLET"
ResourceBundle.fr[ITEMTYPE_SPICE] 					= "frITEMTYPE_SPICE"
ResourceBundle.fr[ITEMTYPE_STYLE_MATERIAL] 			= "Matériau de style"
ResourceBundle.fr[ITEMTYPE_TABARD] 					= "frITEMTYPE_TABARD"
ResourceBundle.fr[ITEMTYPE_TOOL] 					= "Outil"
ResourceBundle.fr[ITEMTYPE_TRASH]					= "Déchet"
ResourceBundle.fr[ITEMTYPE_TREASURE]                = "frITEMTYPE_TREASURE"
ResourceBundle.fr[ITEMTYPE_TROPHY] 					= "Trophée"
ResourceBundle.fr[ITEMTYPE_WEAPON] 					= "frITEMTYPE_WEAPON"
ResourceBundle.fr[ITEMTYPE_WEAPON_BOOSTER] 			= "frITEMTYPE_WEAPON_BOOSTER"
ResourceBundle.fr[ITEMTYPE_WEAPON_TRAIT] 			= "Trait d'arme"
ResourceBundle.fr[ITEMTYPE_WOODWORKING_BOOSTER] 	= "Résine (Travail du bois)"
ResourceBundle.fr[ITEMTYPE_WOODWORKING_MATERIAL] 	= "Matériau (Travail du bois)"
ResourceBundle.fr[ITEMTYPE_WOODWORKING_RAW_MATERIAL] = "Matériau brut (Travail du bois)"