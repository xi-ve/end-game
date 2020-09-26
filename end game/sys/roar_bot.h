#pragma once
#include <inc.h>
namespace sys
{
	struct s_path_script
	{
		s_path_script(sdk::util::c_vector3 p, std::string i, std::string n, bool s = 0)
		{
			pos = p;  script = i; n = npc_name; special_event = s; pause = p.pause;
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
	class c_roar_bot
	{
	private:
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
		std::deque<s_path_script> cur_route;
		//
		void repath(int a, int b);
		bool pause(uint64_t s, float p);
		//
		bool has_lootables(std::vector<sdk::player::s_blank_proxy>& olist, sdk::util::c_vector3 s);
		bool loot_near(sdk::util::c_vector3 o);
		//
		void gpoint();
		void spoint();
		//
	public:
		bool dwork, glua_actions; std::vector<std::string> last_lua_actions;
		//
		void gppoint(float t);
		//
		sdk::util::c_vector3 lp;
		char*pathname;
		bool recording_g, recording_s;
		void record();
		void load(std::string p);
		void work(uint64_t s);
		//
		void snpc(std::string a);
		void sscr(std::string a);
		//
		int gpsize() { return (int)this->grind.size(); }
		int gssize() { return (int)this->store.size(); }
		int assize() { return (int)this->allowed_sell_items.size(); }
		//
		std::deque<sdk::util::c_vector3> g_p() { return this->grind; }
	};
	extern c_roar_bot* roar_bot;
}