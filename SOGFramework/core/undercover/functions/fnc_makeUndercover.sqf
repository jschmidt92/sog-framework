#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt
	
	Description:
	Creates an AI unit and registers it as undercover.
	
	Arguments:
	0: OBJECT - The AI unit
	1: STRING - The ID of the task
	
	Example:
	[this, "task_name"] spawn SOG_undercover_fnc_makeUndercover
	
	Returns:
	void
*/

params [["_unit", objNull], ["_taskID", ""], ["_allowedGear", []], "_area"];

// Check stuff
if (isNull _unit) exitWith {
	[COMPONENT_STR, "ERROR", "Unit is not found", true] call EFUNC(main,log)
};
if (_taskID == "") exitWith {
	[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)
};

// Register undercover
SETVAR(_unit, GVAR(assignedTask), _taskID);
private _index = GVAR(allUndercover) pushBackUnique _unit;

// log
[COMPONENT_STR, "DEBUG", format [
	"Unit (%1) is registered as undercover. Undercover array: %2", _unit, str GVAR(allUndercover)
]] call EFUNC(main,log);

if (_index == -1) then {
	[COMPONENT_STR, "WARNING", format ["Unit (%1) is already undercover", _unit], true] call EFUNC(main,log);
};