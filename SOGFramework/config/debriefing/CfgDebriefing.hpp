/* ----------------------------------- COOP ENDINGS ----------------------------------- */

// Generic - Major Success
class MissionSuccess {
	title = "Mission Success";              // Closing shot - Main title
	subtitle = "default_subtitle";          // Closing shot - Short description
	description = "default_description";    // Debriefing - Summary of the mission
	pictureBackground = "";                 // Debriefing - 2:1 picture as background
	picture = "mil_end";                    // Closing shot - 1:1 icon in the middle of the screen
	pictureColor[] = {0, 0.8, 0, 1};        // Closing shot - Icon colour
};

// Generic - Minor success
class MinorSuccess {
	title = "Minor Success";
	subtitle = "default_subtitle";
	description = "default_description";
	pictureBackground = "";
	picture = "mil_flag";
	pictureColor[] = {0, 0.8, 0, 1};
};

// Generic - Minor fail
class MinorFail {
	title = "Minor Defeat";
	subtitle = "default_subtitle";
	description = "default_description";
	pictureBackground = "";
	picture = "mil_flag";
	pictureColor[] = {0.9, 0, 0, 1};
};

// Generic - Major Fail
class MissionFail {
	title = "Mission Failed";
	subtitle = "default_text";
	description = "default_text";
	pictureBackground = "";
	picture = "KIA";
	pictureColor[] = {0.6, 0.1, 0.2, 1};
};

// Player casualty
class PlayerCasLimit {
	title = "Mission Failed";
	subtitle = "You've suffered serious casualties";
	description = "Your unit suffered serious casualties. Better luck next time.";
	pictureBackground = "";
	picture = "KIA";
	pictureColor[] = {0.6, 0.1, 0.2, 1};
};

// Civilian casualty
class CivCasLimit {
	title = "Mission Failed";
	subtitle = "Civilian casualty limit reached";
	description = "The number of civilian casualties was too high. Watch your fire next time.";
	pictureBackground = "";
	picture = "KIA";
	pictureColor[] = {0.6, 0.1, 0.2, 1};
};


/* --------------------------- GAME MASTER ENDING --------------------------- */

// Game master
class MissionTerminated {
	title = "Mission Terminated";
	subtitle = "The mission was terminated by a game master";
	description = "Due to technical reasons the mission was terminated.";
	pictureBackground = "";
	picture = "mil_warning";
	pictureColor[] = {0.9, 0, 0, 1};
};


/* ----------------------------- CUSTOM ENDINGS ----------------------------- */