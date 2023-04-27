#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Creates an AI unit and registers it as a hostage/POW.

	Arguments:
	0: OBJECT - The AI unit
	1: STRING - The ID of the task

	Example:
	[this, "task_name"] spawn SOG_hostage_fnc_makeHostage

	Returns:
	void
*/

params [["_unit", objNull], ["_taskID", ""]];

private _nearPlayers = [];

// Check stuff
if (isNull _unit) exitWith {[COMPONENT_STR, "ERROR", "Unit is not found", true] call EFUNC(main,log)};
if (_taskID == "") exitWith {[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)};

// Register hostage
SETVAR(_unit,GVAR(assignedTask),_taskID);
private _index = GVAR(allHostages) pushBackUnique _unit;

// Log
[COMPONENT_STR, "DEBUG", format [
	"Unit (%1) is registered as a hostage. Hostage array: %2", _unit, str GVAR(allHostages)
]] call EFUNC(main,log);

if (_index == -1) then {
	[COMPONENT_STR, "WARNING", format ["Unit (%1) is already a hostage", _unit], true] call EFUNC(main,log);
};

// Animation Loop
if (alive _unit) then {
	_unit setCaptive true;
	_unit enableAIFeature ["MOVE", false];
	_unit playMove "acts_executionvictim_loop";

	waitUntil {
		sleep 1;
		_nearPlayers = allPlayers inAreaArray [ASLtoAGL getPosASL _unit, 2, 2, 0, false, 2];
		count _nearPlayers > 0
	};

	private _nearPlayer = _nearPlayers select 0;

	[_unit] joinSilent (group _nearPlayer);

	_unit setCaptive false;
	_unit enableAIFeature ["MOVE", true];
	_unit playMove "acts_executionvictim_unbow";
};