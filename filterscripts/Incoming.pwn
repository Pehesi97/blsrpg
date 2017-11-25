#include a_samp

enum iI
{
    IncomingIP[16],
    IncomingVezes,
    IncomingTempo
}
new IncomingConnection[iI];

public OnIncomingConnection(playerid, ip_address[], port)
{
    if(!strcmp(IncomingConnection[IncomingIP], ip_address, true) && IncomingConnection[IncomingTempo] > gettime()) {
        if(IncomingConnection[IncomingVezes] > 3) return BlockIpAddress(ip_address, 0), printf("ip %s bloqueado!", ip_address);
        IncomingConnection[IncomingVezes]++;
        return 1;
    }
    format(IncomingConnection[IncomingIP], 16, ip_address);
    IncomingConnection[IncomingVezes] = 0;
    IncomingConnection[IncomingTempo] = gettime()+2;
    return 1;
}
