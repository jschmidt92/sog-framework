#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Checks the destroy task conditions.
 *
 * Arguments:
 * 0: ID of the PFH <SCALAR>
 * 1: Array of the targets linked to this task <ARRAY>
 * 2: ID of the task <STRING>
 * 3: Number of targets escaped to fail the task <NUMBER>
 * 4: Number of targets destroyed to complete the task <NUMBER>
 * 5: Should the mission end (MissionSuccess) if the task is successful <BOOL> (default: false)
 * 6: Should the mission end (MissionFailed) if the task is failed <BOOL> (default: false)
 *
 * Return Value:
 * Boolean of success <BOOL>
 *
 * Example:
 * [1, [target1, target2], "task1", 1, 2, false] call SOG_destroy_fnc_checkTaskConditions
 *
 * Public: No
 */

if !(isServer) exitWith {};

params ["_handle", "_targets", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false]];

// Check the success limit
if ({ !alive _x } count _targets >= _limitSuccess) exitWith {
    [_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

    // End the mission if it was enabled
    if (_endSuccess) then {
        [QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
    };
};