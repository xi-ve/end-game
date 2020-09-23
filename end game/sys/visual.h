#pragma once
#include <inc.h>
namespace sys
{
	class c_visuals
	{
	private:
		uint64_t self;
		void monster_proxy_debug();
		void portal();
		void trace_debug();
	public:
		int filter = 34;
		void work();
	};
	extern c_visuals* visuals;
}