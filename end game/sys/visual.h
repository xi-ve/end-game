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
	public:
		void work();
	};
	extern c_visuals* visuals;
}