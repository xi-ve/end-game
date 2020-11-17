#pragma once
#include <inc.h>
namespace sys
{
	class c_protection
	{
	private:
		sys::s_cfg_v* iprotection_range = NULL; sys::s_cfg_v* smart_detect = NULL; sys::s_cfg_v* iheight_range;
		sys::s_cfg_v* iexit_on_player = NULL;
	public:
		bool players_in_range(uint64_t s);
	};
	extern c_protection* protection;
}