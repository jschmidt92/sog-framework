#include "script_component.hpp"

/*
	Author:
	Malbryn
	J. Schmidt
	
	Description:
	Registers a task as a defuse type of task.
	
	Arguments:
	0: STRING - ID of the task
	1: SCALAR - Number of objects destroyed to fail the task
	2: SCALAR - Number of ieds defused to complete the task
	3: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
	4: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
	
	Example:
	["task_name", 2, 3, false] call SOG_defuse_fnc_registerDiffuseTask
	
	Returns:
	void
*/

if !(isServer) exitWith {};

params [["_taskID", ""], ["_limitFail", -1], ["_limitSuccess", -1], ["_endSuccess", false], ["_endFail", false]];

// Add a PFH to each task
// Delay the PFH until mission start so every ied is initialised
[QGVARMAIN(initFramework), {
	_thisArgs params ["_taskID", "_limitFail", "_limitSuccess", "_endSuccess", "_endFail"];

	// Check stuff
	if !([_taskID] call BFUNC(taskExists)) then {
		[COMPONENT_STR, "DEBUG", format ["Task (%1) does not exist", _taskID], true, 0] call EFUNC(main,log);
	};

	if (_limitFail > count GVAR(allObjects)) then {
		[COMPONENT_STR, "WARNING", format [
			"Required number of objects to survive (set to %1) is higher than the object count (current: %2)", _limitFail, count GVAR(allObjects)
		], true, 0] call EFUNC(main,log);
	};

	if (_limitSuccess > count GVAR(allIEDs)) then {
		[COMPONENT_STR, "WARNING", format [
			"Required number of IEDs to defuse (set to %1) is higher than the ied count (current: %2)", _limitSuccess, count GVAR(allIEDs)
		], true, 0] call EFUNC(main,log);
	};

	// Get the ieds
	private _ieds = GVAR(allIEDs) select {
		GETVAR(_x, GVAR(assignedTask), "") == _taskID
	};

	// Get the objects
	private _objects = GVAR(allObjects) select {
		GETVAR(_x, GVAR(assignedTask), "") == _taskID
	};

	// PFH
	private _handle = [{
		_this#0 params ["_ieds", "_objects", "_taskID", "_limitFail", "_limitSuccess", "_endSuccess", "_endFail"];
		_this#1 params ["_handle"];

		// Check function
		[_handle, _ieds, _objects, _taskID, _limitFail, _limitSuccess, _endSuccess, _endFail] call FUNC(checkTaskConditions);
	}, 3, [_ieds, _objects, _taskID, _limitFail, _limitSuccess, _endSuccess, _endFail]] call CFUNC(addPerFrameHandler);
}, [_taskID, _limitFail, _limitSuccess, _endSuccess, _endFail]] call CFUNC(addEventHandlerArgs);