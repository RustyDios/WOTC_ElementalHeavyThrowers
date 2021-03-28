//*******************************************************************************************
//  FILE:   ElementalHeavyThrowers.uc                                    
//  
//	File created by RustyDios	30/10/20    12:00
//	LAST UPDATED				04/11/20	02:30
//
//  EXTENDS THE RAINMAKER EFFECT TO COVER THE HEAVY WEAPONS IN THIS MOD
//
//*******************************************************************************************

class X2Effect_DLC_3Rainmaker_RustyRainmakerExtension extends X2Effect_Persistent;

//var bool bDisplayInUI;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	switch (AbilityState.GetMyTemplateName())
	{
	    case 'Heavythrower_Fire_Spark':
   		case 'Heavythrower_Acid_Spark':
		case 'Heavythrower_Cryo_Spark':
		case 'Heavythrower_Poison_Spark':
		    return class'X2Ability_SparkAbilitySet'.default.RAINMAKER_DMG_FLAMETHROWER;
            break;
	    case 'Heavythrower_Fire_Mk2_Spark':
   		case 'Heavythrower_Acid_Mk2_Spark':
		case 'Heavythrower_Cryo_MK2_Spark':
		case 'Heavythrower_Poison_Mk2_Spark':
		    return class'X2Ability_SparkAbilitySet'.default.RAINMAKER_DMG_FLAMETHROWER2;
            break;
        default:
            return 0;
            break;
	}
	return 0;
}
