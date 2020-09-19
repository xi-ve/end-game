#pragma once
#include <inc.h>
namespace fn
{
	class c_patcher
	{
	private:
		void patch(uint64_t a, uint64_t e, BYTE i);
	public:
		void create_patches();
	};
	extern c_patcher* patcher;
}