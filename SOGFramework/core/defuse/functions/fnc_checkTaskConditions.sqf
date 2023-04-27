#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Checks the defuse task conditions.
 * 
 * Arguments:
 * 0: ID of the PFH <SCALAR>
 * 1: Array of the objects linked to this task <ARRAY>
 * 2: Array of IEDs linked to this task <ARRAY>
 * 3: ID of the task <STRING>
 * 4: Number of objects destroyed to fail the task <NUMBER>
 * 5: Number of IEDs to defuse to complete the task <NUMBER>
 * 6: Should the mission end (MissionSuccess) if the task is successful <BOOL> (default: false)
 * 7: Should the mission end (MissionFailed) if the task is failed <BOOL> (default: false)
 *
 * Return Value:
 * Boolean of success <BOOL>
 * 
 * Example:
 * [2, [obj1, obj2, obj3], [ied1, ied2, ied3], "task1", 2, 3, true] call SOG_defuse_fnc_checkTaskConditions
 * 
 * Public: No
 */

if !(isServer) exitWith {};

params ["_handle", "_ieds", "_objects", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false]];

// Check the destroyed count
if ({ !alive _x } count _objects >= _limitFail) exitWith {
    [_taskID, "FAILED"] call BFUNC(taskSetState);

    // Stop PFH
    [_handle] call CFUNC(removePerFrameHandler);

    // End the mission if it was enabled
    if (_endFail) then {
        [QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
    };
};

// If the task is done, we don't check the ieds anymore to save performance
// However we still track the number of the objects
if (_taskID call BFUNC(taskState) == "SUCCEEDED") exitWith {};

// Check the success limit
if (EGVAR(main,defusedCount) >= _limitSuccess && { !alive _x } count _objects < _limitFail) then {
    [_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

    // Stop PFH
    [_handle] call CFUNC(removePerFrameHandler);

    // End the mission if it was enabled
    if (_endSuccess) then {
        [QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
    };
};