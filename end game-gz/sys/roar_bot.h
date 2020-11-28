#pragma once
#include <inc.h>
namespace sys
{
	class c_roar_bot
	{
	private:
		std::vector<int> arsha_chests =
		{
			/*weapon chests for all classes*/
			617, 618, 621
		};
		std::vector<int> arsha_items =
		{
			/*armor and acc.*/
			48291, 48292, 48294, 48296, 48343, 48346, 48340, 48348
		};
		std::vector<int> arsha_weapons =
		{
			/*weapons*/
			/*archer*/	 48191, 48195, 48192,
			/*guardian*/ 35187, 48142, 48256,
			/*sorc*/     48149, 48241, 48150,
			/*zerker*/   48153, 48242, 48154,
			/*maewha*/   48161, 48162, 48247,
			/*warrior*/  48141, 48240,
			/*ranger*/   48145, 48146, 48243,
			/*lahn*/     48177, 48178, 48255,
			/*tamer*/    48157, 48158, 48244,
			/*shai*/	 63232, 63697, 34649,
			/*striker*/  48173, 48174, 48253,
			/*musa*/     48246,
			/*mystic*/   48254,
			/*valk*/     48245,
			/*kuno*/     48166, 48249,
			/*ninja*/    48169, 48248,
			/*dk*/       48172, 48252,
			/*witch*/    48165, 48250,
			/*witcher*/  48251
		};
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
		std::string s_scr = "X", s_npc = "X";
		//
		int p_mode = 0;//0,grind 1,store
		int reversed = 0;
		bool skill_locked = 0; bool npc_interacted = false;
		bool path_contains_repair = false;
		bool arsha_char = false;
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
		bool is_arsha_low_dur();
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