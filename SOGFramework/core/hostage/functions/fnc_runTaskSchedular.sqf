#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Checks the conditions of the hostage rescue task.

	Arguments:
	0: ARRAY - Array of the hostages linked to this task
	1: ARRAY - Array of shooters linked to this task
	2: STRING - ID of the task
	3: STRING - Marker name for the extraction zone
	4: SCALAR - Number of hostages KIA to fail the task
	5: SCALAR - Number of hostages rescued to complete the task
	6: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	7: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	8: ARRAY - Array of task type to select from (Optional, default: [false, false])
	9: SCALAR - Number of seconds before hostages die to fail the task (Required, default: 45)
	10: STRING - Marker name for the cbrn zone


	Example:
	// Default CBRN
	[[pow1, pow2], "t1", "mrk_extraction", 1, 2, false, false, [true, false], 45, "mrk_cbrn"] call MF_hostage_fnc_checkTaskConditions
	// Default Hostage
	[[pow1, pow2], "t1", "mrk_extraction", 1, 2, false, false, [false, true], 45] call MF_hostage_fnc_checkTaskConditions

	Returns:
	void
*/

if !(isServer) exitWith {};

params ["_hostages", "_shooters", "_taskID", "_extZone", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false], ["_type", [["_cbrn", false], ["_hostage", false]]], ["_time", 45], "_cbrnZone"];

private _nearPlayers = [];
private _cbrn = _this select 8 select 0;
private _hostage = _this select 8 select 1;

// Check if type CBRN
if (_cbrn) then {
	while { _time > 0 } do {
		// Check the death count
		if ({ !alive _x } count _hostages >= _limitFail) exitWith {
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

		// Check if captive
		if ({ !captive _x } count _hostages >= _limitSuccess) exitWith {
			// Check the success limit
			while { (({ alive _x } count _hostages) >= _limitSuccess) } do {
				uiSleep 1;

				if ({ _x inArea _extZone } count _hostages >= _limitSuccess) exitWith {
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
			"SmokeShellYellow" createVehicle getMarkerPos _cbrnZone;

			uiSleep 5;

			{
				if (captive _x) then {
					_x setDamage 0.9;
					_x playMove "acts_executionvictim_kill_end";

					uiSleep 2.75;

					_x setDamage 1;
				};
			} forEach _hostages;

			[_taskID, "FAILED"] call BFUNC(taskSetState);

			// End the mission if it was enabled
			if (_endFail) then {
				[QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
			};
		};
	};
};

// Check if type Hostage
if (_hostage) then {
	while { _time > 0 } do {
		// Check the death count
		if ({ !alive _x } count _hostages >= _limitFail) exitWith {
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

		// Check if captive
		if (({ !captive _x } count _hostages >= _limitSuccess) || (!isNil "_shooters") && ({ alive _x } count _shooters <= 0)) exitWith {
			// Check the success limit
			while { (({ alive _x } count _hostages) >= _limitSuccess) } do {
				uiSleep 1;

				if ({ _x inArea _extZone } count _hostages >= _limitSuccess) exitWith {
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
			{
				_x enableAIFeature ["MOVE", true];
				_x playMove ""
			} forEach _shooters;

			uiSleep 1;

			{ _x setCaptive false } forEach _hostages;

			uiSleep 5;

			[_taskID, "FAILED"] call BFUNC(taskSetState);

			// End the mission if it was enabled
			if (_endFail) then {
				[QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
			};
		};
	};
};