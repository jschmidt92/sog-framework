#include "script_component.hpp"

params [["_unit", objNull], ["_allowedGear", []], "_area"];

// Why bother checking a unit that is not undercover already?
if !(_unit getVariable ["isUndercover", false]) exitWith {};

_gear = [uniform _unit, headgear _unit, vest _unit, backpack _unit, goggles _unit, hmd _unit, currentWeapon _unit, primaryWeapon _unit, secondaryWeapon _unit, handgunWeapon _unit];
private _allowedGear = _area getVariable ["AllowedGear", []];

if (_gear isNotEqualTo _allowedGear) then {
	// Not undercover anymore
	_unit setVariable ["isUndercover", false];
	_unit allowDamage true;
	_unit setCaptive false;
	hintSilent "You're Not Undercover!"
};