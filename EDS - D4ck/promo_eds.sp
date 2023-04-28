#include <promo_core>
#include <eds>

public Plugin myinfo =
{
	name		= "[PC] Items - EDS",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("eds_cash", GetEDS);
}

void GetEDS(int iClient, const char[] outcome)
{
	EDS_GiveBalance(iClient, StringToInt(outcome));
}