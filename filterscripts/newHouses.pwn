#include a_samp
#include filemanager
#include DOF2

new lines[32][128];

public OnRconCommand(cmd[])
{
    if(!strcmp(cmd, "createhouses", true))
    {
        if(!dir_exists("./New Houses/"))
            dir_create("./Houses/");

        new File:file = f_open("./New Houses/New House.ini", "r"),
            i = 0;

        while(f_read(file, lines[i]))
        {
            strcat(lines[i], "\r\n");
            i++;
        }

        f_close(file);

        new from = 118, to = 180;
        new fileName[128];
        while(from != to)
        {
            format(fileName, 128, "./New Houses/%d.ini", from);
            file = f_open(fileName, "w");

            for(new x = 0; x < i; x++)
            {
                f_write(file, lines[x]);
            }

            f_close(file);

            from++;
        }
        return 1;
    }
    return 0;
}
