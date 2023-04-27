#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Checks the attack task conditions.
 *
 * Arguments:
 * 0: Array of the targets linked to this task <ARRAY>
 * 1: ID of the task <STRING>
 * 2: Number of targets escaped to fail the task <NUMBER>
 * 3: Number of targets eliminated to complete the task <NUMBER>
 * 4: Should the mission end (MissionSuccess) if the task is successful <BOOL> (default: false)
 * 5: Should the mission end (MissionFailed) if the task is failed <BOOL> (default: false)
 * 6: Number of seconds before target(s) escape to fail the task <NUMBER>
 *
 * Return Value:
 * Boolean of success <BOOL>
 *
 * Example:
 * [[target1, target2], "task1", 1, 2, false, false, 45] call SOG_attack_fnc_checkTaskConditions
 *
 * Public: Yes
 */

if !(isServer) exitWith {};

params ["_targets", "_taskID", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false], "_time"];

while { _time > 0 } do {
    _time = _time - 1;
    uiSleep 1;

    // Check the success limit
    if ({ !alive _x } count _targets >= _limitSuccess) exitWith {
        [_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

        // End the mission if it was enabled
        if (_endSuccess) then {
            [QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
        };
    };

    // Check if time has exceeded
    if (_time <= 0) exitWith {
        [_taskID, "FAILED"] call BFUNC(taskSetState);

        // End the mission if it was enabled
        if (_endFail) then {
            [QEGVAR(end_mission,callMission), ["MissionFail", true, playerSide]] call CFUNC(serverEvent);
        };

        // Remove targets
        { deleteVehicle _x } forEach _targets;
    };
};