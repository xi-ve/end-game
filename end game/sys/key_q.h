#pragma once
#include <inc.h>
namespace sys
{
	struct s_key_input
	{
		s_key_input(std::vector<int> keys, int b)
		{
			if (keys.size() > 4) keys.erase(keys.begin() + 4, keys.end());
			for (auto a = 0; a < keys.size(); a++) k[a] = keys[a];
			d = b;
		}
		int k[4] = {0,0,0,0}; int d = 0;
	};
	extern void __stdcall key_worker(void* a);
	class c_key_q
	{
	private:
		HWND lh = 0;
		std::deque<s_key_input*> key_queue;
		void bypass();
	public:
		bool thread_working = false;
		void add(s_key_input* k);
		void rm();
		void work();
		std::deque<s_key_input*> gq() { return key_queue; };
	};
	extern c_key_q* key_q;
}