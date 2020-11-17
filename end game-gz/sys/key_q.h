#pragma once
#include <inc.h>
namespace sys
{
	struct s_key_input
	{
		s_key_input(std::vector<int> keys, int b, bool nothread = false)
		{
			if (keys.size() > 4) keys.erase(keys.begin() + 4, keys.end());
			for (auto a = 0; a < keys.size(); a++) k[a] = keys[a];
			d = b;
			end_time = GetTickCount64() + d; n = nothread;
		}
		int k[4] = { 0,0,0,0 }; int d = 0; ULONGLONG end_time = 0; bool n = false;
	};
	struct s_skill
	{
		s_skill()
		{
			input = new sys::s_key_input({0,0,0},0);
		};
		sys::s_key_input*   input = NULL;
		int					condition = 0;
		int					mp = 0;
		int					cd = 0;
		int					awakening = 0;
		//
		uint64_t			last_use = 0;
		uint64_t			next_possible_use = 0;
		int					total_uses = 0;

	};
	extern void __stdcall key_worker(void* a);
	class c_key_q
	{
	private:
		HWND lh = 0;
		std::deque<s_key_input*> key_queue;
	public:
		void bypass();

		ULONGLONG stopped_time = 0;
		bool thread_working = false;
		void add(s_key_input* k);
		void rm();
		void rma();
		void work();
		std::deque<s_key_input*> gq() { return key_queue; };
	};
	extern c_key_q* key_q;
}