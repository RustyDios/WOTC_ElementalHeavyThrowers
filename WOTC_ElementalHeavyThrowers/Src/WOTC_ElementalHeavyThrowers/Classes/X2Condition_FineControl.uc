//*******************************************************************************************
//  FILE:   ElementalHeavyThrowers.uc                                    
//  
//	PRETTY MUCH STLEN FROM MITZRUTIS CHEMTHROWER CODE SO THE MOD BUILDS
//	SHOULD BE THE SAME
//
//*******************************************************************************************
class X2Condition_FineControl extends X2Condition;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource) 
{ 
	local XComGameState_Unit TargetUnit, SourceUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	SourceUnit = XComGameState_Unit(kSource);
	if (TargetUnit != none && SourceUnit != none)
	{
		if (SourceUnit.IsFriendlyUnit(TargetUnit) && SourceUnit.HasSoldierAbility('MZFineControl', true))
			return 'AA_NotInRange';
	}

	return 'AA_Success'; 
}