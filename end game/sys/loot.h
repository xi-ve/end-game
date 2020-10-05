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

	typedef uint64_t(__fastcall* t_loot_get_base)(int);
	typedef uint64_t(__fastcall* t_loot_get_rarity)(uint64_t);
	typedef const CHAR* (__fastcall* t_loot_get_name)(uint64_t);
	typedef void(__fastcall* t_loot_click_slot)(BYTE, int);
	typedef int(__fastcall* t_loot_get_item_count)();

	class c_loot
	{
	private:
		ULONGLONG last_tick = 0;
		t_loot_get_base f_loot_get_base = (t_loot_get_base)core::offsets::fn::loot_get_base;
		t_loot_get_rarity f_loot_get_rarity = (t_loot_get_rarity)core::offsets::fn::loot_get_rarity;
		t_loot_get_name f_loot_get_name = (t_loot_get_name)core::offsets::fn::loot_get_name;
		t_loot_click_slot f_loot_click_slot = (t_loot_click_slot)core::offsets::fn::loot_click_slot;
		t_loot_get_item_count f_loot_get_item_count = (t_loot_get_item_count)core::offsets::fn::loot_item_count;
		sys::s_cfg_v* whitelistv = NULL; sys::s_cfg_v* blacklistv = NULL; sys::s_cfg_v* grey = NULL;
		sys::s_cfg_v* green = NULL; sys::s_cfg_v* blue = NULL;
		sys::s_cfg_v* orange = NULL; sys::s_cfg_v* yellow = NULL; sys::s_cfg_v* ienable = NULL;
		sys::s_cfg_v* ienable_filter = NULL;
		std::vector<int>			blacklist;
		std::vector<int>			whitelist;
		uint64_t					self = NULL, last_ent = NULL;
		void						spack(int k);
		uint64_t					gitem(int s);
		s_looting_item				gctx(uint64_t p);
		uint64_t					hnear();
		bool						pick(s_looting_item ctx);
		bool						lhas(int s);
	public:
		int act_id_cur = 0; ULONGLONG pack_time = 0;
		int loot_count_grey = 0, loot_count_blue = 0, loot_count_green = 0, loot_count_orange = 0, loot_count_yellow = 0;
		std::unordered_map<int, s_looting_item> looted_items = {}; int last_actor = 0; int last_item = 0;
		std::vector<uint64_t>       loot_proxys;
		void	 mloot();
		bool	 read_whitelist();
		bool	 read_blacklist();
		void     add_whitelist(int idx);
		void     add_blacklist(int idx);
		void     reset_whitelist();
		void     reset_blacklist();
		std::vector<std::string> gwl();
		std::vector<std::string> gbl();
		void starget(int k);
		void work(uint64_t self);
	};
	extern c_loot* loot;
}