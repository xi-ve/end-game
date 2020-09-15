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
			static uint64_t lua_to_string = 0x141D980D0;

		}
		namespace patch
		{
			static uint64_t walk_to_pos = 0x1406E2780;
			static uint64_t walk_mouse = 0x1406E2871;
			static uint64_t window_focus_validity = 0x1402C3C00;
			static uint64_t window_base = 0x143CED210;
		}
		namespace cl
		{
			static uint64_t client_base = 0x143CA0420;
		}
		namespace fn
		{
			static uint64_t cast_ray = 0x14167FC60;
		}
		namespace actor
		{
			static uint64_t actor_self = 0x143CF4CB0;
			static uint64_t actor_list_start = 0x143CE8E30;
			static uint64_t actor_list_end = 0x143CE8E38;
			//struct offsets
			static uint64_t actor_proxy_key = 0x58;
			static uint64_t actor_proxy_type = 0x5C;
			static uint64_t actor_char_ctrl = 0x410;
			static uint64_t actor_mov_base = 0x8;
			static uint64_t actor_char_scene = 0x10;
			static uint64_t actor_networked_move = 0x198;
			static uint64_t actor_mov_cx = 0x120;
			static uint64_t actor_mov_cy = actor_mov_cx+0x4;
			static uint64_t actor_mov_cz = actor_mov_cy+0x4;
			static uint64_t actor_mov_pure_x = 0x170;
			static uint64_t actor_mov_pure_y = actor_mov_pure_x+0x4;
			static uint64_t actor_mov_pure_z = actor_mov_pure_y+0x4;
			static uint64_t actor_inv_base = 0x1EF8;
			static uint64_t actor_inv_left = actor_inv_base + 0x18;
			static uint64_t actor_inv_max = actor_inv_left + 0x19;
			static uint64_t actor_can_play = actor_inv_base - 0xB;
			static uint64_t actor_cursor_3d_x = 0x5CF0;
			static uint64_t actor_cursor_3d_y = actor_cursor_3d_x+0x4;
			static uint64_t actor_cursor_3d_z = actor_cursor_3d_y+0x4;
		}
	}
}