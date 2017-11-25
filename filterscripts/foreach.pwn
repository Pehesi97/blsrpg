#include a_samp
#include sscanf2
#include foreach

new Iterator:Test<30>;

public OnRconCommand(cmd[])
{
    new _cmd[16], info[64];
    if(sscanf(cmd, "s[16]S()[64]", _cmd, info))
        return 0;

    if(!strcmp(_cmd, "test", true))
    {
		Iter_Add(Test, 5);
		print("1");
		Iter_Add(Test, 5);
		print("2");
		foreach(new i: Test)
			printf("%d", i);
        return 1;
    }
    return 0;
}
