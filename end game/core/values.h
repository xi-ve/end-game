#pragma once
#include <inc.h>
namespace core
{
	namespace offsets
	{
		namespace hk
		{
			//int __fastcall sub_140D8A750(__int64 a1, __int16 a2, __int64 a3) <-- packet outbound func | ref: 41 56 48 83 EC 30 48 C7 44 24 ? ? ? ? ? 48 89 5C 24 ? 48 89 74 24 ? 48 89 7C 24 ? 49 8B F8 0F B7 F2 
			static uint64_t packet_outbound = 0x140D8AB00;
		}
		namespace fn
		{

		}
		namespace actor
		{
			static uint64_t actor_self = 0x143CF4CB0;
			static uint64_t actor_list_start = 0x143CE8E30;
			static uint64_t actor_list_end = 0x143CE8E38;
		}
	}
}