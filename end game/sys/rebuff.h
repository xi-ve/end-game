#pragma once
#include <inc.h>
namespace sys
{
	typedef __int64(__fastcall* t_get_buff_desc)(uint64_t);
	class c_rebuff
	{
	private:
		uint64_t self = NULL;
		t_get_buff_desc f_get_buff_desc = (t_get_buff_desc)core::offsets::fn::buff_get_name;
		std::string gstr(uint64_t p, int s);
		bool update();
		std::vector<std::string> buffs;
	public:
		std::vector<std::string> gbuffs();
		void work(uint64_t s);
	};
	extern c_rebuff* rebuff;
}