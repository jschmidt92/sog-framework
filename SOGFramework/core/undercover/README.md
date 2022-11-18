# Undercover
## Description:
_This module adds support for undercover tasks/missions._

_The mission maker can define undercover units, the framework will monitor the status of those units._

_A threshold can be set, so the given amount of undercover have to be exfiled in order to complete the task._

_The module can also trigger mission complete or mission fail._

## Usage:
1. _Set up the undercover task_
2. _Place down the undercover unit(s)_
3. _Call the `SOG_attack_fnc_makeUndercover` function in the undercover' init field that links the unit to the undercover task_

```
Arguments:
    0: OBJECT - The AI unit or object
    1: STRING - The ID of the task

Example:
    [this, "task_name"] call SOG_attack_fnc_makeUndercover
```

5. _Register the undercover task by calling the `SOG_attack_fnc_registerUndercoverTask` function in the init field of the task_

```
Arguments:
    0: STRING - ID of the task
    1: SCALAR - Number of undercover exposed to fail the task
    2: SCALAR - Number of undercover exfiled to complete the task
    4: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
    5: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
    6: BOOLEAN - Does the task have a time limit (Optional, default: false)
    3: TIME - Number of seconds before undercover exfil (Optional, default: 45) ** timeLimit Must Be Enabled **

Example:
    // Default No Time Limit
    ["task_name", 1, 2, false] call SOG_undercover_fnc_registerUndercoverTask

    // Undercover Within Time Limit
    ["task_name", 1, 2, false, false, true, 45] call SOG_undercover_fnc_registerUndercoverTask
```

## Config:
\-

## Supported mission type(s):
 - Coop
