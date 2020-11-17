#pragma once
#include <inc.h>
namespace fn
{
	class c_patcher
	{
	public:
		void patch(uint64_t a, uint64_t e, BYTE i);
		void create_patches();
	};
	extern c_patcher* patcher;
}