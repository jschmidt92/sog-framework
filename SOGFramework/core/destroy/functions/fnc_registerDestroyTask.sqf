#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Registers a destroy task.
 *
 * Arguments:
 * 0: ID of the task <STRING>
 * 1: Number of targets escaped to fail the task <NUMBER>
 * 2: Number of targets destroyed to complete the task <NUMBER>
 * 3: Should the mission end (MissionSuccess) if the task is successful <BOOL> (default: false)
 * 4: Should the mission end (MissionFailed) if the task is failed <BOOL> (default: false)
 * 5: Number of seconds before targets escape <NUMBER> (default: nil)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["task1", 1, 2, false] call SOG_destroy_fnc_registerDestroyTask
 * ["task1", 1, 2, false, false, 45] call SOG_destroy_fnc_registerDestroyTask
 *
 * Public: Yes
 */

if !(isServer) exitWith {};

params [["_taskID", ""], ["_limitFail", -1], ["_limitSuccess", -1], ["_endSuccess", false], ["_endFail", false], "_time"];

if (!isNil "_time") then {
    // Add a EH to each task
    // Delay the EH until mission start so every target is initialised
    [QGVARMAIN(initFramework), {
        _thisArgs params ["_taskID", "_limitFail", "_limitSuccess", "_endSuccess", "_endFail", "_time"];

        // Check if taskID is defined
        if !([_taskID] call BFUNC(taskExists)) then {
            [COMPONENT_STR, "DEBUG", format ["Task (%1) does not exist", _taskID], true, 0] call EFUNC(main,log);
        };

        // Check if number of targets to destroy equal target count
        if (_limitSuccess > count GVAR(allTargets)) then {
            [COMPONENT_STR, "WARNING", format ["Required number of targets to destroy (set to %1) is higher than the target count (current: %2)", _limitSuccess, count GVAR(allTargets)], true, 0] call EFUNC(main,log);
        };

        // Get the targets assigned to taskID
        private _targets = GVAR(allTargets) select {GETVAR(_x,GVAR(assignedTask),"") == _taskID};

        // Spawn function to check task conditions
        [_targets, _taskID, _limitFail, _limitSuccess, _endSuccess, _endFail, _time] spawn FUNC(runTaskSchedular);
    }, [_taskID, _limitFail, _limitSuccess, _endSuccess, _endFail, _time]] call CFUNC(addEventHandlerArgs);
} else {
    // Add a PFH to each task
    // Delay the PFH until mission start so every target is initialised
    [QGVARMAIN(initFramework), {
        _thisArgs params ["_taskID", "_limitFail", "_limitSuccess", "_endSuccess", "_endFail"];

        // Check if taskID is defined
        if !([_taskID] call BFUNC(taskExists)) then {
            [COMPONENT_STR, "DEBUG", format ["Task (%1) does not exist", _taskID], true, 0] call EFUNC(main,log);
        };

        // Check if number of targets to destroy equal target count
        if (_limitSuccess > count GVAR(allTargets)) then {
            [COMPONENT_STR, "WARNING", format ["Required number of targets to destroy (set to %1) is higher than the target count (current: %2)", _limitSuccess, count GVAR(allTargets)], true, 0] call EFUNC(main,log);
        };

        // Get the targets assigned to taskID
        private _targets = GVAR(allTargets) select {GETVAR(_x,GVAR(assignedTask),"") == _taskID};

        // PFH
        private _handle = [{
            _this#0 params ["_targets", "_taskID", "_limitFail", "_limitSuccess", "_endSuccess", "_endFail"];
            _this#1 params ["_handle"];

            // Call function to check task conditions
            [_handle, _targets, _taskID, _limitFail, _limitSuccess, _endSuccess, _endFail] call FUNC(checkTaskConditions);
        }, 60, [_targets, _taskID, _limitFail, _limitSuccess, _endSuccess, _endFail]] call CFUNC(addPerFrameHandler);
    }, [_taskID, _limitFail, _limitSuccess, _endSuccess, _endFail]] call CFUNC(addEventHandlerArgs);
};