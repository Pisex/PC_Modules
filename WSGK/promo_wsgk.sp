#include <promo_core>
#include <k1_wsgk>

public Plugin myinfo =
{
	name		= "[PC] Items - WSGK",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("wsgk_item", GetWSGKItem);
}

void GetWSGKItem(int iClient, const char[] outcome)
{
	char exp[3][32];
	ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
	WSGK_GiveClientItem (iClient, StringToInt(exp[0]), StringToInt(exp[1]), view_as<bool>(StringToInt(exp[2])));
}