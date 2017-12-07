enum pInfo
{
	pID,
    // Banco
    pName[MAX_PLAYER_NAME], // Nome
	pKey[128], // 
	pPass[128],
	pSeatBelt,
	bool:pAutoBelt,
	pCapacete,
	pLevel,
	pAdmin,
	pAdminWork,
	pEnigma,
	pDonateRank,
	gPupgrade,
	pConnectTime,
	pReg,
	pSex,
	pAge,
	pOrigin,
	pExp,
	pMoney,
	pBLSCash,
	pHoraVIP,
	pVIP,
	pBank,
	pCrimes,
	pCar[5],
	pKills,
	pDeaths,
	pArrested,
	pWantedDeaths,
	pPhoneBook,
	pPhone,
	pLottoNr,
 	pFishes,
	pBiggestFish,
	pJob,
	pHeadValue,
	pJailed,
	pJailTime,
	pJailTimetotal,
	pMats,
	pDrugs,
	pLuta,
	pCigarro,
	pPC,
	pNBook,
	p3G,
	pCorda,
	pPlano,
	pVotou,
	pBan,
	pLeader,
	pMember,
	pFMember,
	pRank,
	pChar,
	pContractTime,
	pDetSkill,
	pSexSkill,
	pBoxSkill,
	pLawSkill,
	pMechSkill,
	pJackSkill,
	pCarSkill,
	pNewsSkill,
	pDrugsSkill,
	pCookSkill,
	pFishSkill,
	Float:pHealth,
	Float:pSHealth,
	Float:pLocalX,
    Float:pLocalY,
    Float:pLocalZ,
	pInt,
	pLocal,
	pModel,
	pPnumber,
	pHouseKey,
	pPaluguelkey,
	pBizKey,
	pAtend,
	pNota,
    pLocalSpawn,
    pBonusExp,

	Float:LastSpeed,

	pCarLic,
	pCarLicPoints,
	pFlyLic,
	pBoatLic,
	pFishLic,
	pGunLic,

	pPacoteArmas,
	pGun1,
	pGun2,
	pGun3,
	pGun4,
	pAmmo1,
	pAmmo2,
	pAmmo3,
	pAmmo4,
	pCarTime,
	pPayDayHad,
	pCDPlayer,
	pWins,
	pLoses,
	pAlcoholPerk,
	pDrugPerk,
	pMiserPerk,
	pPainPerk,
	pTraderPerk,
	pTut,
	pWarns,
	pFuel,
	pRoadblock,
	pCone,
	pCorrente,
	pRequestingBackup,
	pMarried,
	pLastLogin[24],
	pLastSave,
	pLogedTime,
	pCreditos,
	pDest[32],
	pAviso1[32],
	pAviso2[32],
	CMD,
//	pInvWeapon,
//	pInvAmmo,
	pSpeaker,
	LastZone,
	TransferID,
	LastVeh,
    pIP[16],

	pDrogasGuardadas,
	pPastilhas,
	pIrcId,
	pDoenca,
	bool:pTemMascara,
	bool:pMascarado,
	bool:pCapaChuva,

    bool:pExplosivo,

	bool:pDesbugou,

    pRG[32],
    pVoto
	pCompletedNonRepTask[5],

    // Runtime
	pDynamicBB,
	Text3D:pDynamicBBLabel,
	pDynamicBBArea,
	bool:pBoombox,
	Float:pDynamicBBX,
	Float:pDynamicBBY,
	Float:pDynamicBBZ,
	pDynamicBBInt,
	pDynamicBBVW,
	pDynamicBBStation[128],

	//pReferral[MAX_PLAYER_NAME],
	//Referral
    gSpectateID,
    gSpectateType,
	TurfKills,
	TurfDeaths,
	WarPoints,
	SenhaFila,
	MuteTime,
	bool:Spawned,
    bool:AllowGod,
	pMorto,
	bool:FirstSpawn,
	bool:SeePoints,
	bool:SeeName,
	bool:SeeChecksBar,
	JailReason[128]
};

new Player[MAX_PLAYERS][pInfo];