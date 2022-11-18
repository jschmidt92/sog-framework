#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt

	Description:
	Creates an AI unit and registers it as a shooter.

	Arguments:
	0: OBJECT - The AI unit
	1: STRING - The ID of the task

	Example:
	[this, "task_name"] call MF_hostage_fnc_makeShooter

	Returns:
	void
*/

params [["_unit", objNull], ["_taskID", ""]];

// Check stuff
if (isNull _unit) exitWith {[COMPONENT_STR, "ERROR", "Unit is not found", true] call EFUNC(main,log)};
if (_taskID == "") exitWith {[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)};

// Animation Loop
if (alive _unit) then {
	_unit enableAIFeature ["MOVE", false];
	_unit playMove "AidlPercMstpSrasWrflDnon_G01";
};

// Register hostage
SETVAR(_unit,GVAR(assignedTask),_taskID);
private _index = GVAR(allShooters) pushBackUnique _unit;

// Log
[COMPONENT_STR, "DEBUG", format [
	"Unit (%1) is registered as a shooter. Shooter array: %2", _unit, str GVAR(allShooters)
]] call EFUNC(main,log);

if (_index == -1) then {
	[COMPONENT_STR, "WARNING", format ["Unit (%1) is already a shooter", _unit], true] call EFUNC(main,log);
};