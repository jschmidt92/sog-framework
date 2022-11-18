# Defuse
## Description:
_This module adds support for defuse tasks/missions._

_The mission maker can define ied objects, the framework will monitor the status of those objects._

_A threshold can be set, so the given amount of IEDs have to be defused, and the number of objects that need to survive in order to complete the task._

_The module can also trigger mission complete or mission fail._

## Usage:
1. _Set up the ied task_
2. _Place down the ied object(s)_
3. _Place down the object(s)_
4. _Spawn the `SOG_defuse_fnc_makeIED` function in the ieds' init field that links the ied to the defuse task_

```
Arguments:
  0: OBJECT - The IED object
  1: STRING - The ID of the task
  2: SCALAR - The Countdown Timer

Example:
  [this, "task_name", 30] spawn SOG_defuse_fnc_makeIED
```

5. _Call the `SOG_defuse_fnc_makeObject` function in the objects' init field that links the object to the defuse task_

```
Arguments:
  0: OBJECT - The Object
  1: STRING - The ID of the task

Example:
  [this, "task_name"] call SOG_defuse_fnc_makeObject
```

6. _Register the defuse task by calling the `SOG_defuse_fnc_registerDefuseTask` function in the init field of the task_

```
Arguments:
  0: STRING - ID of the task
  1: SCALAR - Number of objects destroyed to fail the task
  2: SCALAR - Number of ieds to defuse to complete the task
  3: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
  4: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)

Example:
  ["task_name", 2, 3, true] call SOG_defuse_fnc_registerDefuseTask
```

## Config:
\-

## Supported mission type(s):
- Coop