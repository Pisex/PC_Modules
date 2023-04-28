#include <promo_core>
#include <premium>

public Plugin myinfo =
{
	name		= "[PC] Items - Premium",
	author		= "Pisex",
	version		= "1.0.0"
};

public void OnPluginStart()
{
    if(PC_CoreIsLoad()) PC_OnCoreLoaded();
}

public void PC_OnCoreLoaded()
{
    PC_RegItem("premium_group", GetPremium);
}

void GetPremium(int iClient, const char[] outcome)
{
	char exp[2][32];
	ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
	if(Premium_IsValidGroup(exp[0]))
	{
		if(Premium_IsClientHaveAccess(iClient))
		{
			DataPack data = new DataPack();
			data.WriteCell(GetClientUserId(iClient));
			data.WriteString(outcome);
			CreateTimer(0.4, TimerMenuConfirm, data, TIMER_DATA_HNDL_CLOSE|TIMER_FLAG_NO_MAPCHANGE);
			return;
		}

		char sSteamID[32];
		GetClientAuthId(iClient, AuthId_Steam2, sSteamID, sizeof sSteamID);
		Premium_RemoveClientAccess(sSteamID, 0, "Give a new premium");
		Premium_GiveClientAccess(iClient, exp[0], StringToInt(exp[1]));
	}
	else LogError("Ошибка. Невалидная вип-группа.");
}

Action TimerMenuConfirm(Handle timer, DataPack data)
{
	data.Reset();
	int iClient = GetClientOfUserId(data.ReadCell());
	if(iClient)
	{
		char outcome[256];
		data.ReadString(outcome, sizeof(outcome));
		MenuConfirm(iClient, outcome).Display(iClient, MENU_TIME_FOREVER);
	}
	return Plugin_Stop;
}

Menu MenuConfirm(int iClient, const char[] outcome)
{
	char buff[128], exp[3][32];
	ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
	Menu menu = new Menu(HandlerOfMenuConfirm);
	menu.ExitButton = false;

	Premium_GetClientGroup(iClient, buff, sizeof(buff));
	menu.SetTitle("Внимание! Вы пытаетесь получить «%s»,\nпри этом уже имея «%s»\n \n%s\n ", exp[0], buff, Premium_GetClientExpires(iClient) && !strcmp(buff, exp[0], false) ? "Продлеваем текущую группу?" : "Меняем текущую группу на новую?");

	FormatEx(buff, sizeof(buff), "Согласен");
	menu.AddItem(outcome, buff);

	FormatEx(buff, sizeof(buff), "Откажусь");
	menu.AddItem("", buff);

	return menu;
}

int HandlerOfMenuConfirm(Menu menu, MenuAction action, int iClient, int item)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			char outcome[128], exp[3][32];
			menu.GetItem(item, outcome, sizeof(outcome));
			ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));

			if(exp[0][0])
			{
				char buff[128];
				Premium_GetClientGroup(iClient, buff, sizeof(buff));

				if(Premium_GetClientExpires(iClient) && !strcmp(buff, exp[0], false))
				{
					char sSteamID[32];
					GetClientAuthId(iClient, AuthId_Steam2, sSteamID, sizeof sSteamID);
					Premium_RemoveClientAccess(sSteamID, 0, "Adding Access time");
					Premium_GiveClientAccess(iClient, exp[0], 0, (StringToInt(exp[2]) + Premium_GetClientExpires(iClient)) - GetTime());
				}
				else
				{
					char sSteamID[32];
					GetClientAuthId(iClient, AuthId_Steam2, sSteamID, sizeof sSteamID);
					Premium_RemoveClientAccess(sSteamID, 0, "Give a new premium");
					DataPack data = new DataPack();
					data.WriteCell(GetClientUserId(iClient));
					data.WriteCell(StringToInt(exp[1]));
					data.WriteString(exp[0]);
					CreateTimer(0.5, RequestFrameCallbackPremium, data, TIMER_DATA_HNDL_CLOSE|TIMER_FLAG_NO_MAPCHANGE);
				}
			}
		}

		case MenuAction_End:
		{
			delete menu;
		}
	}
	return 0;
}

Action RequestFrameCallbackPremium(Handle timer, DataPack data)
{
	data.Reset();
	int iClient = GetClientOfUserId(data.ReadCell());
	if(iClient)
	{
		char buff[128];
		int time = data.ReadCell();
		data.ReadString(buff, sizeof(buff));
		Premium_GiveClientAccess(iClient, buff, time);
	}
	return Plugin_Stop;
}