#include a_samp
#include sscanf2

public OnRconCommand(cmd[])
{
    new _cmd[16], info[64];
    if(sscanf(cmd, "s[16]S()[64]", _cmd, info))
        return 0;

    if(!strcmp(_cmd, "lerp", true))
    {
        new a, b, Float:at;
        if(sscanf(info, "ddf", a, b, at))
            return 0;

        new ms = GetTickCount();
        printf("lerp(%d, %d, %.1f) = %d | ms = %d", a, b, at, lerp(a, b, at), GetTickCount() - ms);
        return 1;
    }
    else if(!strcmp(_cmd, "floatlerp", true))
    {
        new Float:a, Float:b, Float:at;
        if(sscanf(info, "fff", a, b, at))
            return 0;

        new ms = GetTickCount();
        printf("floatlerp(%.1f, %.1f, %.1f) = %f | ms = %d", a, b, at, floatlerp(a, b, at), GetTickCount() - ms);
        return 1;
    }
    return 0;
}

/*forward Lerp(a, b, Float:at);
public Lerp(a, b, Float:at)
{
    if(at > 1.0)
        return b;
    else if(at < 0.0)
        return a;

    new d = b - a,
        Float:p = d * at,
        r = floatround(floatadd(a, p));
    return r;
}*/

/*forward Float:FloatLerp(Float:a, Float:b, Float:at);
public Float:FloatLerp(Float:a, Float:b, Float:at)
{
    if(at > 1.0)
        return b;
    else if(at < 0.0)
        return a;

    new Float:d = b - a,
        Float:p = d * at,
        Float:r = a + p;
    return r;
}  */

forward Float:floatlerp(Float:a, Float:b, Float:at);
public Float:floatlerp(Float:a, Float:b, Float:at)
    return floatadd(a, (b - a) * at);

stock lerp(a, b, Float:at)
    return floatround(floatlerp(a, b, at));
