// The UID of the mission maker (to access the admin menu and debug console during the mission)
#define UID ""  // Admin's UID

// VCOM AI
#define VCOMAI  // Comment out this line if you don't want to load VCOM AI

// Mission parameters
class Header {
	gameType =  Coop;  // Game type (use 'Coop' for PvE and 'TDM' for TvT)
	minPlayers =  1;  // Minimum number of players
	maxPlayers = 32;  // Maximum number of players
};

// Mission selection screen
briefingName = "[CO-12] SOG Feat Showcase Test";  // Mission name on the mission selection screen (use [CO-XX] or [TVT-XX] where XX is the max. player number)
overviewText = "SOG Feat Showcase Testing";  // Mission info on the mission selection screen (e.g. mission assets, factions, time limit etc.)

// Loading screen settings
onLoadName = "SOG Feat Showcase Test";  // Name of the operation on the loading screen (you can drop the [CO-XX] part here)
onLoadMission = "SOG Feat Showcase Testing";  // Mission description on the loading screen
author = "J. Schmidt";  // Author of the mission
loadScreen = "SOGFramework\config\img\loading_screen.jpg";  // Loading screen image (use 2:1 image ratio)