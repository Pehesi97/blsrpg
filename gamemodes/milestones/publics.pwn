// Milestones
public CompletarNonRepMilestone(playerid, id)
{
	if(Player[playerid][pCompletedNonRepTask][id] == 1)
	    return true;

	new sstring[320];
	GivePlayerGP(playerid, MilNonRepGrana);
	Player[playerid][pExp] += MilNonRepResp;
	Player[playerid][pCompletedNonRepTask][id] = 1;
	GivePlayerCash(playerid, MilNonRepCash);
	format(sstring, 320, "[BLS]: {FFFFFF}Você completou a missão: \"{00FFFF}%s{FFFFFF}\", por isso recebeu R$%d, %d respeitos e BLS$%d.", MilNonRepeatTasks[id][milTask], Mil1Grana, Mil1Resp, Mil1Cash);
	SendClientMessage(playerid, 0x1E90FFFF, sstring);

	new nxtlevel = Player[playerid][pLevel] + 1;
    new expamount = nxtlevel * levelexp;
   	if(Player[playerid][pExp] >= expamount)
   	{
   	    format(sstring, sizeof(sstring), "~g~Level Up: ~w~%d", nxtlevel);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		PlayerPlayMusic(playerid);
		Player[playerid][pLevel] ++;
	    Player[playerid][pExp] -= expamount;
		Player[playerid][gPupgrade] += 2;
		GameTextForPlayer(playerid, sstring, 5000, 1);
		format(sstring, 128, "{FF0000}[Info]:{FFFFFF} Você passou para o nível %d.", nxtlevel);
		SendClientMessage(playerid, SERVER_INFO, sstring);
		format(sstring, 128, "{FF0000}[Info]:{FFFFFF} Você tem %d pontos de atualização.", Player[playerid][gPupgrade]);
		SendClientMessage(playerid, SERVER_INFO, sstring);

        if(Player[playerid][pLevel] == 10 || Player[playerid][pLevel] == 15 || Player[playerid][pLevel] == 20)
		{
	        format(sstring, sizeof(sstring), "{FF0000}[Info]:{FFFFFF} Parabéns a %s, pois agora ele é nível %d!", Player[playerid][pName], Player[playerid][pLevel]);
    	    SendClientMessageToAll(SERVER_INFO, sstring);
        }
	}
	return true;
}
