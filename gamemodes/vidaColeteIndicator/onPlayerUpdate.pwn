    GetPlayerArmour(playerid, colete2[playerid]);
	GetPlayerHealth(playerid, vida2[playerid]);

	if(colete2[playerid] > 0) PlayerTextDrawShow(playerid, colete[playerid]);
	else PlayerTextDrawHide(playerid, colete[playerid]);

	format(Total, sizeof(Total), "%.0f", vida2[playerid]);
	format(Total2, sizeof(Total2), "%.0f", colete2[playerid]);

	//Textdrawstrings
	PlayerTextDrawSetString(playerid, vida[playerid], Total);
	PlayerTextDrawSetString(playerid, colete[playerid], Total2);