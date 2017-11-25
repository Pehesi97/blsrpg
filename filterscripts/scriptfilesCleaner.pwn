#include a_samp
#include filemanager
#include DOF2

new pcis[3][4096][64],
    nicks[3][4096][32],
    bool:fakes[3][4096],
    lastUsedPCI;

stock GetPCIVarIndex(id, &pciFirst, &pciSecond)
{
    pciFirst = id / 4096;
    pciSecond = id - (pciFirst * 4096);

    //printf("%d = %d, %d", id, pciFirst, pciSecond);
    return 1;
}

stock SetPCIInVar(id, pci[])
{
    new pciFirst, pciSecond;
    GetPCIVarIndex(id, pciFirst, pciSecond);

    format(pcis[pciFirst][pciSecond], 64, "%s", pci);
    return 1;
}

stock SetNickInVar(id, nick[])
{
    new pciFirst, pciSecond;
    GetPCIVarIndex(id, pciFirst, pciSecond);

    format(nicks[pciFirst][pciSecond], 64, "%s", nick);
    return 1;
}

stock IsPCIIgual(x, y)
{
    new x1, x2, y1, y2;
    GetPCIVarIndex(x, x1, x2);
    GetPCIVarIndex(y, y1, y2);

    if(!strcmp(pcis[x1][x2], pcis[y1][y2]))
        return true;
    return false;
}

public OnRconCommand(cmd[])
{
    if(!strcmp(cmd, "checkscriptfiles", true))
    {
        if(!dir_exists("./oldaccs/"))
        {
            dir_create("./oldaccs/");
            dir_create("./oldaccs/lowlvl/");
            dir_create("./oldaccs/lowpd/");
            dir_create("./oldaccs/fakes/");
            file_create("./oldaccs/admins.txt");
            file_create("./oldaccs/enigmas.txt");
        }

        //new dir:dHandle = dir_open("/scriptfiles/RPG/users/");
        new dir:dHandle = dir_open("./scriptfiles/RPG/users/");
        if(!dHandle)
        {
            print("Directory not Found");
            return 1;
        }

        new item[64], type, filename[128], lvl, pds, adm, itemid, newfilename[128], File: file;

        file = f_open("./oldaccs/admins.txt", "a");
        f_write(file, "\r\n---\r\n");
        f_close(file);
        file = f_open("./oldaccs/enigmas.txt", "a");
        f_write(file, "\r\n---\r\n");
        f_close(file);

        while(dir_list(dHandle, item, type))
        {
            if(type == FM_FILE)
            {
                itemid++;
                //printf("%s", item);
                format(filename, 128, "/RPG/users/%s", item);

                adm = DOF2_GetInt(filename, "AdminLevel");
                if(adm != 0)
                {
                    file = f_open("./oldaccs/admins.txt", "a");

                    format(newfilename, 128, "%s = Admin %d\r\n", item, adm);
                    f_write(file, newfilename);
                    f_close(file);
                }
                else
                {
                    adm = DOF2_GetInt(filename, "Enigma");
                    if(adm != 0)
                    {
                        file = f_open("./oldaccs/enigmas.txt", "a");

                        format(newfilename, 128, "%s = Enigma %d\r\n", item, adm);
                        f_write(file, newfilename);
                        f_close(file);
                    }
                }

                SetPCIInVar(itemid, DOF2_GetString(filename, "PciDeRegistro"));
                SetNickInVar(itemid, item);

                lvl = DOF2_GetInt(filename, "Level");
                if(lvl < 3)
                {
                    //printf("%d: %s, level %d.", itemid, item, lvl);
                    format(filename, 128, "./scriptfiles/RPG/users/%s", item);
                    format(newfilename, 128, "./oldaccs/lowlvl/%s", item);
                    file_move(filename, newfilename);
                }
                else
                {
                    pds = DOF2_GetInt(filename, "PayDayHad");
                    if(pds < 3)
                    {
                        format(filename, 128, "./scriptfiles/RPG/users/%s", item);
                        format(newfilename, 128, "./oldaccs/lowpd/%s", item);
                        file_move(filename, newfilename);
                    }
                }
            }
            else if(type == FM_DIR)
                continue;
        }

        lastUsedPCI = itemid;
        dir_close(dHandle);
        printf("%d files found", itemid);
        return 1;
    }
    else if(!strcmp(cmd, "checkfakes", true))
    {
        new File: file,
            str[64],
            strBig[128],
            totalFakes;
        new pciFirst, pciSecond;
        for(new x = 0; x < lastUsedPCI; x++)
        {
            for(new y = 0; y < lastUsedPCI; y++)
            {
                if(IsPCIIgual(x, y))
                {
                    if(x == y)
                        continue;

                    GetPCIVarIndex(y, pciFirst, pciSecond);
                    if(fakes[pciFirst][pciSecond])
                        continue;

                    format(strBig, 128, "./oldaccs/fakes/%s.txt", pcis[pciFirst][pciSecond]);
                    if(!file_exists(strBig))
                        file_create(strBig);

                    file = f_open(strBig, "a");

                    format(str, 64, "%s\r\n", nicks[pciFirst][pciSecond]);
                    f_write(file, str);
                    fakes[pciFirst][pciSecond] = true;
                    
                    GetPCIVarIndex(x, pciFirst, pciSecond);
                    if(!fakes[pciFirst][pciSecond])
                    {
	                    format(str, 64, "%s\r\n", nicks[pciFirst][pciSecond]);
	                    f_write(file, str);
	                    fakes[pciFirst][pciSecond] = true;
                    }
                    
                    
                    f_close(file);
                    totalFakes++;
                }
            }
        }
        printf("%d fakes found", totalFakes);
        return 1;
    }
    return 0;
}
