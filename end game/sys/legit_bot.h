#pragma once
#include <inc.h>
namespace sys
{
	extern std::vector<int> v_keys_i;
	extern std::vector<std::string> v_keys_s;
	extern std::unordered_map<int, int> v_quickslot;
	extern std::unordered_map<int, std::string> v_keys;;
	extern std::unordered_map<int, int> v_keys_flags;
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
		sdk::util::c_vector3 pos = { 0,0,0 };
		float		   pause = 0;
		bool		   special_event = 0;
		bool		   repair_event = 0;
		std::string    script = "NONE";
		std::string	   npc_name = "NONE";
	};
	typedef uint64_t(__stdcall* t_npc_interaction)(uint64_t);
	class c_legit_bot
	{
	private:
		sys::s_cfg_v* ipot = NULL; sys::s_cfg_v* isp_pct = NULL; sys::s_cfg_v* ihp_pct = NULL;
		ULONGLONG loot_outtime = 0; ULONGLONG ltp = 0; ULONGLONG pause_ending_tick = 0; ULONGLONG sp_delay = 0; ULONGLONG skill_delay = 0;
		ULONGLONG max_cooltime = 0; ULONGLONG sct = 0;
		int i_sell_state = 0; std::vector<int> items_left_sell = {};
		std::vector<int> wp_items = { 591, 592, 593, 594, 582, 977, 17710, 17709, 17708, 830, 829, 828, 827, -1 };		
		std::vector<int> hp_pots = { 529, 524, 530, 525, 528, 519, 514, 518, 513, 517, 583, 580, 750108 };
		std::vector<int> mp_pots = { 532, 526, 533, 527, 531, 522, 516, 521, 515, 520, 581, 17688, 19936, 19937, 19938 };
		//
		t_npc_interaction f_npc_interaction = (t_npc_interaction)(core::offsets::fn::start_npc_interaction);
		uint64_t att_target = NULL;
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
		//
		bool ssp(s_path_script s);
		void repath(int a, int b);
		bool pause(uint64_t s, float p);
		bool find_node(sdk::util::c_vector3 t, sdk::util::c_vector3 f, float md);
		//
		bool has_lootables(sdk::util::c_vector3 s);
		bool loot_near(sdk::util::c_vector3 o);
		bool has_aggro();
		//
		bool stance();
		//
		void gpoint();
		//
		bool mobs_near(sdk::util::c_vector3 p, sdk::util::c_vector3 s);
		sdk::player::s_blank_proxy nearest(sdk::util::c_vector3 from, sdk::util::c_vector3 s, float max);
		bool update_target();
		//
		void spitch(float f);
		void syaw(float f);
	public:
		std::deque<s_path_script> cur_route = {};
		sdk::player::s_blank_proxy target_actor = {};
		sdk::util::c_vector3 walk_node = {}; std::vector<sdk::util::c_vector3> scan_nodes = {};

		std::deque<s_skill*> skills;
		int loot_act_k = 0;
		bool dwork = false; bool glua_actions = false; bool force_store = false; std::vector<std::string> last_lua_actions = {};
		//
		void aim_pos(sdk::util::c_vector3 t, sdk::util::c_vector3 s);
		bool blockage(sdk::util::c_vector3 s);
		//
		void gppoint(float t);
		void spoint();
		void sepoint();
		void sitem(int i);
		int  gmode() { return this->p_mode; }
		std::vector<std::string> gitm();
		std::vector<int> gitm_left();
		int gitem_bn(std::string s);
		void autopot();
		//
		bool add_skill(int key, int key2, int key3, int interval, int cd, int mp, int awakening, int condition);
		bool save_skill_profile();
		bool load_skill_profile();
		void rskill();
		//
		sdk::util::c_vector3 lp = {};
		std::string pathname = "", combo_name = "def.combo";
		bool recording_g = 0, recording_s = 0, store_can_path = 0;
		void record();
		void load();
		void save();
		bool nav_to(sdk::util::c_vector3 spos, float dst);
		void set_walk();
		void work(uint64_t s);
		bool snear();
		void reset();
		//
		void snpc(std::string a) { this->s_npc = a; };
		void sscr(std::string a) { this->s_scr = a; };
		//
		int gpsize() { return (int)this->grind.size(); }
		int gssize() { return (int)this->store.size(); }
		int assize() { return (int)this->allowed_sell_items.size(); }
		void sgpos(sdk::util::c_vector3 to_replace, sdk::util::c_vector3 new_pos);
		//
		std::vector<std::string> gnpcs();
		//
		std::deque<sdk::util::c_vector3> g_p() { return this->grind; }
		std::deque<s_path_script>		 g_s() { return this->store; }
	};
	extern c_legit_bot* legit_bot;
}