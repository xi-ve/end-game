#pragma once
#include <inc.h>
namespace sdk
{
	namespace menu
	{
		class c_menu
		{
		private:
			sys::s_cfg_v* iteleport_gen2 = NULL; sys::s_cfg_v* ibypass_trial = NULL; sys::s_cfg_v* iloot_enable = NULL;
			sys::s_cfg_v* iloot_enable_filter = NULL; sys::s_cfg_v* grey = NULL; sys::s_cfg_v* green = NULL;
			sys::s_cfg_v* blue = NULL; sys::s_cfg_v* orange = NULL; sys::s_cfg_v* yellow = NULL; 
			sys::s_cfg_v* ikey_ctp = NULL; sys::s_cfg_v* ibot_timescale = NULL; sys::s_cfg_v* ibot_lootrange = NULL;
			sys::s_cfg_v* iroar_path = NULL; sys::s_cfg_v* iroar_pause = NULL; sys::s_cfg_v* ienable_portal = NULL;
			sys::s_cfg_v* ienable_debug = NULL; sys::s_cfg_v* ient_alt = NULL; sys::s_cfg_v* istore_path = NULL;
			size_t TabHeight = 0; size_t TabWidth = 100; size_t ctab = 0;
			int selected_whitelist = 0; float t = 1.1f; char ct[128]; int ps = 0; int si = 0; int ni = 0; int is_scr = 0;
			void tab(size_t Index, const char* Text, int height);
			bool was_setup = false;
			bool menu_active = false;
		public:
			void work();
			void sactive();
			bool gactive() { return this->menu_active; };
		};
		extern c_menu* menu;
	}
}