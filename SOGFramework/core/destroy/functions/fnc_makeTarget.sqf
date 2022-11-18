#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Creates an AI unit and registers it as a target.

	Arguments:
	0: OBJECT - The AI unit
	1: STRING - The ID of the task

	Example:
	[this, "task_name"] call MF_destroy_fnc_makeTarget

	Returns:
	void
*/

params [["_unit", objNull], ["_taskID", ""]];

// Check stuff
if (isNull _unit) exitWith {[COMPONENT_STR, "ERROR", "Unit is not found", true] call EFUNC(main,log)};
if (_taskID == "") exitWith {[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)};

// Register target
SETVAR(_unit,GVAR(assignedTask),_taskID);
private _index = GVAR(allTargets) pushBackUnique _unit;

// Log
[COMPONENT_STR, "DEBUG", format [
	"Unit (%1) is registered as a target. Target array: %2", _unit, str GVAR(allTargets)
]] call EFUNC(main,log);

if (_index == -1) then {
	[COMPONENT_STR, "WARNING", format ["Unit (%1) is already a target", _unit], true] call EFUNC(main,log);
};