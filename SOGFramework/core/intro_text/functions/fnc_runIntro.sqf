#include "script_component.hpp"

/*
	Author:
	Malbryn

	Description:
	Runs the intro text at mission start.

	Arguments:
	-

	Example:
	call MF_intro_text_fnc_runIntro

	Returns:
	void
*/

[{
	private _text =
	[
		[GVAR(title), "size='1.0' font='PuristaBold'"],
		["", "<br/>"],

		[GVAR(date), "size='0.75' font='PuristaMedium'"],
		["", "<br/>"],

		[GVAR(location), "size='0.75' font='PuristaMedium'"],
		["", "<br/>"],

		[rank player, "size='0.5' font='PuristaSemiBold'"],
		[" ", "size='0.5' font='PuristaBold'"],
		[toUpper (name player), "size='0.5' font='PuristaSemiBold'"],
		["", "<br/>"]
	];

	private _output = [_text, safezoneX - 0.01, safeZoneY + (1 - 0.125) * safeZoneH, true, "<t align='right' size='1,1' >%1</t>"] spawn BFUNC(typeText2);
}, [], GVAR(delay)] call CFUNC(waitAndExecute);