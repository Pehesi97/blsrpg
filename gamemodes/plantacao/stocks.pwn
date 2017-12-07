stock GetPlantacaoQuality(plantId)
{
    new Retorno[32];
    format(Retorno, 32, "---");

    if(Plantacao[plantId][plantChance] == 0)
        format(Retorno, 32, "Perfeita");
    else if(Plantacao[plantId][plantChance] <= 5)
        format(Retorno, 32, "Melhor");
    else if(Plantacao[plantId][plantChance] <= 10)
        format(Retorno, 32, "Ótima");
    else if(Plantacao[plantId][plantChance] <= 15)
        format(Retorno, 32, "Boa");
    else if(Plantacao[plantId][plantChance] <= 20)
        format(Retorno, 32, "Mediana");
    else if(Plantacao[plantId][plantChance] <= 25)
        format(Retorno, 32, "Ruim");
    else
        format(Retorno, 32, "Horrível");
    return Retorno;
}

stock GetPlantacaoCommandString(plantId)
{
    new Retorno[64];
    format(Retorno, 64, "");

    if(IsACopOrg(gZonesData[Plantacao[plantId][plantPlace]][ZoneOwner]))
    {
        if(Plantacao[plantId][plantTime] != -1)
            format(Retorno, 64, "\n{3C7035}Use {FFFFFF}/QueimarPlantacao");
    }
    else if(IsAGangOrgID(gZonesData[Plantacao[plantId][plantPlace]][ZoneOwner]))
    {
        if(Plantacao[plantId][plantTime] == 0)
            format(Retorno, 64, "\n{3C7035}Use {FFFFFF}/ColherPlantacao");
        else if(Plantacao[plantId][plantTime] == -1)
            format(Retorno, 64, "\n{3C7035}Use {FFFFFF}/Plantar");
    }
    return Retorno;
}

stock GetPlantacaoString(plantId)
{
    new Retorno[256];
    format(Retorno, 256, "");

    if(Plantacao[plantId][plantTime] == 0)
        format(Retorno, 256, "Pronto para Colheita%s", GetPlantacaoCommandString(plantId));
    else if(Plantacao[plantId][plantTime] != -1)
        format(Retorno, 256, "Tempo Restante: {FFFFFF}%s%s", Convert(Plantacao[plantId][plantTime]), GetPlantacaoCommandString(plantId));
    else
        format(Retorno, 256, "Preço: {FFFFFF}R$%d\n{3C7035}Qualidade: {FFFFFF}%s\n{3C7035}Produção: {FFFFFF}%d%s", Plantacao[plantId][plantAmount] * DRUG_PRICE, GetPlantacaoQuality(plantId), Plantacao[plantId][plantAmount] * MAX_DRUGS, GetPlantacaoCommandString(plantId));

    return Retorno;
}

stock LoadPlantacao()
{
	new file[32];
	format(file, sizeof(file), "/RPG/Plantacao.INI");

	if(!DOF2_FileExists(file))
        return SavePlantacao();

    for(new i = 0; i < sizeof(Plantacao); i++)
    {
        format(thestring, sizeof(thestring), "P%d_T", i);
        Plantacao[i][plantTime] = DOF2_GetInt(file, thestring);
    }
    return 1;
}

stock SavePlantacao()
{
	new file[32];
	format(file, sizeof(file), "/RPG/Plantacao.INI");

	if(!DOF2_FileExists(file))
	    DOF2_CreateFile(file);

    for(new i = 0; i < sizeof(Plantacao); i++)
    {
        format(thestring, sizeof(thestring), "P%d_T", i);
        DOF2_SetInt(file, thestring, Plantacao[i][plantTime]);
    }
    DOF2_SaveFile();
    return 1;
}