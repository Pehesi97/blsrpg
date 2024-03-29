#if !defined MAX_REMOVED_OBJECTS
	#define MAX_REMOVED_OBJECTS 700
#endif

enum RemovedObjectsENUM {_model, Float:_oX, Float:_oY, Float:_oZ, Float:_orX, Float:_orY, Float:_orZ, Float:_oRadius, restored}
new RemovedObjects[MAX_REMOVED_OBJECTS][RemovedObjectsENUM];

/*
native RemoveBuilding(modelid, Float:oX, Float:oY, Float:oZ, Float:oRadius = 0.25, Float:orX = 0.0, Float:orY = 0.0, Float:orZ = 0.0);
native RestoreBuilding(slotid);
native RemoveSpecificBuilding(modelid);

native CountRemovedObjects();
*/

stock RemoveBuilding(modelid, Float:oX, Float:oY, Float:oZ, Float:oRadius = 0.25, Float:orX = 0.0, Float:orY = 0.0, Float:orZ = 0.0)
{
	for(new i; i < MAX_REMOVED_OBJECTS; i++)
	{
	    if(RemovedObjects[i][_model] != modelid) continue;
	    if(RemovedObjects[i][restored] != 0)
	    {
	        if((RemovedObjects[i][_oX] == oX) && (RemovedObjects[i][_oY] == oY) && (RemovedObjects[i][_oZ] == oZ))
	        {
	            DestroyObject(RemovedObjects[i][restored]);
	            RemovedObjects[i][restored] = 0;
	            RemovedObjects[i][_model] = 0;
	            return i;
	        }
	    }
	}

	new Slot = GetObjectFreeSlot();
	if(Slot == -1) return printf("\tCannot remove any more objects.\nIncrease MAX_REMOVED_OBJECTS in your script.\nIt is currently: %i", MAX_REMOVED_OBJECTS);
	
	RemovedObjects[Slot][_model] = modelid;
	RemovedObjects[Slot][_oX] = oX;
	RemovedObjects[Slot][_oY] = oY;
	RemovedObjects[Slot][_oZ] = oZ;
	RemovedObjects[Slot][_oRadius] = oRadius;

	RemovedObjects[Slot][_orX] = orX;
	RemovedObjects[Slot][_orY] = orY;
	RemovedObjects[Slot][_orZ] = orZ;

	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    RemoveBuildingForPlayer(i, modelid, oX, oY, oZ, oRadius);
	}
	return Slot;
}

stock RestoreBuilding(slotid)
{
	if(slotid < 0 || slotid > MAX_REMOVED_OBJECTS) return 0;
	if(RemovedObjects[slotid][_model] == 0) return 0;
	RemovedObjects[slot][restored] = CreateObject(RemovedObjects[slot][_model], RemovedObjects[slot][_oX], RemovedObjects[slot][_oY], RemovedObjects[slot][_oZ], RemovedObjects[slot][_orX], RemovedObjects[slot][_orY], RemovedObjects[slot][_orZ]);
	return 1;
}

stock RemoveSpecificBuilding(modelid)
{
	return RemoveBuilding(modelid, 0.0, 0.0, 0.0, 10000.0);
}

forward REMOBJ_OnPlayerConnect(playerid);
public OnPlayerConnect(playerid)
{
	for(new i; i < MAX_REMOVED_OBJECTS; i++)
	{
	    if(RemovedObjects[i][_model] != 0) RemoveBuildingForPlayer(playerid, RemovedObjects[i][_model], RemovedObjects[i][_oX], RemovedObjects[i][_oY], RemovedObjects[i][_oZ], RemovedObjects[i][_oRadius]);
	}
	if(funcidx("REMOBJ_OnPlayerConnect") != -1) CallLocalFunction("REMOBJ_OnPlayerConnect", "i", playerid);
	return 1;
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect REMOBJ_OnPlayerConnect

stock GetObjectFreeSlot()
{
	for(new i; i < MAX_REMOVED_OBJECTS; i++)
	{
	    if(RemovedObjects[i][_model] == 0) return i;
	}
	return -1;
}

stock CountRemovedObjects()
{
    new count = 0;
    for(new i; i < MAX_REMOVED_OBJECTS; i++)
    {
        if(RemovedObjects[i][_model] != 0) count++;
    }
	return count;
}
