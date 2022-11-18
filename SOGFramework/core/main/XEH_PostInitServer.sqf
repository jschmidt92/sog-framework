#include "script_component.hpp"

// Set time multiplier
setTimeMultiplier GVARMAIN(timeAcceleration);

// Unit check
call FUNC(checkUnits);

if (isServer) then {
	GVAR(defusedCount) = 0;

	["ace_explosives_defuse", {
		GVAR(defusedCount) = GVAR(defusedCount) + 1;
	}] call CFUNC(addEventHandler);
};