#pragma once
#include <inc.h>
namespace sys
{
	struct s_damage_event
	{
		s_damage_event(uint64_t a, float b, std::string c)
		{
			ptr = a; damage = b; name = c;
		}
		uint64_t ptr = 0;
		float damage = 0;
		std::string name = "";
	};
	struct s_killed_mobs
	{
		s_killed_mobs(std::string a)
		{
			name = a; count = 1;
		}
		std::string name = "";
		int count = 0;
	};
	class c_damage
	{
	public:
		ULONGLONG timer = 0;
		float buffer_dps = 0;
		int	  buffer_hps = 0;
		float total_dps = 0;
		int   total_hps = 0;
		std::unordered_map<int, int> actors_hp;
		std::vector<s_damage_event>  dmg_events;
		std::vector<s_killed_mobs>   killed_mobs;
		void work(int target);
		std::vector<s_damage_event> gevents();
	};
	extern c_damage* damage;
}