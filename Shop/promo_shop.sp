#include <promo_core>
#include <shop>

public Plugin myinfo =
{
	name		= "[PC] Items - Shop",
	author		= "Pisex",
	version		= "1.0.0"
};

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	MarkNativeAsOptional("Shop_GiveClientGold");
	MarkNativeAsOptional("Shop_GiveClientCrystal");
	return APLRes_Success;
}

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("shop_credits", GetShopCredits);
    PC_RegItem("shop_gold", GetShopGold);
    PC_RegItem("shop_crystals", GetShopCrystal);
    PC_RegItem("shop_items", GetShopItems);
}

void GetShopCredits(int iClient, const char[] outcome)
{
    Shop_GiveClientCredits(iClient, StringToInt(outcome), IGNORE_FORWARD_HOOK);
}

void GetShopGold(int iClient, const char[] outcome)
{
    Shop_GiveClientGold(iClient, StringToInt(outcome), IGNORE_FORWARD_HOOK);
}

void GetShopCrystal(int iClient, const char[] outcome)
{
    Shop_GiveClientCrystal(iClient, StringToInt(outcome), IGNORE_FORWARD_HOOK);
}

void GetShopItems(int iClient, const char[] outcome)
{
    char exp[3][32];
	ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
	Shop_GiveClientItem(iClient, Shop_GetItemId(Shop_GetCategoryId(exp[0]), exp[1]), StringToInt(exp[2]));
}