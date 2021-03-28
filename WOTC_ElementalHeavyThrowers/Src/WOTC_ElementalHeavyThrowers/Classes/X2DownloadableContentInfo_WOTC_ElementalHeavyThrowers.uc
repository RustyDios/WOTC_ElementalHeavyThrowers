//*******************************************************************************************
//  FILE:   XComDownloadableContentInfo_WOTC_ElementalHeavyThrowers.uc                                    
//  
//	File created by RustyDios	30/10/20    12:00
//	LAST UPDATED				02/11/20    02:00
//
//*******************************************************************************************

class X2DownloadableContentInfo_WOTC_ElementalHeavyThrowers extends X2DownloadableContentInfo;

var config array<name> SparkCharacterTemplates;
var config EInventorySlot eBitHeavySlot;

static event OnLoadedSavedGame(){}

static event InstallNewCampaign(XComGameState StartState){}

static event OnLoadedSavedGameToStrategy()
{
    ReplaceOutdatedItem('Flamethrower', 'Heavythrower_Fire');
    ReplaceOutdatedItem('FlamethrowerMk2', 'Heavythrower_Fire_Mk2');
}

static event OnPostTemplatesCreated()
{
    RemoveOriginalFlamethrowers('Flamethrower');
    RemoveOriginalFlamethrowers('FlamethrowerMk2');
}

//////////////////////////////////////////////////////////////////////////////////////////
// REMOVE THE OLD HEAVY FLAMERS FROM SPAWNING
//////////////////////////////////////////////////////////////////////////////////////////

static function RemoveOriginalFlamethrowers(name TemplateName)
{
	local X2ItemTemplateManager ItemMgr;
	local X2ItemTemplate        Template;

    //Karen !!!
   	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

    Template = ItemMgr.FindItemTemplate(TemplateName);
    if (Template != none)
    {
       	Template.RewardDecks.length = 0;
       	Template.CanBeBuilt = false;
        Template.HideInInventory = true;
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
// REPLACE ORIGINAL HEAVY FLAMERS WITH NEW ONES
//////////////////////////////////////////////////////////////////////////////////////////

static function ReplaceOutdatedItem(name ItemTemplateName, name ReplacementName)
{
    local XComGameStateHistory              History;
    local XComGameState_HeadquartersXCom    XComHQ;
	local X2ItemTemplateManager             ItemMgr;

	local X2ItemTemplate                    ItemTemplate, ReplacementItemTemplate;

    local XComGameState                     NewGameState;

	local array<XComGameState_Item>         InventoryItems;
    local XComGameState_Item                ItemState, ReplacementItemState;

	local array<XComGameState_Unit>         Soldiers;
	local XComGameState_Unit                SoldierState;
	local EInventorySlot                    InventorySlot;
	local int iSoldier;

    //get history and Hq
    History = `XCOMHISTORY;
    XComHQ = `XCOMHQ;

	//karen !!! call the item manager
   	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

    //get the templates we want
    ItemTemplate = ItemMgr.FindItemTemplate(ItemTemplateName);
    ReplacementItemTemplate = ItemMgr.FindItemTemplate(ReplacementName);

    //state for swapping the item
    NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Replacing Heavy Flame Items");

    //  We will be modifying HQ's Inventory, so we need to add it to the NewGameState.
    XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));

    //  If there is an item like that in the HQ Inventory already
    if (ItemTemplate != none && XComHQ.HasItem(ItemTemplate))
    {
        //get the state of the item
        ItemState = XComHQ.GetItemByName(ItemTemplate.DataName);
        
        //create a replacement state, with the same quanity
        ReplacementItemState = ReplacementItemTemplate.CreateInstanceFromTemplate(NewGameState);
		ReplacementItemState.Quantity = ItemState.Quantity;

        //remove the old item
        XComHQ.RemoveItemFromInventory(NewGameState, ItemState.GetReference(), ItemState.Quantity);
        NewGameState.RemoveStateObject(ItemState.GetReference().ObjectID);
        
        //give the new item
        XComHQ.PutItemInInventory(NewGameState, ReplacementItemState);
    }

    //then check every soldier's inventory and replace the old item with a new one
	Soldiers = XComHQ.GetSoldiers();
	for (iSoldier = 0; iSoldier < Soldiers.Length; iSoldier++)
    {
        InventoryItems = Soldiers[iSoldier].GetAllInventoryItems(NewGameState, false);
        foreach InventoryItems(ItemState)
        {
            if(ItemState.GetMyTemplateName() == ItemTemplate.DataName)
            {
                //create a replacement state, with the same quanity
                ReplacementItemState = ReplacementItemTemplate.CreateInstanceFromTemplate(NewGameState);
		        ReplacementItemState.Quantity = ItemState.Quantity;
                InventorySlot = ItemState.InventorySlot; // save the slot location for the new item !
                
                // Remove the old item from the soldier
                SoldierState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', Soldiers[iSoldier].ObjectID));
                SoldierState.RemoveItemFromInventory(ItemState, NewGameState);

                // Delete the old item
                NewGameState.RemoveStateObject(ItemState.GetReference().ObjectID);

                // Then add the new item to the soldier in the same slot
                SoldierState.AddItemToInventory(ReplacementItemState, InventorySlot, NewGameState);
            }
        }
    }

    //  Submit the New Game State if we have added any State Objects to it, other than XCOM HQ itself.
    if (NewGameState.GetNumGameStateObjects() > 1)
    {
        History.AddGameStateToHistory(NewGameState);
    }
    else
    {
        //  Otherwise, clean it up.
        History.CleanupPendingGameState(NewGameState);
    }
}

//////////////////////////////////////////////////////////////////////////////////////////
// ADD THE ITEMS TO THE HQ INVENTORY BY CONSOLE COMMAND
//////////////////////////////////////////////////////////////////////////////////////////

exec function RustyFix_ToolBox_Heavy()
{
	RustyFix_HeavyToolBox_AddItem("Heavythrower_Fire", 4);
	RustyFix_HeavyToolBox_AddItem("Heavythrower_Fire_Mk2", 4);

	RustyFix_HeavyToolBox_AddItem("Heavythrower_Cryo", 4);
	RustyFix_HeavyToolBox_AddItem("Heavythrower_Cryo_Mk2", 4);

	RustyFix_HeavyToolBox_AddItem("Heavythrower_Acid", 4);
	RustyFix_HeavyToolBox_AddItem("Heavythrower_Acid_Mk2", 4);

	RustyFix_HeavyToolBox_AddItem("Heavythrower_Poison", 4);
	RustyFix_HeavyToolBox_AddItem("Heavythrower_Poison_Mk2", 4);

	RustyFix_HeavyToolBox_AddItem("HeavyPlatedArmor", 4);   //exo suits
	RustyFix_HeavyToolBox_AddItem("HeavyPoweredArmor", 4);  //war suits
}

static function RustyFix_HeavyToolBox_AddItem(string strItemTemplate, optional int Quantity = 1, optional bool bLoot = false)
{
	local X2ItemTemplateManager ItemManager;
	local X2ItemTemplate ItemTemplate;
	local XComGameState NewGameState;
	local XComGameState_Item ItemState;
	local XComGameState_HeadquartersXCom HQState;
	local XComGameStateHistory History;
	local bool bWasInfinite;

	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplate = ItemManager.FindItemTemplate(name(strItemTemplate));

	if (ItemTemplate == none)
	{
		`log("No item template named" @ strItemTemplate @ "was found.");
		return;
	}

	if (ItemTemplate.bInfiniteItem)
	{
		bWasInfinite = true;
		ItemTemplate.bInfiniteItem = false;
	}

	History = `XCOMHISTORY;
	HQState = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	`assert(HQState != none);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Item Cheat: Create Item");
	ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState.Quantity = Quantity;

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Item Cheat: Complete");
	HQState = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(HQState.Class, HQState.ObjectID));
	HQState.PutItemInInventory(NewGameState, ItemState, bLoot);

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	`log("Added item" @ strItemTemplate @ "object id" @ ItemState.ObjectID);

	if (bWasInfinite)
	{
		ItemTemplate.bInfiniteItem = true;
	}
}
