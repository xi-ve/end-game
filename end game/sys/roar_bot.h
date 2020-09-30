#pragma once
#include <inc.h>
namespace sys
{
	struct s_path_script
	{
		s_path_script(sdk::util::c_vector3 p, std::string i, std::string n, bool s = 0)
		{
			pos = p;  script = i; npc_name = n; special_event = s; pause = p.pause;
		};
		s_path_script()
		{
			pos.clear(); pause = 0; script = ""; npc_name = "";
		}
		sdk::util::c_vector3 pos;
		float		   pause = 0;
		bool		   special_event = 0;
		bool		   repair_event = 0;
		std::string    script   = "NONE";
		std::string	   npc_name = "NONE";
	};
	typedef uint64_t(__stdcall* t_npc_interaction)(uint64_t);
	class c_roar_bot
	{
	private:
		ULONGLONG list_clear_time = 0; ULONGLONG ltp = 0; ULONGLONG pause_ending_tick = 0; ULONGLONG sp_delay = 0; ULONGLONG skill_delay = 0;
		std::vector<sdk::player::s_blank_proxy> llist;
		std::vector<sdk::player::s_blank_proxy> list;
		sys::s_cfg_v* ibot_lootrange = NULL; sys::s_cfg_v* ibot_timescale = NULL; sys::s_cfg_v* iloot_tp = NULL;
		int i_sell_state = 0; std::vector<int> items_left_sell;
		std::vector<int> wp_items = { 591, 592, 593, 594, 582, -1 };
		//
		t_npc_interaction f_npc_interaction = (t_npc_interaction)(core::offsets::fn::start_npc_interaction);
		//
		ULONGLONG execution;
		uint64_t self;
		std::vector<int> allowed_sell_items;
		std::deque<sdk::util::c_vector3> grind;
		std::deque<s_path_script>		 store;
		//
		std::string s_scr, s_npc;
		//
		int p_mode = 0;//0,grind 1,store
		int reversed = 0;
		bool skill_locked = 0;
		std::deque<s_path_script> cur_route;
		//
		bool ssp(s_path_script s);
		void repath(int a, int b);
		bool pause(uint64_t s, float p);
		//
		bool has_lootables(std::vector<sdk::player::s_blank_proxy>& olist, sdk::util::c_vector3 s);
		bool loot_near(sdk::util::c_vector3 o);

		void skill();
		//
		void gpoint();
		//
	public:
		bool dwork; bool glua_actions; bool force_store; std::vector<std::string> last_lua_actions;
		//
		void gppoint(float t);
		void spoint();
		void sepoint();
		void sitem(int i);
		int  gmode() { return this->p_mode; }
		std::vector<std::string> gitm();
		std::vector<int> gitm_left();
		int gitem_bn(std::string s);
		//
		sdk::util::c_vector3 lp;
		std::string pathname;
		bool recording_g, recording_s, store_can_path;
		void record();
		void load();
		void work(uint64_t s);
		bool snear();
		void reset();
		//
		void snpc(std::string a);
		void sscr(std::string a);
		//
		int gpsize() { return (int)this->grind.size(); }
		int gssize() { return (int)this->store.size(); }
		int assize() { return (int)this->allowed_sell_items.size(); }
		//
		std::vector<std::string> gnpcs();
		//
		std::deque<sdk::util::c_vector3> g_p() { return this->grind; }
		std::deque<s_path_script>		 g_s() { return this->store; }
	};
	extern c_roar_bot* roar_bot;
}