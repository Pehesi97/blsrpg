public OnPlayerConnect(playerid)
{
	SetTimerEx("playerConnectLookAt", 100, false, "d", playerid);
    PlayAudioStreamForPlayer(playerid, "http://blsrpg.com.br/iPod/heymama.mp3");

	if(IsPlayerNPC(playerid))
		return 1;

	//Text Draws Login
	TextDrawShowForPlayer(playerid, TextDrawLogin0);
	TextDrawShowForPlayer(playerid, TextDrawLogin1);
	TextDrawShowForPlayer(playerid, TextDrawLogin2);
	TextDrawShowForPlayer(playerid, TextDrawLogin3);
	TextDrawShowForPlayer(playerid, TextDrawLogin4);
	TextDrawShowForPlayer(playerid, TextDrawLogin5);
	TextDrawShowForPlayer(playerid, TextDrawLogin6);
	TextDrawShowForPlayer(playerid, TextDrawLogin7);
	TextDrawShowForPlayer(playerid, TextDrawLogin8);
	TextDrawShowForPlayer(playerid, TextDrawLogin9);
	TextDrawShowForPlayer(playerid, TextDrawLogin10);
	TextDrawShowForPlayer(playerid, TextDrawLogin11);
	TextDrawShowForPlayer(playerid, TextDrawLogin12);
	TextDrawShowForPlayer(playerid, TextDrawLogin13);
	
	TextDrawShowForPlayer(playerid, FundoLogin);

	vida[playerid] = CreatePlayerTextDraw(playerid, 610.000000, 65.000000, " ");
	PlayerTextDrawBackgroundColor(playerid,vida[playerid], 255);
	PlayerTextDrawFont(playerid,vida[playerid], 2);
	PlayerTextDrawLetterSize(playerid,vida[playerid], 0.25, 1.1);
	PlayerTextDrawColor(playerid,vida[playerid], COR_TEXTDRAW00);
	PlayerTextDrawSetOutline(playerid,vida[playerid], 0);
	PlayerTextDrawSetProportional(playerid,vida[playerid], 1);
	PlayerTextDrawSetShadow(playerid,vida[playerid], 1);

	colete[playerid] = CreatePlayerTextDraw(playerid, 610.000000, 43.000000, " ");
	PlayerTextDrawBackgroundColor(playerid,colete[playerid], 255);
	PlayerTextDrawFont(playerid,colete[playerid], 2);
	PlayerTextDrawLetterSize(playerid,colete[playerid], 0.25, 1.1);
	PlayerTextDrawColor(playerid,colete[playerid], COR_TEXTDRAW01);
	PlayerTextDrawSetOutline(playerid,colete[playerid], 0);
	PlayerTextDrawSetProportional(playerid,colete[playerid], 1);
	PlayerTextDrawSetShadow(playerid,colete[playerid], 1);

    new sterre[64], filing[64];
    gpci(playerid, sterre, sizeof(sterre));
	format(filing, sizeof(filing), "/RPG/bangpci/%s", sterre);
	if(DOF2_FileExists(filing))
	{
	    Kick(playerid);
	    return true;
	}

	format(Player[playerid][pPass], 128, "");
	format(Player[playerid][pKey], 128, "");

	SetPlayerColor(playerid,COLOR_GREY);
	new string[256];
	new banfile[50]; banfile = GetBannedFile(playerid);
    GetPlayerIp(playerid,IP,sizeof(IP));

	if(!strcmp(ReturnPlayer(playerid), "Smith_Bls") || !strcmp(ReturnPlayer(playerid), "Ran_BLS"))
		goto Join;

	if(DOF2_FileExists(banfile))
	{
		new nome[52], admin[52], motivo[52], data[52], tempban[128];
		format(nome,52,"%s", DOF2_GetString(banfile,"PlayerName"));
		format(admin,52,"%s", DOF2_GetString(banfile,"AdminName"));
		format(motivo,52,"%s", DOF2_GetString(banfile,"Motivo"));
		format(data,52,"%s", DOF2_GetString(banfile,"Data"));

		new tick = DOF2_GetInt(banfile,"BanTime");
		if(tick > 0)
		{
			if(tick > GetTickCount())
			    format(tempban,128,"|| Ban temporário - Acaba em %s", Convert(tick-GetTickCount()));

			else
			{
			    SendClientMessage(playerid, COLOR_NOTICIA,"[Bot_BLS]: Seu ban temporário acabou.");
				new accfile[128];
				format(accfile,128,"/RPG/bans/%s.ini", DOF2_GetString(banfile,"PlayerName"));
				DOF2_RemoveFile(accfile);
				format(accfile,128,"/RPG/users/%s.ini", DOF2_GetString(banfile,"PlayerName"));
				DOF2_SetInt(accfile, "Banned", 0);
				DOF2_RemoveFile(banfile);
				goto Join;
			}
		}

		SendClientMessage(playerid, COLOR_BARRAS,"=============================================================");
		format(string,128,"- Seu IP '%s' foi banido com o nick %s pelo %s em '%s'.", IP, nome, admin, data);
	    SendClientMessage(playerid, COLOR_WHITE, string);
	    format(string,128,"- Motivo: '%s' %s", motivo, tempban);
  	    SendClientMessage(playerid, COLOR_WHITE, string);
		SendClientMessage(playerid, COLOR_ORANGE,"Visite a página 'blsrpg.com.br/forum', leia as regras e crie seu tópico com esta imagem (F8 para capturá-la)");
		SendClientMessage(playerid, COLOR_BARRAS,"=============================================================");

		return SetTimerEx("OnKick",500,false, "i", playerid);
	}
	printf("%d\n", Player[playerid][pCDPlayer]);
	Join:
	for(new i = 0; pInfo:i < pInfo; pInfo:i++)
		Player[playerid][pInfo:i] = 0; //the 1 was only for example.

	printf("%d\n", Player[playerid][pCDPlayer]);

	if(playerid >= HighestID+1)
		HighestID = playerid;

	new on = 0;
	foreach(new i: Player)
	    on++;

	if(on > Recorde)
	{
	    format(string,128,"[BLS]: O recorde de usuários foi batido. Novo recorde : %d.", on);
  	    SendClientMessageToAll(COLOR_NOTICIA, string);

  	    new hour, minute, second, day, month, year;
		GetTimeFix(hour, minute, second);
		getdate(year, month, day);

        format(Record,34,"%02d/%02d/%04d às %02d:%02d:%02d", day, month, year, hour, minute, second);

	    Recorde = on;
	    DOF2_SetString(RECORD_FILE,"Data",Record);
	    DOF2_SetInt(RECORD_FILE,"Recorde",Recorde);
	    DOF2_SaveFile();
	}

    Player[playerid][FirstSpawn] = true;

	SetTimerEx("MovePlayer",1000,false,"i",playerid);
	ResetPlayerMoney(playerid);

	if(strfind(ReturnPlayer(playerid), "_", true) == -1)
	{
	    ShowPlayerDialog(playerid, 957, DIALOG_STYLE_MSGBOX, "{FFFFFF}BLS - Erro", "{FFFFFF}Seu nome não foi aceito em nosso servidor. Seu nick deve estar no formato: Nome_Sobrenone.\nExemplo: Patinho_Feio.", "Fechar", "");
	    gPlayerLogged[playerid] = 0;
		//Kick(playerid);
		return true;
	}
	escondendo[playerid] = 0;

	// Milestones
	for(new i = 0; i < 5; i++)
	    Player[playerid][pCompletedNonRepTask][i] = 0;

	//Multas
	multa[playerid] = 0;
	multas[playerid] = 0;
	//Multas
	if(Player[playerid][pHouseKey] != 255)
	    Incasa[playerid] = Player[playerid][pHouseKey];
	else
	    Incasa[playerid] = Player[playerid][pPaluguelkey];

	Player[playerid][gSpectateID] = INVALID_PLAYER_ID;
	Player[playerid][TransferID] = INVALID_PLAYER_ID;
	Player[playerid][pCar][0] = INVALID_VEHICLE_ID;
	Player[playerid][pCar][1] = INVALID_VEHICLE_ID;
	Player[playerid][pCar][2] = INVALID_VEHICLE_ID;
	Player[playerid][pCar][3] = INVALID_VEHICLE_ID;
	Player[playerid][pCar][4] = INVALID_VEHICLE_ID;

	// Boombox
	Player[playerid][pDynamicBB] = 0;
	Player[playerid][pDynamicBBArea] = 0;
	Player[playerid][pBoombox] = false;
	Player[playerid][pDynamicBBX] = 0.0;
	Player[playerid][pDynamicBBY] = 0.0;
	Player[playerid][pDynamicBBZ] = 0.0;
	Player[playerid][pDynamicBBInt] = 0;
	Player[playerid][pDynamicBBVW] = 0;
	format(Player[playerid][pDynamicBBStation], 128, "");

	//Concessionária
	PlayerGerenciando[playerid] = INVALID_VEHICLE_ID;
	//Concessionária
	Pacote[playerid] = 0;
	PizzaDialog[playerid] = 0;
	Pixando[playerid] = false;
	LimpandoPiche[playerid] = false;
	Player[playerid][Spawned] = false;
    Player[playerid][AllowGod] = false;
	SendoProcurado[playerid] = false;
    Procurando[playerid] = false;
	nobangu[playerid] = false;
	noteste[playerid] = false;
	noevento[playerid] = false;
	DarNota[playerid] = false;
	InGZ[playerid] = 0;
	PlayerOnMission[playerid] = 0;
	RouboPos[playerid] = 0;
	votou[playerid] = false;
	Conce[playerid] = 0;
	FicarRoco[playerid] = false;
	Player[playerid][pMoney] = 0;
	Player[playerid][pBLSCash] = 0;
	Player[playerid][pHoraVIP] = 0;
	nowh[playerid] = 0;
	InModShop[playerid] = false;
	pegar1[playerid] = 0;
    CarColor[playerid][0] = 1;
	CarColor[playerid][1] = 1;
    g@PlayerSu[playerid] = false;
    OuvindoIPod[playerid] = false;
    InTAA[playerid] = false;
    TAAStarted[playerid] = 0;
    HiddenAdmin[playerid] = false;
    for(new i = 0; i < sizeof(TAAObjects[]); i++)
        TAAObjects[playerid][i] = -1;

	//SetPlayerTeam(playerid, playerid*2);
//	SetPlayerMapIcon(playerid, 1, 1257.6265,-785.2055,92.0302,43,MAPICON_GLOBAL); // Russa
//	SetPlayerMapIcon(playerid, 1, 1653.9097,-1655.0175,22.5156,30,MAPICON_GLOBAL);//PR
	SetPlayerMapIcon(playerid, 1, 2424.3491,-1922.7054,13.5469,17,MAPICON_GLOBAL); //24-7 lowrider
	SetPlayerMapIcon(playerid, 2, 1352.3300,-1755.7100,13.3530,17,MAPICON_GLOBAL); //24-7 DP
	SetPlayerMapIcon(playerid, 3, 1315.4900,-900.8430,39.5781,17,MAPICON_GLOBAL); //24-7 Banco
	SetPlayerMapIcon(playerid, 4, 1832.6463, -1842.5885, 13.5781,17,MAPICON_GLOBAL); //24-7 Spawn
	SetPlayerMapIcon(playerid, 5, 374.5654,-2055.4023,8.0156,17,MAPICON_GLOBAL); // 24-7 Pier
	SetPlayerMapIcon(playerid, 7, 1750.9022,-2054.1663,14.1010,51,MAPICON_GLOBAL);//caminhao
	SetPlayerMapIcon(playerid, 8, 1933.4171,-1864.4463,13.5619,6,MAPICON_GLOBAL);//Lojas de armas
	SetPlayerMapIcon(playerid, 9, 1117.4230,-2037.0621,78.7500, 56, MAPICON_GLOBAL );//pref
	SetPlayerMapIcon(playerid, 10, 2029.9769,-1406.1050,17.2170,22,MAPICON_GLOBAL);//Hospital
	SetPlayerMapIcon(playerid, 11, 1561.4166,-1665.8405,28.3956,30,MAPICON_GLOBAL);//DP
	SetPlayerMapIcon(playerid, 12, 1450.629882,-1095.147338,17.687129,22,MAPICON_GLOBAL);//Farmácia
	SetPlayerMapIcon(playerid, 13, 1831.364868,-1995.974731,13.546875,58,MAPICON_GLOBAL);
	SetPlayerMapIcon(playerid, 14, 2245.7581,-1660.3862,15.2865,45,MAPICON_GLOBAL);// Lojas D.s
	SetPlayerMapIcon(playerid, 15, 1462.3883,-1010.1879,26.8438,52,MAPICON_GLOBAL);//Banco
	SetPlayerMapIcon(playerid, 16, 375.3680,-2087.7510,7.8359,9,MAPICON_GLOBAL);//pesca
	SetPlayerMapIcon(playerid, 17, 1631.9384,-1170.1406,24.0781,25,MAPICON_GLOBAL);//Loteria
	SetPlayerMapIcon(playerid, 18, 1826.2664,-1124.9415,23.9814,55,MAPICON_GLOBAL);//conce
	SetPlayerMapIcon(playerid, 19, 338.8566,-1809.3798,4.5179,27,MAPICON_GLOBAL);//mecanica
	SetPlayerMapIcon(playerid, 20, 333.9397,-1519.0159,35.8672,30,MAPICON_GLOBAL);//FBI
	SetPlayerMapIcon(playerid, 21, 641.2360,-1355.3855,13.3958,35,MAPICON_GLOBAL); // anuncio
	SetPlayerMapIcon(playerid, 22, 2648.7905,-2018.9167,69.0208, 27, MAPICON_GLOBAL); // transfender
	SetPlayerMapIcon(playerid, 23, 1040.1967,-1039.0023,69.0938, 27, MAPICON_GLOBAL); // transfender
	SetPlayerMapIcon(playerid, 24, -2707.3838,220.8588,42.8703, 27, MAPICON_GLOBAL); // transfender
    SetPlayerMapIcon(playerid, 25, 1836.1659,-1682.4061,13.3593,48,MAPICON_GLOBAL);//Alhambra
    SetPlayerMapIcon(playerid, 26, 1022.4554,-1121.7389,23.8718,48,MAPICON_GLOBAL);//Boate Pimp
    SetPlayerMapIcon(playerid, 27, 1310.0320,-1367.6229,13.5382,23,MAPICON_GLOBAL);// paintball
    SetPlayerMapIcon(playerid, 28, 1830.4603,-1768.1846,13.5469,24,MAPICON_GLOBAL);// paintball
    SetPlayerMapIcon(playerid, 29, 1280.9172,-1340.4066,13.3751,42,MAPICON_GLOBAL);// taxi
    SetPlayerMapIcon(playerid, 30, 1771.9641,-1855.4810,13.4141,42,MAPICON_GLOBAL);// taxi
    SetPlayerMapIcon(playerid, 31, 2103.9763,-1806.2046,13.5547,29,MAPICON_GLOBAL);// pizzaria
    SetPlayerMapIcon(playerid, 32, 2229.3528,-1721.7533,13.5658,54,MAPICON_GLOBAL);// academia
    SetPlayerMapIcon(playerid, 33, 2230.8035,-1333.3748,23.9816,40,MAPICON_GLOBAL);// igreja
/*    for(new i = 0; i < MAX_RACEGZ; i++)
        SetPlayerMapIcon(playerid, 49 - i, RaceMapIcon[i][0], RaceMapIcon[i][1], 25.0, 53, MAPICON_GLOBAL);      */
    //Icones Usados: De 1 à 35, e + todos de 50

	//mexer
	for(new i = 0; i < sizeof(TurfsCoords); i++)
		GangZoneShowForPlayer(playerid, Turfs[i], OrgsColors[gZonesData[i][ZoneOwner]]);
	for(new i = 0; i < MAX_RACEGZ; i++)
		GangZoneShowForPlayer(playerid, RaceGZID[i], OrgsColors[RaceGZ[i][rOwner]]);
/*    for(new b = 0; b < MAX_AREASAZUIS; b++)
        GangZoneShowForPlayer(playerid, AreasAzuis[b][azGangZoneID], AreaAzulColor);*/

	TruckMission[playerid] = 0; FuneMission[playerid] = 0; BusMission[playerid] = 0; GasMission[playerid] = 0; PaperMission[playerid] = 0; LixoMission[playerid] = 0;
	HidePM[playerid] = 0; PhoneOnline[playerid] = 0;
	AdvOffer[playerid] = 999; AdvPrice[playerid] = 0;
    CallLawyer[playerid] = 0; WantLawyer[playerid] = 0;
	CurrentMoney[playerid] = 0;
	CP[playerid] = 0; 	CarOffer[playerid] = 999; CarPrice[playerid] = 0; CarID[playerid] = 0; CarCalls[playerid] = 0;
	MoneyMessage[playerid] = 0; Condom[playerid] = 0; pedagio[playerid] = 0; pedagyo[playerid] = 0;
	DSTPlayer[playerid] = 0; SexOffer[playerid] = 999; SexPrice[playerid] = 0;
	RepairOffer[playerid] = 999; RepairPrice[playerid] = 0; RepairCar[playerid] = 0;
	TalkingLive[playerid] = 255; LiveOffer[playerid] = 999; TakingLesson[playerid] = 0;
	RefillOffer[playerid] = 999; RefillPrice[playerid] = 0;
	DrugOffer[playerid] = 999; PlayerCuffed[playerid] = 0; PlayerCuffedTime[playerid] = 0; Camburao[playerid] = false;
	Invite[playerid] = 0; InviteJob[playerid] = 0;
	DrugPrice[playerid] = 0; OnCK[playerid] = 999; GettingCK[playerid] = 999;
	DrugGram[playerid] = 0; ConnectedToLaptop[playerid] = false;
	JailPrice[playerid] = 0; MedicTime[playerid] = 0; NeedMedicTime[playerid] = 0;
	WantedPoints[playerid] = 0;	OnDuty[playerid] = 0; BoxWaitTime[playerid] = 0;
	SafeTime[playerid] = 60; TaxistaIn[playerid] = false; PlayerTied[playerid] = 0;
    TempoPedido[playerid] = 0; JobDuty[playerid] = 0;
	Mobile[playerid] = 255; BoxOffer[playerid] = 999; PlayerBoxing[playerid] = 0;
	Spectate[playerid] = 255; PlayerDrunk[playerid] = 0; PlayerDrunkTime[playerid] = 0;
	Unspec[playerid][sLocal] = 255; Unspec[playerid][sNum] = -1; Unspec[playerid][sArea] = 0; FishCount[playerid] = 0;
	WritingPaper[playerid] = 0; WritingPaperNumber[playerid] = 999; WritingLine[playerid] = 0; BringingPaper[playerid] = 0; GotPaper[playerid] = 0;
	PaperOffer[playerid] = 999; ConsumingMoney[playerid] = 0;
	SafeBan[playerid] = 0;
	BigEar[playerid] = 0; BigCW[playerid] = 0; BigSms[playerid] = 0; BigMp[playerid] = 0; gDice[playerid] = 0;
	gPlayerLogged[playerid] = 0; gPlayerLogTries[playerid] = 0; gPlayerAccount[playerid] = 0; PlayerKarting[playerid] = 0; PlayerInKart[playerid] = 0;
	PlayerTazeTime[playerid] = 0; PlayerStoned[playerid] = 0;
	TicketOffer[playerid] = 999; TicketMoney[playerid] = 0;
	MatsHolding[playerid] = 0; EmergencyCall[playerid] = false;
    PedidoAceito[playerid] = 900;
	HireCar[playerid] = 299; sPizza[playerid] = 0; bPizza[playerid] = 0;
	PlayerPaintballing[playerid] = 0; PlayerPaintballKills[playerid] = 0; DoadorChat[playerid] = 0;
	ReduceTimeArmas[playerid] = 0; ReduceTime[playerid] = 0; UsinaTime[playerid] = 0; AtentadoTime[playerid] = 0; BombTime[playerid] = 0;
	CarroBombaTime[playerid] = 0; JornalTime[playerid] = 0; SairTime[playerid] = 0; PuxarTime[playerid] = 0;
	Fishes[playerid][pLastFish] = 0; Fishes[playerid][pFishID] = 0; CuraAcc[playerid] = 999;
	ProposeOffer[playerid] = 999; MarryWitness[playerid] = 999; MarryWitnessOffer[playerid] = 999; MarriageCeremoney[playerid] = 0; ProposedTo[playerid] = 999; GotProposedBy[playerid] = 999; DivorceOffer[playerid] = 999; BlindFold[playerid] = 0;
	Player[playerid][pLevel] = 0; AdminDuty[playerid] = 0; AdminAfk[playerid] = 0; Vitima[playerid] = 999; EventoInfo[InscritoEvento][playerid] = false; PlayerInRace[playerid] = false;
	InAFoodPlace[playerid] = 0; TipoAntiFK[playerid] = 1; AFKTimer[playerid] = -1;
	//AutoCinto
	Player[playerid][pAutoBelt] = false;

	Player[playerid][pAdmin] = 0;
	Player[playerid][pAdminWork] = 0;
	Player[playerid][pDonateRank] = 0;
	Player[playerid][gPupgrade] = 0;
	Player[playerid][pConnectTime] = 0;
	Player[playerid][pReg] = 0;
	Player[playerid][pSex] = 0;
	Player[playerid][pAge] = 0;
	Player[playerid][pOrigin] = 0;
	Player[playerid][pExp] = 0;
	Player[playerid][pBank] = 0;
	Player[playerid][pCrimes] = 0;
	Player[playerid][pDeaths] = 0;
	Player[playerid][pArrested] = 0;
	Player[playerid][pWantedDeaths] = 0;
	Player[playerid][pPhoneBook] = 0;
	Player[playerid][pPhone] = 0;
	Player[playerid][pLottoNr] = 0;
	Player[playerid][pBiggestFish] = 0;
	Player[playerid][pJob] = DESEMPREGADO;
	Player[playerid][pHeadValue] = 0;
	Player[playerid][pJailed] = 0;
	Player[playerid][pJailTime] = 0;
	Player[playerid][pJailTimetotal] = 0;
	Player[playerid][pMats] = 0;
	Player[playerid][pDrugs] = 0;
	Player[playerid][pLuta] = 0;
	Player[playerid][pCigarro] = 0;
	Player[playerid][pPC] = 0;
	Player[playerid][p3G] = 0;
	Player[playerid][pNBook] = 0;
	Player[playerid][pCorda] = 0;
	Player[playerid][pPlano] = 0;
	Player[playerid][pVotou] = 0;
	Player[playerid][pLeader] = 0;
	Player[playerid][pMember] = 0;
	Player[playerid][pFMember] = 255;
	Player[playerid][pRank] = 0;
	Player[playerid][pChar] = 23;
	Player[playerid][pContractTime] = 0;
	Player[playerid][pDetSkill] = 0;
	Player[playerid][pSexSkill] = 0;
	Player[playerid][pBoxSkill] = 0;
	Player[playerid][pLawSkill] = 0;
	Player[playerid][pMechSkill] = 0;
	Player[playerid][pJackSkill] = 0;
	Player[playerid][pCarSkill] = 0;
	Player[playerid][pNewsSkill] = 0;
	Player[playerid][pDrugsSkill] = 0;
	Player[playerid][pCookSkill] = 0;
	Player[playerid][pFishSkill] = 0;
	Player[playerid][pSHealth] = 0.0;
	Player[playerid][pHealth] = 50.0;
	Player[playerid][pInt] = 0;
	Player[playerid][pLocal] = 255;
	Player[playerid][pModel] = 60;
	//VehicleInfo[vInfo][vLock] = true;
	Player[playerid][pHouseKey] = 255;
	Player[playerid][pAtend] = 0;
	Player[playerid][pPaluguelkey] = 255;
	Player[playerid][pBizKey] = 255;
	Player[playerid][pCarLic] = 0;
	Player[playerid][pCarLicPoints] = 0;
	Player[playerid][pFlyLic] = 0;
	Player[playerid][pBoatLic] = 0;
	Player[playerid][pFishLic] = 0;
	Player[playerid][pGunLic] = 0;
	Player[playerid][pPacoteArmas] = 0;
	Player[playerid][pGun1] = 0;
	Player[playerid][pGun2] = 0;
	Player[playerid][pGun3] = 0;
	Player[playerid][pGun4] = 0;
	Player[playerid][pAmmo1] = 0;
	Player[playerid][pAmmo2] = 0;
	Player[playerid][pAmmo3] = 0;
	Player[playerid][pAmmo4] = 0;
	Player[playerid][pCarTime] = 0;
	Player[playerid][pPayDayHad] = 0;
	Player[playerid][pCDPlayer] = 0;
	Player[playerid][pWins] = 0;
	Player[playerid][pLoses] = 0;
	Player[playerid][pAlcoholPerk] = 0;
	Player[playerid][pDrugPerk] = 0;
	Player[playerid][pMiserPerk] = 0;
	Player[playerid][pPainPerk] = 0;
	Player[playerid][pTraderPerk] = 0;
	Player[playerid][pTut] = 0;
	Player[playerid][pWarns] = 0;
	Player[playerid][pFuel] = 0;
//	Player[playerid][pInvWeapon] = 0;
//	Player[playerid][pInvAmmo] = 0;
	Player[playerid][pSpeaker] = 0;
	Player[playerid][pRequestingBackup] = 0;
	Player[playerid][pRoadblock] = -1;
	Player[playerid][pCone] = 0;
	Player[playerid][pCorrente] = -1;
	Player[playerid][pAdjustable] = 0;
	Player[playerid][pCreditos] = 0;
	Player[playerid][pIrcId] = -1;
	Player[playerid][LastVeh] = INVALID_VEHICLE_ID;
	//format(Player[playerid][pReferral], MAX_PLAYER_NAME, "--");
	strmid(Player[playerid][pLastLogin], "0/0/0/0/0/0", 0, strlen("0/0/0/0/0/0"),255);
	ClearCrime(playerid);
	ClearFishes(playerid);
	ClearCooking(playerid);
	ClearGroceries(playerid);
	ClearMarriage(playerid);

	SendMensagemIP(playerid);
	OnLogin(playerid);

	Player[playerid][pTemMascara] = false;
	Player[playerid][pMascarado] = false;
	Player[playerid][pCapaChuva] = false;

	ModoSA_Info[playerid][SA_Vida][0] = 100.0;
	ModoSA_Info[playerid][SA_Vida][1] = 0.0;
	ModoSA_Info[playerid][SA_Pos][0] = 0.0;
	ModoSA_Info[playerid][SA_Pos][1] = 0.0;
	ModoSA_Info[playerid][SA_Pos][2] = 0.0;
	ModoSA_Info[playerid][SA_Pos][3] = 0.0;
	ModoSA_Info[playerid][SA_MarkPos][0] = 0.0;
	ModoSA_Info[playerid][SA_MarkPos][1] = 0.0;
	ModoSA_Info[playerid][SA_MarkPos][2] = 0.0;
	ModoSA_Info[playerid][SA_Int][0] = 0;
	ModoSA_Info[playerid][SA_Int][1] = 0;

    AdminTime[playerid][Time_Play] = 0;
    AdminTime[playerid][Time_Work] = 0;
    AdminTime[playerid][Time_RPG] = 0;
    AdminTime[playerid][Time_AFK] = 0;
    AdminTime[playerid][Time_PlayS] = 0;
    AdminTime[playerid][Time_WorkS] = 0;
    AdminTime[playerid][Time_RPGS] = 0;
    AdminTime[playerid][Time_AFKS] = 0;

    Joynado[playerid] = false;
    HoldingOrgMoney[playerid] = 0;
    PlayerPlaySound(playerid,1186, 0.0, 0.0, 0.0);

    Binco_OnPlayerConnect(playerid); //Include original do Samp

    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        IgnorarRelato[playerid][i] = false;
        IgnorarRelato[i][playerid] = false;
    }

    /*Sistema de Ultimos Logins
    GetPlayerIp(playerid, Player[playerid][pIP], 16);
    for(new i = 0; i < MAX_ULTIMOS_IPS; i++)
    {
        if(!strcmp(Player[playerid][pIP], UltimosIPs[i], true)
        && strcmp(ReturnPlayer(playerid), UltimosIPsNome[i], true) != 0)
        {
            format(string, 155, "O IP de %s foi Identificado como o mesmo de %s. (%s e %s)", ReturnPlayer(playerid), UltimosIPsNome[i], Player[playerid][pIP], UltimosIPs[i]);
            ABroadCast(COLOR_RED, string, 1);
            break;
        }
    }*/
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	Player[playerid][pCDPlayer] = 20;
	StopAudioStreamForPlayer(playerid);

	PlayerTextDrawHide(playerid,vida[playerid]);
	PlayerTextDrawHide(playerid,colete[playerid]);

	new sstring[128];
    format(sstring, sizeof(sstring), "-OperServ-: %s desconectou do servidor.", Player[playerid][pName]);
    ABroadCast(COLOR_BARRAS, sstring, 6);
	//Boombox
	if(Player[playerid][pDynamicBB] != 0)
	{
	    DestroyDynamicObject(Player[playerid][pDynamicBB]);
	    DestroyDynamic3DTextLabel(Player[playerid][pDynamicBBLabel]);
	    if(IsValidDynamicArea(Player[playerid][pDynamicBBArea]))
	    {
	        new string[128];
	        format(string, 128, "O dono da Boombox (%s) desconectou-se.", Player[playerid][pName]);
	        foreach(Player, i)
	        {
	            if(IsPlayerInDynamicArea(i, Player[playerid][pDynamicBBArea]))
	            {
	                StopAudioStreamForPlayer(i);
					SendClientMessage(i, COLOR_PURPLE, string);
	            }
	        }
	    }
	}

    //Sistema de Tiro ao Alvo
    if(InTAA[playerid])
        EndTAA(playerid, false);

    if(PlayerInRace[playerid])
        EndRace(playerid, RACE_LOST_DISCONNECT);

    //Sistema de Contrato
    if (SendoProcurado[playerid])
    {
        foreach(new i: Player)
        {
            if (Vitima[i] == playerid)
            {
                Vitima[i] = 999;
                SendoProcurado[playerid] = false;
                Procurando[i] = false;
                //Player[playerid][pHeadValue] = 0; //Tah Loco?
                SendClientMessage(i, SERVER_INFO, "{FF0000}[Info]:{FFFFFF} O player que estava sob seu contrato deslogou.");
                break;
			}
		}
	}
	if(gPlayerLogged[playerid])
	{
		if(Player[playerid][pIrcId] != -1) SetIrc(playerid, -1);
  	}

	new file[128];
	format(file, sizeof(file), "/RPG/users/%s.ini", Player[playerid][pName]);
  	DOF2_SetInt(file, "Online", 0);
  	DOF2_SaveFile();
  	SavePlayerToys(playerid);

  	if(HireCar[playerid] != 299) UnLockCar(HireCar[playerid]);

	GetPlayerPos(playerid,Player[playerid][pLocalX],Player[playerid][pLocalY],Player[playerid][pLocalZ]);
	//TELEFONEMA
	new caller = Mobile[playerid];
	if(caller != 255)
	{
		if(caller < 255)
		{
            SetTimerEx("RemoverAttachTelefone", 1500, false, "d", caller);
			SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
			SendClientMessage(caller,  COLOR_LIGHTBLUE, "** Desligaram");

			CellTime[caller] = 0;
			Mobile[caller] = 255;
    	    KillTimer(LOL[caller]);
		}
		Mobile[playerid] = 255;
		CellTime[playerid] = 0;
		KillTimer(LOL[playerid]);
	}
	if(EmergencyCall[playerid])
        EmergencyCall[playerid] = false;
	//?
    //Algo parecido com Foreach e não sei por quê não usar Foreach '-' (Já tava aqui) ~ Marcos
	if(playerid == HighestID+1)
	{
	    new highID = 0;
		foreach(new x: Player)
	        if(x>highID)
	            highID = x;

		HighestID = highID;
	}

    new string[155];
    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s desconectou. (Caiu/Crashou)", ReturnPlayer(playerid));
        case 2: format(string, sizeof(string), "%s desconectou. (Kickado/Banido)", ReturnPlayer(playerid));
        default: format(string, sizeof(string), "%s desconectou. (Saiu)", ReturnPlayer(playerid));
    }
    ProxDetectorEx(75.0, playerid, string, COLOR_RED);

    if(IsACop(playerid))
		WantedPoints[playerid] = 0;

	if(reason == 1 && PlayerTied[playerid] > 0)
    {
	    BanguBot(playerid,30,"Sair do servidor em Sequestro");
    }

	if(Incasa[playerid] != 0) {
		format(file, sizeof(file), "/RPG/users/%s.ini", Player[playerid][pName]);
		DOF2_SetInt(file, "sleep", gettime());
	}

    NoTaxi[playerid][0] = 0;
	NoTaxi[playerid][1] = 0;
	NoTaxi[playerid][2] = -1;
    OnPlayerSave(playerid);

    Conce[playerid] = 0;
    CarColor[playerid][0] = 1;
	CarColor[playerid][1] = 1;
    /*VehicleInfo[vehicleid][vLock] = false;
	VehicleInfo[vehicleid][vPRFLock] = 0;
	if(CarShopping[playerid] == true)
	{
		CarShopping[playerid] = false;
		DestroyVehicle(ShopCar[playerid]);
	    carbrowse[playerid] = 0;
 	}                            */

	Player[playerid][pAdjustable] = 1;
	Teste[playerid] = 0;
    TakingLesson[playerid] = 0;
    Acertos[playerid] = 0;
    ClearCrime(playerid);
    CPorder[playerid] = 0;

    for(new z;z<MAX_JOBS;z++)
        if(Solicitando[playerid][z] == true)
		    Cancelando(playerid,z);

	foreach(new x: Player)
 		if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && Player[x][gSpectateID] == playerid)
   			AdvanceSpectate(x);

	if(GettingCK[playerid] < 999)
	{
	    if(IsPlayerConnected(GettingCK[playerid]))
	    {
	        SendClientMessage(GettingCK[playerid], COLOR_YELLOW, "O personagem saiu do servidor, tente mais tarde.");
	        OnCK[GettingCK[playerid]] = 999;
	    }
	}

	if(PlayerPaintballing[playerid] != 0)
	    PaintballPlayers --;

	if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
	    KartingPlayers --;

	if(PlayerBoxing[playerid] > 0)
	{
	    if(Boxer1 == playerid)
	    {
	        if(IsPlayerConnected(Boxer2))
	        {
	        	PlayerBoxing[Boxer2] = 0;
	        	SafeSetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer2, 5);
	        	GameTextForPlayer(Boxer2, "~r~Partida interrompida", 5000, 1);
			}
	    }
	    else if(Boxer2 == playerid)
	    {
	        if(IsPlayerConnected(Boxer1))
	        {
	        	PlayerBoxing[Boxer1] = 0;
	        	SafeSetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer1, 5);
	        	GameTextForPlayer(Boxer1, "~r~partida interrompida", 5000, 1);
			}
	    }
	    InRing = 0;
     	RoundStarted = 0;
		Boxer1 = 255;
		Boxer2 = 255;
		TBoxer = 255;
	}
    if(TaxistaIn[playerid] == true)
		TaxistaNum -= 1;

	if(Player[playerid][pJob] == MEDICO)
	{
		if(JobDuty[playerid] == 1)
		{
			Medics -= 1;
		}
	}
	else if(Player[playerid][pJob] == MECANICO)
	{
		if(JobDuty[playerid] == 1)
		{
			Mechanics -= 1;
		}
	}
	else if(Player[playerid][pJob] == EPIZZA)
	{
		if(JobDuty[playerid] == 1)
		{
			PizzaBoys -= 1;
		}
	}
	if(Player[playerid][pCone] != 0)
	{
		Player[playerid][pCone] = 0;
		RemoveCone(playerid);
	}
	if(Player[playerid][pCorrente] != 0)
	{
		DeleteClosestStrip();
 		Player[playerid][pCorrente] = 0;
 		RemoveCorrente(playerid);
	}
    return 1;
}
