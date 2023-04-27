#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Checks the conditions of the hvt task.

	Arguments:
	0: SCALAR - ID of the PFH
	1: ARRAY - Array of the hvts linked to this task
	2: STRING - ID of the task
	3: STRING - Marker name for the extraction zone
	4: SCALAR - Number of hvts KIA to fail the task
	5: SCALAR - Number of captured hvts to complete the task
	6: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	7: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	8: ARRAY - Array of task type to select from (Required, default: [true, false])


	Example:
	// Capture No Time Limit
	[1, [hvt1, hvt2], "t1", "mrk_extraction", 1, 2, false, false, [true, false]] call SOG_hvt_fnc_checkTaskConditions

	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_handle", "_hvts", "_taskID", "_extZone", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false], ["_type", [["_capture", true], ["_eliminate", false]]]];

private _nearPlayers = [];
private _capture = _this select 8 select 0;
private _eliminate = _this select 8 select 1;

// Check if type Capture
if (_capture) then {
	// Check the death count
	if ({ !alive _x } count _hvts >= _limitFail) exitWith {
		[_taskID, "FAILED"] call BFUNC(taskSetState);

		// Stop PFH
		[_handle] call CFUNC(removePerFrameHandler);

		// End the mission if it was enabled
		if (_endFail) then {
			[QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
		};
	};

	// If the task is done, we don't check the zone anymore to save performance
	// However we still track the death of the hvts
	if (_taskID call BFUNC(taskState) == "SUCCEEDED") exitWith {};

	// Check the success limit
	if ({ _x inArea _extZone } count _hvts >= _limitSuccess) exitWith {
		[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

		// End the mission if it was enabled
		if (_endSuccess) then {
			[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
		};
	};
};

// Check if type Eliminate
if (_eliminate) then {
	// If the task is failed, we don't check the task anymore to save performance
	if (_taskID call BFUNC(taskState) == "FAILED") exitWith {};

	// Check the success limit
	if ({ !alive _x } count _hvts >= _limitSuccess) exitWith {
		[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

		// End the mission if it was enabled
		if (_endSuccess) then {
			[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
		};
	};
};