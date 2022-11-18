#include "..\core\main\script_macros.hpp"  // DO NOT REMOVE

/* -------------------------------- MISSION PARAMETERS -------------------------------- */

// Debug mode
GVARMAIN(debugMode) = true;  // Debug mode for mission/framework development (turn it off before deploying the mission)


// End condition - Player casualty limit
GVARMAIN(modulePlayerCasualties) = false;  // Coop
EGVAR(end_conditions,playerCasLimit) = 75;  // Coop: Percentage of the max. allowed player casualty

// End condition - Civilian casualty limit
GVARMAIN(moduleCivilianCasualties) = false;  // Coop
EGVAR(end_conditions,civilianCasLimit) = 50;  // Percentage of the max. allowed civilian casualty


// End condition - Task limit
GVARMAIN(moduleTaskLimit) = false;  // Coop
EGVAR(end_conditions,taskLimit) = 2;  // Minimum number of completed tasks


/* --------------------------------- OPTIONAL MODULES --------------------------------- */

// ACRE
GVARMAIN(moduleACRE) = false;  // Coop
EGVAR(acre,useBabel) = false;  // TvT


// Attack
GVARMAIN(moduleAttack) = true;  // Coop


// Briefing
GVARMAIN(moduleBriefing) = false;  // Coop


// Defuse
GVARMAIN(moduleDefuse) = true;  // Coop


// Destroy
GVARMAIN(moduleDestroy) = true;  // Coop


// Hostage
GVARMAIN(moduleHostage) = true;  // Coop


// HVT
GVARMAIN(moduleHVT) = true;  // Coop


// Intel
GVARMAIN(moduleIntel) = false;  // Coop


// Intro text
GVARMAIN(moduleIntroText) = true;  // Coop
EGVAR(intro_text,title) = "TEST TITLE";  // Title
EGVAR(intro_text,date) = "TEST DATE";  // Date
EGVAR(intro_text,location) = "TEST LOCATION";  // Location
EGVAR(intro_text,delay) = 15;  // Delay after loading in


// TFAR
GVARMAIN(moduleTFAR) = false;  // Coop