# HVT
## Description:
_This module adds support for hvt capture or eliminate tasks/missions._

_The mission maker can define hvt units, the framework will monitor the status of those units._

_An extraction area and a threshold can be set, so the given amount of hvts have to be in the extraction zone or eliminated in order to complete the task._

_The module can also trigger mission complete or mission fail._

## Usage:
1. _Set up the hvt task_
2. _Place down the hvt unit(s)_
3. _Place down an area marker that marks the extraction zone, also give it a unique name_
4. _Call the `SOG_hvt_fnc_makeHVT` function in the hvts' init field that links the unit to the hvt task_

```
Arguments:
  0: OBJECT - The AI unit
  1: STRING - The ID of the task

Example:
  [this, "task_name"] call SOG_hvt_fnc_makeHVT
```

5. _Register the hvt task by calling the `SOG_hvt_fnc_registerHvtTask` function in the init field of the task_

```
Arguments:
  0: STRING - ID of the task
  1: STRING - Marker name for the extraction zone
  2: NUMBER - Number of hvts KIA or escaped to fail the task
  3: NUMBER - Number of captured or eliminated hvts to complete the task
  4: BOOLEAN - Should the mission end (MissionSuccess) if the task is successful (Optional, default: false)
  5: BOOLEAN - Should the mission end (MissionFailed) if the task is failed (Optional, default: false)
  6: ARRAY - Array of task types to select from (Optional, default: [true, false])
  7: TIME - Number of seconds before hvts escape (Optional)

Example:
  // Capture No Time Limit
  ["task_name", "marker_name", 1, 2, false, false, [true, false]] call SOG_hvt_fnc_registerHvtTask

  // Eliminate No Time Limit
  ["task_name", "marker_name", 1, 2, false, false, [false, true]] call SOG_hvt_fnc_registerHvtTask

  // Capture Within Time Limit
  ["task_name", "marker_name", 1, 2, false, false, [true, false], 45] call SOG_hvt_fnc_registerHvtTask

  // Eliminate Within Time Limit
  ["task_name", "marker_name", 1, 2, false, false, [false, true], 45] call SOG_hvt_fnc_registerHvtTask
```

## Config:
\-

## Supported mission type(s):
- Coop