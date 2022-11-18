#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt
	
	Description:
	Take an item and register it as an object.
	
	Arguments:
	0: OBJECT - The object
	1: STRING - The ID of the task
	
	Example:
	[this, "task_name"] call SOG_defuse_fnc_makeObject
	
	Returns:
	void
*/

params [["_object", objNull], ["_taskID", ""]];

// Check stuff
if (isNull _object) exitWith {
	[COMPONENT_STR, "ERROR", "Item is not found", true] call EFUNC(main,log)
};
if (_taskID == "") exitWith {
	[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)
};

// Register object
SETVAR(_object, GVAR(assignedTask), _taskID);
private _index = GVAR(allObjects) pushBackUnique _object;

// log
[COMPONENT_STR, "DEBUG", format [
	"Item (%1) is registered as an object. Object array: %2", _object, str GVAR(allObjects)
]] call EFUNC(main,log);

if (_index == -1) then {
	[COMPONENT_STR, "WARNING", format ["Item (%1) is already an object", _object], true] call EFUNC(main,log);
};