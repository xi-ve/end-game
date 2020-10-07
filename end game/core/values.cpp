#include <inc.h>

//48 8B C4 55 41 54 41 55 41 56 41 57 48 8B EC 48 83 EC 60 48 C7 45 ? ? ? ? ? 48 89 58 08 48 89 70 10 48 89 78 18 45 0F B6 E1 
uint64_t core::offsets::hk::packet_outbound = 0x140DD1AE0;
//tostring
uint64_t core::offsets::hk::lua_to_string = 0x141DFCEB0;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 48 8B 39 48 8B F2 
uint64_t core::offsets::hk::lua_do_buffer = 0x1415B0F60;
//48 8B C4 56 57 41 56 48 83 EC 70 48 C7 40 ? ? ? ? ? 48 89 58 08 48 89 68 18 45 8B F0 48 8B FA 48 8B E9 8B 52 38 E8 ? ? ? ? 8B 57 38 48 8B CD E8 ? ? ? ? 48 85 C0 0F 85 ? ? ? ? 
uint64_t core::offsets::hk::proxy_deadbody = 0x1407EC030;//ref v7 = sub_xxxx(0x488...
//89 54 24 10 55 56 57 41 54 41 55 41 56 41 57 48 83 EC 40 48 C7 44 24 ? ? ? ? ? 
uint64_t core::offsets::hk::proxy_delete = 0x1407D5160;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 8B F2 41 0F B6 F8 
uint64_t core::offsets::hk::is_key_pressed = 0x1419302A0;
//40 53 48 83 EC 20 48 8B D9 33 D2 48 83 C1 40 
uint64_t core::offsets::hk::reset_input_class = 0x141930330;


//C6 83 ? ? ? ? ? 48 85 FF 
uint64_t core::offsets::patch::walk_to_pos = 0x140708F00;
//48 8B CB 40 84 F6 0F 84 ? ? ? ? 48 8D 54 24 ? 
uint64_t core::offsets::patch::walk_mouse = 0x140708FF1 + 0x18;
//48 8B C4 48 89 48 08 55 48 8D 68 A1 48 81 EC ? ? ? ? 48 C7 45 ? ? ? ? ? 48 89 58 10 48 89 70 18 48 89 78 20 0F 29 70 E8 
uint64_t core::offsets::patch::window_focus_validity = 0x1402E9140;
//48 8D 0D ? ? ? ? E8 ? ? ? ? 84 C0 75 13 45 33 C0 48 8B CF 41 8D 50 28 
uint64_t core::offsets::patch::window_base = 0x143D86FE0;


//48 8B 35 ? ? ? ? 48 85 F6 0F 84 ? ? ? ? 48 8B 76 18
uint64_t core::offsets::cl::client_base = 0x143D39260;
//0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 10 44 24 ? 0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 28 05 ? ? ? ?
uint64_t core::offsets::cl::camera_matrice = 0x144BBF0E0;
//48 8B 05 ? ? ? ? 4C 8B 00 48 8B 48 08 49 2B C8 48 C1 F9 04 48 3B CA 76 40 
uint64_t core::offsets::cl::ascii_table = 0x143D39318;
//81 0D ? ? ? ? ? ? ? ? 48 8B 05 ? ? ? ? C6 05 ? ? ? ? ? 
uint64_t core::offsets::cl::loot_base = 0x143D8FB30;
//F2 0F 10 35 ? ? ? ? F2 0F 11 74 24 ? 44 8B 3D ? ? ? ? 
uint64_t core::offsets::cl::cursor_world = 0x143D8ED58;


//48 8B C4 56 57 41 56 48 81 EC ? ? ? ? 48 C7 80 ? ? ? ? ? ? ? ? 48 89 58 10 48 89 68 18 0F 29 70 D8 
uint64_t core::offsets::fn::cast_ray = 0x1416E4620;
//40 53 48 83 EC 20 48 8D 99 ? ? ? ? 48 8B CB E8 ? ? ? ? 44 8B 43 08 45 85 C0 75 0D
uint64_t core::offsets::fn::actor_get_hp = 0x1407CC670;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 50 48 8B 35 ? ? ? ? 
uint64_t core::offsets::fn::start_npc_dialog = 0x14035A020;
//48 89 5C 24 ? 48 89 74 24 ? 57 48 83 EC 30 48 8B F9 FF 15 ? ? ? ? 
uint64_t core::offsets::fn::start_npc_interaction = 0x140833020;
//getGradeType
uint64_t core::offsets::fn::loot_get_rarity = 0x140BE1680;
//40 53 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 8D 91 ? ? ? ? 83 3A 00 75 0D 48 8D 05 ? ? ? ? 48 83 C4 50 5B C3 48 8D 59 68 48 C7 43 ? ? ? ? ? 
uint64_t core::offsets::fn::loot_get_name = 0x140BE1480;
//looting_getItem
uint64_t core::offsets::fn::loot_get_base = 0x140A8B5D0;
//looting_slotClick
uint64_t core::offsets::fn::loot_click_slot = 0x140A8BA90;
//looting_getItemCount
uint64_t core::offsets::fn::loot_item_count = 0x140A8B710;
//40 53 48 83 EC 30 48 C7 44 24 ? ? ? ? ? 0F B6 DA 0F B6 D1 
uint64_t core::offsets::fn::inv_get_item = 0x140A88650;
//40 53 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 8B D9 48 8D 51 20 33 C0 66 3B 02 73 0C 48 8D 0D ? ? ? ? E8 ? ? ? ? 48 8D 90 ? ? ? ? 
uint64_t core::offsets::fn::buff_get_name = 0x140305000;


//FromClient_SelfPlayerExpChanged
uint64_t core::offsets::actor::actor_self = 0x143D8ED10;
//
uint64_t core::offsets::actor::interaction_current = 0x143D93DE0;
//48 8D 15 ? ? ? ? 48 8D 4D EF E8 ? ? ? ? 90 4C 8B 75 F7  
uint64_t core::offsets::actor::actor_list_base = 0x143D8E860;
uint64_t core::offsets::actor::actor_list_start = 0x143D8E8A0;//470 delta to local
uint64_t core::offsets::actor::actor_list_end = core::offsets::actor::actor_list_start + 0x8;
uint64_t core::offsets::actor::unsealed_pet_start = 0x143D7CBA0 + 0x18;
uint64_t core::offsets::actor::unsealed_pet_end = core::offsets::actor::unsealed_pet_start + 0x8;
uint64_t core::offsets::actor::sealed_pet_start = 0x143D7CBA0;
uint64_t core::offsets::actor::sealed_pet_end = core::offsets::actor::sealed_pet_start + 0x8;
//struct offsets
uint64_t core::offsets::actor::actor_was_looted = 0x468;
uint64_t core::offsets::actor::actor_proxy_key = 0x58;
uint64_t core::offsets::actor::actor_proxy_type = 0x5C;
uint64_t core::offsets::actor::actor_char_ctrl = 0x410;
uint64_t core::offsets::actor::actor_mov_base = 0x8;
uint64_t core::offsets::actor::actor_char_scene = 0x10;
uint64_t core::offsets::actor::actor_loot_owner = 0x448;
uint64_t core::offsets::actor::actor_networked_move = 0x198;
uint64_t core::offsets::actor::actor_animation_speed = 0x4C0;
uint64_t core::offsets::actor::actor_is_dead = 0x1F0;
uint64_t core::offsets::actor::actor_mov_cx = 0x120;
uint64_t core::offsets::actor::actor_mov_cy = core::offsets::actor::actor_mov_cx + 0x4;
uint64_t core::offsets::actor::actor_mov_cz = core::offsets::actor::actor_mov_cy + 0x4;
uint64_t core::offsets::actor::actor_mov_pure_alt_x = 0x8;
uint64_t core::offsets::actor::actor_mov_pure_alt_y = core::offsets::actor::actor_mov_pure_alt_x + 0x4;
uint64_t core::offsets::actor::actor_mov_pure_alt_z = core::offsets::actor::actor_mov_pure_alt_y + 0x4;
uint64_t core::offsets::actor::actor_mov_pure_x = 0x170;
uint64_t core::offsets::actor::actor_mov_pure_y = core::offsets::actor::actor_mov_pure_x + 0x4;
uint64_t core::offsets::actor::actor_mov_pure_z = core::offsets::actor::actor_mov_pure_y + 0x4;
uint64_t core::offsets::actor::actor_inv_base = 0x1EF8;
uint64_t core::offsets::actor::actor_inv_left = core::offsets::actor::actor_inv_base + 0x18;
uint64_t core::offsets::actor::actor_inv_max = core::offsets::actor::actor_inv_left + 0x1;
uint64_t core::offsets::actor::actor_can_play = core::offsets::actor::actor_inv_base - 0xB;
uint64_t core::offsets::actor::actor_cursor_3d_x = 0x5D18;
uint64_t core::offsets::actor::actor_cursor_3d_y = core::offsets::actor::actor_cursor_3d_x + 0x4;
uint64_t core::offsets::actor::actor_cursor_3d_z = core::offsets::actor::actor_cursor_3d_y + 0x4;
uint64_t core::offsets::actor::actor_inv_raw_weight = core::offsets::actor::actor_inv_base - 0x8;
uint64_t core::offsets::actor::actor_inv_max_weight = 0x1098;
uint64_t core::offsets::actor::actor_guild_name = 0x1102;
uint64_t core::offsets::actor::actor_inv_gear_weight = 0x2128;
uint64_t core::offsets::actor::actor_attack_target = 0xB40;
