#pragma once
#include <inc.h>
namespace sys
{
	extern void __stdcall tp_thread_gen1();
	class c_cursor_tp
	{		
	public:
		bool                 _doneTp = 1;
		bool                 _alt = 0;
		bool                 _setTp = 0;
		sdk::util::c_vector3             _startPos;
		sdk::util::c_vector3             _endPos;
		void work(uint64_t s);
		void set_pos(uint64_t s, sdk::util::c_vector3 p);
	};
	extern c_cursor_tp* cursor_tp;
}