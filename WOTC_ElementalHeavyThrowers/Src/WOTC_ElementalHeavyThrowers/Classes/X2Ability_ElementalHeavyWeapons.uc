//*******************************************************************************************
//  FILE:   ElementalHeavyThrowers.uc                                    
//  
//	File created by RustyDios	30/10/20    12:00
//	LAST UPDATED				04/11/20    02:20
//
//*******************************************************************************************
class X2Ability_ElementalHeavyWeapons extends X2Ability config(GameData_WeaponData);

var config int	iAP_COST, iAMMO_COST, iCOOLDOWN_COST, iLOSTCALL;
var config bool bAP_ENDSTURN, bAP_FREE, bSHOWRAINMAKERFLYOVER;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	//normal soldier abilities
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Fire_Soldier',			class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWER_RANGE,		class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWER_RADIUS		, "UILib_EHW.Icons.UIPerk_FIRE"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Fire_Mk2_Soldier',		class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_FIRE"));
	
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Acid_Soldier',			class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWER_RANGE,		class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWER_RADIUS		, "UILib_EHW.Icons.UIPerk_ACID"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Acid_Mk2_Soldier',		class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_ACID"));

	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Cryo_Soldier',			class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWER_RANGE,		class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWER_RADIUS		, "UILib_EHW.Icons.UIPerk_ICE"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Cryo_Mk2_Soldier',		class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_ICE"));

	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Poison_Soldier',		class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWER_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWER_RADIUS	, "UILib_EHW.Icons.UIPerk_POISON"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Poison_Mk2_Soldier',	class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_POISON"));


	//for sparks
	Templates.AddItem(Create_RustyRainmakerExtension());

	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Fire_Spark',		class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWER_RANGE,		class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWER_RADIUS		, "UILib_EHW.Icons.UIPerk_FIRE"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Fire_Mk2_Spark',	class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_FIRE"));

	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Acid_Spark',		class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWER_RANGE,		class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWER_RADIUS		, "UILib_EHW.Icons.UIPerk_ACID"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Acid_Mk2_Spark',	class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_ACID"));

	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Cryo_Spark',		class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWER_RANGE,		class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWER_RADIUS		, "UILib_EHW.Icons.UIPerk_ICE"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Cryo_Mk2_Spark',	class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_ICE"));

	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Poison_Spark',		class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWER_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWER_RADIUS	, "UILib_EHW.Icons.UIPerk_POISON"));
	Templates.AddItem(Create_Heavy_Thrower('Heavythrower_Poison_Mk2_Spark',	class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWERMK2_RANGE,	class'X2Item_ElementalHeavyWeapons'.default.POISONTHROWERMK2_RADIUS	, "UILib_EHW.Icons.UIPerk_POISON"));


	return Templates;
}

static function X2AbilityTemplate Create_Heavy_Thrower(name TemplateName, int iRange, int iRadius, string ImagePath = "UILibrary_PerkIcons.UIPerk_flamethrower")
{
	local X2AbilityTemplate                 Template;

	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCooldown					Cooldown;
	local X2AbilityCost_Ammo                AmmoCost;

	local X2AbilityTarget_Cursor            CursorTarget;
	local X2AbilityMultiTarget_Cone         ConeMultiTarget;

	local X2Condition_UnitProperty			ShooterPropertyCondition;

	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local X2Effect_ApplyFireToWorld         FireToWorldEffect;
	local X2Effect_ApplyAcidToWorld_Cone	AcidToWorldEffect;
	local X2Effect_ApplyPoisonToWorld		PoisonToWorldEffect;
	local X2Effect_DLC_Day60Freeze			FreezeEffect;
	local X2Effect							RemoveEffects;

	local array<name>                       SkipExclusions;

	//create
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	//setup
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.ARMOR_ACTIVE_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailableOrNoTargets;// eAbilityIconBehavior_HideSpecificErrors;
		Template.HideErrors.AddItem('AA_WrongSoldierClass');
		Template.HideErrors.AddItem('AA_CannotAfford_AmmoCost');
		Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.IconImage = "img:///" $ImagePath;

	//costs ... AP cost is turn ending and considers 'salvo' and 'burning rush' for not turn ending
	ActionPointCost = new class'X2AbilityCost_ActionPoints';	// new class'X2AbilityCost_HeavyWeaponActionPoints';
	ActionPointCost.iNumPoints = default.iAP_COST;
	ActionPointCost.bConsumeAllPoints = default.bAP_ENDSTURN;
	ActionPointCost.bFreeCost = default.bAP_FREE;
	ActionPointCost.DoNotConsumeAllEffects.AddItem('MZBurningRush');
	ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('Salvo');
	Template.AbilityCosts.AddItem(ActionPointCost);

	//costs ... ammo as charges
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = default.iAMMO_COST;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bUseAmmoAsChargesForHUD = true;

	//costs ... cooldown added so with extra charges you can't use salvo to fire consecutive blasts in one turn
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.iCOOLDOWN_COST;
	Template.AbilityCooldown = Cooldown;

	//aiming, triggers
	Template.AbilityToHitCalc = default.DeadEye;					//nevermiss, as default!
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);	//player click to activate

	//targetting .. allow even if burning or disoriented ... dont target the dead ... don't target friendlies if you have fine control
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	Template.AbilityMultiTargetConditions.AddItem(default.LivingTargetOnlyProperty);
	
	Template.AbilityMultiTargetConditions.AddItem(new class'X2Condition_FineControl');

	//exclude the wrong version
	if (InStr(TemplateName, "Spark") != INDEX_NONE )
	{
		ShooterPropertyCondition = new class'X2Condition_UnitProperty';
		ShooterPropertyCondition.RequireSoldierClasses.AddItem('Spark');
		Template.AbilityShooterConditions.AddItem(ShooterPropertyCondition);
	}
	else 
	{
		ShooterPropertyCondition = new class'X2Condition_UnitProperty';
		ShooterPropertyCondition.ExcludeSoldierClasses.AddItem('Spark');
		Template.AbilityShooterConditions.AddItem(ShooterPropertyCondition);
	}

	//targetting .. check for blocking cover, spreadout, lightly damage environment .. conical
	Template.TargetingMethod = class'X2TargetingMethod_Cone';

	Template.bCheckCollision = true;
	Template.bAffectNeighboringTiles = true;
	Template.bFragileDamageOnly = true;

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	ConeMultiTarget = new class'X2AbilityMultiTarget_Cone';
	ConeMultiTarget.bUseWeaponRadius = true;
	ConeMultiTarget.ConeEndDiameter = iRadius * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.ConeLength = iRange * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.AddBonusConeSize('Rainmaker', class'X2Ability_SparkAbilitySet'.default.RAINMAKER_CONEDIAMETER_FLAMETHROWER, class'X2Ability_SparkAbilitySet'.default.RAINMAKER_CONELENGTH_FLAMETHROWER);
	Template.AbilityMultiTargetStyle = ConeMultiTarget;

	//damage

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.AddMultiTargetEffect(WeaponDamageEffect);

	//effects
	switch (TemplateName)
	{
		//===== FIRE EFFECTS LV1 =====//
		case 'Heavythrower_Fire_Spark':
				Template.CustomFireAnim = 'FF_FireFireThrower';
				//Template.CustomSelfFireAnim = 'FF_FireFireThrower';
		case 'Heavythrower_Fire_Soldier':
				Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateBurningStatusEffect(class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWER_BURNDAMAGE, class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWER_BURNSPREAD));

				FireToWorldEffect = new class'X2Effect_ApplyFireToWorld';
				FireToWorldEffect.bUseFireChanceLevel = true;
				FireToWorldEffect.bDamageFragileOnly = true;
				FireToWorldEffect.FireChance_Level1 = 0.0f;
				FireToWorldEffect.FireChance_Level2 = 0.5f;
				FireToWorldEffect.FireChance_Level3 = 0.25f;
				FireToWorldEffect.bCheckForLOSFromTargetLocation = false; //The flamethrower does its own LOS filtering
				Template.AddMultiTargetEffect(FireToWorldEffect);
				break;
		//===== FIRE EFFECTS LV2 =====//
		case 'Heavythrower_Fire_Mk2_Spark':
				Template.CustomFireAnim = 'FF_FireFireThrower_Lv2';
				//Template.CustomSelfFireAnim = 'FF_FireFireThrower_Lv2';
		case 'Heavythrower_Fire_Mk2_Soldier':
				Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateBurningStatusEffect(class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWERMK2_BURNDAMAGE, class'X2Item_ElementalHeavyWeapons'.default.FIRETHROWERMK2_BURNSPREAD));

				FireToWorldEffect = new class'X2Effect_ApplyFireToWorld';
				FireToWorldEffect.bUseFireChanceLevel = true;
				FireToWorldEffect.bDamageFragileOnly = true;
				FireToWorldEffect.FireChance_Level1 = 0.0f;
				FireToWorldEffect.FireChance_Level2 = 0.5f;
				FireToWorldEffect.FireChance_Level3 = 0.25f;
				FireToWorldEffect.bCheckForLOSFromTargetLocation = false; //The flamethrower does its own LOS filtering
				Template.AddMultiTargetEffect(FireToWorldEffect);
				break;
		//===== ACID EFFECTS LV1 =====//
		case 'Heavythrower_Acid_Spark':
				Template.CustomFireAnim = 'FF_FireAcidThrower';
				//Template.CustomSelfFireAnim = 'FF_FireAcidThrower';
		case 'Heavythrower_Acid_Soldier':
				Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateAcidBurningStatusEffect(class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWER_BURNDAMAGE, class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWER_BURNSPREAD));

				AcidToWorldEffect = new class'X2Effect_ApplyAcidToWorld_Cone';
				Template.AddMultiTargetEffect(AcidToWorldEffect);
				break;
		//===== ACID EFFECTS LV2 =====//
		case 'Heavythrower_Acid_Mk2_Spark':
				Template.CustomFireAnim = 'FF_FireAcidThrower_Lv2';
				//Template.CustomSelfFireAnim = 'FF_FireAcidThrower_Lv2';
		case 'Heavythrower_Acid_Mk2_Soldier':
				Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateAcidBurningStatusEffect(class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWERMK2_BURNDAMAGE, class'X2Item_ElementalHeavyWeapons'.default.ACIDTHROWERMK2_BURNSPREAD));

				AcidToWorldEffect = new class'X2Effect_ApplyAcidToWorld_Cone';
				Template.AddMultiTargetEffect(AcidToWorldEffect);
				break;
		//===== CRYO EFFECTS LV1 =====//
		case 'Heavythrower_Cryo_Spark':
				Template.CustomFireAnim = 'FF_FireCryoThrower';
				//Template.CustomSelfFireAnim = 'FF_FireCryoThrower';
		case 'Heavythrower_Cryo_Soldier':
				FreezeEffect = class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeEffect(class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWER_MINDURATION,class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWER_MAXDURATION);
				FreezeEffect.bApplyRulerModifiers = true;
				Template.AddMultiTargetEffect(FreezeEffect);

				RemoveEffects=class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeRemoveEffects();
				Template.AddMultiTargetEffect(RemoveEffects);
				break;
		//===== CRYO EFFECTS LV2 =====//
		case 'Heavythrower_Cryo_Mk2_Spark':
				Template.CustomFireAnim = 'FF_FireCryoThrower_Lv2';
				//Template.CustomSelfFireAnim = 'FF_FireCryoThrower_Lv2';
		case 'Heavythrower_Cryo_Mk2_Soldier':
				FreezeEffect = class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeEffect(class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWERMK2_MINDURATION,class'X2Item_ElementalHeavyWeapons'.default.CRYOTHROWERMK2_MAXDURATION);
				FreezeEffect.bApplyRulerModifiers = true;
				Template.AddMultiTargetEffect(FreezeEffect);

				RemoveEffects=class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeRemoveEffects();
				Template.AddMultiTargetEffect(RemoveEffects);
				break;
		//===== POISON EFFECTS LV1 =====//
		case 'Heavythrower_Poison_Spark':
				Template.CustomFireAnim = 'FF_FirePoisonThrower';
				//Template.CustomSelfFireAnim = 'FF_FirePoisonThrower';
		case 'Heavythrower_Poison_Soldier':
				Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

				PoisonToWorldEffect = new class'X2Effect_ApplyPoisonToWorld';
				Template.AddMultiTargetEffect(PoisonToWorldEffect);
				break;
		//===== POISON EFFECTS LV2 =====//
		case 'Heavythrower_Poison_Mk2_Spark':
				Template.CustomFireAnim = 'FF_FirePoisonThrower_Lv2';
				//Template.CustomSelfFireAnim = 'FF_FirePoisonThrower_Lv2';
		case 'Heavythrower_Poison_Mk2_Soldier':
				Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

				PoisonToWorldEffect = new class'X2Effect_ApplyPoisonToWorld';
				Template.AddMultiTargetEffect(PoisonToWorldEffect);
				break;
		//===== I FUCKED UP EFFECTS =====//
		default:
				break;
	}

	Template.bAllowBonusWeaponEffects = true;
	Template.DamagePreviewFn = HeavyThrower_DamagePreview;

	//visualizations, extras, more spark interactions, wotc interactions
	if (InStr(TemplateName, "Spark") != INDEX_NONE)
	{
		Template.AdditionalAbilities.AddItem('RustyRainmakerExtension');
		Template.bDisplayInUITacticalText = false;
		Template.BuildVisualizationFn = HeavyThrowerWeaponVisualization;
	}
	else
	{
		Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
		//Template.BuildVisualizationFn = HeavyThrowerWeaponVisualization;
	}

	Template.ActionFireClass = class'X2Action_Fire_Flamethrower';

	Template.ActivationSpeech = 'Flamethrower';
	Template.CinescriptCameraType = "Soldier_HeavyWeapons";
	Template.bStationaryWeapon = true;
	//Template.bUniqueSource = true;

	Template.BuildVisualizationFn = HeavyThrowerWeaponVisualization;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.bFrameEvenWhenUnitIsHidden = true;	

	//Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.HeavyWeaponLostSpawnIncreasePerUse;				//50
	//Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;				//10
	Template.LostSpawnIncreasePerUse = default.iLOSTCALL;	//	0 ... DO NOT EVER CALL MORE LOST :)
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;						//50
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;	//2

	return Template;	
}

//function for UI preview of directed blast
function bool HeavyThrower_DamagePreview(XComGameState_Ability AbilityState, StateObjectReference TargetRef, out WeaponDamageValue MinDamagePreview, out WeaponDamageValue MaxDamagePreview, out int AllowsShield)
{
	AbilityState.GetMyTemplate().AbilityMultiTargetEffects[0].GetDamagePreview(TargetRef, AbilityState, false, MinDamagePreview, MaxDamagePreview, AllowsShield);
	return true;
}

//SPARK STUFFS
static function X2AbilityTemplate Create_RustyRainmakerExtension()
{
	local X2AbilityTemplate             Template;
	local X2Effect_Persistent           PersistentEffect;
	local X2Condition_AbilityProperty	AbilityCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RustyRainmakerExtension');
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

	Template.IconImage = "img:///UILibrary_DLC3Images.UIPerk_spark_rainmaker";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bIsPassive = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentEffect = new class'X2Effect_DLC_3Rainmaker_RustyRainmakerExtension';
	PersistentEffect.bDisplayInUI = class'X2Ability_ElementalHeavyWeapons'.default.bSHOWRAINMAKERFLYOVER;
	PersistentEffect.BuildPersistentEffect(1, true, false);
	if (default.bSHOWRAINMAKERFLYOVER)
	{
		PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false, ,Template.AbilitySourceName);
	}
		AbilityCondition = new class'X2Condition_AbilityProperty';
		AbilityCondition.OwnerHasSoldierAbilities.AddItem('Rainmaker');
		PersistentEffect.TargetConditions.AddItem(AbilityCondition);
	Template.AddTargetEffect(PersistentEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Note: no visualization on purpose!

	return Template;
}

//==========================================================================
//	EQUIPMENT VISUALIZATION -- CURTESY OF IRIDARS SPARK ARSENAL 
//==========================================================================

function HeavyThrowerWeaponVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory				History;
	local XComGameStateContext_Ability		Context;
	local XComGameState_Unit				SourceUnitState;
	local array<XComGameState_Unit>			AttachedUnitStates;
	local XComGameState_Unit				CosmeticUnit;
	local VisualizationActionMetadata		EmptyMetadata;
	local VisualizationActionMetadata		ActionMetadata;
	local X2AbilityTemplate					AbilityTemplate;
	local XComGameState_Item				CosmeticHeavyWeapon;	//, SourceWeapon;
	local X2Action_ExitCover				ExitCoverAction;
	local X2Action_ExitCover				SourceExitCoverAction;
	local X2Action_EnterCover				EnterCoverAction;
	local X2Action_Fire						FireAction;
	local X2Action_Fire						NewFireAction;
	local XComGameStateVisualizationMgr		VisMgr;
	local Actor								SourceVisualizer;
	local Array<X2Action>					ParentArray;
	local Array<X2Action>					TempDamageNodes;
	local Array<X2Action>					DamageNodes;
	local int								ScanNodes;

	//`LOG("SPARK VIS FIRED",,'Sparktest');

	VisMgr = `XCOMVISUALIZATIONMGR;
	// Jwats: Build the standard visualization
	TypicalAbility_BuildVisualization(VisualizeGameState);

	// Jwats: Now handle the cosmetic unit
	History = `XCOMHISTORY;
	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);

	SourceUnitState = XComGameState_Unit(History.GetGameStateForObjectID(Context.InputContext.SourceObject.ObjectID));
	SourceVisualizer = History.GetVisualizer(SourceUnitState.ObjectID);
	SourceUnitState.GetAttachedUnits(AttachedUnitStates, VisualizeGameState);

	//SourceWeapon = XComGameState_Item(History.GetGameStateForObjectID(Context.InputContext.ItemObject.ObjectID));

	//==========================================================================
	//	CONTINUE ON WITH VISUALIZATION ONLY IF WE HAVE A COSMETIC UNIT, ie A BIT EQUIPED TO FIRE FROM
	//	IF WE DONT THEN TYPICALABILITY_BUILDVISUALIZATION ABOVE SHOULD HAVE US COVERED
	//==========================================================================

	//`assert(AttachedUnitStates.Length > 0);	//DONT USE FUXXING ASSERT BECAUSE IF IT FAILS IT CTD'S WITH AN ASSERT APPERROR IN THE LOGS >:(
	//and honestly I'd rather the game just bugs out visually than a CTD
	if (AttachedUnitStates.Length > 0)
	{
		CosmeticUnit = AttachedUnitStates[0];

		CosmeticHeavyWeapon = CosmeticUnit.GetItemInSlot(eInvSlot_HeavyWeapon);
		if (CosmeticHeavyWeapon != none)
		{
			// Jwats: Because the shooter might be using a unique fire action we'll replace it with the standard fire action to just
			//			command the cosmetic unit
			SourceExitCoverAction = X2Action_ExitCover(VisMgr.GetNodeOfType(VisMgr.BuildVisTree, class'X2Action_ExitCover', SourceVisualizer));
			FireAction = X2Action_Fire(VisMgr.GetNodeOfType(VisMgr.BuildVisTree, AbilityTemplate.ActionFireClass, SourceVisualizer));

			// Jwats: Replace the current fire action with this fire action
			NewFireAction = X2Action_Fire(class'X2Action_Fire'.static.CreateVisualizationAction(Context, SourceVisualizer));
			NewFireAction.SetFireParameters(Context.IsResultContextHit());
			VisMgr.ReplaceNode(NewFireAction, FireAction);

			// Jwats: Have the bit do an exit cover/fire/enter cover
			ActionMetadata = EmptyMetadata;
			ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(CosmeticUnit.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
			ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(CosmeticUnit.ObjectID);
			if( ActionMetadata.StateObject_NewState == none )
			{
				ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
			}
			ActionMetadata.VisualizeActor = History.GetVisualizer(CosmeticUnit.ObjectID);

			// Jwats: Wait to exit cover until the main guy is ready
			ExitCoverAction = X2Action_ExitCover(class'X2Action_ExitCover'.static.AddToVisualizationTree(ActionMetadata, Context, false, , SourceExitCoverAction.ParentActions));
			FireAction = X2Action_Fire(AbilityTemplate.ActionFireClass.static.AddToVisualizationTree(ActionMetadata, Context, false));
			EnterCoverAction = X2Action_EnterCover(class'X2Action_EnterCover'.static.AddToVisualizationTree(ActionMetadata, Context, false, FireAction));
			ExitCoverAction.UseWeapon = XGWeapon(History.GetVisualizer(CosmeticHeavyWeapon.ObjectID));
			FireAction.SetFireParameters(Context.IsResultContextHit());
			
			// Jwats: Make sure that the fire actions are in sync! Wait until both have completed their exit cover
			ParentArray.Length = 0;
			ParentArray.AddItem(ExitCoverAction);
			ParentArray.AddItem(SourceExitCoverAction);
			VisMgr.ConnectAction(FireAction, VisMgr.BuildVisTree, false, , ParentArray);
			VisMgr.ConnectAction(NewFireAction, VisMgr.BuildVisTree, false, , ParentArray);

			// Jwats: Update the apply weapon damage nodes to have the bit's fire flamethrower as their parent instead of the spark's fire node
			VisMgr.GetNodesOfType(VisMgr.BuildVisTree, class'X2Action_ApplyWeaponDamageToUnit', TempDamageNodes);
			DamageNodes = TempDamageNodes;
			VisMgr.GetNodesOfType(VisMgr.BuildVisTree, class'X2Action_ApplyWeaponDamageToTerrain', TempDamageNodes);

			for( ScanNodes = 0; ScanNodes < TempDamageNodes.Length; ++ScanNodes )
			{
				DamageNodes.AddItem(TempDamageNodes[ScanNodes]);
			}
			
			for( ScanNodes = 0; ScanNodes < DamageNodes.Length; ++ScanNodes )
			{
				if( DamageNodes[ScanNodes].ParentActions[0] == NewFireAction )
				{
					VisMgr.DisconnectAction(DamageNodes[ScanNodes]);
					VisMgr.ConnectAction(DamageNodes[ScanNodes], VisMgr.BuildVisTree, false, FireAction);
				}
			}

			// Jwats: Now make sure the enter cover of the bit is a child of all the apply weapon damage nodes
			VisMgr.ConnectAction(EnterCoverAction, VisMgr.BuildVisTree, false, , DamageNodes);
		}
	}
}
