///
///   Не Забудьте добавить tuning.cfg   в скриптфайлс     А СКРИПТ ЖЕЛАТЕЛЬНО ВПИСЫВАТЬ В МОД!!! УДАЧИ В ПОЛЬЗОВАНИИ   Misha_Konsta
///

#include <a_samp>

forward Starting();
forward ZagruzComponent(vehicleid);
forward ZagruzTuning();
forward SohranTuning();
forward split(const strsrc[], strdest[][], delimiter);
 AntiDeAMX()
    {
    new a[][] =
    {
    "Unarmed (Fist)",
    "Brass K"
    };
    #pragma unused a
    }

new AvtoModification[MAX_VEHICLES][11];


public OnFilterScriptInit()
{
    ZagruzTuning();
    SetTimer("Starting", 10000, 0);
	return 1;
}


public ZagruzComponent(vehicleid)
{
    if(AvtoModification[vehicleid][0] >= 1000 && AvtoModification[vehicleid][0] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][0])) != AvtoModification[vehicleid][0])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][0]);
        }
	}
	if(AvtoModification[vehicleid][1] >= 1000 && AvtoModification[vehicleid][1] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][1])) != AvtoModification[vehicleid][1])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][1]);
        }
	}
	if(AvtoModification[vehicleid][2] >= 1000 && AvtoModification[vehicleid][2] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][2])) != AvtoModification[vehicleid][2])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][2]);
        }
	}
	if(AvtoModification[vehicleid][3] >= 1000 && AvtoModification[vehicleid][3] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][3])) != AvtoModification[vehicleid][3])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][3]);
        }
	}
	if(AvtoModification[vehicleid][4] >= 1000 && AvtoModification[vehicleid][4] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][4])) != AvtoModification[vehicleid][4])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][4]);
        }
	}
	if(AvtoModification[vehicleid][5] >= 1000 && AvtoModification[vehicleid][5] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][5])) != AvtoModification[vehicleid][5])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][5]);
        }
	}
	if(AvtoModification[vehicleid][6] >= 1000 && AvtoModification[vehicleid][6] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][6])) != AvtoModification[vehicleid][6])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][6]);
        }
	}
	if(AvtoModification[vehicleid][7] >= 1000 && AvtoModification[vehicleid][7] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][7])) != AvtoModification[vehicleid][7])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][7]);
        }
	}
	if(AvtoModification[vehicleid][8] >= 1000 && AvtoModification[vehicleid][8] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][8])) != AvtoModification[vehicleid][8])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][8]);
        }
	}
	if(AvtoModification[vehicleid][9] >= 1000 && AvtoModification[vehicleid][9] <= 1193)
	{
	    if(GetVehicleComponentInSlot(vehicleid,GetVehicleComponentType(AvtoModification[vehicleid][9])) != AvtoModification[vehicleid][9])
        {
            AddVehicleComponent(vehicleid,AvtoModification[vehicleid][9]);
        }
	}
    if(AvtoModification[vehicleid][10] > 0)
	{
	    ChangeVehiclePaintjob(vehicleid,AvtoModification[vehicleid][10]);
	}
	return 1;
}



public Starting()
{
    for(new v = 0; v < MAX_VEHICLES; v++)
    {
        ZagruzComponent(v);
    }
}
public OnPlayerConnect(playerid)
{
SendClientMessage(playerid,0xFFFFFF96,"На сервере установлена система сохранения тюнинга ");
SendClientMessage(playerid,0xFFFFFF96,"By Pawn-Script.ru ");
}
public OnVehicleSpawn(vehicleid)
{
    ZagruzComponent(vehicleid);
	return 1;
}

public OnVehicleMod(playerid,vehicleid,componentid)
{
    AntiDeAMX();
	SohranTuning();

	if(AvtoModification[vehicleid][0] == 0)
	{
	    AvtoModification[vehicleid][0] = componentid;
	}
	else if(AvtoModification[vehicleid][1] == 0)
	{
	    AvtoModification[vehicleid][1] = componentid;
	}
	else if(AvtoModification[vehicleid][2] == 0)
	{
	    AvtoModification[vehicleid][2] = componentid;
	}
	else if(AvtoModification[vehicleid][3] == 0)
	{
	    AvtoModification[vehicleid][3] = componentid;
	}
	else if(AvtoModification[vehicleid][4] == 0)
	{
	    AvtoModification[vehicleid][4] = componentid;
	}
	else if(AvtoModification[vehicleid][5] == 0)
	{
	    AvtoModification[vehicleid][5] = componentid;
	}
	else if(AvtoModification[vehicleid][6] == 0)
	{
	    AvtoModification[vehicleid][6] = componentid;
	}
	else if(AvtoModification[vehicleid][7] == 0)
	{
	    AvtoModification[vehicleid][7] = componentid;
	}
	else if(AvtoModification[vehicleid][8] == 0)
	{
	    AvtoModification[vehicleid][8] = componentid;
	}
	else if(AvtoModification[vehicleid][9] == 0)
	{
	    AvtoModification[vehicleid][9] = componentid;
	}
	else
	{
		SendClientMessage(playerid,0xFFFFFF96,"У тебя уже есть этот компонент");
	}
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    AvtoModification[vehicleid][10] = paintjobid;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);

    if(strcmp("/удалитьнахуй",cmd,true)==0)
    {
        if (!IsPlayerInAnyVehicle(playerid))
        {
            SendClientMessage(playerid,0xFFFFFF96,"Ты не в авто.");
            return 1;
        }
   	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(AvtoModification[vehicleid][0] > 0)
	    {
	        AvtoModification[vehicleid][0] = 0;
	        AvtoModification[vehicleid][1] = 0;
	        AvtoModification[vehicleid][2] = 0;
	        AvtoModification[vehicleid][3] = 0;
	        AvtoModification[vehicleid][4] = 0;
	        AvtoModification[vehicleid][5] = 0;
	        AvtoModification[vehicleid][6] = 0;
	        AvtoModification[vehicleid][7] = 0;
	        AvtoModification[vehicleid][8] = 0;
	        AvtoModification[vehicleid][9] = 0;
	        AvtoModification[vehicleid][10] = 0;
	        SendClientMessage(playerid,0xFFFFFF96,"Тюнинг успешно удален.");
    	    SetVehicleToRespawn(vehicleid);
	        return 1;
	    }
	    else
	    {
	        SendClientMessage(playerid,0xFFFFFF96,"Нету!!!.");
	    }
        return 1;
	}

	return 0;
}
///   Не Забудьте добавить tuning.cfg   в скриптфайлс     А СКРИПТ ЖЕЛАТЕЛЬНО ВПИСЫВАТЬ В МОД!!! УДАЧИ В ПОЛЬЗОВАНИИ   Misha_Konsta
public ZagruzTuning()
{
	new arrCoords[11][64];
	new strFromFile2[256];
	new File: file = fopen("tuning.cfg", io_read);
	if (file)
	{
		new idx;
		while((idx < MAX_VEHICLES))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			AvtoModification[idx][0] = strval(arrCoords[0]);
		    AvtoModification[idx][1] = strval(arrCoords[1]);
		    AvtoModification[idx][2] = strval(arrCoords[2]);
		    AvtoModification[idx][3] = strval(arrCoords[3]);
		    AvtoModification[idx][4] = strval(arrCoords[4]);
		    AvtoModification[idx][5] = strval(arrCoords[5]);
		    AvtoModification[idx][6] = strval(arrCoords[6]);
		    AvtoModification[idx][7] = strval(arrCoords[7]);
		    AvtoModification[idx][8] = strval(arrCoords[8]);
		    AvtoModification[idx][9] = strval(arrCoords[9]);
		    AvtoModification[idx][10] = strval(arrCoords[10]);
			idx++;
		}
		fclose(file);
	}
	return 1;
}
///   Не Забудьте добавить tuning.cfg   в скриптфайлс     А СКРИПТ ЖЕЛАТЕЛЬНО ВПИСЫВАТЬ В МОД!!! УДАЧИ В ПОЛЬЗОВАНИИ   Misha_Konsta
public SohranTuning()
{
	new idx;
	new File: file2;
	while((idx < MAX_VEHICLES))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		AvtoModification[idx][0],
		AvtoModification[idx][1],
		AvtoModification[idx][2],
		AvtoModification[idx][3],
		AvtoModification[idx][4],
		AvtoModification[idx][5],
		AvtoModification[idx][6],
		AvtoModification[idx][7],
		AvtoModification[idx][8],
		AvtoModification[idx][9],
		AvtoModification[idx][10]);
		if(idx == 0)
		{
			file2 = fopen("tuning.cfg", io_write);
		}
		else
		{
			file2 = fopen("tuning.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

stock PointOverString(string[], argument, schar)
{
	new length = strlen(string), arg, result[128], index;
	for (new i = 0; i < length; i++)
	{
		if (string[i] == schar || i == length || string[i + 1] == 10)
		{
			arg++;
			if (arg == argument + 1)
			{
				result[i-index] = EOS;
				return result;
			}
			else if (arg == argument)
			index = i+1;
		}
		else if (arg == argument)
		result[i - index] = string[i];
	}
	return result;
}

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
///   Не Забудьте добавить tuning.cfg   в скриптфайлс     А СКРИПТ ЖЕЛАТЕЛЬНО ВПИСЫВАТЬ В МОД!!! УДАЧИ В ПОЛЬЗОВАНИИ   Misha_Konsta
