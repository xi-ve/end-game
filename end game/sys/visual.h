#pragma once
#include <inc.h>
namespace sys
{
	class c_visuals
	{
	private:
		uint64_t self;
		void monster_proxy_debug();
		void teleport_points();
	public:
		void work();
	};
	extern c_visuals* visuals;
}