#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt
	
	Description:
	Checks the conditions of the undercover task.
	
	Arguments:
	0: SCALAR - ID of the PFH
	1: ARRAY - Array of the undercover linked to this task
	2: STRING - ID of the task
	3: SCALAR - Number of undercover exposed to fail the task
	4: SCALAR - Number of undercover exfiled to complete the task
	6: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	7: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	8: BOOLEAN - Does the task have a time limit (Optional, default: false)
	5: TIME - Number of seconds before undercover exfil to fail the task (Optional, default: 45) ** timeLimit Must Be Enabled **
	
	
	Example:
	// Default No Time Limit
	[1, [undercover1, undercover2], "t1", 1, 2, false] call SOG_undercover_fnc_checkTaskConditions
	
	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_handle", "_undercover", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false], ["_timeLimit", false], "_time"];

// Check if time Limit
if (_timeLimit) then {
	while { _time > 0 } do {
		_time = _time - 1;
		uiSleep 1;

		// Check if time has exceeded and undercover KIA
		if (_time <= 0 && {
			alive _x
		} count _undercover >= _limitFail) exitWith {
			[_taskID, "FAILED"] call BFUNC(taskSetState);

			// Stop PFH
			[_handle] call CFUNC(removePerFrameHandler);

			// End the mission if it was enabled
			if (_endFail) then {
				[QEGVAR(end_mission,callMission), ["MissionFail", true, playerSide]] call CFUNC(serverEvent);
			};

			// Remove undercover
			{
				deleteVehicle _x
			} forEach _undercover;
		};

		// If the task is failed, we don't check the task anymore to save performance
		if (_taskID call BFUNC(taskState) == "FAILED") exitWith {};

		// Check the success limit
		if ({
			!alive _x
		} count _undercover >= _limitSuccess) exitWith {
			[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

			// End the mission if it was enabled
			if (_endSuccess) then {
				[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
			};
		};
	};
} else {
	// Check the success limit
	if ({
		!alive _x
	} count _undercover >= _limitSuccess) exitWith {
		[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

		// End the mission if it was enabled
		if (_endSuccess) then {
			[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
		};
	};
};