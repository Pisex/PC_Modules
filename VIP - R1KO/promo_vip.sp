#include <promo_core>
#include <vip_core>

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
    PC_RegItem("vip_group", GetVIP);
}

void GetVIP(int iClient, const char[] outcome)
{
	char exp[2][32];
	ExplodeString(outcome, "|", exp, sizeof(exp), sizeof(exp[]));
	if(VIP_IsValidVIPGroup(exp[0]))
	{
		if(VIP_IsClientVIP(iClient))
		{
			DataPack data = new DataPack();
			data.WriteCell(GetClientUserId(iClient));
			data.WriteString(outcome);
			CreateTimer(0.4, TimerMenuConfirm, data, TIMER_DATA_HNDL_CLOSE|TIMER_FLAG_NO_MAPCHANGE);
            return;
		}

		VIP_RemoveClientVIP2(0, iClient, true, true);
		VIP_GiveClientVIP(0, iClient, StringToInt(exp[1]), exp[0]);
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

	VIP_GetClientVIPGroup(iClient, buff, sizeof(buff));
	menu.SetTitle("Внимание! Вы пытаетесь получить «%s»,\nпри этом уже имея «%s»\n \n%s\n ", exp[0], buff, VIP_GetClientAccessTime(iClient) && !strcmp(buff, exp[0], false) ? "Продлеваем текущую группу?" : "Меняем текущую группу на новую?");

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
				VIP_GetClientVIPGroup(iClient, buff, sizeof(buff));

				if(VIP_GetClientAccessTime(iClient) && !strcmp(buff, exp[0], false)) VIP_SetClientAccessTime(iClient, StringToInt(exp[2]) + VIP_GetClientAccessTime(iClient));
				else
				{
					VIP_RemoveClientVIP2(0, iClient, true, false);
					DataPack data = new DataPack();
					data.WriteCell(GetClientUserId(iClient));
					data.WriteCell(StringToInt(exp[1]));
					data.WriteString(exp[0]);
					CreateTimer(0.5, RequestFrameCallbackVIP, data, TIMER_DATA_HNDL_CLOSE|TIMER_FLAG_NO_MAPCHANGE);
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

Action RequestFrameCallbackVIP(Handle timer, DataPack data)
{
	data.Reset();
	int iClient = GetClientOfUserId(data.ReadCell());
	if(iClient)
	{
		char buff[128];
		int time = data.ReadCell();
		data.ReadString(buff, sizeof(buff));
		VIP_GiveClientVIP(0, iClient, time, buff);
	}
	return Plugin_Stop;
}