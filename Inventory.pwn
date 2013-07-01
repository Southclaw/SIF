/*==============================================================================

Southclaw's Interactivity Framework (SIF) (Formerly: Adventure API)


	SIF/Overview
	{
		SIF is a collection of high-level include scripts to make the
		development of interactive features easy for the developer while
		maintaining quality front-end gameplay for players.
	}

	SIF/Inventory/Description
	{
		Offers extended item functionality using the virtual item feature in
		SIF/Item. This enables multiple items to be stored by players and
		retrieved when needed. It contains functions and callbacks for complete
		control from external scripts over inventory actions by players.
	}

	SIF/Inventory/Dependencies
	{
		SIF/Item
		Streamer Plugin
		YSI\y_hooks
	}

	SIF/Inventory/Credits
	{
		SA:MP Team						- Amazing mod!
		SA:MP Community					- Inspiration and support
		Incognito						- Very useful streamer plugin
		Y_Less							- YSI framework
	}

	SIF/Inventory/Core Functions
	{
		The functions that control the core features of this script.

		native -
		native - SIF/Inventory/Core
		native -

		native AddItemToInventory(playerid, itemid, call)
		{
			Description:
				Adds the specified item to a players inventory and removes the
				item from the world.

			Parameters:
				<playerid> (int)
					The player to add the item to.

				<itemid> (int, itemid)
					The ID handle of the item to add.

				<call>
					Determines whether or not to call OnPlayerAddToInventory.

			Returns:
				0
					If the item specified is an invalid item ID.

				-1
					If the inventory is full.

				1
					If the function completed successfully.
		}

		native RemoveItemFromInventory(playerid, slotid)
		{
			Description:
				Removes the item from the specified slot if there is one.

			Parameters:
				<playerid> (int)
					The player to remove the item from.
				
				<slotid>
					The inventory slot, must be between 0 and INV_MAX_SLOTS.

			Returns:
				0
					If the specified slot is invalid.
		}

		native DisplayPlayerInventory(playerid)
		{
			Description:
				Displays a dialog to the player listing his inventory contents.

			Parameters:
				-

			Returns:
				0
					If OnPlayerOpenInventory has returned true and cancelled
					displaying the dialog to the player.
		}
	}

	SIF/Inventory/Events
	{
		Events called by player actions done by using features from this script.

		native -
		native - SIF/Inventory/Callbacks
		native -

		native OnPlayerOpenInventory(playerid);
		{
			Called:
				When a player presses H to open his inventory.

			Parameters:
				<playerid> (int)
					The player who opened their inventory.

			Returns:
				1
					To cancel displaying the inventory to the player.
		}

		native OnPlayerCloseInventory(playerid);
		{
			Called:
				When a player exits the inventory dialog.

			Parameters:
				<playerid> (int)
					The player who closed their inventory.

			Returns:
				1
					To disable the player from closing their inventory.
		}

		native OnPlayerSelectExtraItem(playerid, item)
		{
			Called:
				When a player selects an extra menu item (not an actual
				inventory item, but a menu item added with AddInventoryListItem)

			Parameters:
				<playerid> (int)
					The player who chose the menu item.

				<item> (int)
					The menu row starting from 0 (however, the actual listitem
					value would be above INV_MAX_SLOTS)

			Returns:
				(none)

		}

		native OnPlayerAddToInventory(playerid, itemid);
		{
			Called:
				When a player adds an item to his inventory by pressing Y.

			Parameters:
				<playerid> (int)
					The player who added an item to his inventory.

				<itemid> (int, itemid)
					The ID handle of the item that was added.

			Returns:
				1
					To cancel the action and disallow the player to add the
					item to his inventory.
		}

		native OnPlayerAddedToInventory(playerid, itemid);
		{
			Called:
				After a player has added an item to their inventory and the
				inventory index has been updated with the new item.

			Parameters:
				<playerid> (int)
					The player who added an item to his inventory.

				<itemid> (int, itemid)
					The ID handle of the item that was added.

			Returns:
				(none)
		}

		native OnPlayerViewInventoryOpt(playerid);
		{
			Called:
				When a player opens the options menu for an item in his
				inventory. This callback can be used to add extra options.

			Parameters:
				<playerid>
					The player who opened the options menu.

			Returns:
				(none)
		}

		native OnPlayerRemoveFromInventory(playerid, slotid);
		{
			Called:
				When a player removes an item from his inventory either by
				equipping it or dropping it.

			Parameters:
				<playerid> (int)
					The player who removed an item from his inventory.

				<slotid> (int)
					The inventory slot which he removed the item from.

			Returns:
				1
					To cancel the action and disallow the player from removing
					the item from his inventory.
		}

		native OnPlayerRemovedFromInventory(playerid, slotid);
		{
			Called:
				After a player has removed an item from his inventory and the
				inventory index is updated with the item removed.

			Parameters:
				<playerid> (int)
					The player who removed an item from his inventory.

				<slotid> (int)
					The inventory slot which he removed the item from.

			Returns:
				(none)
		}

		native OnPlayerSelectInventoryOption(playerid, option);
		{
			Called:
				When a player selects an additional option from the item options
				menu. Note that this is only called when extra options are
				selected and not for the default Equip, Use and Drop options.

			Parameters:
				<playerid> (int)
					The player who selected an option in his inventory options.

				<option> (int)
					The option selected starting from 0, not the dialog
					listitem value. (it's listitem + number of default options)

			Returns:
				(none)
		}
	}

	SIF/Inventory/Interface Functions
	{
		Functions to get or set data values in this script without editing
		the data directly. These include automatic ID validation checks.

		native -
		native - SIF/Inventory/Interface
		native -

		native GetInventorySlotItem(playerid, slotid)
		{
			Description:
				Returns the ID handle of the item stored in the specified slot.

			Parameters:
				<slotid> (int)
					The slot to get the item ID of, from 0 to
					INV_MAX_SLOTS - 1.

			Returns:
				(int, itemid)
					ID handle of the item in the specified slot.

				INVALID_ITEM_ID
					If the slot was invalid or the slot is empty.
		}

		native IsInventorySlotUsed(playerid, slotid)
		{
			Description:
				Checks if the specified inventory slot contains an item.

			Parameters:
				<slotid> (int)
					The slot to check, from 0 to INV_MAX_SLOTS - 1.

			Returns:
				-1
					If the specified slot is invalid.

				0
					If the slot is used.

				1
					If the slot is empty.
		}

		native GetPlayerSelectedInventorySlot(playerid)
		{
			Description:
				Returns the inventory slot that the player is currently
				interacting with. The value this function returns will reset to
				-1 once the player exits his inventory menu.

			Parameters:
				-

			Returns:
				-1
					If the player has exited his inventory.
		}

		native IsPlayerInventoryFull(playerid)
		{
			Description:
				Checks if a players inventory is full. This is simply done by
				checking if the last slot is full as items are automatically
				shifted up the index when an item is removed.

			Parameters:
				-

			Returns:
				0
					If it isn't full.

				1
					If it is full.
		}

		native AddInventoryListItem(playerid, itemname[])
		{
			Description:
				Only works properly when used in OnPlayerOpenInventory, this
				function adds a new menu row under the inventory items. When
				a newly added row is selected, the callback
				OnPlayerSelectExtraItem is called.

			Parameters:
				<playerid> (int)
					The player to add the new menu item to.

				<itemname> (string)
					The text to display in the new menu row. Does not require a
					newline '\n' character.

			Returns:
		}

		native AddInventoryOption(playerid, option[])
		{
			Description:
				Only works properly when used in OnPlayerViewInventoryOpt.
				This function adds an option to the inventory item options list.
				The inventory options are addressed from 0, not the number of
				default options.

			Parameters:
				<option> (string)
					The option name, note that a new line character is not
					required as the function adds these automatically.

			Returns:
				0
					If the options string can't fit the specified option.
		}

		native GetInventoryFreeSlots(playerid)
		{
			Description:
				Returns the amount of free slots in a player's inventory.

			Parameters:
				-

			Returns:
				-
		}
	}

	SIF/Inventory/Internal Functions
	{
		Internal events called by player actions done by using features from
		this script.
	
		DisplayPlayerInventoryOptions(playerid, slotid)
		{
			Description:
				Displays the options menu and calls OnPlayerViewInventoryOpt
				in order to add any additional options.
		}
	}

	SIF/Inventory/Hooks
	{
		Hooked functions or callbacks, either SA:MP natives or from other
		scripts or plugins.

		SAMP/OnPlayerKeyStateChange
		{
			Reason:
				To detect if a player presses Y to put an item in their
				inventory or H to access their inventory.
		}
		SAMP/OnDialogResponse
		{
			Reason:
				To handle the dialogs used in the script for listing inventory
				items and item options.
		}
	}

==============================================================================*/


#if !defined _SIF_ITEM_INCLUDED
	#include <SIF/Item.pwn>
#endif

#include <YSI\y_iterate>
#include <YSI\y_timers>
#include <YSI\y_hooks>
#include <streamer>

#define _SIF_INVENTORY_INCLUDED


/*==============================================================================

	Setup

==============================================================================*/


#define INV_MAX_SLOTS				(4)
#define DIALOG_INVENTORY_LIST		(9000)
#define DIALOG_INVENTORY_OPTIONS	(9001)


new
		inv_Data					[MAX_PLAYERS][INV_MAX_SLOTS],
		inv_ViewingInventory		[MAX_PLAYERS],
		inv_SelectedSlot			[MAX_PLAYERS],
		inv_ExtraItemList			[MAX_PLAYERS][128],
		inv_ExtraItemCount			[MAX_PLAYERS],
		inv_OptionsList				[MAX_PLAYERS][128],
		inv_OptionsCount			[MAX_PLAYERS],
		inv_PutAwayTick				[MAX_PLAYERS],
Timer:	inv_PutAwayTimer			[MAX_PLAYERS];


forward OnPlayerOpenInventory(playerid);
forward OnPlayerCloseInventory(playerid);
forward OnPlayerSelectExtraItem(playerid, item);
forward OnPlayerAddToInventory(playerid, itemid);
forward OnPlayerAddedToInventory(playerid, itemid);
forward OnPlayerRemoveFromInventory(playerid, slotid);
forward OnPlayerRemovedFromInventory(playerid, slotid);
forward OnPlayerViewInventoryOpt(playerid);
forward OnPlayerSelectInventoryOpt(playerid, option);


/*==============================================================================

	Zeroing

==============================================================================*/


hook OnGameModeInit()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
		for(new j; j < INV_MAX_SLOTS; j++)
		{
			inv_Data[i][j] = INVALID_ITEM_ID;
			inv_SelectedSlot[i] = -1;
		}
	}
}

hook OnPlayerConnect(playerid)
{
	for(new j; j < INV_MAX_SLOTS; j++)
	{
		inv_Data[playerid][j] = INVALID_ITEM_ID;
		inv_SelectedSlot[playerid] = -1;
	}

	return;
}


/*==============================================================================

	Core Functions

==============================================================================*/


stock AddItemToInventory(playerid, itemid, call = 1)
{
	if(!IsValidItem(itemid))
		return 0;

	if(call)
	{
		if(CallLocalFunction("OnPlayerAddToInventory", "dd", playerid, itemid))
			return -1;
	}

	new i;
	while(i < INV_MAX_SLOTS)
	{
		if(!IsValidItem(inv_Data[playerid][i]))break;
		i++;
	}
	if(i == INV_MAX_SLOTS)
		return -2;
	
	inv_Data[playerid][i] = itemid;

	RemoveItemFromWorld(itemid);

	CallLocalFunction("OnPlayerAddedToInventory", "dd", playerid, itemid);
/*
	if(inv_ViewingInventory[playerid])
		DisplayPlayerInventory(playerid);
*/
	return 1;
}
stock RemoveItemFromInventory(playerid, slotid, call = 1)
{
	if(!(0 <= slotid < INV_MAX_SLOTS))
		return 0;

	if(call)
	{
		if(CallLocalFunction("OnPlayerRemoveFromInventory", "dd", playerid, slotid))
			return 0;
	}

	inv_Data[playerid][slotid] = INVALID_ITEM_ID;
	
	if(slotid < (INV_MAX_SLOTS - 1))
	{
		for(new i = slotid; i < (INV_MAX_SLOTS - 1); i++)
		    inv_Data[playerid][i] = inv_Data[playerid][i+1];

		inv_Data[playerid][(INV_MAX_SLOTS - 1)] = INVALID_ITEM_ID;
	}

	if(call)
		CallLocalFunction("OnPlayerRemovedFromInventory", "dd", playerid, slotid);

	return 1;
}

stock DisplayPlayerInventory(playerid)
{
	new
		list[(INV_MAX_SLOTS * (ITM_MAX_NAME + 1)) + 32],
		tmp[ITM_MAX_NAME];
	
	for(new i; i < INV_MAX_SLOTS; i++)
	{
		if(!IsValidItem(inv_Data[playerid][i])) strcat(list, "<Empty>\n");
		else
		{
			GetItemName(inv_Data[playerid][i], tmp);
			strcat(list, tmp);
			strcat(list, "\n");
		}
	}

	inv_ExtraItemList[playerid][0] = EOS;
	inv_ExtraItemCount[playerid] = 0;

	if(CallLocalFunction("OnPlayerOpenInventory", "d", playerid))
		return 0;
	
	if(!isnull(inv_ExtraItemList[playerid]))
		strcat(list, inv_ExtraItemList[playerid]);

	ShowPlayerDialog(playerid, DIALOG_INVENTORY_LIST, DIALOG_STYLE_LIST, "Inventory", list, "Options", "Close");
	SelectTextDraw(playerid, 0xFFFF00FF);

	inv_ViewingInventory[playerid] = true;

	return 1;
}

ClosePlayerInventory(playerid)
{
	ShowPlayerDialog(playerid, -1, 0, " ", " ", " ", " ");
	CallLocalFunction("OnPlayerCloseInventory", "d", playerid);
	inv_ViewingInventory[playerid] = false;
}


/*==============================================================================

	Internal Functions and Hooks

==============================================================================*/


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CTRL_BACK)
	{
		if(!IsPlayerInAnyVehicle(playerid))
			DisplayPlayerInventory(playerid);
	}
	if(newkeys & KEY_YES)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			if(tickcount() - inv_PutAwayTick[playerid] < 1000)
				return 0;
	
			inv_PutAwayTick[playerid] = tickcount();
	
			new itemid = GetPlayerItem(playerid);
	
			if(IsValidItem(itemid))
			{
				if(GetItemTypeSize(GetItemType(itemid)) != ITEM_SIZE_SMALL)
				{
					ShowActionText(playerid, "Item too big for inventory", 3000, 150);
				}
				else
				{
					if(IsPlayerInventoryFull(playerid))
					{
						ShowActionText(playerid, "Inventory full", 3000, 100);
					}
					else
					{
						ShowActionText(playerid, "Item added to inventory", 3000, 150);
						ApplyAnimation(playerid, "PED", "PHONE_IN", 4.0, 1, 0, 0, 0, 300);
						stop inv_PutAwayTimer[playerid];
						inv_PutAwayTimer[playerid] = defer PlayerPutItemInInventory(playerid, itemid);
					}
				}
			}
		}
	}

	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:65535)
	{
		if(inv_ViewingInventory[playerid])
		{
			ClosePlayerInventory(playerid);
		}
	}

	return 1;
}


timer PlayerPutItemInInventory[300](playerid, itemid)
{
	AddItemToInventory(playerid, itemid);
}

DisplayPlayerInventoryOptions(playerid, slotid)
{
	new
		name[ITM_MAX_NAME];

	GetItemName(inv_Data[playerid][slotid], name);
	inv_OptionsList[playerid] = "Equip\nUse\nDrop\n";
	inv_OptionsCount[playerid] = 0;

	CallLocalFunction("OnPlayerViewInventoryOpt", "d", playerid);

	ShowPlayerDialog(playerid, DIALOG_INVENTORY_OPTIONS, DIALOG_STYLE_LIST, name, inv_OptionsList[playerid], "Accept", "Back");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_INVENTORY_LIST)
	{
		if(response)
		{
			if(listitem >= INV_MAX_SLOTS)
			{
				CallLocalFunction("OnPlayerSelectExtraItem", "dd", playerid, listitem - INV_MAX_SLOTS);
				inv_ViewingInventory[playerid] = false;
				return 1;
			}

			if(!IsValidItem(inv_Data[playerid][listitem]))
			{
				DisplayPlayerInventory(playerid);
			}
			else
			{
				inv_SelectedSlot[playerid] = listitem;
				DisplayPlayerInventoryOptions(playerid, listitem);
			}
		}
		else
		{
			if(CallLocalFunction("OnPlayerCloseInventory", "d", playerid))
				DisplayPlayerInventory(playerid);

			CancelSelectTextDraw(playerid);
			inv_SelectedSlot[playerid] = -1;
			inv_ViewingInventory[playerid] = false;
		}
	}
	if(dialogid == DIALOG_INVENTORY_OPTIONS)
	{
		if(!response)
		{
			DisplayPlayerInventory(playerid);
			return 1;
		}

		switch(listitem)
		{
			case 0:
			{
				if(GetPlayerItem(playerid) == INVALID_ITEM_ID && GetPlayerWeapon(playerid) == 0)
				{
					new itemid = inv_Data[playerid][inv_SelectedSlot[playerid]];

					RemoveItemFromInventory(playerid, inv_SelectedSlot[playerid]);
					CreateItemInWorld(itemid);
					GiveWorldItemToPlayer(playerid, itemid, 1);
					DisplayPlayerInventory(playerid);
				}
				else
				{
					ShowActionText(playerid, "You are already holding something", 3000, 200);
					DisplayPlayerInventory(playerid);
				}
			}
			case 1:
			{
				if(GetPlayerItem(playerid) == INVALID_ITEM_ID && GetPlayerWeapon(playerid) == 0)
				{
					new itemid = inv_Data[playerid][inv_SelectedSlot[playerid]];

					RemoveItemFromInventory(playerid, inv_SelectedSlot[playerid]);
					CreateItemInWorld(itemid);
					GiveWorldItemToPlayer(playerid, itemid, 1);

					PlayerUseItem(playerid);

					CallLocalFunction("OnPlayerCloseInventory", "d", playerid);
					CancelSelectTextDraw(playerid);
					inv_SelectedSlot[playerid] = -1;
					inv_ViewingInventory[playerid] = false;
				}
				else
				{
					ShowActionText(playerid, "You are already holding something", 3000, 200);
					DisplayPlayerInventory(playerid);
				}
			}
			case 2:
			{
				if(GetPlayerItem(playerid) == INVALID_ITEM_ID && GetPlayerWeapon(playerid) == 0)
				{
					new itemid = inv_Data[playerid][inv_SelectedSlot[playerid]];

					RemoveItemFromInventory(playerid, inv_SelectedSlot[playerid]);
					CreateItemInWorld(itemid);
					GiveWorldItemToPlayer(playerid, itemid, 1);

					PlayerDropItem(playerid);

					CallLocalFunction("OnPlayerCloseInventory", "d", playerid);
					CancelSelectTextDraw(playerid);
					inv_SelectedSlot[playerid] = -1;
					inv_ViewingInventory[playerid] = false;
				}
				else
				{
					ShowActionText(playerid, "You are already holding something", 3000, 200);
					DisplayPlayerInventory(playerid);
				}
			}
			default:
			{
				CallLocalFunction("OnPlayerSelectInventoryOpt", "dd", playerid, listitem - 3);
			}
		}
	}
	return 1;
}


/*==============================================================================

	Interface Functions

==============================================================================*/


stock GetInventorySlotItem(playerid, slotid)
{
	if(!(0 <= slotid < INV_MAX_SLOTS))
		return INVALID_ITEM_ID;

	return inv_Data[playerid][slotid];
}

stock IsInventorySlotUsed(playerid, slotid)
{
	if(!(0 <= slotid < INV_MAX_SLOTS))
		return -1;

	if(!IsValidItem(inv_Data[playerid][slotid]))
		return 0;

	return 1;
}

stock GetPlayerSelectedInventorySlot(playerid)
{
	if(!(0 <= playerid < MAX_PLAYERS))
		return -1;

	return inv_SelectedSlot[playerid];
}

stock IsPlayerInventoryFull(playerid)
{
	if(!(0 <= playerid < MAX_PLAYERS))
		return 0;

	return IsValidItem(inv_Data[playerid][INV_MAX_SLOTS-1]);
}

stock AddInventoryListItem(playerid, itemname[])
{
	if(strlen(inv_ExtraItemList[playerid]) + strlen(itemname) > sizeof(inv_ExtraItemList[]))
		return 0;

	strcat(inv_ExtraItemList[playerid], itemname);
	strcat(inv_ExtraItemList[playerid], "\n");

	return inv_ExtraItemCount[playerid]++;
}

stock AddInventoryOption(playerid, option[])
{
	if(strlen(inv_OptionsList[playerid]) + strlen(option) > sizeof(inv_OptionsList[]))
		return 0;

	strcat(inv_OptionsList[playerid], option);
	strcat(inv_OptionsList[playerid], "\n");

	return inv_OptionsCount[playerid]++;
}

stock IsPlayerViewingInventory(playerid)
{
	if(!(0 <= playerid < MAX_PLAYERS))
		return 0;

	return inv_ViewingInventory[playerid];
}

stock GetInventoryFreeSlots(playerid)
{
	for(new i; i < INV_MAX_SLOTS; i++)
	{
		if(!IsValidItem(inv_Data[playerid][i]))
			return INV_MAX_SLOTS - (i + 1);
	}
	return 0;
}
