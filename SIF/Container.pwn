/*==============================================================================

Southclaw's Interactivity Framework (SIF) (Formerly: Adventure API)

	SIF Version: 1.4.0
	Module Version: 2.0.0


	SIF/Overview
	{
		SIF is a collection of high-level include scripts to make the
		development of interactive features easy for the developer while
		maintaining quality front-end gameplay for players.
	}

	SIF/Container/Description
	{
		A complex script that allows 'virtual inventories' to be created in
		order to store items in. Containers can be interacted with just like
		anything else with a button or a virtual container can be created
		without a way of interacting in the game world so the contents of if can
		be shown from a script function instead.

		This script hooks a lot of Inventory functions and uses the interface
		functions to allow players to switch between a container item list and
		their own inventory to make swapping items or looting quick and easy.
	}

	SIF/Container/Dependencies
	{
		SIF/Button
		SIF/Item
		SIF/Inventory
		Streamer Plugin
		YSI\y_hooks
		YSI\y_timers
	}

	SIF/Container/Credits
	{
		SA:MP Team						- Amazing mod!
		SA:MP Community					- Inspiration and support
		Incognito						- Very useful streamer plugin
		Y_Less							- YSI framework
	}

	SIF/Container/Constants
	{
		These can be altered by defining their values before the include line.

		CNT_MAX
			Maximum amount of containers that can be created.

		CNT_MAX_NAME
			Maximum string length for container names.

		CNT_MAX_SLOTS
			Maximum slot size amount for containers.
	}

	SIF/Container/Core Functions
	{
		The functions that control the core features of this script.

		native -
		native - SIF/Container/Core
		native -

		native CreateContainer(name[], size, buttonid = INVALID_BUTTON_ID)
		{
			Description:
				Creates a container to store items in, can be specified as
				virtual to not create a button or label so the container is only
				accessible via the script.

			Parameters:
				<name> (string)
					The name given to the container. Also applied to the button
					label if created in the world.

				<size> (int)
					The maximum capacity of items the container can store.

				<buttonid> (int, buttonid)
					If specified, the container is associated with a button
					which, when pressed, opens the container UI for a player.

			Returns:
				(int, containerid)
					Container ID handle of the newly created container.

				INVALID_CONTAINER_ID
					If another container cannot be created due to CNT_MAX
					limit.
		}

		native DestroyContainer(containerid, destroyitems = true)
		{
			Description:
				Removes a container from memory and frees the ID.

			Parameters:
				<containerid> (int, containerid)
					The container to destroy.

				<destroyitems> (boolean)
					When true, the items in the container are also destroyed.

			Returns:
				0
					If the containerid is invalid.
		}

		native AddItemToContainer(containerid, itemid, playerid = INVALID_PLAYER_ID)
		{
			Description:
				Adds an item to a container list, calls OnItemAddToContainer.

			Parameters:
				<containerid> (int, containerid)
					The container to add the item to.

				<itemid> (int)
					The item to add (must be valid, may be virtual)

				<playerid> (int)
					Can tell other scripts that the item was added by a player
					and not automatically.

			Returns:
				0
					If the function completed successfully.

				(int+)
					The amount of slots required to fit the item in.

				(int-)
					A negative integer error code.
		}

		native RemoveItemFromContainer(containerid, slotid, playerid = INVALID_PLAYER_ID)
		{
			Description:
				Removes an item from a container slot.

			Parameters:
				<containerid> (int)
					The container to remove from.

				<slotid> (int)
					The slot in the container to remove an item from. NOT an
					itemid!

				<playerid> (int)
					Can tell other scripts that a player caused the item
					removal rather than the script.

			Returns:
				1
					On success.

				0
					If the specified slot was out of bounds.

				-1
					If the specified slot contained an invalid item ID.
		}
	}

	SIF/Container/Events
	{
		Events called by player actions done by using features from this script.

		native -
		native - SIF/Container/Callbacks
		native -

		native OnItemAddToContainer(containerid, itemid, playerid);
		{
			Called:
				When an item is added to a container. Note that the item won't
				actually be in the container list when this is called.

			Parameters:
				<containerid> (int)
					The container the item will be added to.

				<itemid> (int)
					The item that will be added.

				<playerid> (int)
					The player who is adding it (specified in
					AddItemToContainer)

			Returns:
				1
					To cancel the item being added.
		}

		native OnItemAddedToContainer(containerid, itemid, playerid);
		{
			Called:
				After an item has been added to a container.

			Parameters:
				<containerid> (int)
					The container the item was added to.

				<itemid> (int)
					The item that was added.

				<playerid> (int)
					The player who added it (specified in AddItemToContainer)

			Returns:
				(none)
		}

		native OnItemRemoveFromContainer(containerid, slotid, playerid);
		{
			Called:
				As an item is removed from a container. Note that the item will
				still be in the container list when this is called.

			Parameters:
				<containerid> (int)
					The container the item will be removed from.

				<itemid> (int)
					The item that will be removed.

				<playerid> (int)
					The player who is removing it (specified in
					RemoveItemFromContainer)

			Returns:
				1
					To cancel the item being removed.
		}

		native OnItemRemovedFromContainer(containerid, slotid, playerid);
		{
			Called:
				After an item has been removed from a container.

			Parameters:
				<containerid> (int)
					The container the item was removed from.

				<itemid> (int)
					The item that was removed.

				<playerid> (int)
					The player who removed it (specified in
					RemoveItemFromContainer)

			Returns:
				(nothing)
		}
	}

	SIF/Container/Interface Functions
	{
		Functions to get or set data values in this script without editing
		the data directly. These include automatic ID validation checks.

		native -
		native - SIF/Container/Interface
		native -

		native IsValidContainer(containerid)
		{
			Description:
				Checks if a container ID is valid.

			Parameters:
				-

			Returns:
				-
		}

		native GetContainerButton(containerid)
		{
			Description:
				Returns the button ID used by a container (if not virtual).

			Parameters:
				-

			Returns:
				(int, buttonid)
		}

		native GetContainerName(containerid, name[])
		{
			Description:
				Returns a container's name.

			Parameters:
				-

			Returns:
				(bool)
					Success state.
		}

		native GetContainerSize(containerid)
		{
			Description:
				Returns a container's item capacity.

			Parameters:
				-

			Returns:
				-
		}

		native SetContainerSize(containerid, size)
		{
			Description:
				Sets a container's item capacity.

			Parameters:
				-

			Returns:
				-
		}

		native GetContainerWorld(containerid)
		{
			Description:
				Returns the virtual world a container's button exists in.

			Parameters:
				-

			Returns:
				-
		}

		native SetContainerWorld(containerid, world)
		{
			Description:
				Sets the virtual world that a container's button will exist in.

			Parameters:
				-

			Returns:
				-
		}

		native GetContainerInterior(containerid)
		{
			Description:
				Returns the interior world a container's button exists in.

			Parameters:
				-

			Returns:
				-
		}

		native SetContainerInterior(containerid, interior)
		{
			Description:
				Sets the interior world that a container's button will exist in.

			Parameters:
				-

			Returns:
				-
		}

		native GetContainerSlotItem(containerid, slot)
		{
			Description:
				Returns the item stored in the specified slot.

			Parameters:
				-

			Returns:
				(int, itemid)
		}

		native IsContainerSlotUsed(containerid, slotid)
		{
			Description:
				Checks if a slot in a container is occupied by an item.

			Parameters:
				-

			Returns:
				-
		}

		native IsContainerFull(containerid)
		{
			Description:
				Checks if a container is full.

			Parameters:
				-

			Returns:
				-
		}

		native IsContainerEmpty(containerid)
		{
			Description:
				Checks if a container is empty.

			Parameters:
				-

			Returns:
				-
		}

		native WillItemTypeFitInContainer(containerid, ItemType:itemtype)
		{
			Description:
				Checks if an item type will fit into a container.

			Parameters:
				-

			Returns:
				-
		}

		native GetContainerFreeSlots(containerid)
		{
			Description:
				Returns the number of free item slots in a container.

			Parameters:
				-

			Returns:
				-
		}

		native GetItemContainer(itemid)
		{
			Description:
				Returns the ID of the container that <itemid> is stored in.

			Parameters:
				-

			Returns:
				(int, containerid)
		}

		native GetItemContainerSlot(itemid)
		{
			Description:
				Returns the container slot that the item is stored in if inside
				a container.

			Parameters:
				-

			Returns:
				(int)
		}

		native GetButtonContainer(buttonid)
		{
			Description:
				Returns the ID of the container that <buttonid> is created for.

			Parameters:
				-

			Returns:
				(int, containerid)
		}
	}

	SIF/Container/Internal Functions
	{
		Internal events called by player actions done by using features from
		this script.
	
		-
	}

	SIF/Container/Hooks
	{
		Hooked functions or callbacks, either SA:MP natives or from other
		scripts or plugins.

		YSI/OnScriptInit
		{
			Reason:
				Zero initialised array cells.
		}

		SIF/OnButtonPress
		{
			Reason:
				Allowing container entities to be interacted with.
		}
	}

==============================================================================*/


#if defined _SIF_CONTAINER_INCLUDED
	#endinput
#endif

#if !defined _SIF_DEBUG_INCLUDED
	#include <SIF\Debug.pwn>
#endif

#if !defined _SIF_ITEM_INCLUDED
	#include <SIF\Item.pwn>
#endif

#if !defined _SIF_INVENTORY_INCLUDED
	#include <SIF\Inventory.pwn>
#endif

#include <YSI\y_iterate>
#include <YSI\y_timers>
#include <YSI\y_hooks>
#include <streamer>

#define _SIF_CONTAINER_INCLUDED


/*==============================================================================

	Setup

==============================================================================*/


#if !defined CNT_MAX
	#define CNT_MAX						(4096)
#endif

#if !defined CNT_MAX_NAME
	#define CNT_MAX_NAME				(32)
#endif

#if !defined CNT_MAX_SLOTS
	#define CNT_MAX_SLOTS				(24)
#endif


#define INVALID_CONTAINER_ID			(-1)


enum E_CONTAINER_DATA
{
			cnt_name[CNT_MAX_NAME],
			cnt_size,
			cnt_buttonId
}


new
			cnt_Data					[CNT_MAX][E_CONTAINER_DATA],
			cnt_Items					[CNT_MAX][CNT_MAX_SLOTS],
Iterator:	cnt_Index<CNT_MAX>,
			cnt_ItemContainer			[ITM_MAX] = {INVALID_CONTAINER_ID, ...},
			cnt_ItemContainerSlot		[ITM_MAX] = {-1, ...},
			cnt_ButtonContainer			[BTN_MAX] = {INVALID_CONTAINER_ID, ...};


forward OnContainerCreate(containerid);
forward OnContainerDestroy(containerid);
forward OnItemAddToContainer(containerid, itemid, playerid);
forward OnItemAddedToContainer(containerid, itemid, playerid);
forward OnItemRemoveFromContainer(containerid, slotid, playerid);
forward OnItemRemovedFromContainer(containerid, slotid, playerid);


static CNT_DEBUG = -1;


/*==============================================================================

	Zeroing

==============================================================================*/


hook OnScriptInit()
{
	CNT_DEBUG = sif_debug_register_handler("SIF/Container");
	sif_d:SIF_DEBUG_LEVEL_CALLBACKS:CNT_DEBUG("[OnScriptInit]");
}


/*==============================================================================

	Core Functions

==============================================================================*/


stock CreateContainer(name[], size, buttonid = INVALID_BUTTON_ID)
{
	sif_d:SIF_DEBUG_LEVEL_CORE:CNT_DEBUG("[CreateContainer] '%s' %d", name, size);
	new id = Iter_Free(cnt_Index);

	if(id == -1)
	{
		print("ERROR: Container limit reached.");
		return INVALID_CONTAINER_ID;
	}

	size = (size > CNT_MAX_SLOTS) ? CNT_MAX_SLOTS : size;

	strcpy(cnt_Data[id][cnt_name], name, CNT_MAX_NAME);
	cnt_Data[id][cnt_size]			= size;
	cnt_Data[id][cnt_buttonId]		= buttonid;

	if(IsValidButton(buttonid))
	{
		cnt_ButtonContainer[buttonid] = id;
	}

	for(new i; i < CNT_MAX_SLOTS; i++)
		cnt_Items[id][i] = INVALID_ITEM_ID;

	Iter_Add(cnt_Index, id);

	CallLocalFunction("OnContainerDestroy", "d", id);

	return id;
}

stock DestroyContainer(containerid, destroyitems = true, destroybutton = true)
{
	sif_d:SIF_DEBUG_LEVEL_CORE:CNT_DEBUG("[DestroyContainer] %d", containerid);
	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	CallLocalFunction("OnContainerDestroy", "d", containerid);

	if(destroyitems)
	{
		for(new i; i < cnt_Data[containerid][cnt_size]; i++)
		{
			if(cnt_Items[containerid][i] == INVALID_ITEM_ID)
				break;

			cnt_ItemContainer[cnt_Items[containerid][i]] = INVALID_CONTAINER_ID;
			DestroyItem(cnt_Items[containerid][i]);
			cnt_Items[containerid][i] = INVALID_ITEM_ID;
		}
	}

	if(IsValidButton(cnt_Data[containerid][cnt_buttonId]))
	{
		cnt_ButtonContainer[cnt_Data[containerid][cnt_buttonId]] = INVALID_CONTAINER_ID;

		if(destroybutton)
			DestroyButton(cnt_Data[containerid][cnt_buttonId]);
	}

	cnt_Data[containerid][cnt_name][0]	= EOS;
	cnt_Data[containerid][cnt_size]		= 0;
	cnt_Data[containerid][cnt_buttonId]	= INVALID_BUTTON_ID;

	Iter_Remove(cnt_Index, containerid);

	return 1;
}

stock AddItemToContainer(containerid, itemid, playerid = INVALID_PLAYER_ID)
{
	sif_d:SIF_DEBUG_LEVEL_CORE:CNT_DEBUG("[AddItemToContainer] %d %d %d", containerid, itemid, playerid);
	if(!Iter_Contains(cnt_Index, containerid))
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[AddItemToContainer] ERROR: Invalid container ID");
		return -1;
	}

	if(!IsValidItem(itemid))
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[AddItemToContainer] ERROR: Invalid item ID");
		return -2;
	}

	new
		slots,
		idx;

	while(idx < cnt_Data[containerid][cnt_size])
	{
		sif_d:SIF_DEBUG_LEVEL_LOOPS:CNT_DEBUG("[AddItemToContainer] Looping %d/%d item: %d", idx, cnt_Data[containerid][cnt_size], cnt_Items[containerid][idx]);
		if(!IsValidItem(cnt_Items[containerid][idx]))
			break;

		if(cnt_Items[containerid][idx] == itemid)
		{
			sif_d:SIF_DEBUG_LEVEL_LOOPS:CNT_DEBUG("[AddItemToContainer] ERROR: Item is already in container");
			return -3;
		}

		slots += GetItemTypeSize(GetItemType(cnt_Items[containerid][idx]));
		idx++;
	}

	new itemsize = GetItemTypeSize(GetItemType(itemid));

	if((itemsize + slots) > cnt_Data[containerid][cnt_size])
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[AddItemToContainer] ERROR: Item doesn't fit, size: %d free: %d required: %d.", itemsize, cnt_Data[containerid][cnt_size] - slots, (itemsize + slots) - cnt_Data[containerid][cnt_size]);
		return (itemsize + slots) - cnt_Data[containerid][cnt_size];
	}

	if(CallLocalFunction("OnItemAddToContainer", "ddd", containerid, itemid, playerid))
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[AddItemToContainer] ERROR: OnItemAddToContainer event returned 1");
		return -4;
	}

	if(cnt_ItemContainer[itemid] != INVALID_CONTAINER_ID)
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[AddItemToContainer] WARNING: Item is currently in container %d slot %d, removing.", cnt_ItemContainer[itemid], cnt_ItemContainerSlot[itemid]);
		if(!RemoveItemFromContainer(cnt_ItemContainer[itemid], cnt_ItemContainerSlot[itemid]))
			return -5;
	}

	#if defined _SIF_INVENTORY_INCLUDED
	if(GetItemPlayerInventory(itemid) != INVALID_PLAYER_ID)
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[AddItemToContainer] WARNING: Item is currently in player inventory %d slot %d, removing.", GetItemPlayerInventory(itemid), GetItemPlayerInventorySlot(itemid));
		if(!RemoveItemFromInventory(GetItemPlayerInventory(itemid), GetItemPlayerInventorySlot(itemid)))
			return -6;
	}
	#endif

	cnt_Items[containerid][idx] = itemid;
	cnt_ItemContainer[itemid] = containerid;
	cnt_ItemContainerSlot[itemid] = idx;

	sif_d:SIF_DEBUG_LEVEL_CORE:CNT_DEBUG("[AddItemToContainer] Added item %d to container %d at slot %d", itemid, containerid, idx);

	RemoveItemFromWorld(itemid);

	CallLocalFunction("OnItemAddedToContainer", "ddd", containerid, itemid, playerid);
	
	return 0;
}

stock RemoveItemFromContainer(containerid, slotid, playerid = INVALID_PLAYER_ID, call = 1)
{
	sif_d:SIF_DEBUG_LEVEL_CORE:CNT_DEBUG("[RemoveItemFromContainer] %d %d %d %d", containerid, slotid, playerid, call);
	if(!(0 <= slotid < cnt_Data[containerid][cnt_size]))
		return 0;

	if(!IsValidItem(cnt_Items[containerid][slotid]))
	{
		if(cnt_Items[containerid][slotid] != INVALID_ITEM_ID)
		{
			sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[RemoveItemFromContainer] ERROR: Container slot is pointing to an invalid item.");
			cnt_Items[containerid][slotid] = INVALID_ITEM_ID;

			if(slotid < (cnt_Data[containerid][cnt_size] - 1))
			{
				sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[RemoveItemFromContainer] Shifting items down starting from %d.", slotid);

				for(new i = slotid; i < (cnt_Data[containerid][cnt_size] - 1); i++)
				{
				    cnt_Items[containerid][i] = cnt_Items[containerid][i+1];

					if(cnt_Items[containerid][i] != INVALID_ITEM_ID)
						cnt_ItemContainerSlot[cnt_Items[containerid][i]] = i;
				}

				cnt_Items[containerid][(cnt_Data[containerid][cnt_size] - 1)] = INVALID_ITEM_ID;
			}
		}

		return -1;
	}

	if(call)
	{
		if(CallLocalFunction("OnItemRemoveFromContainer", "ddd", containerid, slotid, playerid))
		{
			sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[RemoveItemFromContainer] ERROR: OnItemRemoveFromContainer returned 1");
			return 1;
		}
	}

	cnt_ItemContainer[cnt_Items[containerid][slotid]] = INVALID_CONTAINER_ID;
	cnt_ItemContainerSlot[cnt_Items[containerid][slotid]] = -1;
	cnt_Items[containerid][slotid] = INVALID_ITEM_ID;

	if(slotid < (cnt_Data[containerid][cnt_size] - 1))
	{
		sif_d:SIF_DEBUG_LEVEL_CORE_DEEP:CNT_DEBUG("[RemoveItemFromContainer] Shifting items down starting from %d.", slotid);
		for(new i = slotid; i < (cnt_Data[containerid][cnt_size] - 1); i++)
		{
			cnt_Items[containerid][i] = cnt_Items[containerid][i+1];

			if(cnt_Items[containerid][i] != INVALID_ITEM_ID)
				cnt_ItemContainerSlot[cnt_Items[containerid][i]] = i;
		}

		cnt_Items[containerid][(cnt_Data[containerid][cnt_size] - 1)] = INVALID_ITEM_ID;
	}

	if(call)
		CallLocalFunction("OnItemRemovedFromContainer", "ddd", containerid, slotid, playerid);

	return 1;
}


/*==============================================================================

	Internal Functions and Hooks

==============================================================================*/


public OnItemDestroy(itemid)
{
	sif_d:SIF_DEBUG_LEVEL_CALLBACKS:CNT_DEBUG("[OnItemDestroy] %d", itemid);
	if(cnt_ItemContainer[itemid] != INVALID_CONTAINER_ID)
	{
		RemoveItemFromContainer(cnt_ItemContainer[itemid], cnt_ItemContainerSlot[itemid]);
	}

	#if defined cnt_OnItemDestroy
		return cnt_OnItemDestroy(itemid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnItemDestroy
	#undef OnItemDestroy
#else
	#define _ALS_OnItemDestroy
#endif
#define OnItemDestroy cnt_OnItemDestroy
#if defined cnt_OnItemDestroy
	forward cnt_OnItemDestroy(itemid);
#endif

public OnItemCreateInWorld(itemid)
{
	sif_d:SIF_DEBUG_LEVEL_CALLBACKS:CNT_DEBUG("[OnItemCreateInWorld] %d", itemid);
	if(cnt_ItemContainer[itemid] != INVALID_CONTAINER_ID)
	{
		RemoveItemFromContainer(cnt_ItemContainer[itemid], cnt_ItemContainerSlot[itemid]);
	}

	#if defined cnt_OnItemCreateInWorld
		return cnt_OnItemCreateInWorld(itemid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnItemCreateInWorld
	#undef OnItemCreateInWorld
#else
	#define _ALS_OnItemCreateInWorld
#endif
 
#define OnItemCreateInWorld cnt_OnItemCreateInWorld
#if defined cnt_OnItemCreateInWorld
	forward cnt_OnItemCreateInWorld(itemid);
#endif

public OnButtonPress(playerid, buttonid)
{
	new containerid = GetButtonContainer(buttonid);

	if(IsValidContainer(containerid))
	{
		ClearAnimations(playerid, 1);
		DisplayContainerInventory(playerid, containerid);
	}

	#if defined cnt_OnButtonPress
		return cnt_OnButtonPress(playerid, buttonid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnButtonPress
	#undef OnButtonPress
#else
	#define _ALS_OnButtonPress
#endif
#define OnButtonPress cnt_OnButtonPress
#if defined cnt_OnButtonPress
	forward cnt_OnButtonPress(playerid, buttonid);
#endif


/*==============================================================================

	Interface

==============================================================================*/


stock IsValidContainer(containerid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[IsValidContainer] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	return 1;
}

// cnt_buttonId
stock GetContainerButton(containerid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetContainerButton] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	return cnt_Data[containerid][cnt_buttonId];
}

// cnt_name
stock GetContainerName(containerid, name[])
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetContainerName] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	name[0] = EOS;
	strcat(name, cnt_Data[containerid][cnt_name], CNT_MAX_NAME);

	return 1;
}

// cnt_size
stock GetContainerSize(containerid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetContainerSize] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return -1;

	return cnt_Data[containerid][cnt_size];
}
stock SetContainerSize(containerid, size)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[SetContainerSize] %d %d", containerid, size);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	cnt_Data[containerid][cnt_size] = size;

	return 1;
}

// cnt_Items
stock GetContainerSlotItem(containerid, slotid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetContainerSlotItem] %d %d", containerid, slotid);

	if(!Iter_Contains(cnt_Index, containerid))
		return INVALID_ITEM_ID;

	if(!(0 <= slotid < CNT_MAX_SLOTS))
		return INVALID_ITEM_ID;

	return cnt_Items[containerid][slotid];
}

stock IsContainerSlotUsed(containerid, slotid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[IsContainerSlotUsed] %d %d", containerid, slotid);

	if(!(0 <= slotid < CNT_MAX_SLOTS))
		return -1;

	if(!IsValidItem(cnt_Items[containerid][slotid]))
		return 0;

	return 1;
}

stock IsContainerFull(containerid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[IsContainerFull] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	return GetContainerFreeSlots(containerid) == 0;
}

stock IsContainerEmpty(containerid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[IsContainerEmpty] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	return !IsValidItem(cnt_Items[containerid][0]);
}

stock WillItemTypeFitInContainer(containerid, ItemType:itemtype)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[WillItemTypeFitInContainer] %d %d", containerid, _:itemtype);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	new
		slots,
		idx;

	while(idx < cnt_Data[containerid][cnt_size])
	{
		if(!IsValidItem(cnt_Items[containerid][idx]))
			break;

		slots += GetItemTypeSize(GetItemType(cnt_Items[containerid][idx]));
		idx++;
	}

	if(slots + GetItemTypeSize(itemtype) > cnt_Data[containerid][cnt_size])
		return 0;

	return 1;
}

stock GetContainerFreeSlots(containerid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetContainerFreeSlots] %d", containerid);

	if(!Iter_Contains(cnt_Index, containerid))
		return 0;

	new
		slots,
		idx;

	while(idx < cnt_Data[containerid][cnt_size])
	{
		if(!IsValidItem(cnt_Items[containerid][idx]))
			break;

		slots += GetItemTypeSize(GetItemType(cnt_Items[containerid][idx]));
		idx++;
	}

	return cnt_Data[containerid][cnt_size] - slots;
}

stock GetItemContainer(itemid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetItemContainer] %d", itemid);

	if(!IsValidItem(itemid))
		return INVALID_CONTAINER_ID;

	return cnt_ItemContainer[itemid];
}

stock GetItemContainerSlot(itemid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetItemContainerSlot] %d", itemid);

	if(!IsValidItem(itemid))
		return INVALID_CONTAINER_ID;

	return cnt_ItemContainerSlot[itemid];
}

stock GetButtonContainer(buttonid)
{
	sif_d:SIF_DEBUG_LEVEL_INTERFACE:CNT_DEBUG("[GetButtonContainer] %d", buttonid);

	if(!IsValidButton(buttonid))
		return INVALID_CONTAINER_ID;

	return cnt_ButtonContainer[buttonid];
}
