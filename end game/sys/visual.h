#pragma once
#include <inc.h>
namespace sys
{
	class c_visuals
	{
	private:
		sys::s_cfg_v* iroar_pause = NULL; sys::s_cfg_v* ibot_lootrange = NULL; sys::s_cfg_v* iroar_visual = NULL;
		sys::s_cfg_v* ienable_portal = NULL; sys::s_cfg_v* ienable_debug = NULL; sys::s_cfg_v* istore_path = NULL;
		sys::s_cfg_v* ivis_linestart = NULL; sys::s_cfg_v* ialive_byname = NULL;
		uint64_t self = NULL;
		std::string esp_mob_t = "Raccoon";
		void monster_proxy_debug();
		void alive_proxy_debug();
		void portal();
		void trace_debug();
		void roar_path();
		void store_path();
		void lineto_roar();
		void debug_mobs();
		int filter = 34;
	public:
		std::vector<sdk::util::c_vector3> gcircle(sdk::util::c_vector3 from, float dst, int deg);
		void work();
	};
	extern c_visuals* visuals;
}