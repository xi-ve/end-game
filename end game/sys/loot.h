#pragma once
#include <inc.h>
namespace sys
{
	struct s_looting_item
	{
		s_looting_item() {};
		s_looting_item(int c, int i, int r, std::string n)
		{
			count = c; id = i; rarity = r; name = n;
		}
		int count = 0, id = 0, rarity = 0;
		std::string name = "";
	};
	class c_loot
	{
	private:
		uint64_t					self;
		void						spack(int k);
		uint64_t					gitem(int s);
		s_looting_item				gctx(uint64_t p);
		uint64_t					hnear();
	public:
		uint64_t last_ent;
		void work(uint64_t self);
	};
	extern c_loot* loot;
}