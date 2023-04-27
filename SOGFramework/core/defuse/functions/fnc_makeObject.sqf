#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Registers an item as an object.
 *
 * Arguments:
 * 0: The object <OBJECT>
 * 1: The ID of the task <STRING>
 *
 * Return Value:
 * None
 * 
 * Example:
 * [this, "task1"] call SOG_defuse_fnc_makeObject
 * 
 * Public: Yes
 */

params [["_object", objNull], ["_taskID", ""]];

// Check if item is defined
if (isNull _object) exitWith {
    [COMPONENT_STR, "ERROR", "Item is not found", true] call EFUNC(main,log)
};

// Check if taskID is defined
if (_taskID == "") exitWith {
    [COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)
};

// Assign object to taskID
SETVAR(_object, GVAR(assignedTask), _taskID);

// Add object to object array
private _index = GVAR(allObjects) pushBackUnique _object;

// Log
[COMPONENT_STR, "DEBUG", format ["Item (%1) is registered as an object. Object array: %2", _object, str GVAR(allObjects)]] call EFUNC(main,log);

if (_index == -1) then {
    [COMPONENT_STR, "WARNING", format ["Item (%1) is already an object", _object], true] call EFUNC(main,log);
};