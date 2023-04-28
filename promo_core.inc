native void PC_RegItem(char[] sName, PCReward ItemTake);

typedef PCReward = function void (int iClient, const char[] outcome);

native bool PC_CoreIsLoad();

forward void PC_OnCoreLoaded();