#pragma once
#include <inc.h>
namespace core
{
	namespace offsets
	{
		namespace hk
		{
			//48 8B C4 55 41 54 41 55 41 56 41 57 48 8B EC 48 83 EC 60 48 C7 45 ? ? ? ? ? 48 89 58 08 48 89 70 10 48 89 78 18 45 0F B6 E1 
			static uint64_t packet_outbound = 0x140D92C20;
			//tostring
			static uint64_t lua_to_string = 0x141DA5F20;
		}
		namespace patch
		{
			//C6 83 ? ? ? ? ? 48 85 FF 
			static uint64_t walk_to_pos = 0x1406E3A00;
			//48 8B CB 40 84 F6 0F 84 ? ? ? ? 48 8D 54 24 ? 
			static uint64_t walk_mouse = 0x1406E3AF1;
			//48 8B C4 48 89 48 08 55 48 8D 68 A1 48 81 EC ? ? ? ? 48 C7 45 ? ? ? ? ? 48 89 58 10 48 89 70 18 48 89 78 20 0F 29 70 E8 
			static uint64_t window_focus_validity = 0x1402C3930;
			//48 8D 0D ? ? ? ? E8 ? ? ? ? 84 C0 75 13 45 33 C0 48 8B CF 41 8D 50 28 
			static uint64_t window_base = 0x143D02290;
		}
		namespace cl
		{
			//48 8B 35 ? ? ? ? 48 85 F6 0F 84 ? ? ? ? 48 8B 76 18
			static uint64_t client_base = 0x143CB54A0;
			//0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 10 44 24 ? 0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 28 05 ? ? ? ?
			static uint64_t camera_matrice = 0x144B38960;
		}
		namespace fn
		{
			//48 8B C4 56 57 41 56 48 81 EC ? ? ? ? 48 C7 80 ? ? ? ? ? ? ? ? 48 89 58 10 48 89 68 18 0F 29 70 D8 
			static uint64_t cast_ray = 0x14168D460;
			//40 53 48 83 EC 20 48 8D 99 ? ? ? ? 48 8B CB E8 ? ? ? ? 44 8B 43 08 45 85 C0 75 0D
			static uint64_t actor_get_hp = 0x14079A2C0;
			//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 50 48 8B 35 ? ? ? ? 
			static uint64_t start_npc_dialog = 0x1407DFA70;
			//48 89 5C 24 ? 48 89 74 24 ? 57 48 83 EC 30 48 8B F9 FF 15 ? ? ? ? 
			static uint64_t start_npc_interaction = 0x1408005C0;
			//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 8B F2 41 0F B6 F8 
			static uint64_t is_key_pressed = 0x1418D9070;
			//40 53 48 83 EC 20 48 8B D9 33 D2 48 83 C1 40 
			static uint64_t reset_input_class = 0x1418D9100;
			//getGradeType
			static uint64_t loot_get_rarity = 0x140BA2A70;
			//40 53 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 8D 91 ? ? ? ? 83 3A 00 75 0D 48 8D 05 ? ? ? ? 48 83 C4 50 5B C3 48 8D 59 68 48 C7 43 ? ? ? ? ? 
			static uint64_t loot_get_name = 0x140A81550;
			//looting_getItem
			static uint64_t loot_get_base = 0x14094D7E0;
			//looting_slotClick
			static uint64_t loot_click_slot = 0x140A53380;
			//looting_getItemCount
			static uint64_t loot_item_count = 0x140A53000;
		}
		namespace actor
		{
			//FromClient_SelfPlayerExpChanged
			static uint64_t actor_self = 0x143D09E90;
			//EventChattingMessageUpdate
			static uint64_t actor_list_start = 0x143CFDEB0;
			static uint64_t actor_list_end = actor_list_start + 0x8;
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
			static uint64_t actor_inv_base = 0x1F00;
			static uint64_t actor_inv_left = actor_inv_base + 0x18;
			static uint64_t actor_inv_max = actor_inv_left + 0x19;
			static uint64_t actor_can_play = actor_inv_base - 0xB;
			static uint64_t actor_cursor_3d_x = 0x5CF8;
			static uint64_t actor_cursor_3d_y = actor_cursor_3d_x+0x4;
			static uint64_t actor_cursor_3d_z = actor_cursor_3d_y+0x4;
		}
	}
}