You created an XCOM 2 Mod Project!

uses the values presented in this mod https://steamcommunity.com/sharedfiles/filedetails/?id=1195570782 heavy weapon tweaks

https://steamcommunity.com/sharedfiles/filedetails/?id=2262682879 Frost munitions
https://steamcommunity.com/sharedfiles/filedetails/?id=1891339003 Bitterfrost Protocol

https://steamcommunity.com/sharedfiles/filedetails/?id=1137905049 Enhanced Status Penalties WOTC
https://steamcommunity.com/sharedfiles/filedetails/?id=1862467473 Depower Heavy weapons

negates the entries in XComGame_SoldierSkills for flamethower range and radius
fully removes basegame flamethrower and hellfire projector

MUCH THANKS to Iridar and Mitzruti for helping bugfix my issues with SPARK visualisations

Respects burning rush, salvo, fine control and rainmaker
=====================================================================================
Texture2D'UILib_EHW.Inventory.Inv_AcidThrower'
Texture2D'UILib_EHW.Inventory.Inv_AcidThrowerMK2'
Texture2D'UILib_EHW.Inventory.Inv_CryoThrower'
Texture2D'UILib_EHW.Inventory.Inv_CryoThrowerMK2'
Texture2D'UILib_EHW.Inventory.Inv_FireThrower'
Texture2D'UILib_EHW.Inventory.Inv_FireThrowerMK2'
Texture2D'UILib_EHW.Inventory.Inv_PoisonThrower'
Texture2D'UILib_EHW.Inventory.Inv_PoisonThrowerMK2'

Texture2D'UILib_EHW.Icons.UIPerk_ACID'
Texture2D'UILib_EHW.Icons.UIPerk_FIRE'
Texture2D'UILib_EHW.Icons.UIPerk_ICE'
Texture2D'UILib_EHW.Icons.UIPerk_POISON'
=====================================================================================
STEAM DESC      https://steamcommunity.com/sharedfiles/filedetails/?id=2286276688
=====================================================================================
[h1] What is this?[/h1]
This is an expansion of the basic game Heavy Flamethrower.

It adds 3 new types of heavy weapon and replaces the base game flamthrower.
So all 4 base elemental types: fire, acid, poison and cryo/frost.
With a basic and advanced version ... 8 weapons ... 
... but wait you need to repeat them for SPARKS ... so technically 16 weapons...
... and the BITS need thier own weapons too.. well this soon became a nightmare

The new arm throwers will all respect [i]Salvo[/i], [i]RainMaker[/i], [i]Burning Rush[/i] and [i]Fine Control[/i].
The new arm throwers are added to their respective experimental weapons projects.
As well as basic damages they also never miss and inflict the status you would expect (burning, acid burn, poison and frozen).

[h1] Config [/h1]
Lots of options in the [i]XComGameData_WeaponData[/i] to control all the damages, ranges and stuff
Default values were based on the values found in [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1195570782] Heavy Weapon Tweaks [/url] and options of [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1862467473] Depower Heavy Weapons [/url]

[h1] Compatibility/Known Issues [/h1]
[list]
[*]Fully replaces the base game heavy flamethrowers with a new version, so any mods that affect/need them will not work with this version.
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2127166233] SPARK Arsenal [/url] has an option that lets you exchange the weapon on a BIT with aid protocol. This mod works with that, but the visualisation bugs out.
The new unit given the thrower will also fire thier normal weapon. I tried to make it work but I just don't understand [b]Iridars Magic Code[/b] enough to make it fully work. Sorry.
[*]Sometimes the visual stream jet will glitch out, the weapon still works but just looks wrong.
[*]Includes config for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2259746446] PGOv2 [/url] and [b]Covert Infiltration[/b].
[*]Should be fine to add mid-campaign, strategy save ... will automatically replace old flamethrowers with new ones.
[/list]
[h1] Credits and Thanks [/h1]
As always, much thanks to the XCOM2 Modders Discord for continued help and support.
[b]Iridar[/b] and [b]Mitzruti[/b] for help with SPARK integrations
[b]MrCloista[/b] for requesting this mod for his birthday present. :) And then allowing me to release it.

~ Enjoy [b]!![/b] and please [url=https://www.buymeacoffee.com/RustyDios] buy me a Cuppa Tea[/url]
=====================================================================
>> notes from iridar <<
Ugh, heavy weapons with SPARKs are a mess.
You need two weapon archetypes. One for regular soldiers and one for SPARKs.
The one for SPARKs needs to use an AltGameArchetype system, where the heavy weapon automatically detects it is equipped on the BIT, and then uses an alternative archetype.
Both archetypes need to specify one of the existing firing animations (assuming you don't want to use a custom one, which is a whole 'nother can of worms)
The alternative archetype used by BITs needs to link to a dummy weapon mesh, which is basically a tiny triangle with a gun_fire socket.
You also need two firing abilities, one for soldiers, and one for SPARKs that uses its own BuildVisualization function.
You will also have to use some conditions to make sure these abilities are only available to their appropriate units.
The tech that handles this for existing heavy weapons will not catch your custom one.

WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX
WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Powered
WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Spark
WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Bit

WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Lv2
WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Lv2_Powered
WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Lv2_Spark
WP_HeavyThrower_XXX.Archetypes.WP_HeavyThrower_XXX_Lv2_Bit
