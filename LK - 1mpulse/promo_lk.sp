#include <promo_core>
#include <shop>
#include <lk>

public Plugin myinfo =
{
	name		= "[PC] Items - LK",
	author		= "Pisex",
	version		= "1.0.0"
};

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	MarkNativeAsOptional("LK_AddClientCash");
	return APLRes_Success;
}

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("lk_cash", GetLKCash);
    PC_RegItem("lk_cashold", GetLKCashOld);
}

void GetLKCash(int iClient, const char[] outcome)
{
	LK_ChangeBalance(iClient, LK_Cash, LK_Add, StringToInt(outcome));
}

void GetLKCashOld(int iClient, const char[] outcome)
{
	LK_AddClientCash(iClient, StringToInt(outcome));
}