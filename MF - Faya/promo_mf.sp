#include <promo_core>
#include <mf>

public Plugin myinfo =
{
	name		= "[PC] Items - MF",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("mf_farm", GetMFFarm);
    PC_RegItem("mf_bitcoin", GetMFBitok);
}

void GetMFFarm(int iClient, const char[] outcome)
{
    char exp[2][64];
    ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
	MF_AddClientFarm(iClient, StringToInt(exp[0]), StringToInt(exp[1]));
}

void GetMFBitok(int iClient, const char[] outcome)
{
    MF_AddClientBitcoins(iClient, StringToInt(outcome));
}