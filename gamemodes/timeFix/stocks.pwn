stock GetTimeFix(&h, &m, &s)
{
    gettime(h, m, s);

    h += timeFixer;
    if(h > 23)
        h -= 24;
    if(h < 0)
        h += 24;

    //23 + 1 = 24, 24 - 24 = 0
    //0 - 1 = -1, -1 + 24 = 23
    return 1;
}
stock GetTimeFix2(&h)
{
    gettime(h);

    h += timeFixer;
    if(h > 23)
        h -= 24;
    if(h < 0)
        h += 24;

    //23 + 1 = 24, 24 - 24 = 0
    //0 - 1 = -1, -1 + 24 = 23
    return 1;
}