#pragma once
#include <inc.h>
namespace sys
{
	class c_reconnect
	{
	private:
		sys::s_cfg_v* ienable = NULL;
		bool should_restart_roar = false, did_walk = false;
		ULONGLONG wait_timer = 0, execution = 0;
	public:
		int is_reconnecting();
		void work();
	};
	extern c_reconnect* reconnect;
}