// Neon
public SubirNeon(playerid) {
	new elev = IsAtNeonShop(playerid);
	switch (elev) {
	    case 0: { MoveDynamicObject(ElevadoresNeon[0], 1554.40234, -2166.41821, 11.65980, 0.2); }
	    case 1: { MoveDynamicObject(ElevadoresNeon[1], 1563.39392, -2166.41821, 11.65980, 0.2); }
	    case 2: { MoveDynamicObject(ElevadoresNeon[2], 1572.88684, -2166.41821, 11.65980, 0.2); }
	    case 3: { MoveDynamicObject(ElevadoresNeon[3], 1581.84766, -2166.41821, 11.65980, 0.2); }
	}
}

public DescerNeon(playerid) {
	new elev = IsAtNeonShop(playerid);
	switch (elev) {
	    case 0: { MoveDynamicObject(ElevadoresNeon[0], 1554.40234, -2166.41821, 10.75980, 0.2); }
	    case 1: { MoveDynamicObject(ElevadoresNeon[1], 1563.39392, -2166.41821, 10.75980, 0.2); }
	    case 2: { MoveDynamicObject(ElevadoresNeon[2], 1572.88684, -2166.41821, 10.75980, 0.2); }
	    case 3: { MoveDynamicObject(ElevadoresNeon[3], 1581.84766, -2166.41821, 10.75980, 0.2); }
	}
}

public NeonAdded(veh, playerid) {
   	PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	SetEngine(veh, true);
	SendClientMessage(playerid, 0x1E90FFFF, "[Neon Shop]: {FFFFFF}O neon foi adicionado com sucesso!");
	DescerNeon(playerid);
	return true;
}

public NeonRemoved(veh, playerid) {
   	PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	SetEngine(veh, true);
	SendClientMessage(playerid, 0x1E90FFFF, "[Neon Shop]: {FFFFFF}O neon foi removido com sucesso!");
	DescerNeon(playerid);
	return true;
}