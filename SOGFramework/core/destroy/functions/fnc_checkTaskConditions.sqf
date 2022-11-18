#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Checks the conditions of the destroy task.

	Arguments:
	0: SCALAR - ID of the PFH
	1: ARRAY - Array of the targets linked to this task
	2: STRING - ID of the task
	3: SCALAR - Number of targets escaped to fail the task
	4: SCALAR - Number of targets destroyed to complete the task
	5: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	6: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)


	Example:
	// Default No Time Limit
	[1, [target1, target2], "t1", 1, 2, false] call MF_destroy_fnc_checkTaskConditions

	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_handle", "_targets", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false]];

// Check the success limit
if ({ !alive _x } count _targets >= _limitSuccess) exitWith {
	[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

	// End the mission if it was enabled
	if (_endSuccess) then {
		[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
	};
};