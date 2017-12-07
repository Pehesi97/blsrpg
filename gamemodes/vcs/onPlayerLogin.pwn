            new built = DOF2_GetInt(file, "GMBuilt");

            if(built < BUILT)
		    {
				if(built < 20171207)
				{
				    if(Pacote[playerid] != 0)
				    {
				        CompletarNonRepMilestone(playerid, 0);
				    }
				    if(Player[playerid][pJob] != DESEMPREGADO)
				    {
						CompletarNonRepMilestone(playerid, 1);
						CompletarNonRepMilestone(playerid, 2);
				    }
				    if(Player[playerid][pCarLic] == 1)
				    {
						CompletarNonRepMilestone(playerid, 3);
				    }
				    if(Player[playerid][pMember] != 0 || Player[playerid][pLeader] != 0)
				    {
						CompletarNonRepMilestone(playerid, 4);
				    }
				}

                SendClientMessage(playerid, 0xFFFF00FF, "[Update]: {FFFFFF}Sua conta foi atualizada de acordo com a nova versão do servidor.");
				DOF2_SetInt(file, "GMBuilt", BUILT);
                DOF2_SaveFile();
			}