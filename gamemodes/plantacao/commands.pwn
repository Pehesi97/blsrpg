CMD:plantar(playerid)
{
    new plantId = -1;
    for(new i = 0; i < sizeof(Plantacao); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.5, Plantacao[i][plantPos][0], Plantacao[i][plantPos][1], Plantacao[i][plantPos][2]))
        {
            plantId = i;
            break;
        }
    }
    if(plantId == -1)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Você não está perto de uma Plantação.");

    if(gZonesData[Plantacao[plantId][plantPlace]][ZoneOwner] != GetPlayerOrg(playerid) || GetPlayerOrg(playerid) == 0)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Você não é dono desta GangZone.");
    if(Plantacao[plantId][plantTime] != -1)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Algo já foi Plantado.");
    if(GetPlayerGP(playerid) < Plantacao[plantId][plantAmount] * DRUG_PRICE)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Você não pode Pagar.");
    if(IsACop(playerid))
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Infelizmente você é um Homem da Lei e não pode plantar aqui."); //;-;

    GivePlayerGP(playerid, -Plantacao[plantId][plantAmount] * DRUG_PRICE);
    Plantacao[plantId][plantTime] = (2 * 60 * 60);

    SendClientMessage(playerid, COLOR_YELLOW, "Você pagou por esta plantação, ela ficará pronta em 2 horas.");

    Update3DTextLabelText(PlantacaoText[plantId], 0x3C7035FF, GetPlantacaoString(plantId));
    return 1;
}

CMD:colherplantacao(playerid)
{
    new plantId = -1, objs = 0;
    for(new i = 0; i < sizeof(Plantacao); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.5, Plantacao[i][plantPos][0], Plantacao[i][plantPos][1], Plantacao[i][plantPos][2]))
        {
            plantId = i;
            break;
        }
        else
            objs += Plantacao[i][plantAmount];
    }
    if(plantId == -1)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Você não está perto de uma Plantação.");

    if(gZonesData[Plantacao[plantId][plantPlace]][ZoneOwner] != GetPlayerOrg(playerid) || GetPlayerOrg(playerid) == 0)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Você não é dono desta GangZone.");
    if(Plantacao[plantId][plantTime] != 0)
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} A Plantação não está pronta para Colheita.");
    if(IsACop(playerid))
        return SendClientMessage(playerid, 0xAA3333AA, "[ERRO]:{FFFFFF} Infelizmente você é um Homem da Lei e não pode colher este produto."); //;-;

    Plantacao[plantId][plantTime] = -1;
    for(new o = objs; o < objs + Plantacao[plantId][plantAmount]; o++)
        SetDynamicObjectPos(PlantacaoObj[o], PlantacaoObjFinalPos[o][0], PlantacaoObjFinalPos[o][1], PlantacaoObjFinalPos[o][2] - 2.0);

    CofreOrg[GetPlayerOrg(playerid)][cfDrogas] += floatround((Plantacao[plantId][plantAmount] * MAX_DRUGS) * 0.95);
    Player[playerid][pDrugs] += floatround((Plantacao[plantId][plantAmount] * MAX_DRUGS) * 0.05);

    format(thestring, sizeof(thestring), "Você colheu as drogas e pegou %d para você.", floatround((Plantacao[plantId][plantAmount] * MAX_DRUGS) * 0.05));
    SendClientMessage(playerid, COLOR_YELLOW, thestring);

    Update3DTextLabelText(PlantacaoText[plantId], 0x3C7035FF, GetPlantacaoString(plantId));
    return 1;
}

CMD:queimarplantacao(playerid)
{
    new plantId = -1, objs = 0;
    for(new i = 0; i < sizeof(Plantacao); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.5, Plantacao[i][plantPos][0], Plantacao[i][plantPos][1], Plantacao[i][plantPos][2]))
        {
            plantId = i;
            break;
        }
        else
            objs += Plantacao[i][plantAmount];
    }
    if(plantId == -1)
        return SendClientMessage(playerid, COLOR_RED, "[ERRO]:{FFFFFF} Você não está perto de uma plantação.");

    if(gZonesData[Plantacao[plantId][plantPlace]][ZoneOwner] != GetPlayerOrg(playerid) || GetPlayerOrg(playerid) == 0)
        return SendClientMessage(playerid, COLOR_RED, "[ERRO]:{FFFFFF} Você não é dono desta GangZone.");
    if(Plantacao[plantId][plantTime] == -1)
        return SendClientMessage(playerid, COLOR_RED, "[ERRO]:{FFFFFF} Não há nada para queimar.");
    if(!IsACop(playerid))
        return SendClientMessage(playerid, COLOR_RED, "[ERRO]:{FFFFFF} Você não quer queimar realmente este produto maravilhoso, quer?"); //;-;

    Plantacao[plantId][plantTime] = -1;
    for(new o = objs; o < objs + Plantacao[plantId][plantAmount]; o++)
        SetDynamicObjectPos(PlantacaoObj[o], PlantacaoObjFinalPos[o][0], PlantacaoObjFinalPos[o][1], PlantacaoObjFinalPos[o][2] - 2.0);

    format(thestring, sizeof(thestring), "Você queimou estas drogas, causando R$%d de prejuízo para quem plantou.", Plantacao[plantId][plantAmount] * DRUG_PRICE);
    SendClientMessage(playerid, COLOR_YELLOW, thestring);

    Update3DTextLabelText(PlantacaoText[plantId], 0x3C7035FF, GetPlantacaoString(plantId));
    return 1;
}