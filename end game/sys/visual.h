#pragma once
#include <inc.h>
namespace sys
{
	class c_visuals
	{
	private:
		uint64_t self;
		std::vector<sdk::util::c_vector3> gcircle(sdk::util::c_vector3 from, float dst);
		void monster_proxy_debug();
		void alive_proxy_debug();
		void portal();
		void trace_debug();
		void roar_path();
	public:
		int filter = 34;
		void work();
	};
	extern c_visuals* visuals;
}