#include <promo_core>
#include <uBP>

public Plugin myinfo =
{
	name		= "[PC] Items - uBP",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("bp_access", GetBPA);
    PC_RegItem("bp_exp", GetBPExp);
    PC_RegItem("bp_star", GetBPStar);
}

void GetBPA(int iClient, const char[] outcome)
{
	uBP_SetPass(iClient, true);
}

void GetBPExp(int iClient, const char[] outcome)
{
	uBP_SetXP(iClient, uBP_GetXP(iClient) + StringToInt(outcome));
}

void GetBPStar(int iClient, const char[] outcome)
{
	uBP_SetPoints(iClient, uBP_GetPoints(iClient) + StringToInt(outcome));
}