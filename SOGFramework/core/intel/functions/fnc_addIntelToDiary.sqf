#include "script_component.hpp"

/*
 * Author: Kex, Malbryn
 * Adds a "Mission Intel" diary record to the player's diary.
 *
 * Arguments:
 * 0: Title of the intel <STRING>
 * 1: Intel text <STRING>
 * 2: Name of the player who found the intel <STRING>
 * 3: If the intel was shared globally <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Test title", "Test text", name player, true] call MF_intel_fnc_addIntelToDiary
 *
 * Public: No
 */

if !(hasInterface) exitWith {};

params ["_title", "_text", "_finder", "_isGlobal"];

private _diaryId = QGVAR(intelDiary);

if !(player diarySubjectExists _diaryId) then {
	player createDiarySubject [_diaryId, "Mission Intel"];
};

player createDiaryRecord [_diaryId, [_title, format ["Shared globally: %1", _isGlobal]]];
player createDiaryRecord [_diaryId, [_title, _text]];
player createDiaryRecord [_diaryId, [_title, "--------------------------------"]];

if (name player == _finder) then {
	openMap [true, false];
};