#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Registers an IED and starts countdown timer.
 * 
 * Arguments:
 * 0: The object <OBJECT>
 * 1: The ID of the task <STRING>
 * 2: The Countdown Timer <NUMBER>
 *
 * Return Value:
 * None
 * 
 * Example:
 * [this, "task1", 30] spawn SOG_defuse_fnc_makeIED
 * 
 * Public: Yes
 */

params [["_ied", objNull], ["_taskID", ""], "_time"];

// Check if IED is defined
if (isNull _ied) exitWith {
    [COMPONENT_STR, "ERROR", "IED is not found", true] call EFUNC(main,log)
};

// Check if taskID is defined
if (_taskID == "") exitWith {
    [COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)
};

// Assigns IED to taskID
SETVAR(_ied, GVAR(assignedTask), _taskID);

// Add IED to IED array
private _index = GVAR(allIEDs) pushBackUnique _ied;

// Log
[COMPONENT_STR, "DEBUG", format ["Object (%1) is registered as an IED. IED array: %2", _ied, str GVAR(allIEDs)]] call EFUNC(main,log);

if (_index == -1) then {
    [COMPONENT_STR, "WARNING", format ["Object (%1) is already an IED", _ied], true] call EFUNC(main,log);
};

// Countdown timer
while { (_time > 0) && alive _ied } do {
    _time = _time -1;
    uiSleep 1;

    hintSilent parseText format ["<t size='2' color='#ff0000' shadow='2'>%1</t>", _time];

    if (!alive _ied) exitWith {};

    if (_time > 10) then { _ied say3D "SOG_TimerBeep" };
    if (_time <= 10 && _time > 5) then { _ied say3D "SOG_TimerBeepShort" };
    if (_time <= 5) then { _ied say3D "SOG_TimerEnd" };
    if (_time <= 0) exitWith { _ied setDamage 1 }
};

hint "";