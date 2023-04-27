#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Registers an AI unit as a target.
 *
 * Arguments:
 * 0: The AI unit <OBJECT>
 * 1: The ID of the task <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, "task1"] call SOG_destroy_fnc_makeTarget
 *
 * Public: Yes
 */

params [["_unit", objNull], ["_taskID", ""]];

// Check if unit is defined
if (isNull _unit) exitWith {[COMPONENT_STR, "ERROR", "Unit is not found", true] call EFUNC(main,log)};

// Check if taskID is defined
if (_taskID == "") exitWith {[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)};

// Assign unit to taskID
SETVAR(_unit,GVAR(assignedTask),_taskID);

// Add unit to target array
private _index = GVAR(allTargets) pushBackUnique _unit;

// Log
[COMPONENT_STR, "DEBUG", format ["Unit (%1) is registered as a target. Target array: %2", _unit, str GVAR(allTargets)]] call EFUNC(main,log);

if (_index == -1) then {
    [COMPONENT_STR, "WARNING", format ["Unit (%1) is already a target", _unit], true] call EFUNC(main,log);
};