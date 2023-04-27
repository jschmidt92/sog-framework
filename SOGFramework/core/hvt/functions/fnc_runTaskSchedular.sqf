#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Checks the conditions of the hvt task.

	Arguments:
	0: STRING - ID of the task
	1: STRING - Marker name for the extraction zone
	2: SCALAR - Number of hvts KIA or escaped to fail the task
	3: SCALAR - Number of hvts caputred or eliminated to complete the task
	4: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	5: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	6: ARRAY - Array of task types to select and set task to (Optional, default: [false, true])
	7: SCALAR - Number of seconds before hvts are killed (Required, default: 45)


	Example:
	// Default Capture
	[[hvt1, hvt2], "t1", "mrk_extraction", 1, 2, false, false, [true, false], 45] call SOG_hvt_fnc_checkTaskConditions
	// Default Eliminate
	[[hvt1, hvt2], "t1", "mrk_extraction", 1, 2, false, false, [false, true], 45] call SOG_hvt_fnc_checkTaskConditions

	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_hvts", "_taskID", "_extZone", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false], ["_type", [["_capture", false], ["_eliminate", true]]], ["_time", 45]];

private _capture = _this select 7 select 0;
private _eliminate = _this select 7 select 1;

// Check if type Capture
if (_capture) then {
	while { _time > 0 } do {
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

		_time = _time - 1;
		uiSleep 1;

		// Check if isHandcuffed
		if ({ captive _x } count _hvts >= _limitSuccess) exitWith {
			// Check the success limit
			while { (({ alive _x } count _hvts) >= _limitSuccess) } do {
				uiSleep 1;

				if ({ _x inArea _extZone } count _hvts >= _limitSuccess) exitWith {
					[_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

					// End the mission if it was enabled
					if (_endSuccess) then {
						[QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
					};
				};
			};
		};

		// Check if Time has exceeded
		if (_time <= 0) exitWith {
			[_taskID, "FAILED"] call BFUNC(taskSetState);

			// End the mission if it was enabled
			if (_endFail) then {
				[QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
			};

			// Delete hvts
			{ deleteVehicle _x } forEach _hvts;
		};
	};
};

// Check if type Eliminate
if (_eliminate) then {
	while { _time > 0 } do {
		_time = _time - 1;
		uiSleep 1;

		// Check the success limit
		if ({ !alive _x } count _hvts >= _limitSuccess) exitWith {
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

			// Remove hvts
			{ deleteVehicle _x } forEach _hvts;
		};
	};
};