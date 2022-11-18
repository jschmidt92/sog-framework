#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt
	
	Description:
	Checks the conditions of the Defuse task.
	
	Arguments:
	0: SCALAR - ID of the PFH
	1: ARRAY - Array of the objects linked to this task
	2: ARRAY - Array of IEDs linked to this task
	3: STRING - ID of the task
	4: SCALAR - Number of objects destroyed to fail the task
	5: SCALAR - Number of IEDs to defuse to complete the task
	6: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	7: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	
	Example:
	[2, [obj1, obj2, obj3], [ied1, ied2, ied3], 2, 3, true] call MF_defuse_fnc_checkTaskConditions
	
	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_handle", "_ieds", "_objects", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false]];

// Check the destroyed objects count
if ({ !alive _x } count _objects >= _limitFail) exitWith {
	[_taskID, "FAILED"] call BFUNC(taskSetState);

	// Stop PFH
	[_handle] call CFUNC(removePerFrameHandler);

	// End the mission if it was enabled
	if (_endFail) then {
		[QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
	};
};

// If the task is done, we don't check the ieds anymore to save performance
// However we still track the number of the objects
if (_taskID call BFUNC(taskState) == "SUCCEEDED") exitWith {};

// Check the success limit
if (EGVAR(main,defusedCount) >= _limitSuccess && { !alive _x } count _objects <= _limitFail) then {
	[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

	// Stop PFH
	[_handle] call CFUNC(removePerFrameHandler);

	// End the mission if it was enabled
	if (_endSuccess) then {
		[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
	};
};