#include "script_component.hpp"

class GVARMAIN(Main) {  // Main first
	init = PATH_PRE(main);
};

class GVARMAIN(ACRE) {
	init = PATH_PRE(acre);
};

class GVARMAIN(Attack) {
	init = PATH_PRE(attack);
};

class GVARMAIN(Briefing) {
	init = PATH_PRE(briefing);
};

class GVARMAIN(Common) {
	init = PATH_PRE(common);
};

class GVARMAIN(Destroy) {
	init = PATH_PRE(destroy);
};

class GVARMAIN(Defuse) {
	init = PATH_PRE(defuse);
};

class GVARMAIN(EndConditions) {
	init = PATH_PRE(end_conditions);
};

class GVARMAIN(EndMission) {
	init = PATH_PRE(end_mission);
};

class GVARMAIN(Hostage) {
	init = PATH_PRE(hostage);
};

class GVARMAIN(HVT) {
	init = PATH_PRE(hvt);
};

class GVARMAIN(Intel) {
	init = PATH_PRE(intel);
};

class GVARMAIN(IntroText) {
	init = PATH_PRE(intro_text);
};

class GVARMAIN(TFAR) {
	init = PATH_PRE(tfar);
};