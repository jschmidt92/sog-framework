#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt
	
	Description:
	Start Countdown Timer, take an object and register it as an IED.
	
	Arguments:
	0: OBJECT - The object
	1: STRING - The ID of the task
	2: SCALAR - The Countdown Timer
	
	Example:
	[this, "task_name", 30] spawn SOG_defuse_fnc_makeIED
	
	Returns:
	void
*/

params [["_ied", objNull], ["_taskID", ""], "_time"];

// Check stuff
if (isNull _ied) exitWith {
	[COMPONENT_STR, "ERROR", "IED is not found", true] call EFUNC(main,log)
};
if (_taskID == "") exitWith {
	[COMPONENT_STR, "ERROR", "Task ID is empty", true] call EFUNC(main,log)
};

// Register IED
SETVAR(_ied, GVAR(assignedTask), _taskID);
private _index = GVAR(allIEDs) pushBackUnique _ied;

// log
[COMPONENT_STR, "DEBUG", format [
	"Object (%1) is registered as an IED. IED array: %2", _ied, str GVAR(allIEDs)
]] call EFUNC(main,log);

if (_index == -1) then {
	[COMPONENT_STR, "WARNING", format ["Object (%1) is already an IED", _ied], true] call EFUNC(main,log);
};

// Countdown Timer
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