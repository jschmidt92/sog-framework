#include "script_component.hpp"

/*
 * Author: Malbryn, J. Schmidt
 * Checks the hostage rescue task conditions.
 *
 * Arguments:
 * 0: ID of the PFH <SCALAR>
 * 1: Array of the hostages linked to this task <ARRAY>
 * 2: Array of shooters linked to this task <ARRAY>
 * 3: ID of the task <STRING>
 * 4: Marker name for the extraction zone <STRING>
 * 5: Number of hostages KIA to fail the task <NUBMER>
 * 6: Number of hostages rescued to complete the task <NUMBER>
 * 7: Should the mission end (MissionSuccess) if the task is successful <BOOL> (default: false)
 * 8: Should the mission end (MissionFailed) if the task is failed <BOOL> (default: false)
 *
 * Return Value:
 * Boolean of success <BOOL>
 *
 * Example:
 * [1, [pow1, pow2], "task1", "mrk_extraction", 1, 2, false] call SOG_hostage_fnc_checkTaskConditions
 *
 * Public: No
 */

if !(isServer) exitWith {};

params ["_handle", "_hostages", "_shooters", "_taskID", "_extZone", "_limitFail", "_limitSuccess", ["_endSuccess", false], ["_endFail", false]];

// Check the death count
if ({ !alive _x } count _hostages >= _limitFail) exitWith {
    [_taskID, "FAILED"] call BFUNC(taskSetState);

    // Stop PFH
    [_handle] call CFUNC(removePerFrameHandler);

    // End the mission if it was enabled
    if (_endFail) then {
        [QEGVAR(end_mission,callMission), ["MissionFail", false, playerSide]] call CFUNC(serverEvent);
    };
};

// If the task is done, we don't check the zone anymore to save performance
// However we still track the death of the hostages
if (_taskID call BFUNC(taskState) == "SUCCEEDED") exitWith {};

// Check the success limit
if ({ _x inArea _extZone } count _hostages >= _limitSuccess) exitWith {
    [_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

    // End the mission if it was enabled
    if (_endSuccess) then {
        [QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
    };
};

// Check the success limit
if (!isNil "_shooters" && { alive _x } count _shooters <= 0) exitWith {
    [_taskID, "SUCCEEDED"] call BFUNC(taskSetState);

    // End the mission if it was enabled
    if (_endSuccess) then {
        [QEGVAR(end_mission,callMission), ["MissionSuccess", true, playerSide]] call CFUNC(serverEvent);
    };
};