#pragma once
#include <inc.h>
namespace sys
{
	class c_roar_bot
	{
	private:
		ULONGLONG loot_outtime = 0; ULONGLONG ltp = 0; ULONGLONG pause_ending_tick = 0; ULONGLONG sp_delay = 0; ULONGLONG skill_delay = 0;
		ULONGLONG max_cooltime = 0; ULONGLONG sct = 0;
		uint64_t last_loot_actor = 0; ULONGLONG last_loot_time = 0;
		sys::s_cfg_v* ibot_lootrange = NULL; sys::s_cfg_v* ibot_timescale = NULL; sys::s_cfg_v* iloot_tp = NULL;
		sys::s_cfg_v* ibot_storage_roar = NULL; sys::s_cfg_v* istop_on_player = NULL; sys::s_cfg_v* iexit_on_player = NULL;
		sys::s_cfg_v* iauto_disable_render = NULL;
		int i_sell_state = 0; std::vector<int> items_left_sell = {};
		std::vector<int> wp_items = { 591, 592, 593, 594, 582, -1 };
		std::string last_interaction_name = "";
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
		bool stance();
		void skill();
		//
		void gpoint();
		//
	public:
		t_npc_interaction f_npc_interaction = (t_npc_interaction)(core::offsets::fn::start_npc_interaction);
		int loot_act_k = 0; int recording_step_size = 50;
		bool dwork = false; bool glua_actions = false; bool force_store = false; std::vector<std::string> last_lua_actions = {};
		//
		void gppoint(float t);
		void spoint();
		void rpoint();
		void sepoint();
		void sitem(int i);
		int  gmode() { return this->p_mode; }
		std::vector<std::string> gitm();
		std::vector<int> gitm_left();
		int gitem_bn(std::string s);
		//
		sdk::util::c_vector3 lp = {};
		std::string pathname = "";
		bool recording_g = 0, recording_s = 0, recording_r = 0, store_can_path = 0;
		void record();
		void load();
		void save();
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
		s_path_script gcur() 
		{
			if (this->cur_route.size()) return this->cur_route.front();
			else return {};
		}
		void sgpos(sdk::util::c_vector3 to_replace, sdk::util::c_vector3 new_pos);
		//
		std::vector<std::string> gnpcs();
		//
		std::deque<sdk::util::c_vector3> g_p() { return this->grind; }
		std::deque<s_path_script>		 g_s() { return this->store; }
	};
	extern c_roar_bot* roar_bot;
}