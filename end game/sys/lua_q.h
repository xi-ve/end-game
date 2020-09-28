#pragma once
#include <inc.h>
namespace sys
{
	class c_lua_q
	{
	private:
		std::vector<std::string> lua_queue;
		void* lua_state; const char* lua_base;
	public:
		void sparam(void* a, const char* b);
		void add(std::string q);
		void work();
	};
	extern c_lua_q* lua_q;
}