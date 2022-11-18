#include "script_component.hpp"

class GVARMAIN(Main) {  // Main first
	init = PATH_POST(main);
	clientInit = PATH_POST_CLIENT(main);
	serverInit = PATH_POST_SERVER(main);
};

class GVARMAIN(ACRE) {
	init = PATH_POST(acre);
	clientInit = PATH_POST_CLIENT(acre);
	serverInit = PATH_POST_SERVER(acre);
};

class GVARMAIN(Attack) {
	init = PATH_POST(attack);
	clientInit = PATH_POST_CLIENT(attack);
	serverInit = PATH_POST_SERVER(attack);
};

class GVARMAIN(Briefing) {
	init = PATH_POST(briefing);
	clientInit = PATH_POST_CLIENT(briefing);
	serverInit = PATH_POST_SERVER(briefing);
};

class GVARMAIN(Common) {
	init = PATH_POST(common);
	clientInit = PATH_POST_CLIENT(common);
	serverInit = PATH_POST_SERVER(common);
};

class GVARMAIN(Destroy) {
	init = PATH_POST(destroy);
	clientInit = PATH_POST_CLIENT(destroy);
	serverInit = PATH_POST_SERVER(destroy);
};

class GVARMAIN(Defuse) {
	init = PATH_POST(defuse);
	clientInit = PATH_POST_CLIENT(defuse);
	serverInit = PATH_POST_SERVER(defuse);
};

class GVARMAIN(EndConditions) {
	init = PATH_POST(end_conditions);
	clientInit = PATH_POST_CLIENT(end_conditions);
	serverInit = PATH_POST_SERVER(end_conditions);
};

class GVARMAIN(EndMission) {
	init = PATH_POST(end_mission);
	clientInit = PATH_POST_CLIENT(end_mission);
	serverInit = PATH_POST_SERVER(end_mission);
};

class GVARMAIN(Hostage) {
	init = PATH_POST(hostage);
	clientInit = PATH_POST_CLIENT(hostage);
	serverInit = PATH_POST_SERVER(hostage);
};

class GVARMAIN(HVT) {
	init = PATH_POST(hvt);
	clientInit = PATH_POST_CLIENT(hvt);
	serverInit = PATH_POST_SERVER(hvt);
};

class GVARMAIN(Intel) {
	init = PATH_POST(intel);
	clientInit = PATH_POST_CLIENT(intel);
	serverInit = PATH_POST_SERVER(intel);
};

class GVARMAIN(IntroText) {
	init = PATH_POST(intro_text);
	clientInit = PATH_POST_CLIENT(intro_text);
	serverInit = PATH_POST_SERVER(intro_text);
};

class GVARMAIN(TFAR) {
	init = PATH_POST(tfar);
	clientInit = PATH_POST_CLIENT(tfar);
	serverInit = PATH_POST_SERVER(tfar);
};