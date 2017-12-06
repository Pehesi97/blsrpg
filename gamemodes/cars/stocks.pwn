forward IsABoat(carid);
public IsABoat(carid)
{
	if(carid==430||carid==446||carid==452||carid==453||carid==454||carid==472||carid==473||carid==484||carid==493)
	{
		return true;
	}
	return 0;
}

forward IsABike(carid);
public IsABike(carid)
{
	if(carid==522||carid==521||carid==468||carid==448||carid==581||carid==461||carid==463||carid==586||carid==523||carid==462||carid==510)
	{
		return true;
	}
	return 0;
}

// Reescrever
stock IsAConceCar(carid)
{
	
	for(new i = 0; i < sizeof(ConceCars); i++)
	{
	    if(carid == ConceCars[i][vID])
	    {
	        return true;
	    }
	}
	return false;
}

stock IsABicicle(carid)
{
	if(carid == 509 || carid == 510 || carid == 481) return true;
	return false;
}

forward IsATaxi(carid);
public IsATaxi(carid)
{
    for(new i = 0; i < sizeof(Taxi); i++)
        if(carid == Taxi[i])
            return true;

	/*if(carid==420||carid==438||carid==586)
	{
		return true;
	}*/
	return false;
}

forward IsAAereo(carid);
public IsAAereo(carid)
{
	if(carid==Aereo[0]||carid==Aereo[1])
	{
		return true;
	}
	return 0;
}

forward IsAPlane(carid);
public IsAPlane(carid)
{
	if(carid==417||carid==425||carid==447||carid==460||carid==464||carid==465||carid==469||carid==476||carid==487||carid==488||carid==497||
	carid==501||carid==511||carid==513||carid==512||carid==519||carid==520||carid==548||carid==553||carid==563||carid==477||carid==592||carid==593)
	{
		return true;
	}
	return 0;
}

forward IsACopCar(carid);
public IsACopCar(carid)
{
	if(carid==426||carid==427||carid==461||carid==470||carid==490||carid==497||carid==521
	||carid==523||carid==541||carid==528||carid==581||carid==596||carid==597||carid==598
	||carid==599||carid==601||carid==602)
	{
		return true;
	}
	return 0;
}

forward IsACaminhao(carid);
public IsACaminhao(carid)
{
	if(carid==403||carid==514||carid==515)
	{
		return true;
	}
	return 0;
}

forward IsAOnibus(carid);
public IsAOnibus(carid)
{
	for(new i=0; i<11; i++)
	    if(carid == Onibus[i])
	        return true;
	return false;
}

forward IsAPizzabike(carid);
public IsAPizzabike(carid)
{
	if(carid==448)
	{
		return true;
	}
	return 0;
}

forward IsATruck(carid);
public IsATruck(carid)
{
	if(carid==456||carid==499)
	{
		return true;
	}
	return 0;
}

stock IsATruckEx(carid)
{
	if(carid == CaminhaoCarga[0] || carid == CaminhaoCarga[1] || carid == CaminhaoCarga[2] || carid == CaminhaoCarga[3] || carid == CaminhaoCarga[4] || carid == CaminhaoCarga[5] || carid == CaminhaoCarga[6] || carid == CaminhaoCarga[7]
	|| carid == CaminhaoCarga[8] || carid == CaminhaoCarga[9] || carid == CaminhaoCarga[10] || carid == CaminhaoCarga[11] || carid == CaminhaoCarga[12] || carid == CaminhaoCarga[13] || carid == CaminhaoCarga[14])
	return false;
}

stock IsAnTransportVehicle(carid)
{
	if(carid >= VeiculosMateriais[0] && carid <= VeiculosMateriais[sizeof(VeiculosMateriais) - 1]) return true;
	return false;
}

stock TransportVehicle(carid)
{
/*	for(new v = 0; v < sizeof(VeiculosMateriais); v++)
	{
	    if(carid == VeiculosMateriais[v]) return v;
	}*/
	if(carid == VeiculosMateriais[0]) return 0;
	else if(carid == VeiculosMateriais[1]) return 1;
	else if(carid == VeiculosMateriais[2]) return 2;
	else if(carid == VeiculosMateriais[3]) return 3;
	return INVALID_VEHICLE_ID;
}