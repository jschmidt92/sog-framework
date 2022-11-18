#include "script_component.hpp"

/*
	Author:
	Malbryn

	Description:
	Adds a "Credits" diary record to the player's diary.

	Arguments:
	-

	Example:
	call MF_main_fnc_addCredits

	Returns:
	void
*/

if !(hasInterface) exitWith {};

// Framework version
private _version = VERSION;
private _build = BUILD;

// Title of the mission
private _title = briefingName;

// Author
private _author = [missionConfigFile] call BFUNC(overviewAuthor);

private _text = format ["
	<font color='#21749c' size='16' face='PuristaSemiBold'>%1</font><br/>
	<font size='14' face='PuristaMedium'>This mission was made</font> <font color='#21749c' size='14' face='PuristaSemiBold'>%2.</font><br/>
	<br/>
	<font size='14' face='PuristaMedium'>Framework version:</font> <font color='#21749c' size='14' face='PuristaSemiBold'>%3 (Build %4)</font>
", _title, _author, _version, _build];

DIARY_SUBJECT("Credits");

DIARY_RECORD_START("Credits", "Scenario")
_text
DIARY_RECORD_END;

DIARY_RECORD_START("Credits", "Mission Framework")
"
<img image='mission_framework\core\main\img\banner.jpg' width='360' height='90'/>
<br/>
<font size='14' face='PuristaMedium'>This mission was made with Malbryn's Mission Framework.<br/>
<br/>
Some parts of this framework are based on other Arma 3 frameworks and scripts. See the original authors below.<br/>
<br/>
- MalFramework by Malbryn<br/>
- Briefing scripts by Perfks and Pax'Jarome<br/>
- Curator scripts by Commy2<br/>
- Diary macros by NeilZar<br/>
- Attack, Defuse, Destroy, Hostage, HVT modules by Malbryn and J. Schmidt<br/>
<br/>
Special thanks to <font color='#21749c'>Garfield</font> and <font color='#21749c'>kMaN</font> for their technical help.
</font>
"
DIARY_RECORD_END;

// Removing some Diary records
[{!isNil "cba_help_DiaryRecordAddons"}, {
	player removeDiarySubject "cba_help_docs";
}] call CFUNC(waitUntilAndExecute);