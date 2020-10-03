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
		sdk::util::c_vector3 pos = {0,0,0};
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
		ULONGLONG loot_outtime = 0; ULONGLONG ltp = 0; ULONGLONG pause_ending_tick = 0; ULONGLONG sp_delay = 0; ULONGLONG skill_delay = 0;
		ULONGLONG max_cooltime = 0;
		sys::s_cfg_v* ibot_lootrange = NULL; sys::s_cfg_v* ibot_timescale = NULL; sys::s_cfg_v* iloot_tp = NULL;
		sys::s_cfg_v* ibot_storage_roar = NULL;
		int i_sell_state = 0; std::vector<int> items_left_sell = {};
		std::vector<int> wp_items = { 591, 592, 593, 594, 582, -1 };
		//
		t_npc_interaction f_npc_interaction = (t_npc_interaction)(core::offsets::fn::start_npc_interaction);
		//
		ULONGLONG execution = 0;
		uint64_t self = 0;
		std::vector<int> allowed_sell_items = {};
		std::deque<sdk::util::c_vector3> grind = {};
		std::deque<s_path_script>		 store = {};
		//
		std::string s_scr = "NONE", s_npc = "NONE";
		//
		int p_mode = 0;//0,grind 1,store
		int reversed = 0;
		bool skill_locked = 0; bool npc_interacted = false;
		std::deque<s_path_script> cur_route = {};
		//
		bool ssp(s_path_script s);
		void repath(int a, int b);
		bool pause(uint64_t s, float p);
		//
		bool has_lootables(sdk::util::c_vector3 s);
		bool loot_near(sdk::util::c_vector3 o);
		bool has_aggro();
		//
		void skill();
		//
		void gpoint();
		//
	public:
		int loot_act_k = 0;
		bool dwork = false; bool glua_actions = false; bool force_store = false; std::vector<std::string> last_lua_actions = {};
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
		sdk::util::c_vector3 lp = {};
		std::string pathname = "";
		bool recording_g = 0, recording_s = 0, store_can_path = 0;
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