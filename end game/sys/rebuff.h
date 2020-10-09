#pragma once
#include <inc.h>
namespace sys
{
	struct s_buff_info
	{
		s_buff_info(std::string a, int b)
		{
			n = a; i = b;
		};
		
		std::string n; int i;
	};
	typedef __int64(__fastcall* t_get_buff_desc)(uint64_t);
	class c_rebuff
	{
	private:
		uint64_t self = NULL; ULONGLONG exection = 0;
		sys::s_cfg_v* ienable = NULL; sys::s_cfg_v* string_buffs = NULL;
		t_get_buff_desc f_get_buff_desc = (t_get_buff_desc)core::offsets::fn::buff_get_name;
		std::string gstr(uint64_t p, int s);
		bool update();
		std::vector<s_buff_info> buffs_set = {};
		std::vector<std::string> buffs = {};
		int  gslot(int i);
	public:
		bool hitem(int i);
		int gibyname(std::string n);
		std::vector<std::string> gbuffs();
		std::vector<std::string> gsbuffs();
		std::vector<s_buff_info> gabuffs();
		bool load();
		bool add(std::string b, int i);
		void reset() { string_buffs->rval.clear(); buffs_set.clear(); };
		void work(uint64_t s);
	};
	extern c_rebuff* rebuff;
}