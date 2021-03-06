#include <sourcemod>
#include <colorvariables>

public Plugin myinfo = {
	name = "z4lab-hub",
	author = "totles",
	description = "z4lab hub [chat info, welcome message]",
	version = "1.0",
	url = "https://z4lab.com"
};

// general settings/stuff
bool g_bMessagesShown[MAXPLAYERS + 1];
static int numPrinted = 0;

ConVar g_Cvar_FirstAdvertDelay;
ConVar g_Cvar_AdvertDelay;
ConVar g_Cvar_ChatPrefix;

float AdvertDelay;
float FirstAdvertDelay;
char g_szChatPrefix[64];

public void OnPluginStart(){
	CreateCommands();

	LoadTranslations("z4lab.phrases");

	CreateConVars();

	HookEvent("player_spawn", Event_OnPlayerSpawn);
	CreateTimer (FirstAdvertDelay, z4labAdvert1);

}

public void OnMapStart(){
	for (int i = 1; i <= MaxClients; i++) {
		g_bMessagesShown[i] = false;
	}
}

void CreateCommands() {
	RegConsoleCmd("sm_z4lab", z4labMain, "[z4lab-hub] displays all z4lab commands");
	RegConsoleCmd("sm_rules", z4labRules, "[z4lab-hub] displays our community rules");
	RegConsoleCmd("sm_homepage", z4labHomepage, "[z4lab-hub] displays a link to our homepage");
	RegConsoleCmd("sm_website", z4labHomepage, "[z4lab-hub] displays a link to our homepage");
	RegConsoleCmd("sm_link", z4labHomepage, "[z4lab-hub] displays a link to our homepage");
	RegConsoleCmd("sm_manifesto", z4labManifesto, "[z4lab-hub] displays a link to our manifesto");
	RegConsoleCmd("sm_changelog", z4labChangelog, "[z4lab-hub] displays a link to our changes");
	RegConsoleCmd("sm_changes", z4labChangelog, "[z4lab-hub] displays a link to our changes");
	RegConsoleCmd("sm_giveaway", z4labGiveaway, "[z4lab-hub] more information for our giveaway");
	RegConsoleCmd("sm_howtosurf", z4labHowtosurf, "[z4lab-hub] shows a video on how to surf");
	RegConsoleCmd("sm_discord", z4labDiscord, "[z4lab-hub] displays our discord link");
	RegConsoleCmd("sm_teamspeak", z4labTeamspeak, "[z4lab-hub] displays our teamspeak information");
	RegConsoleCmd("sm_ts", z4labTeamspeak, "[z4lab-hub] displays our teamspeak information");
	RegConsoleCmd("sm_steamgroup", z4labSteamgroup, "[z4lab-hub] displays a link to our steam group");
	RegConsoleCmd("sm_steam", z4labSteamgroup, "[z4lab-hub] displays a link to our steam group");
	RegConsoleCmd("sm_skins", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
	RegConsoleCmd("sm_ws", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
	RegConsoleCmd("sm_gloves", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
	RegConsoleCmd("sm_glove", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
}

void CreateConVars() {

	g_Cvar_ChatPrefix = CreateConVar("z4lab_chat_prefix", "[{lightgreen}z4lab{default}] {gold}#{bluegrey}", "Chat prefix for our z4lab-hub plugin");
	g_Cvar_AdvertDelay = CreateConVar("z4lab_advert_delay", "80.0" , "Specifies the delay between our chat adverts", 0, true, 40.0, true, 120.0);
	g_Cvar_FirstAdvertDelay = CreateConVar("z4lab_first_advert_delay", "60.0" , "Specifies the delay between our chat adverts", 0, true, 20.0, true, 120.0);

	AutoExecConfig(true, "z4lab_hub");

	AdvertDelay = g_Cvar_AdvertDelay.FloatValue;
	FirstAdvertDelay = g_Cvar_FirstAdvertDelay.FloatValue;

	GetConVarString(g_Cvar_ChatPrefix, g_szChatPrefix, sizeof(g_szChatPrefix));

}

// chat advertisement
public Action z4labAdvert1(Handle timer) {
	CPrintToChatAll("%t", "z4labAd1", g_szChatPrefix);
	CreateTimer(AdvertDelay, z4labAdvert2);
	return Plugin_Continue;
}

public Action z4labAdvert2(Handle timer) {
	CPrintToChatAll("%t", "z4labAd2", g_szChatPrefix);
	CreateTimer(AdvertDelay, z4labAdvert3);
	return Plugin_Continue;
}

public Action z4labAdvert3(Handle timer) {
	CPrintToChatAll("%t", "z4labAd3", g_szChatPrefix);
	CreateTimer(AdvertDelay, z4labAdvert4);
	return Plugin_Continue;
}

public Action z4labAdvert4(Handle timer) {
	CPrintToChatAll("%t", "z4labAd4", g_szChatPrefix);
	CreateTimer(AdvertDelay, z4labAdvert1);
	return Plugin_Continue;
}

// chat commands/triggers
public Action z4labMain(int client, int args) {
	CPrintToChat(client, "%t", "z4labMain", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labHomepage(int client, int args) {
	CPrintToChat(client, "%t", "z4labHomepage", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labManifesto(int client, int args) {
	CPrintToChat(client, "%t", "z4labManifesto", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labChangelog(int client, int args) {
	CPrintToChat(client, "%t", "z4labChangelog", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labRules(int client, int args) {
	CPrintToChat(client, "%t", "z4labRules", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labGiveaway(int client, int args) {
	CPrintToChat(client, "%t", "z4labGiveaway", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labHowtosurf(int client, int args) {
	CPrintToChat(client, "%t", "z4labHowtosurf", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labDiscord(int client, int args) {
	CPrintToChat(client, "%t", "z4labDiscord", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labTeamspeak(int client, int args) {
	CPrintToChat(client, "%t", "z4labTeamspeak", g_szChatPrefix);
	return Plugin_Handled;
}

public Action z4labSteamgroup(int client, int args) {
	CPrintToChat(client, "%t", "z4labSteamgroup", g_szChatPrefix);
	return Plugin_Handled;
}

// show alert message for ws/skin plugin requests
public Action z4labSkins(int client, int args) {
	ClientCommand(client, "play error");
	CreateTimer(0.1, NoSkinsAlert, GetClientUserId(client), TIMER_REPEAT);
	return Plugin_Handled;
}

public Action NoSkinsAlert(Handle timer, any data) {
	int client = GetClientOfUserId(data);

	if (numPrinted >= 40) {
		numPrinted = 0;
		return Plugin_Stop;
	}

	PrintCenterText(client, "<font color='#bf616a'>NO NO NO</font> - this will never happen\ncheck out <font color='#d08770'>!manifesto</font> and\n<font color='#a3be8c'>https://z4lab.com/rules</font>");

	numPrinted++;

	return Plugin_Continue;
}

// welcome message
public void Event_OnPlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if (client == 0 || IsFakeClient(client)) return;
	CreateTimer(2.0, WelcomeMessageDelay, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
}

public Action WelcomeMessageDelay(Handle timer, any data) {
	int client = GetClientOfUserId(data);
	
	if (client == 0 || !IsPlayerAlive(client) || g_bMessagesShown[client]) return Plugin_Continue;

	PrintCenterText(client, "<font color='#88c0d0'>Welcome!</font> Check chat for commands\nMore info with <font color='#d08770'>!rules</font> or on\n<font color='#a3be8c'>https://z4lab.com/rules</font>");
	CPrintToChat(client, "%t", "z4labWelcome1", g_szChatPrefix, client);
	CPrintToChat(client, "%t", "z4labWelcome2", g_szChatPrefix, client);
	CPrintToChat(client, "%t", "z4labWelcome3", g_szChatPrefix, client);
	CPrintToChat(client, "%t", "z4labWelcome4", g_szChatPrefix, client);
	g_bMessagesShown[client] = true;
	
	return Plugin_Continue;
}

public void OnClientDisconnect(int client) {
	g_bMessagesShown[client] = false;
}