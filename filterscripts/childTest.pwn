#include a_samp

public OnRconCommand(cmd[])
{
    if(!strcmp(cmd, "cofre", true))
    {
        if(!IsPlayerConnected(0))
            return 0;

        new Float:hCoords[4];
    	GetPlayerPos(0, hCoords[0], hCoords[1],  hCoords[2]);
    	GetPlayerFacingAngle(0, hCoords[3]);

        CriarCofre(hCoords[0], hCoords[1],  hCoords[2], hCoords[3]);
    }
    return 0;
}

stock ChildObject2D(Float:X, Float:Y, Float:X2, Float:Y2, Float:R, &Float:XR, &Float:YR)
{
    //(((360.0 / 180.0) - 1.0) * R);

    R -= 180.0;
    XR = X + X2 * ((R * (R / 360.0)));
    YR = Y + Y2 * ((R * (R / 360.0)));
    return 1;
}

stock CriarCofre(Float:X, Float:Y, Float:Z, Float:R)
{
    new Float:XR, Float:YR;
    CreateObject(2003, X, Y, Z, 0.0, 0.0, R);

    ChildObject2D(X, Y, 0.0, -0.02, R, XR, YR);
    CreateObject(2005, XR, YR, Z - 0.0825, 0.0, 0.0, R);

    ChildObject2D(X, Y, -0.4, -0.335, R, XR, YR);
    new obj = CreateObject(2004, XR, YR, Z, 0.0, 0.0, R);

    /*new Float:P[3];
    GetObjectPos(o1, P[0], P[1], P[2]);
    printf("%f, %f, %f", P[0], P[1], P[2]);

    GetObjectPos(o2, P[0], P[1], P[2]);
    printf("%f, %f, %f", P[0], P[1], P[2]);*/

    //CreateObject(2005,0.0000000,-0.0200000,-0.0825000,0.0000000,0.0000000,0.0000000);
    //CreateObject(2004,-0.4000000,-0.3350000,0.0000000,0.0000000,0.0000000,0.0000000);
    //CreateObject(2004,-0.4000000,-0.3150000,0.0000000,0.0000000,0.0000000,270.0000000);
    return obj;
}
