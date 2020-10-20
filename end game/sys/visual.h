#pragma once
#include <inc.h>
namespace sys
{
	class c_visuals
	{
	private:
		sys::s_cfg_v* iroar_pause = NULL; sys::s_cfg_v* ibot_lootrange = NULL; sys::s_cfg_v* iroar_visual = NULL;
		sys::s_cfg_v* ienable_portal = NULL; sys::s_cfg_v* ienable_debug = NULL; sys::s_cfg_v* istore_path = NULL;
		sys::s_cfg_v* ivis_linestart = NULL; sys::s_cfg_v* ialive_byname = NULL; sys::s_cfg_v* ienable_legit_path_pauses = NULL;
		sys::s_cfg_v* ienable_legit_path = NULL; sys::s_cfg_v* ienable_player = NULL; sys::s_cfg_v* itrace_debug = NULL;
		uint64_t self = NULL;
		std::string esp_mob_t = "Raccoon";
		std::vector<sdk::player::s_trace> t_map;
		void monster_proxy_debug();
		void alive_proxy_debug();
		void portal();
		void trace_debug();
		void roar_path();
		void store_path();
		void lineto_roar();
		void debug_mobs();
		void editor_debug();
		void legit_path();
		void player_esp();
		void hit_popups();
		int filter = 34;
	public:
		bool debug_editor = false, first_click = false, shown_modal = false, changed_pos = false;
		sdk::util::c_vector3 selected_pos = {}, new_pos = {};
		//
		void ptrace();
		std::vector<sdk::util::c_vector3> gcircle(sdk::util::c_vector3 from, float dst, int deg, int rad = 360);
		std::vector<sdk::util::c_vector3> gcircle_front(sdk::util::c_vector3 from, float dst, int deg, int rad = 5);
		void work();
	};
	extern c_visuals* visuals;
}