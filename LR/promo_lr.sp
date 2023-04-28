#include <promo_core>
#include <lvl_ranks>

public Plugin myinfo =
{
	name		= "[PC] Items - LR",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("lr_exp", GetPoints);
}

void GetPoints(int iClient, const char[] outcome)
{
	LR_ChangeClientValue(iClient, StringToInt(outcome));
}