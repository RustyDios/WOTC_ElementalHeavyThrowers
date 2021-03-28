//*******************************************************************************************
//  FILE:   ElementalHeavyThrowers.uc                                    
//  
//	File created by RustyDios	30/10/20    12:00
//	LAST UPDATED				04/11/20    02:40
//
//*******************************************************************************************
class X2Item_ElementalHeavyWeapons extends X2Item config(GameData_WeaponData);

var config bool bUsePoweredTier;

var config int THROWER_ISOUNDRANGE, THROWER_IENVIRONMENTDAMAGE;

var config array<name>	strFIRE_RESOURCE_COST_TYPE, strACID_RESOURCE_COST_TYPE, strCRYO_RESOURCE_COST_TYPE, strPOISON_RESOURCE_COST_TYPE, strFIREMK2_RESOURCE_COST_TYPE, strACIDMK2_RESOURCE_COST_TYPE, strCRYOMK2_RESOURCE_COST_TYPE,strPOISONMK2_RESOURCE_COST_TYPE;
var config array<int>	iFIRE_RESOURCE_COST_AMOUNT, iACID_RESOURCE_COST_AMOUNT, iCRYO_RESOURCE_COST_AMOUNT, iPOISON_RESOURCE_COST_AMOUNT, iFIREMK2_RESOURCE_COST_AMOUNT, iACIDMK2_RESOURCE_COST_AMOUNT, iCRYOMK2_RESOURCE_COST_AMOUNT, iPOISONMK2_RESOURCE_COST_AMOUNT;

var config WeaponDamageValue FIRETHROWER_BASEDAMAGE, FIRETHROWERMK2_BASEDAMAGE, CRYOTHROWER_BASEDAMAGE, CRYOTHROWERMK2_BASEDAMAGE, POISONTHROWER_BASEDAMAGE, POISONTHROWERMK2_BASEDAMAGE, ACIDTHROWER_BASEDAMAGE, ACIDTHROWERMK2_BASEDAMAGE;

var config int FIRETHROWER_TRADINGPOSTVALUE, FIRETHROWER_IPOINTS, FIRETHROWER_ICLIPSIZE, FIRETHROWER_RANGE, FIRETHROWER_RADIUS, FIRETHROWER_COVERAGE, FIRETHROWER_BURNDAMAGE, FIRETHROWER_BURNSPREAD;
var config int FIRETHROWERMK2_TRADINGPOSTVALUE, FIRETHROWERMK2_IPOINTS, FIRETHROWERMK2_ICLIPSIZE, FIRETHROWERMK2_RANGE, FIRETHROWERMK2_RADIUS, FIRETHROWERMK2_COVERAGE, FIRETHROWERMK2_BURNDAMAGE, FIRETHROWERMK2_BURNSPREAD;

var config int ACIDTHROWER_TRADINGPOSTVALUE, ACIDTHROWER_IPOINTS, ACIDTHROWER_ICLIPSIZE, ACIDTHROWER_RANGE, ACIDTHROWER_RADIUS, ACIDTHROWER_COVERAGE, ACIDTHROWER_BURNDAMAGE, ACIDTHROWER_BURNSPREAD;
var config int ACIDTHROWERMK2_TRADINGPOSTVALUE, ACIDTHROWERMK2_IPOINTS, ACIDTHROWERMK2_ICLIPSIZE, ACIDTHROWERMK2_RANGE, ACIDTHROWERMK2_RADIUS, ACIDTHROWERMK2_COVERAGE, ACIDTHROWERMK2_BURNDAMAGE, ACIDTHROWERMK2_BURNSPREAD;

var config int CRYOTHROWER_TRADINGPOSTVALUE, CRYOTHROWER_IPOINTS, CRYOTHROWER_ICLIPSIZE, CRYOTHROWER_RANGE, CRYOTHROWER_RADIUS, CRYOTHROWER_COVERAGE, CRYOTHROWER_MINDURATION, CRYOTHROWER_MAXDURATION;
var config int CRYOTHROWERMK2_TRADINGPOSTVALUE, CRYOTHROWERMK2_IPOINTS, CRYOTHROWERMK2_ICLIPSIZE, CRYOTHROWERMK2_RANGE, CRYOTHROWERMK2_RADIUS, CRYOTHROWERMK2_COVERAGE, CRYOTHROWERMK2_MINDURATION, CRYOTHROWERMK2_MAXDURATION;

var config int POISONTHROWER_TRADINGPOSTVALUE, POISONTHROWER_IPOINTS, POISONTHROWER_ICLIPSIZE, POISONTHROWER_RANGE, POISONTHROWER_RADIUS, POISONTHROWER_COVERAGE;
var config int POISONTHROWERMK2_TRADINGPOSTVALUE, POISONTHROWERMK2_IPOINTS, POISONTHROWERMK2_ICLIPSIZE, POISONTHROWERMK2_RANGE, POISONTHROWERMK2_RADIUS, POISONTHROWERMK2_COVERAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;

	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Fire',		"UILib_EHW.Inventory.Inv_FireThrower",		"WP_HeavyThrower_Fire.Archetypes.WP_HeavyThrower_Fire",			'Fire',		default.FIRETHROWER_BASEDAMAGE,		default.FIRETHROWER_ICLIPSIZE,		default.FIRETHROWER_RANGE,		default.FIRETHROWER_RADIUS, 	default.FIRETHROWER_COVERAGE, 		default.FIRETHROWER_TRADINGPOSTVALUE, 		default.FIRETHROWER_IPOINTS,		default.strFIRE_RESOURCE_COST_TYPE,		default.iFIRE_RESOURCE_COST_AMOUNT));
	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Fire_Mk2',	"UILib_EHW.Inventory.Inv_FireThrowerMk2",	"WP_HeavyThrower_Fire.Archetypes.WP_HeavyThrower_Fire_Lv2", 	'Fire', 	default.FIRETHROWERMK2_BASEDAMAGE,	default.FIRETHROWERMK2_ICLIPSIZE,	default.FIRETHROWERMK2_RANGE, 	default.FIRETHROWERMK2_RADIUS,	default.FIRETHROWERMK2_COVERAGE,	default.FIRETHROWERMK2_TRADINGPOSTVALUE, 	default.FIRETHROWERMK2_IPOINTS,		default.strFIREMK2_RESOURCE_COST_TYPE,	default.iFIREMK2_RESOURCE_COST_AMOUNT));

	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Acid',		"UILib_EHW.Inventory.Inv_AcidThrower",		"WP_HeavyThrower_Acid.Archetypes.WP_HeavyThrower_Acid", 		'Acid',		default.ACIDTHROWER_BASEDAMAGE,		default.ACIDTHROWER_ICLIPSIZE,		default.ACIDTHROWER_RANGE,		default.ACIDTHROWER_RADIUS, 	default.ACIDTHROWER_COVERAGE, 		default.ACIDTHROWER_TRADINGPOSTVALUE, 		default.ACIDTHROWER_IPOINTS,		default.strACID_RESOURCE_COST_TYPE,		default.iACID_RESOURCE_COST_AMOUNT));
	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Acid_Mk2',	"UILib_EHW.Inventory.Inv_AcidThrowerMK2",	"WP_HeavyThrower_Acid.Archetypes.WP_HeavyThrower_Acid_Lv2", 	'Acid', 	default.ACIDTHROWERMK2_BASEDAMAGE,	default.ACIDTHROWERMK2_ICLIPSIZE,	default.ACIDTHROWERMK2_RANGE, 	default.ACIDTHROWERMK2_RADIUS,	default.ACIDTHROWERMK2_COVERAGE, 	default.ACIDTHROWERMK2_TRADINGPOSTVALUE, 	default.ACIDTHROWERMK2_IPOINTS,		default.strACIDMK2_RESOURCE_COST_TYPE,	default.iACIDMK2_RESOURCE_COST_AMOUNT));

	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Cryo',		"UILib_EHW.Inventory.Inv_CryoThrower",		"WP_HeavyThrower_Cryo.Archetypes.WP_HeavyThrower_Cryo",			'Frost',	default.CRYOTHROWER_BASEDAMAGE,		default.CRYOTHROWER_ICLIPSIZE,		default.CRYOTHROWER_RANGE,		default.CRYOTHROWER_RADIUS, 	default.CRYOTHROWER_COVERAGE, 		default.CRYOTHROWER_TRADINGPOSTVALUE, 		default.CRYOTHROWER_IPOINTS,		default.strCRYO_RESOURCE_COST_TYPE,		default.iCRYO_RESOURCE_COST_AMOUNT));
	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Cryo_Mk2',	"UILib_EHW.Inventory.Inv_CryoThrowerMK2",	"WP_HeavyThrower_Cryo.Archetypes.WP_HeavyThrower_Cryo_Lv2", 	'Frost',	default.CRYOTHROWERMK2_BASEDAMAGE,	default.CRYOTHROWERMK2_ICLIPSIZE,	default.CRYOTHROWERMK2_RANGE, 	default.CRYOTHROWERMK2_RADIUS,	default.CRYOTHROWERMK2_COVERAGE, 	default.CRYOTHROWERMK2_TRADINGPOSTVALUE, 	default.CRYOTHROWERMK2_IPOINTS,		default.strCRYOMK2_RESOURCE_COST_TYPE,	default.iCRYOMK2_RESOURCE_COST_AMOUNT));

	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Poison',		"UILib_EHW.Inventory.Inv_PoisonThrower",	"WP_HeavyThrower_Poison.Archetypes.WP_HeavyThrower_Poison", 	'Poison',	default.POISONTHROWER_BASEDAMAGE,	default.POISONTHROWER_ICLIPSIZE,	default.POISONTHROWER_RANGE,	default.POISONTHROWER_RADIUS, 	default.POISONTHROWER_COVERAGE, 	default.POISONTHROWER_TRADINGPOSTVALUE, 	default.POISONTHROWER_IPOINTS,		default.strPOISON_RESOURCE_COST_TYPE,	default.iPOISON_RESOURCE_COST_AMOUNT));
	Weapons.AddItem(Create_Heavy_Thrower('Heavythrower_Poison_Mk2',	"UILib_EHW.Inventory.Inv_PoisonThrowerMK2",	"WP_HeavyThrower_Poison.Archetypes.WP_HeavyThrower_Poison_Lv2", 'Poison',	default.POISONTHROWERMK2_BASEDAMAGE,default.POISONTHROWERMK2_ICLIPSIZE,	default.POISONTHROWERMK2_RANGE, default.POISONTHROWERMK2_RADIUS,default.POISONTHROWERMK2_COVERAGE, default.POISONTHROWERMK2_TRADINGPOSTVALUE, 	default.POISONTHROWERMK2_IPOINTS,	default.strPOISONMK2_RESOURCE_COST_TYPE,default.iPOISONMK2_RESOURCE_COST_AMOUNT));
	
	return Weapons;
}

static function X2WeaponTemplate Create_Heavy_Thrower(name TemplateName, string ImagePath, string BaseArchetype, name BaseDamageType, WeaponDamageValue BaseDamage, int iAmmo, int iRange, int iRadius, float fCoverage, int iSellValue, int iPoints, array<name> strRESOURCE_COST_TYPE, array<int>	iRESOURCE_COST_AMOUNT)
{
	local X2WeaponTemplate 					Template;
	local ArtifactCost						Resources;
	local int i;

	local AltGameArchetypeUse				GameArch;
	local string AbilityName;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	//setup
	Template.strImage = "img:///" $ImagePath;
	Template.WeaponPanelImage = "_ConventionalCannon";									//attachment icons in the slots
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';			//viewpoint for camera

	Template.EquipSound = "StrategyUI_Heavy_Weapon_Equip";
	Template.WeaponCat = 'heavy';
	Template.WeaponTech = 'heavy';
	Template.InventorySlot = eInvSlot_HeavyWeapon;
	Template.StowedLocation = eSlot_HeavyWeapon;

	Template.iSoundRange =			default.THROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage =	default.THROWER_IENVIRONMENTDAMAGE;

	//build rules
	Template.PointsToComplete = iPoints;
	Template.TradingPostValue = iSellValue;

	Template.CanBeBuilt = false;

	if (InStr(TemplateName, "Mk2") != INDEX_NONE)
	{
		Template.RewardDecks.AddItem('ExperimentalPoweredWeaponRewards');
		Template.Tier = 2;
	}
	else 
	{
		Template.RewardDecks.AddItem('ExperimentalHeavyWeaponRewards');
		Template.Tier = 1;
	}

	//archetype ... this is the weapon model, fire particles, everything
	Template.GameArchetype = BaseArchetype;
	if (default.bUsePoweredTier)
	{
		Template.AltGameArchetype = BaseArchetype $"_Powered";	//if wearing powered armour
		Template.ArmorTechCatForAltArchetype = 'powered';
	}

	GameArch.UseGameArchetypeFn = SparkHeavyWeaponCheck;	//see below if is spark
	GameArch.ArchetypeString = BaseArchetype $"_Spark";
	Template.AltGameArchetypeArray.AddItem(GameArch);

	GameArch.UseGameArchetypeFn = BitHeavyWeaponCheck;		//see below if is bit
	GameArch.ArchetypeString = BaseArchetype $"_Bit";
	Template.AltGameArchetypeArray.AddItem(GameArch);

	//ability for soldiers
	AbilityName = TemplateName $ "_Soldier";
	Template.Abilities.AddItem(name(AbilityName));

	//ability for Sparks	
	AbilityName = TemplateName $ "_Spark";
	Template.Abilities.AddItem(name(AbilityName));

	//clipsize .. is displayed as charges in HUD
	Template.iClipSize = iAmmo;
	Template.bMergeAmmo = true;

	//damage
	Template.BaseDamage = BaseDamage;
	Template.DamageTypeTemplateName = BaseDamageType;

	Template.iRange = iRange;
	Template.iRadius = iRadius;
	Template.fCoverage = fCoverage;

	//Costs array for PGOv2
	for (i = 0; i < strRESOURCE_COST_TYPE.Length; i++)
	{
		if (iRESOURCE_COST_AMOUNT[i] > 0)
		{
			Resources.ItemTemplateName = strRESOURCE_COST_TYPE[i];
			Resources.Quantity = iRESOURCE_COST_AMOUNT[i];
			Template.Cost.ResourceCosts.AddItem(Resources);
		}
	}

	//UI aids
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , Template.iRange);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , Template.iRadius);

	return Template;
}

//==========================================================================
//	SPARK EQUIPMENT CHECKS -- CURTESY OF MITZRUTI'S BITTERFROST PROTOCOLS
//==========================================================================
/*
static function bool SparkHeavyWeaponCheck(XComGameState_Item ItemState, XComGameState_Unit UnitState, string ConsiderArchetype)
{
	switch(UnitState.GetMyTemplateName())
	{
	case 'SparkSoldier':
	case 'LostTowersSpark':
		//`LOG("PASS ::" @UnitState.GetMyTemplateName() @" was equipped :: " @ConsiderArchetype @" of " @ItemState.GetMyTemplate().DataName,,'SparkTest');
		return true;
	}

	//`LOG("FAIL :: " @UnitState.GetMyTemplateName() @" was NOT equipped ::" @ConsiderArchetype @" of " @ItemState.GetMyTemplate().DataName,,'SparkTest');

	return false;
}

static function bool BitHeavyWeaponCheck(XComGameState_Item ItemState, XComGameState_Unit UnitState, string ConsiderArchetype)
{
	switch(UnitState.GetMyTemplateName())
	{
	case 'SparkBitMk1':
	case 'SparkBitMk2':
	case 'SparkBitMk3':
		//`LOG("PASS :: " @UnitState.GetMyTemplateName() @" was equipped :: " @ConsiderArchetype @" of " @ItemState.GetMyTemplate().DataName,,'SparkTest');
		return true;
	}

	//`LOG("FAIL :: " @UnitState.GetMyTemplateName() @" was NOT equipped ::" @ConsiderArchetype @" of " @ItemState.GetMyTemplate().DataName,,'SparkTest');

	return false;
}
*/

//==========================================================================
//	SPARK EQUIPMENT CHECKS -- CURTESY OF IRIDARS SPARK ARSENAL, ADAPTED
//==========================================================================

static function bool SparkHeavyWeaponCheck(XComGameState_Item ItemState, XComGameState_Unit UnitState, string ConsiderArchetype)
{
	//	Use this game archetype only if the unit has a BIT. 
	//	returns false if no BIT, so negative invert makes that false > true and we then return false, no BIT
	//	if check returns true, negative invert makes that true > false, we have bit, then we don't return here ... continue on
	if (!DoesUnitHaveBITEquipped(UnitState))
	{
		return false;
	}

	//	If the Heavy Weapon is in the BIT Heavy Item slot, then we use this Heavy-on-BIT archetype only if this unit is NOT a SPARK.
	//	I.e. they're a regular soldier that have the BIT Heavy Item slot because they equipped a BIT, and now they want to put a Heavy into that "BIT heavy weapon" slot.
	if (ItemState.InventorySlot == class'X2DownloadableContentInfo_WOTC_ElementalHeavyThrowers'.default.eBitHeavySlot)	//eInvSlot_ExtraBackpack
	{
		return class'X2DownloadableContentInfo_WOTC_ElementalHeavyThrowers'.default.SparkCharacterTemplates.Find(UnitState.GetMyTemplateName()) == INDEX_NONE;
	}

	//	If this Heavy Weapon is NOT in the BIT Heavy Item slot, then we use the Heavy-on-BIT archetype if this unit is a spark.
	//	shouldn't really get here, as the spark needs the bit equipped for the heavy slot so should pass check one ?
	//	I guess this is to cover a specialist with bit-heavy AND exo-war suit heavy slots .. the first gets bit heavy, the second gets soldier heavy ... con-fuxing-using
	return class'X2DownloadableContentInfo_WOTC_ElementalHeavyThrowers'.default.SparkCharacterTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE;
}

static function bool BitHeavyWeaponCheck(XComGameState_Item ItemState, XComGameState_Unit UnitState, string ConsiderArchetype)
{
	//	Use alternative alternative archetype for the BIT itself. Nice and simple. You're a Bit. You get the Bit weapon.
	return UnitState.GetMyTemplate().bIsCosmetic;
}

static function bool DoesUnitHaveBITEquipped(XComGameState_Unit SourceUnit)
{
	local array<XComGameState_Item> InventoryItems;
	local XComGameState_Item		InventoryItem;

	InventoryItems = SourceUnit.GetAllInventoryItems(, true);

	foreach InventoryItems(InventoryItem)
	{
		if (InventoryItem.GetWeaponCategory() == 'sparkbit')
		{
			return true;
		}
	}
	return false;
}

defaultproperties
{
	bShouldCreateDifficultyVariants=false
}
