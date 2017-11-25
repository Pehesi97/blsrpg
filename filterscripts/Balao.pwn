/*
Por favor não retire os creditos:
Criado por: dimmy_scarface
Creditos a: Fatal(DeserT) por edite, reposição e desbug de pequenas coisas.
Creditos a: Astro pelos GetPlayerFacingAngle ao direionar o balão
*/


#include <a_samp>
#define COLOR_GOLD 0xFFD700AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA

//=•=
new VelocidadeBalao,VelocidadeBalao2,VelocidadeBalao3,VelocidadeBalao4;
//=•=
new TempoBalao1,TempoBalao2,TempoBalao3,TempoBalao4;
//=•=
new Text3D:TextBalao1,Text3D:TextBalao2,Text3D:TextBalao3,Text3D:TextBalao4;
//=•=
new Balao,Balao2,Balao3,Balao4;
//=•=
new Balao1Laser,Balao2Laser,Balao3Laser,Balao4Laser;
//=•=
new BalaoOcupado1,BalaoOcupado2,BalaoOcupado3,BalaoOcupado4;
//=•=
new DonoBalao[MAX_PLAYERS];
new NoBalao[MAX_PLAYERS];

public OnGameModeInit()
{
	VelocidadeBalao = 2;
	VelocidadeBalao2 = 2;
	VelocidadeBalao3 = 2;
	VelocidadeBalao4 = 2;
	//=====
	Balao = CreateObject(19332,188.8908,-1810.5868,4.4251-1,0,0,180,3000);
	Balao2 = CreateObject(19333,218.9309,-1811.6028,4.4148-1,0,0,180,3000);
	Balao3 = CreateObject(19334,257.7825,-1811.3401,4.3060-1,0,0,180,3000);
	Balao4 = CreateObject(19335,296.6086,-1811.2219,4.4141-1,0,0,180,3000);
	Balao1Laser = CreateObject(18647,0.0,0.0,0.0,0,0,0);
	Balao2Laser = CreateObject(18646,0.0,0.0,0.0,0,0,0);
	Balao3Laser = CreateObject(18649,0.0,0.0,0.0,0,0,0);
	Balao4Laser = CreateObject(18650,0.0,0.0,0.0,0,0,0);
	AttachObjectToObject(Balao1Laser, Balao, 0.0, 0.0, 0.0+3, 0, 0, 270, 1);
	AttachObjectToObject(Balao2Laser, Balao2, 0.0, 0.0, 0.0+3, 0, 0, 270, 1);
	AttachObjectToObject(Balao3Laser, Balao3, 0.0, 0.0, 0.0+3, 0, 0, 270, 1);
	AttachObjectToObject(Balao4Laser, Balao4, 0.0, 0.0, 0.0+3, 0, 0, 270, 1);
	TextBalao1 = Create3DTextLabel("Para alugar o balão\nDigite: /alugarbalao",0xE800A6FF,188.9508,-1807.0344,4.3319,7,0);
    TextBalao2 = Create3DTextLabel("Para alugar o balão\nDigite: /alugarbalao",0xE800A6FF,219.0186,-1808.0635,4.5106,7,0);
    TextBalao3 = Create3DTextLabel("Para alugar o balão\nDigite: /alugarbalao",0xE800A6FF,257.6900,-1807.9561,4.4034,7,0);
    TextBalao4 = Create3DTextLabel("Para alugar o balão\nDigite: /alugarbalao",0xE800A6FF,296.5143,-1807.7748,4.4312,7,0);
    AddStaticPickup(1239,23,188.9508,-1807.0344,4.3319); // 1
    AddStaticPickup(1239,23,219.0186,-1808.0635,4.5106);// 2
    AddStaticPickup(1239,23,257.6900,-1807.9561,4.4034);// 3
    AddStaticPickup(1239,23,296.5143,-1807.7748,4.4312);// 4
	return 0;
}

public OnGameModeExit()
{
	DestroyObject(Balao);
	DestroyObject(Balao2);
	DestroyObject(Balao3);
	DestroyObject(Balao4);
	//
	DestroyObject(Balao1Laser);
	DestroyObject(Balao2Laser);
	DestroyObject(Balao3Laser);
	DestroyObject(Balao4Laser);
	return 0;
}

public OnPlayerConnect(playerid)
{
    DonoBalao[playerid] = 0;
	return 0;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(DonoBalao[playerid] == 1)
	{
		StopObject(Balao);
		SetObjectPos( Balao,188.8908,-1810.5868,4.4251-1);
		BalaoOcupado1 = 0;
		KillTimer(TempoBalao1);
		Update3DTextLabelText(TextBalao1, 0x8D8DFF00, "Para alugar o balão\nDigite: /alugarbalao");
	}
	if(DonoBalao[playerid] == 2)
	{
		StopObject(Balao2);
		SetObjectPos( Balao2,218.9309,-1811.6028,4.4148-1);
		BalaoOcupado2 = 0;
		KillTimer(TempoBalao2);
		Update3DTextLabelText(TextBalao2, 0x8D8DFF00, "Para alugar o balão\nDigite: /alugarbalao");
	}
	if(DonoBalao[playerid] == 3)
	{
		StopObject(Balao3);
		SetObjectPos( Balao3,257.7825,-1811.3401,4.3060-1);
		BalaoOcupado3 = 0;
		KillTimer(TempoBalao3);
		Update3DTextLabelText(TextBalao3, 0x8D8DFF00, "Para alugar o balão\nDigite: /alugarbalao");
	}

	if(DonoBalao[playerid] == 4)
	{
		StopObject(Balao4);
		SetObjectPos( Balao4,296.6086,-1811.2219,4.4141-1);
		BalaoOcupado4 = 0;
		KillTimer(TempoBalao4);
		Update3DTextLabelText(TextBalao4, 0x8D8DFF00, "Para alugar o balão\nDigite: /alugarbalao");
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/alugarbalao", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(DonoBalao[playerid] > 0)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você já alugou um balão, USE: /desalugarbalao");
	            return true;
			}
			if(GetPlayerMoney(playerid)<=999)
			{
    			SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não tem dinheiro para Alugar o Balão (R$1000)");
			}
	    	if (PlayerToPoint(5, playerid,188.9508,-1807.0344,4.3319)&&BalaoOcupado1 == 0)
			{
   				NoBalao[playerid] = 1;
   				DonoBalao[playerid] = 1;
   				BalaoOcupado1 = 1;
   				KillTimer(TempoBalao1);
   				GivePlayerMoney(playerid, -1000);
   				GivePlayerWeapon(playerid, 46, 1);
   				TempoBalao2 = SetTimer("AcabarBalao2",1200000,0);
   				Update3DTextLabelText(TextBalao1, 0xE800A6FF, "Balão Ocupado\nFavor Procurar Outro");
				SendClientMessage(playerid, COLOR_GREEN, "===========[Aluguel do Balão]===========");
		       	SendClientMessage(playerid, COLOR_GREEN, "Contrado - Minutos: 20");
		       	SendClientMessage(playerid, COLOR_GREEN, "Preço - R$1000");
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]O Número do seu Balão é: 1");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Subir para subir o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Descer para descer o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Stop para parar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /LocalizarBalao para localizar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /ChamarBalao para chamar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Velocidade para alterar a velocidade do Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Direcionar para direcionar o Balão na direção desejada");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /DesalugarBalao para desalugar o balão");
		       	return true;
			}
	    	if (PlayerToPoint(5, playerid,219.0186,-1808.0635,4.5106)&&BalaoOcupado2 == 0)
			{
   				NoBalao[playerid] = 1;
   				DonoBalao[playerid] = 2;
   				BalaoOcupado2 = 1;
    			KillTimer(TempoBalao2);
    			GivePlayerWeapon(playerid, 46, 1);
    			GivePlayerMoney(playerid, -1000);
   				TempoBalao2 = SetTimer("AcabarBalao2",1200000,0);
   				Update3DTextLabelText(TextBalao2, 0xE800A6FF, "Balão Ocupado\nFavor Procurar Outro");
				SendClientMessage(playerid, COLOR_GREEN, "===========[Aluguel do Balão]===========");
		       	SendClientMessage(playerid, COLOR_GREEN, "Contrado - Minutos: 20");
		       	SendClientMessage(playerid, COLOR_GREEN, "Preço - R$1000");
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]O Número do seu Balão é: 2");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Subir para subir o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Descer para descer o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Stop para parar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /LocalizarBalao para localizar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /ChamarBalao para chamar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Velocidade para alterar a velocidade do Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Direcionar para direcionar o Balão na direção desejada");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /DesalugarBalao para desalugar o balão");
	   			return true;
			}
	    	if (PlayerToPoint(5, playerid,257.6900,-1807.9561,4.4034)&&BalaoOcupado3 == 0)
			{
   				NoBalao[playerid] = 1;
   				DonoBalao[playerid] = 3;
   				BalaoOcupado3 = 1;
    			KillTimer(TempoBalao3);
    			GivePlayerWeapon(playerid, 46, 1);
    			GivePlayerMoney(playerid, -1000);
   				TempoBalao3 = SetTimer("AcabarBalao3",1200000,0);
   				Update3DTextLabelText(TextBalao3, 0xE800A6FF, "Balão Ocupado\nFavor Procurar Outro");
				SendClientMessage(playerid, COLOR_GREEN, "===========[Aluguel do Balão]===========");
		       	SendClientMessage(playerid, COLOR_GREEN, "Contrado - Minutos: 20");
		       	SendClientMessage(playerid, COLOR_GREEN, "Preço - R$1000");
		       	SendClientMessage(playerid, COLOR_GOLD, "O Número do seu Balão é: 3");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Subir para subir o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Descer para descer o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Stop para parar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /LocalizarBalao para localizar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /ChamarBalao para chamar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Velocidade para alterar a velocidade do Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Direcionar para direcionar o Balão na direção desejada");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /DesalugarBalao para desalugar o balão");
		       	return true;
			}
	    	if (PlayerToPoint(5, playerid,296.5143,-1807.7748,4.4312)&&BalaoOcupado4 == 0)
			{
   				NoBalao[playerid] = 1;
   				DonoBalao[playerid] = 4;
   				BalaoOcupado4 = 1;
   				KillTimer(TempoBalao4);
   				GivePlayerWeapon(playerid, 46, 1);
   				GivePlayerMoney(playerid, -1000);
   				TempoBalao4 = SetTimer("AcabarBalao4",1200000,0);
   				Update3DTextLabelText(TextBalao4, 0xE800A6FF, "Balão Ocupado\nFavor Procurar Outro");
				SendClientMessage(playerid, COLOR_GREEN, "==========[Aluguel do Balão]==========");
		       	SendClientMessage(playerid, COLOR_GREEN, "Contrado - Minutos: 20");
		       	SendClientMessage(playerid, COLOR_GREEN, "Preço - R$1000");
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]O Número do seu Balão é: 4");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Subir para subir o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Descer para descer o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Stop para parar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /LocalizarBalao para localizar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /ChamarBalao para chamar o Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Velocidade para alterar a velocidade do Balão");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /Direcionar para direcionar o Balão na direção desejada");
		       	SendClientMessage(playerid, COLOR_GOLD, "[Comandos Balão]: Use /DesalugarBalao para desalugar o balão");
		       	return true;
			}
	    }
		return true;
	}
	if (strcmp("/Velocidade", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(NoBalao[playerid] == 1)
			{
	         	ShowPlayerDialog(playerid, 9856, DIALOG_STYLE_LIST, "Velocidade do balão","Velocidade: Lenta\nVelocidade: Normal\nVelocidade: Rápida\nVelocidade: Máxima","Confirmar","Sair");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não está no seu balão alugado");
			}
		}
		return true;
	}
	
	if (strcmp("/desalugarbalao", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(DonoBalao[playerid] < 1)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não alugou um balão");
	            return true;
			}
			SendClientMessage(playerid, COLOR_GREEN, "Você desalugou seu balão com sucesso.");
			if(DonoBalao[playerid] == 1)
			{
			   	for(new i = 0; i < MAX_PLAYERS; i++)
     			{
     			    if(IsPlayerConnected(i))
	            	{
						if(GetPlayerSurfingObjectID(i) == Balao)
					    {
					        GivePlayerWeapon(i, 46, 1);
					        SetPlayerInterior(i, 0);
					        SetPlayerVirtualWorld(i, 0);
							SetPlayerPos(i, 188.9508,-1807.0344,4.3319);
						}
					}
				}
				StopObject(Balao);
				SetObjectPos( Balao,188.8908,-1810.5868,4.4251-1);
				BalaoOcupado1 = 0;
				KillTimer(TempoBalao1);
				DonoBalao[playerid] = 0;
				Update3DTextLabelText(TextBalao1, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
			}
			if(DonoBalao[playerid] == 2)
			{
		 		for(new i = 0; i < MAX_PLAYERS; i++)
     			{
     				if(IsPlayerConnected(i))
	            	{
						if(GetPlayerSurfingObjectID(i) == Balao2)
					    {
					        GivePlayerWeapon(i, 46, 1);
					        SetPlayerInterior(i, 0);
					        SetPlayerVirtualWorld(i, 0);
							SetPlayerPos(i, 219.0186,-1808.0635,4.5106);
						}
					}
				}
				StopObject(Balao2);
				SetObjectPos( Balao2,218.9309,-1811.6028,4.4148-1);
				BalaoOcupado2 = 0;
				KillTimer(TempoBalao2);
				DonoBalao[playerid] = 0;
				Update3DTextLabelText(TextBalao2, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
			}
			if(DonoBalao[playerid] == 3)
			{
			    for(new i = 0; i < MAX_PLAYERS; i++)
     			{
     				if(IsPlayerConnected(i))
	            	{
						if(GetPlayerSurfingObjectID(i) == Balao3)
					    {
					        GivePlayerWeapon(i, 46, 1);
					        SetPlayerInterior(i, 0);
					        SetPlayerVirtualWorld(i, 0);
							SetPlayerPos(i, 257.6900,-1807.9561,4.4034);
						}
					}
				}
				StopObject(Balao3);
				SetObjectPos( Balao3,257.7825,-1811.3401,4.3060-1);
				BalaoOcupado3 = 0;
				KillTimer(TempoBalao3);
				DonoBalao[playerid] = 0;
				Update3DTextLabelText(TextBalao3, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
			}

			if(DonoBalao[playerid] == 4)
			{
			    for(new i = 0; i < MAX_PLAYERS; i++)
     			{
     				if(IsPlayerConnected(i))
	            	{
						if(GetPlayerSurfingObjectID(i) == Balao4)
					    {
					        GivePlayerWeapon(i, 46, 1);
					        SetPlayerInterior(i, 0);
					        SetPlayerVirtualWorld(i, 0);
							SetPlayerPos(i, 296.5143,-1807.7748,4.4312);
						}
					}
				}
				StopObject(Balao4);
				SetObjectPos( Balao4,296.6086,-1811.2219,4.4141-1);
				BalaoOcupado4 = 0;
				KillTimer(TempoBalao4);
				DonoBalao[playerid] = 0;
				Update3DTextLabelText(TextBalao4, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
			}
		}
		return true;
	}

	
	if (strcmp("/direcionar", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(NoBalao[playerid] != 1)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não está controlando um balão");
	            return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao == 1 && DonoBalao[playerid] == 1)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+7000,bZ,3,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+700,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY-30000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);
					}
					return true;
			}

			if(NoBalao[playerid] == 1 && VelocidadeBalao == 2&& DonoBalao[playerid] == 1)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+7000,bZ,7,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+700,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY-30000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao == 3&& DonoBalao[playerid] == 1)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+7000,bZ,14,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+700,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY-30000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao == 4&& DonoBalao[playerid] == 1)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+7000,bZ,20,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY+700,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX-15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX,bY-30000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao, bX, bY, bZ);
		            	MoveObject( Balao, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao2 == 1 && DonoBalao[playerid] == 2)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+7000,bZ,3,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+700,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY-30000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);
					}
					return true;
			}

			if(NoBalao[playerid] == 1 && VelocidadeBalao2 == 2&& DonoBalao[playerid] == 2)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+7000,bZ,7,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+700,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY-30000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao2 == 3&& DonoBalao[playerid] == 2)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+7000,bZ,14,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+700,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY-30000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao2 == 4&& DonoBalao[playerid] == 2)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+7000,bZ,20,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY+700,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX-15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX,bY-30000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao2, bX, bY, bZ);
		            	MoveObject( Balao2, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao3 == 1 && DonoBalao[playerid] == 3)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+7000,bZ,3,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+700,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY-30000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);
					}
					return true;
			}

			if(NoBalao[playerid] == 1 && VelocidadeBalao3 == 2&& DonoBalao[playerid] == 3)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+7000,bZ,7,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+700,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY-30000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao3 == 3&& DonoBalao[playerid] == 3)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+7000,bZ,14,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+700,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY-30000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao3 == 4&& DonoBalao[playerid] == 3)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+7000,bZ,20,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY+700,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX-15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX,bY-30000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao3, bX, bY, bZ);
		            	MoveObject( Balao3, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao4 == 1 && DonoBalao[playerid] == 4)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+7000,bZ,3,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+700,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY-30000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY-15000,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+30000,bY,bZ,3,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,3,0.0,0.0,0.0);
					}
					return true;
			}

			if(NoBalao[playerid] == 1 && VelocidadeBalao4 == 2&& DonoBalao[playerid] == 4)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+7000,bZ,7,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+700,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY-30000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY-15000,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+30000,bY,bZ,7,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,7,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao4 == 3&& DonoBalao[playerid] == 4)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+7000,bZ,14,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+700,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY-30000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY-15000,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+30000,bY,bZ,14,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,14,0.0,0.0,0.0);

					}
					return true;
			}
			if(NoBalao[playerid] == 1 && VelocidadeBalao4 == 4&& DonoBalao[playerid] == 4)
			{
		    		new Float:pa;
		    		new Float:bX, Float:bY, Float:bZ;
					GetPlayerFacingAngle(playerid,pa);
					if(pa >= 0.0 && pa <= 22.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+7000,bZ,20,0.0,0.0,0.0);
					}
					else if(pa >= 332.5 && pa < 0.0) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY+700,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 22.5 && pa <= 67.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 67.5 && pa <= 112.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 112.5 && pa <= 157.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX-15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 157.5 && pa <= 202.5) 
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX,bY-30000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 202.5 && pa <= 247.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY-15000,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 247.5 && pa <= 292.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+30000,bY,bZ,20,0.0,0.0,0.0);

					}
					else if(pa >= 292.5 && pa <= 332.5)
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					else
					{
			        	GetObjectPos(Balao4, bX, bY, bZ);
		            	MoveObject( Balao4, bX+15000,bY+15000,bZ,20,0.0,0.0,0.0);

					}
					return true;
			}
		}
		return true;
	}
	if (strcmp("/stop", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 1)
			{
				StopObject(Balao);
				SendClientMessage(playerid, 0xFF00FF, "Balão parado!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 2)
			{
		        StopObject(Balao2);
				SendClientMessage(playerid, 0xFF00FF, "Balão parado!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 3)
			{
		        StopObject(Balao3);
				SendClientMessage(playerid, 0xFF00FF, "Balão parado!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 4)
			{
		        StopObject(Balao4);
				SendClientMessage(playerid, 0xFF00FF, "Balão parado!");
			}
		}
		return true;
	}
	if (strcmp("/subir", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new Float:bX, Float:bY, Float:bZ;
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 1)
			{
		        GetObjectPos(Balao, bX, bY, bZ);
	            MoveObject( Balao, bX,bY,bZ+50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está subindo o balão!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 2)
			{
		        GetObjectPos(Balao2, bX, bY, bZ);
	            MoveObject( Balao2, bX,bY,bZ+50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está subindo o balão!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 3)
			{
		        GetObjectPos(Balao3, bX, bY, bZ);
	            MoveObject( Balao3, bX,bY,bZ+50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[ERRO]Você está subindo o balão!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 4)
			{
		        GetObjectPos(Balao4, bX, bY, bZ);
	            MoveObject( Balao4, bX,bY,bZ+50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está subindo o balão!");
			}
		}
		return true;
	}
	
	if (strcmp("/chamarbalao", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		   	new Float:pX, Float:pY, Float:pZ;
	        if(NoBalao[playerid] != 1)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não está controlando um balão");
	            return true;
			}
 	        if(GetPlayerInterior(playerid) > 0)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não pode chamar o balão agora!");
	            return true;
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 1)
			{
			    StopObject(Balao);
				GetPlayerPos(playerid,pX, pY, pZ);
		       	SetObjectPos( Balao, pX,pY+2,pZ-1);
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você chamou seu Balão");
		       	return true;
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 2)
			{
			    StopObject(Balao2);
				GetPlayerPos(playerid,pX, pY, pZ);
		       	SetObjectPos( Balao2, pX,pY+2,pZ-1);
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você chamou seu Balão");
		       	return true;
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 3)
			{
			    StopObject(Balao3);
				GetPlayerPos(playerid,pX, pY, pZ);
		       	SetObjectPos( Balao3, pX,pY+2,pZ-1);
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você chamou seu Balão");
		       	return true;
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 4)
			{
			    StopObject(Balao4);
				GetPlayerPos(playerid,pX, pY, pZ);
		       	SetObjectPos( Balao4, pX,pY+2,pZ-1);
		       	SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você chamou seu Balão");
		       	return true;
			}
		}
		return true;
	}

	
	if (strcmp("/localizarbalao", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	      	new Float:bX, Float:bY, Float:bZ;
	        if(DonoBalao[playerid] < 1)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não alugou um balão");
	            return true;
			}
  	        if(GetPlayerInterior(playerid) > 0)
	        {
	            SendClientMessage(playerid, COLOR_RED, "[ERRO]Você não pode localizar o balão agora!");
	            return true;
			}
			if(DonoBalao[playerid] == 1)
			{
				GetObjectPos(Balao, bX, bY, bZ);
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, bX,bY,bZ, 6);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Seu balão foi marcado com um checkpoint vermelho no mapa!");
				return true;
			}
			if(DonoBalao[playerid] == 2)
			{
				GetObjectPos(Balao2, bX, bY, bZ);
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, bX,bY,bZ, 6);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Seu balão foi marcado com um checkpoint vermelho no mapa!");
				return true;
			}
			if(DonoBalao[playerid] == 3)
			{
				GetObjectPos(Balao3, bX, bY, bZ);
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, bX,bY,bZ, 6);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Seu balão foi marcado com um checkpoint vermelho no mapa!");
				return true;
			}

			if(DonoBalao[playerid] == 4)
			{
				GetObjectPos(Balao4, bX, bY, bZ);
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, bX,bY,bZ, 6);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Seu balão foi marcado com um checkpoint vermelho no mapa!");
				return true;
			}
		}
		return true;
	}

	if (strcmp("/descer", cmdtext, true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new Float:bX, Float:bY, Float:bZ;
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 1)
			{
		        GetObjectPos(Balao, bX, bY, bZ);
	            MoveObject( Balao, bX,bY,bZ-50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está descendo o balão!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 2)
			{
		        GetObjectPos(Balao2, bX, bY, bZ);
	            MoveObject( Balao2, bX,bY,bZ-50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está descendo o balão!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 3)
			{
		        GetObjectPos(Balao3, bX, bY, bZ);
	            MoveObject( Balao3, bX,bY,bZ-50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está descendo o balão!");
			}
			if(NoBalao[playerid] == 1 && DonoBalao[playerid] == 4)
			{
		        GetObjectPos(Balao4, bX, bY, bZ);
	            MoveObject( Balao4, bX,bY,bZ-50,3,0.0,0.0,0.0);
				SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você está descendo o balão!");
			}
		}
		return true;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == 16 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        OnPlayerCommandText(playerid,"/alugarbalao");
	}
   	if(newkeys == 16 && NoBalao[playerid] == 1)
    {
      	new Float:bX, Float:bY, Float:bZ;
        if(DonoBalao[playerid] == 1)
        {
            GetObjectPos(Balao, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 10, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/stop");
			}
		}
  		if(DonoBalao[playerid] == 2)
        {
            GetObjectPos(Balao2, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 10, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/stop");
			}
		}
		if(DonoBalao[playerid] == 3)
        {
            GetObjectPos(Balao3, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 10, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/stop");
			}
		}
		if(DonoBalao[playerid] == 4)
        {
            GetObjectPos(Balao4, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 10, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/stop");
			}
		}
    }
   	if(newkeys == KEY_YES && NoBalao[playerid] == 1)
    {
      	new Float:bX, Float:bY, Float:bZ;
        if(DonoBalao[playerid] == 1)
        {
            GetObjectPos(Balao, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 5, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/direcionar");
			}
		}
  		if(DonoBalao[playerid] == 2)
        {
            GetObjectPos(Balao2, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 5, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/direcionar");
			}
		}
		if(DonoBalao[playerid] == 3)
        {
            GetObjectPos(Balao3, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 5, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/direcionar");
			}
		}
		if(DonoBalao[playerid] == 4)
        {
            GetObjectPos(Balao4, bX, bY, bZ);
	    	if(IsPlayerInRangeOfPoint(playerid, 5, bX, bY, bZ))
	    	{
	    		OnPlayerCommandText(playerid,"/direcionar");
			}
		}
    }
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
   	if(dialogid == 9859)
	{
	    TogglePlayerControllable(playerid, 1);
		if(response >= 1)
		{
  			OnPlayerCommandText(playerid,"/alugarbalao");
			return true;
		}
		return 1;
	}
	if(dialogid == 9856)
	{
		if(response >= 1)
		{
			if(listitem == 0)
			{
				if(DonoBalao[playerid] == 1)
				{
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: LENTA!");
				    VelocidadeBalao = 1;
					return true;
				}
  				if(DonoBalao[playerid] == 2)
				{
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: LENTA!");
				    VelocidadeBalao2 = 1;
					return true;
				}
 				if(DonoBalao[playerid] == 3)
				{
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: LENTA!");
				    VelocidadeBalao3 = 1;
					return true;
				}
 				if(DonoBalao[playerid] == 4)
				{
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: LENTA!");
				    VelocidadeBalao4 = 1;
					return true;
				}
		 	}
			if(listitem == 1)
			{
			    if(DonoBalao[playerid] == 1)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: NORMAL!");
				    VelocidadeBalao = 2;
					return true;
				}
 			    if(DonoBalao[playerid] == 2)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: NORMAL!");
				    VelocidadeBalao2 = 2;
					return true;
				}
 			    if(DonoBalao[playerid] == 3)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: NORMAL!");
				    VelocidadeBalao3 = 2;
					return true;
				}
 			    if(DonoBalao[playerid] == 4)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: NORMAL!");
				    VelocidadeBalao4 = 2;
					return true;
				}
		 	}
			if(listitem == 2)
			{
			    if(DonoBalao[playerid] == 1)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: RÁPIDA!");
				    VelocidadeBalao = 3;
					return true;
				}
  			    if(DonoBalao[playerid] == 2)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: RÁPIDA!");
				    VelocidadeBalao2 = 3;
					return true;
				}
 			    if(DonoBalao[playerid] == 3)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: RÁPIDA!");
				    VelocidadeBalao3 = 3;
					return true;
				}
 			    if(DonoBalao[playerid] == 4)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: RÁPIDA!");
				    VelocidadeBalao4 = 3;
					return true;
				}
		 	}
   			if(listitem == 3)
			{
			    if(DonoBalao[playerid] == 1)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: MÁXIMA!");
				    VelocidadeBalao = 4;
					return true;
				}
  			    if(DonoBalao[playerid] == 2)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: MÁXIMA!");
				    VelocidadeBalao2 = 4;
					return true;
				}
  			    if(DonoBalao[playerid] == 3)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: MÁXIMA!");
				    VelocidadeBalao3 = 4;
					return true;
				}
  			    if(DonoBalao[playerid] == 4)
			    {
					SendClientMessage(playerid, COLOR_GOLD, "[INFO]Você ajustou a velocidade do balão para: MÁXIMA!");
				    VelocidadeBalao4 = 4;
					return true;
				}
		 	}
		}
		return true;
	}
	return 0;
}
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return true;
		}
	}
	return 0;
}


forward AcabarBalao1();
public AcabarBalao1()
{
    StopObject(Balao);
	SetObjectPos( Balao,188.8908,-1810.5868,4.4251-1);
	BalaoOcupado1 = 0;
	KillTimer(TempoBalao1);
	Update3DTextLabelText(TextBalao1, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(GetPlayerSurfingObjectID(i) == Balao)
		    {
		        GivePlayerWeapon(i, 46, 1);
		        DonoBalao[i] = 0;
		        SetPlayerInterior(i, 0);
		        SetPlayerVirtualWorld(i, 0);
				SetPlayerPos(i, 188.9508,-1807.0344,4.3319);
				SendClientMessage(i, COLOR_GOLD, "O Tempo do aluguel do balão acabou!");
			}
		}
	}
	return true;
}
forward AcabarBalao2();
public AcabarBalao2()
{
    StopObject(Balao2);
	SetObjectPos( Balao2,218.9309,-1811.6028,4.4148-1);
	BalaoOcupado2 = 0;
	KillTimer(TempoBalao2);
	Update3DTextLabelText(TextBalao2, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(GetPlayerSurfingObjectID(i) == Balao2)
		    {
		        GivePlayerWeapon(i, 46, 1);
		        DonoBalao[i] = 0;
		        SetPlayerInterior(i, 0);
		        SetPlayerVirtualWorld(i, 0);
				SetPlayerPos(i, 219.0186,-1808.0635,4.5106);
				SendClientMessage(i, COLOR_GOLD, "O Tempo do aluguel do balão acabou!");
			}
		}
	}
	return true;
}
forward AcabarBalao3();
public AcabarBalao3()
{
    StopObject(Balao3);
	SetObjectPos( Balao3,257.7825,-1811.3401,4.3060-1);
	BalaoOcupado3 = 0;
	KillTimer(TempoBalao3);
	Update3DTextLabelText(TextBalao3, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(GetPlayerSurfingObjectID(i) == Balao3)
		    {
		        GivePlayerWeapon(i, 46, 1);
		        DonoBalao[i] = 0;
		        SetPlayerInterior(i, 0);
		        SetPlayerVirtualWorld(i, 0);
				SetPlayerPos(i, 257.6900,-1807.9561,4.4034);
				SendClientMessage(i, COLOR_GOLD, "O Tempo do aluguel do balão acabou!");
			}
		}
	}
	return true;
}
forward AcabarBalao4();
public AcabarBalao4()
{
    StopObject(Balao4);
	SetObjectPos( Balao4,296.6086,-1811.2219,4.4141-1);
	BalaoOcupado4 = 0;
	KillTimer(TempoBalao4);
	Update3DTextLabelText(TextBalao4, 0xE800A6FF, "Para alugar o balão\ndigite /alugarbalao");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(GetPlayerSurfingObjectID(i) == Balao4)
		    {
		        GivePlayerWeapon(i, 46, 1);
		        DonoBalao[i] = 0;
		        SetPlayerInterior(i, 0);
		        SetPlayerVirtualWorld(i, 0);
				SetPlayerPos(i, 296.5143,-1807.7748,4.4312);
				SendClientMessage(i, COLOR_GOLD, "O Tempo do aluguel do balão acabou!");
			}
		}
	}
	return true;
}
