#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Checks the conditions of the destroy task.

	Arguments:
	0: ARRAY - Array of the targets linked to this task
	1: STRING - ID of the task
	2: SCALAR - Number of targets escaped to fail the task
	3: SCALAR - Number of targets destroyed to complete the task
	4: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	5: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	6: SCALAR - Number of seconds before targets escape to fail the task (Required, default: 45)


	Example:
	// Default Time Limit
	[[target1, target2], "t1", 1, 2, false, false, 45] call MF_destroy_fnc_checkTaskConditions

	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_targets", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false], ["_time", 45]];

while { _time > 0 } do {
	_time = _time - 1;
	uiSleep 1;

	// Check the success limit
	if ({ !alive _x } count _targets >= _limitSuccess) exitWith {
		[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

		// End the mission if it was enabled
		if (_endSuccess) then {
			[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
		};
	};

	// Check if Time has exceeded
	if (_time <= 0) exitWith {
		[_taskID, "FAILED"] call BFUNC(taskSetState);

		// End the mission if it was enabled
		if (_endFail) then {
			[QEGVAR(end_mission,callMission), ["MissionFail", true, playerSide]] call CFUNC(serverEvent);
		};

		// Remove targets
		{ deleteVehicle _x } forEach _targets;
	};
};