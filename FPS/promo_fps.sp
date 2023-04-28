#include <promo_core>
#include <FirePlayersStats>

public Plugin myinfo =
{
	name		= "[PC] Items - FPS",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("fps_points", GetPoints);
}

void GetPoints(int iClient, const char[] outcome)
{
	FPS_SetPoints(iClient, StringToFloat(outcome));
}