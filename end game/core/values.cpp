#include <inc.h>

//48 8B C4 55 41 54 41 55 41 56 41 57 48 8B EC 48 83 EC 60 48 C7 45 ? ? ? ? ? 48 89 58 08 48 89 70 10 48 89 78 18 45 0F B6 E1 
uint64_t core::offsets::hk::packet_outbound = 0x140DFAF70;
//tostring
uint64_t core::offsets::hk::lua_to_string = 0x141E34790;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 48 8B 39 48 8B F2 
uint64_t core::offsets::hk::lua_do_buffer = 0x1415E7D70;
//48 89 4C 24 ? 57 48 83 EC 30 48 C7 44 24 ? ? ? ? ? 48 89 5C 24 ? 48 89 74 24 ? 8B F2 48 8B D9 48 8D 05 ? ? ? ? 48 89 01 48 8D B9 ? ? ? ? 48 8B 07 
uint64_t core::offsets::hk::proxy_deadbody = 0x140807C00;//0x1407F77C0;//ref v7 = sub_xxxx(0x4A0...  /1160
//89 54 24 10 55 56 57 41 54 41 55 41 56 41 57 48 83 EC 40 48 C7 44 24 ? ? ? ? ? 
uint64_t core::offsets::hk::proxy_delete = 0x1407F16C0;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 8B F2 41 0F B6 F8 
uint64_t core::offsets::hk::is_key_pressed = 0x141967B90;
//40 53 48 83 EC 20 48 8B D9 33 D2 48 83 C1 40 
uint64_t core::offsets::hk::reset_input_class = 0x141967C20;
//40 53 48 83 EC 20 48 8B C2 48 8B D9 48 85 D2 75 06 
uint64_t core::offsets::hk::focus_validator = 0x14193BDD0;
//44 89 4C 24 ? 44 89 44 24 ? 89 54 24 10 48 89 4C 24 ? 55 
uint64_t core::offsets::hk::add_damage = 0x140B445F0;


//C6 83 ? ? ? ? ? 48 85 FF 
uint64_t core::offsets::patch::walk_to_pos = 0x140714630;
//48 8B CB 40 84 F6 0F 84 ? ? ? ? 48 8D 54 24 ? 
uint64_t core::offsets::patch::walk_mouse = 0x140714721 + 0x18;
//48 8B C4 48 89 48 08 55 48 8D 68 A1 48 81 EC ? ? ? ? 48 C7 45 ? ? ? ? ? 48 89 58 10 48 89 70 18 48 89 78 20 0F 29 70 E8 
uint64_t core::offsets::patch::window_focus_validity = 0x1402ED5D0;
//48 8D 0D ? ? ? ? E8 ? ? ? ? 84 C0 75 13 45 33 C0 48 8B CF 41 8D 50 28 
uint64_t core::offsets::patch::window_base = 0x143DD5260;


//48 8B 35 ? ? ? ? 48 85 F6 0F 84 ? ? ? ? 48 8B 76 18
uint64_t core::offsets::cl::client_base = 0x143D88480;
//0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 10 44 24 ? 0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 28 05 ? ? ? ?
uint64_t core::offsets::cl::camera_matrice = 0x144C102B0;
//48 8B 05 ? ? ? ? 4C 8B 00 48 8B 48 08 49 2B C8 48 C1 F9 04 48 3B CA 76 40 
uint64_t core::offsets::cl::ascii_table = 0x143D88540;
//81 0D ? ? ? ? ? ? ? ? 48 8B 05 ? ? ? ? C6 05 ? ? ? ? ? 
uint64_t core::offsets::cl::loot_base = 0x143DDE7D0;
//F2 0F 10 35 ? ? ? ? F2 0F 11 74 24 ? 44 8B 3D ? ? ? ? 
uint64_t core::offsets::cl::cursor_world = 0x143DDDA18;
//48 8D 0D ? ? ? ? C7 80 ? ? ? ? ? ? ? ? E8 ? ? ? ? 
uint64_t core::offsets::cl::dialog_base = 0x143DE2A50;
//48 8B 05 ? ? ? ? 48 8B 90 ? ? ? ? 48 8B 4A 48 
uint64_t core::offsets::cl::ui_manager = 0x143D90938;
//
uint64_t core::offsets::cl::symvar_base = 0x143C50418;


//48 8B C4 56 57 41 56 48 81 EC ? ? ? ? 48 C7 80 ? ? ? ? ? ? ? ? 48 89 58 10 48 89 68 18 0F 29 70 D8 
uint64_t core::offsets::fn::cast_ray = 0x14171B750;
//40 53 48 83 EC 20 48 8D 99 ? ? ? ? 48 8B CB E8 ? ? ? ? 44 8B 43 08 45 85 C0 75 0D
uint64_t core::offsets::fn::actor_get_hp = 0x0;//not used anymore
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 50 48 8B 35 ? ? ? ? 
uint64_t core::offsets::fn::start_npc_dialog = 0x14035E110;
//E8 ? ? ? ? E9 ? ? ? ? 41 8B 86 ? ? ? ? C1 E8 08 A8 01 49 8B CE 
uint64_t core::offsets::fn::start_npc_interaction = 0x14084ECA0;
//getGradeType
uint64_t core::offsets::fn::loot_get_rarity = 0x140C097C0;
//ItemEnchantStaticStatusWrapper getName
uint64_t core::offsets::fn::loot_get_name = 0x140C095C0;
//looting_getItem
uint64_t core::offsets::fn::loot_get_base = 0x140AAE6C0;
//looting_slotClick
uint64_t core::offsets::fn::loot_click_slot = 0x140AAEB80;
//looting_getItemCount
uint64_t core::offsets::fn::loot_item_count = 0x140AAE800;
//40 53 48 83 EC 30 48 C7 44 24 ? ? ? ? ? 0F B6 DA 0F B6 D1 
uint64_t core::offsets::fn::inv_get_item = 0x140AAB9A0;
//40 53 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 8B D9 48 8D 51 20 33 C0 66 3B 02 73 0C 48 8D 0D ? ? ? ? E8 ? ? ? ? 48 8D 90 ? ? ? ? 
uint64_t core::offsets::fn::buff_get_name = 0x140309490;
//40 57 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 89 5C 24 ? 48 89 74 24 ? 48 8B D9 C7 44 24 ? ? ? ? ? 65 48 8B 04 25 ? ? ? ? B9 ? ? ? ? 48 8B 10 8B 04 11 39 05 ? ? ? ? 0F 8F ? ? ? ? 
uint64_t core::offsets::fn::dialog_gettext = 0x14067FD30;
//4C 8B 41 70 48 B8 ? ? ? ? ? ? ? ? 48 8B 49 78 4C 63 CA 49 2B C8 48 F7 E9 48 C1 FA 05 
uint64_t core::offsets::fn::dialog_getbutton = 0x1406806B0;
//E8 ? ? ? ? 83 F8 FF 0F 84 ? ? ? ? 4C 89 B4 24 ? ? ? ? 
uint64_t core::offsets::fn::canjump = 0x14164BB30;

//FromClient_SelfPlayerExpChanged
uint64_t core::offsets::actor::actor_self = 0x143DDD9D0;
//48 8B 35 ? ? ? ? 45 33 FF 48 85 F6 
uint64_t core::offsets::actor::interaction_current = 0x143DE2A80;
//48 8D 15 ? ? ? ? 48 8D 4D EF E8 ? ? ? ? 90 4C 8B 75 F7  
uint64_t core::offsets::actor::actor_list_base = 0x143DDD520;//-40 to list
uint64_t core::offsets::actor::actor_list_start = 0x143DDD560;//470 delta to local
uint64_t core::offsets::actor::actor_list_end = core::offsets::actor::actor_list_start + 0x8;
uint64_t core::offsets::actor::unsealed_pet_start = 0x143D7CBA0 + 0x18;
uint64_t core::offsets::actor::unsealed_pet_end = core::offsets::actor::unsealed_pet_start + 0x8;
uint64_t core::offsets::actor::sealed_pet_start = 0x143D7CBA0;
uint64_t core::offsets::actor::sealed_pet_end = core::offsets::actor::sealed_pet_start + 0x8;
//struct offsets
uint64_t core::offsets::actor::actor_was_looted = 0x480;
uint64_t core::offsets::actor::actor_proxy_key = 0x58;
uint64_t core::offsets::actor::actor_proxy_type = 0x5C;
uint64_t core::offsets::actor::actor_char_ctrl = 0x428;
uint64_t core::offsets::actor::actor_mov_base = 0x8;
uint64_t core::offsets::actor::actor_char_scene = 0x10;
uint64_t core::offsets::actor::actor_loot_owner = 0x460;
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
uint64_t core::offsets::actor::actor_inv_base = 0x1F10;
uint64_t core::offsets::actor::actor_inv_left = core::offsets::actor::actor_inv_base + 0x18;
uint64_t core::offsets::actor::actor_inv_max = core::offsets::actor::actor_inv_left + 0x1;
uint64_t core::offsets::actor::actor_can_play = core::offsets::actor::actor_inv_base - 0xB;
uint64_t core::offsets::actor::actor_cursor_3d_x = 0x5D40;
uint64_t core::offsets::actor::actor_cursor_3d_y = core::offsets::actor::actor_cursor_3d_x + 0x4;
uint64_t core::offsets::actor::actor_cursor_3d_z = core::offsets::actor::actor_cursor_3d_y + 0x4;
uint64_t core::offsets::actor::actor_inv_raw_weight = core::offsets::actor::actor_inv_base - 0x8;
uint64_t core::offsets::actor::actor_inv_max_weight = 0x10B0;
uint64_t core::offsets::actor::actor_guild_name = 0x1102;
uint64_t core::offsets::actor::actor_inv_gear_weight = 0x2140;
uint64_t core::offsets::actor::actor_attack_target = 0xB58;
uint64_t core::offsets::actor::actor_max_sp = 0x124;
uint64_t core::offsets::actor::actor_combat_stance = 0x47c;
