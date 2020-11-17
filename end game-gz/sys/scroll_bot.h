#pragma once
#include <inc.h>
namespace sys
{
	struct s_scroll_type
	{
		s_scroll_type(sdk::util::c_vector3 pos, int id, std::string prename, std::string pre2name, std::string mainname)
		{
			position = pos;
			scroll_id = id;
			pre_boss = prename;
			pre_boss_2 = pre2name;
			boss = mainname;
		};
		sdk::util::c_vector3 position;
		int scroll_id;
		std::string pre_boss;
		std::string pre_boss_2;
		std::string boss;
	};
	class c_scrollbot
	{
	private:
		sys::s_cfg_v* scrollbot_toggle = NULL; sys::s_cfg_v* ienable_do_all = NULL; sys::s_cfg_v* ienable_do_num = NULL;
		ULONGLONG last_use = 0, last_tick = 0;
		int scrolls_done = 0;

		std::vector<s_scroll_type> scroll_types;

		bool		used_scroll = 0;
		int			scroll_id = 41595;
		int			scrolls_left = 0;

		sdk::util::c_vector3 scroll_spawn_pos = sdk::util::c_vector3(403458.f, -3918.f, 5948.f);
		std::string boss_name = "Khalk";
		std::string boss_pre_name = "Magram";
		std::string boss_pre_name_2 = "";
		uint64_t    boss_act = 0;
		uint64_t    boss_pre_act = 0;
		uint64_t	boss_pre_2_act = 0;
		bool		boss_detected = 0;
		bool		boss_pre_detected = 0;
		bool		boss_pre_died = 0;
		bool		boss_pre_2_detected = 0;
		bool		boss_pre_2_died = 0;
		bool		boss_died = 0;

		bool		took_rewards = 0;
		bool		walked_back = 0;
		bool		walked_back_1 = 0;
		bool		walked_back_2 = 0;
		bool		is_ready_next = 0;

		/*scroll methods*/

		bool		did_use_scroll(uint64_t self);
		bool		find_pre_boss(uint64_t self);
		bool		find_pre_2_boss(uint64_t self);
		bool		find_boss(uint64_t self);
		bool		kill_logic(uint64_t self, uint64_t target);
		bool		kill_pre_boss(uint64_t self);
		bool		kill_pre_2_boss(uint64_t self);
		bool		kill_boss(uint64_t self);
		bool		take_reward(uint64_t self);
		bool		walk_to_start_after_1(uint64_t self);
		bool		walk_to_start_after_2(uint64_t self);
		bool		walk_back_to_start(uint64_t self);
	public:
		int			max_range_from_mob = 800;
		std::string get_main_boss();
		bool set_scroll_type();
		void set_scroll_type_by_pos(uint64_t self);
		void work(uint64_t self, ULONGLONG tick);
		void reset();
	};
	extern c_scrollbot* scrollbot;
}