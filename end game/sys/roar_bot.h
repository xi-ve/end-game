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
		uint64_t self;
	public:
		std::vector<int> allowed_sell_items;
		std::vector<sdk::util::c_vector3> grind;
		std::vector<s_path_script> store;

		void load(std::string p);
		void work(uint64_t s);
	};
	extern c_roar_bot* roar_bot;
}