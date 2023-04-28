#include <promo_core>
#include <STB_API>

public Plugin myinfo =
{
	name		= "[PC] Items - STB",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("stb", GetSTBBalance);
}

void GetSTBBalance(int iClient, const char[] outcome)
{
	STB_ChangeBalance(iClient, STB_Add, StringToInt(outcome));
}