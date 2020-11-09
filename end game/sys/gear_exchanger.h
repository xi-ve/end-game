#pragma once
#include <inc.h>
namespace sys
{
	struct s_exchange
	{
		s_exchange(byte s, uint64_t a, WORD i)
		{
			slot = s;
			adr = a;
			item = i;
		};
		byte slot = 0;
		uint64_t adr = 0;
		WORD item = 0;
	};
	extern void __stdcall exchange();
	typedef int(__fastcall* t_delete_item)(int key, bool inv_type, int slot, int count);
	typedef void(__fastcall* t_unequip)(byte slot);
	class c_gear_exchanger
	{
	public:		
		t_delete_item f_delete_item = (t_delete_item)0x140AAF480;
		t_unequip	  f_unequip = (t_unequip)0x140AAE3F0;
		bool thread_is_working = false;
		bool done_exchange = false;
		bool work();
	};
	extern c_gear_exchanger* gear_exchanger;
}