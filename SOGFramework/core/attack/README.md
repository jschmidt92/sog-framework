# Attack
## Description:
_This module adds support for attack tasks/missions._

_The mission maker can define target units, the framework will monitor the status of those units._

_A threshold can be set, so the given amount of targets have to be eliminated in order to complete the task._

_The module can also trigger mission complete or mission fail._

## Usage:
1. _Set up the attack task_
2. _Place down the target unit(s)_
3. _Call the `SOG_attack_fnc_makeTarget` function in the targets' init field that links the unit to the attack task_

```
Arguments:
  0: OBJECT - The AI unit or object
  1: STRING - The ID of the task

Example:
  [this, "task_name"] call SOG_attack_fnc_makeTarget
```

4. _Register the attack task by calling the `SOG_attack_fnc_registerAttackTask` function in the init field of the task_

```
Arguments:
  0: STRING - ID of the task
  1: SCALAR - Number of targets escaped to fail the task
  2: SCALAR - Number of targets eliminated to complete the task
  3: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
  4: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
  5: SCALAR - Number of seconds before targets escape (Optional)

Example:
  // Default No Time Limit
  ["task_name", 1, 2, false] call SOG_attack_fnc_registerAttackTask

  // Attack Within Time Limit
  ["task_name", 1, 2, false, false, 45] call SOG_attack_fnc_registerAttackTask
```

## Config:
\-

## Supported mission type(s):
- Coop