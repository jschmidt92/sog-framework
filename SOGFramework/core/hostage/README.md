# Hostage
## Description:
_This module adds support for hostage rescue tasks/missions._

_The mission maker can define hostage units, the framework will monitor the status of those units._

_An extraction area and a threshold can be set, so the given amount of hostages have to be in the extraction zone in order to complete the task._

_The module can also trigger mission complete or mission fail._

## Usage:
1. _Set up the hostage task_
2. _Place down the hostage unit(s)_
3. _Place down the shooter unit(s) (Optional)_
4. _Place down an area marker that marks the extraction zone, also give it a unique name_
5. _Call the `SOG_hostage_fnc_makeHostage` function in the hostages' init field that links the unit to the hostage task_

```
Arguments:
  0: OBJECT - The AI unit
  1: STRING - The ID of the task

Example:
  [this, "task_name"] call SOG_hostage_fnc_makeHostage
```

6. _Call the `SOG_hostage_fnc_makeShooter` function in the shooters' init field that links the unit to the hostage task (Optional, ** Shooter Unit(s) Must Be Placed **)_

```
Arguments:
  0: OBJECT - The AI unit
  1: STRING - The ID of the task

Example:
  [this, "task_name"] call SOG_hostage_fnc_makeShooter
```

7. _Register the hostage task by calling the `SOG_hostage_fnc_registerHostageTask` function in the init field of the task_

```
Arguments:
  0: STRING - ID of the task
  1: STRING - Marker name for the extraction zone
  2: NUMBER - Number of hostages KIA to fail the task
  3: NUMBER - Number of hostages rescued to complete the task
  4: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
  5: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
  6: ARRAY - Array of task types to select from (Optional, default: [false, false])
  7: TIME - Number of seconds before hostages are killed (Optional)
  8: STRING - Marker name for the cbrn zone

Example:
  // Default No Time Limit
  ["task_name", "marker_name", 1, 2, false] call SOG_hostage_fnc_registerHostageTask

  // CBRN Attack When Time Limit Expires
  ["task_name", "marker_name", 1, 2, false, false, [true, false], 45, "marker_name"] call SOG_hostage_fnc_registerHostageTask

  // Execution When Time Limit Expires
  ["task_name", "marker_name", 1, 2, false, false, [false, true], 45] call SOG_hostage_fnc_registerHostageTask
```

## Config:
\-

## Supported mission type(s):
- Coop