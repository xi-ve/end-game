#include <inc.h>

//48 8B C4 55 41 54 41 55 41 56 41 57 48 8B EC 48 83 EC 60 48 C7 45 ? ? ? ? ? 48 89 58 08 48 89 70 10 48 89 78 18 45 0F B6 E1 
uint64_t core::offsets::hk::packet_outbound = 0x140E218B0;
//tostring
uint64_t core::offsets::hk::lua_to_string = 0x141E8F7B0;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 48 8B 39 48 8B F2 
uint64_t core::offsets::hk::lua_do_buffer = 0x141641D30;
//48 89 4C 24 ? 57 48 83 EC 30 48 C7 44 24 ? ? ? ? ? 48 89 5C 24 ? 48 89 74 24 ? 8B F2 48 8B D9 48 8D 05 ? ? ? ? 48 89 01 48 8D B9 ? ? ? ? 48 8B 07 
uint64_t core::offsets::hk::proxy_deadbody = 0x14081E040;//0x1407F77C0;//ref v7 = sub_xxxx(0x4A0...  /1160
//89 54 24 10 55 56 57 41 54 41 55 41 56 41 57 48 83 EC 40 48 C7 44 24 ? ? ? ? ? 
uint64_t core::offsets::hk::proxy_delete = 0x140807960;
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 20 8B F2 41 0F B6 F8 
uint64_t core::offsets::hk::is_key_pressed = 0x1419C2AF0;
//40 53 48 83 EC 20 48 8B D9 33 D2 48 83 C1 40 
uint64_t core::offsets::hk::reset_input_class = 0x1419C2B80;
//40 53 48 83 EC 20 48 8B C2 48 8B D9 48 85 D2 75 06 
uint64_t core::offsets::hk::focus_validator = 0x141996760;
//44 89 4C 24 ? 44 89 44 24 ? 89 54 24 10 48 89 4C 24 ? 55 
uint64_t core::offsets::hk::add_damage = 0x140B67290;


//C6 83 ? ? ? ? ? 48 85 FF 
uint64_t core::offsets::patch::walk_to_pos = 0x140728590;
//48 8B CB 40 84 F6 0F 84 ? ? ? ? 48 8D 54 24 ? 
uint64_t core::offsets::patch::walk_mouse = 0x140728681 + 0x18;
//48 8B C4 48 89 48 08 55 48 8D 68 A1 48 81 EC ? ? ? ? 48 C7 45 ? ? ? ? ? 48 89 58 10 48 89 70 18 48 89 78 20 0F 29 70 E8 
uint64_t core::offsets::patch::window_focus_validity = 0x1402FA0A0;
//48 8D 0D ? ? ? ? E8 ? ? ? ? 84 C0 75 13 45 33 C0 48 8B CF 41 8D 50 28 
uint64_t core::offsets::patch::window_base = 0x143E666A0;


//48 8B 35 ? ? ? ? 48 85 F6 0F 84 ? ? ? ? 48 8B 76 18
uint64_t core::offsets::cl::client_base = 0x143E18900;
//0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 10 44 24 ? 0F 29 05 ? ? ? ? 0F 10 4C 24 ? 0F 29 0D ? ? ? ? 0F 28 05 ? ? ? ?
uint64_t core::offsets::cl::camera_matrice = 0x144FB2110;
//48 8B 05 ? ? ? ? 4C 8B 00 48 8B 48 08 49 2B C8 48 C1 F9 04 48 3B CA 76 40 
uint64_t core::offsets::cl::ascii_table = 0x143E189B8;
//81 0D ? ? ? ? ? ? ? ? 48 8B 05 ? ? ? ? C6 05 ? ? ? ? ? 
uint64_t core::offsets::cl::loot_base = 0x143E6FDD0;
//F2 0F 10 35 ? ? ? ? F2 0F 11 74 24 ? 44 8B 3D ? ? ? ? 
uint64_t core::offsets::cl::cursor_world = 0x143E6F018;
//48 8D 0D ? ? ? ? C7 80 ? ? ? ? ? ? ? ? E8 ? ? ? ? 
uint64_t core::offsets::cl::dialog_base = 0x143E74050;
//48 8B 05 ? ? ? ? 48 8B 90 ? ? ? ? 48 8B 4A 48 
uint64_t core::offsets::cl::ui_manager = 0x143E20DB0;
//ch_updatingSkinningTextureBatchSize second off_14xxxxx counting upwards
uint64_t core::offsets::cl::symvar_base = 0x143CDC9B8;


//48 8B C4 56 57 41 56 48 81 EC ? ? ? ? 48 C7 80 ? ? ? ? ? ? ? ? 48 89 58 10 48 89 68 18 0F 29 70 D8 
uint64_t core::offsets::fn::cast_ray = 0x141775ED0;
//40 53 48 83 EC 20 48 8D 99 ? ? ? ? 48 8B CB E8 ? ? ? ? 44 8B 43 08 45 85 C0 75 0D
uint64_t core::offsets::fn::actor_get_hp = 0x0;//not used anymore
//48 89 5C 24 ? 48 89 6C 24 ? 48 89 74 24 ? 57 48 83 EC 50 48 8B 35 ? ? ? ? 
uint64_t core::offsets::fn::start_npc_dialog = 0x014036A8E0;
//E8 ? ? ? ? E9 ? ? ? ? 41 8B 86 ? ? ? ? C1 E8 08 A8 01 49 8B CE 
uint64_t core::offsets::fn::start_npc_interaction = 0x140865C10;
//getGradeType
uint64_t core::offsets::fn::loot_get_rarity = 0x140C2C7B0;
//ItemEnchantStaticStatusWrapper getName
uint64_t core::offsets::fn::loot_get_name = 0x140C2C5B0;
//looting_getItem
uint64_t core::offsets::fn::loot_get_base = 0x140ACF960;
//looting_slotClick
uint64_t core::offsets::fn::loot_click_slot = 0x140ACFE20;
//looting_getItemCount
uint64_t core::offsets::fn::loot_item_count = 0x140ACFAA0;
//40 53 48 83 EC 30 48 C7 44 24 ? ? ? ? ? 0F B6 DA 0F B6 D1 
uint64_t core::offsets::fn::inv_get_item = 0x140ACCC30;
//40 53 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 8B D9 48 8D 51 20 33 C0 66 3B 02 73 0C 48 8D 0D ? ? ? ? E8 ? ? ? ? 48 8D 90 ? ? ? ? 
uint64_t core::offsets::fn::buff_get_name = 0x140315F60;
//40 57 48 83 EC 50 48 C7 44 24 ? ? ? ? ? 48 89 5C 24 ? 48 89 74 24 ? 48 8B D9 C7 44 24 ? ? ? ? ? 65 48 8B 04 25 ? ? ? ? B9 ? ? ? ? 48 8B 10 8B 04 11 39 05 ? ? ? ? 0F 8F ? ? ? ? 
uint64_t core::offsets::fn::dialog_gettext = 0x14068E0B0;
//4C 8B 41 70 48 B8 ? ? ? ? ? ? ? ? 48 8B 49 78 4C 63 CA 49 2B C8 48 F7 E9 48 C1 FA 05 
uint64_t core::offsets::fn::dialog_getbutton = 0x14068EA30;
//E8 ? ? ? ? 83 F8 FF 0F 84 ? ? ? ? 4C 89 B4 24 ? ? ? ? 
uint64_t core::offsets::fn::canjump = 0x1416A60A0;
//48 83 EC 68 48 C7 44 24 ? ? ? ? ? 8B C1 
uint64_t core::offsets::fn::delete_item = 0x140AD0720;
//80 F9 20 0F 83 ? ? ? ? 48 83 EC 58 
uint64_t core::offsets::fn::uneq_item = 0x0140ACF680;

//FromClient_SelfPlayerExpChanged
uint64_t core::offsets::actor::actor_self = 0x143E6EFD0;
//48 8B 35 ? ? ? ? 45 33 FF 48 85 F6 
uint64_t core::offsets::actor::interaction_current = 0x143E74080;
//48 8D 15 ? ? ? ? 48 8D 4D EF E8 ? ? ? ? 90 4C 8B 75 F7  
uint64_t core::offsets::actor::actor_list_base = 0x143E6EB20	;//-40 to list
uint64_t core::offsets::actor::actor_list_start = 0x143E6EB60;//470 delta to local
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
uint64_t core::offsets::actor::actor_inv_base = 0x1F30;
uint64_t core::offsets::actor::actor_inv_left = core::offsets::actor::actor_inv_base + 0x18;
uint64_t core::offsets::actor::actor_inv_max = core::offsets::actor::actor_inv_left + 0x1;
uint64_t core::offsets::actor::actor_can_play = core::offsets::actor::actor_inv_base - 0xB;
uint64_t core::offsets::actor::actor_cursor_3d_x = 0x5D78;
uint64_t core::offsets::actor::actor_cursor_3d_y = core::offsets::actor::actor_cursor_3d_x + 0x4;
uint64_t core::offsets::actor::actor_cursor_3d_z = core::offsets::actor::actor_cursor_3d_y + 0x4;
uint64_t core::offsets::actor::actor_inv_raw_weight = core::offsets::actor::actor_inv_base - 0x8;
uint64_t core::offsets::actor::actor_inv_max_weight = 0x10C8;
uint64_t core::offsets::actor::actor_guild_name = 0x1328;
uint64_t core::offsets::actor::actor_inv_gear_weight = 0x2178;
uint64_t core::offsets::actor::actor_attack_target = 0xB58;
uint64_t core::offsets::actor::actor_max_sp = 0x124;
uint64_t core::offsets::actor::actor_combat_stance = 0x47c;
uint64_t core::offsets::actor::eq_dur_awak = 0x9D0;
uint64_t core::offsets::actor::eq_dur_awak_id = core::offsets::actor::eq_dur_awak + 0x4;
uint64_t core::offsets::actor::eq_dur_main_weapon = 0x548;
uint64_t core::offsets::actor::eq_dur_main_weapon_id = core::offsets::actor::eq_dur_main_weapon + 0x4;
uint64_t core::offsets::actor::eq_dur_sub_weapon = core::offsets::actor::eq_dur_main_weapon + 0x28;
uint64_t core::offsets::actor::eq_dur_sub_weapon_id = core::offsets::actor::eq_dur_main_weapon + 0x2C;
uint64_t core::offsets::actor::eq_dur_gather_tool = core::offsets::actor::eq_dur_sub_weapon + 0x28;
uint64_t core::offsets::actor::eq_dur_gather_tool_id = core::offsets::actor::eq_dur_sub_weapon + 0x2C;
uint64_t core::offsets::actor::eq_dur_armor = core::offsets::actor::eq_dur_gather_tool + 0x28;
uint64_t core::offsets::actor::eq_dur_armor_id = core::offsets::actor::eq_dur_gather_tool + 0x2C;
uint64_t core::offsets::actor::eq_dur_gloves = core::offsets::actor::eq_dur_armor + 0x28;
uint64_t core::offsets::actor::eq_dur_gloves_id = core::offsets::actor::eq_dur_armor + 0x2C;
uint64_t core::offsets::actor::eq_dur_shoes = core::offsets::actor::eq_dur_gloves + 0x28;
uint64_t core::offsets::actor::eq_dur_shoes_id = core::offsets::actor::eq_dur_gloves + 0x2C;
uint64_t core::offsets::actor::eq_dur_helmet = core::offsets::actor::eq_dur_shoes + 0x28;
uint64_t core::offsets::actor::eq_dur_helmet_id = core::offsets::actor::eq_dur_shoes + 0x2C;
uint64_t core::offsets::actor::eq_dur_neck = core::offsets::actor::eq_dur_helmet + 0x28;
uint64_t core::offsets::actor::eq_dur_neck_id = core::offsets::actor::eq_dur_helmet + 0x2C;
uint64_t core::offsets::actor::eq_dur_ring1 = core::offsets::actor::eq_dur_neck + 0x28;
uint64_t core::offsets::actor::eq_dur_ring1_id = core::offsets::actor::eq_dur_neck + 0x2C;
uint64_t core::offsets::actor::eq_dur_ring2 = core::offsets::actor::eq_dur_ring1 + 0x28;
uint64_t core::offsets::actor::eq_dur_ring2_id = core::offsets::actor::eq_dur_ring1 + 0x2C;
uint64_t core::offsets::actor::eq_dur_ear1 = core::offsets::actor::eq_dur_ring2 + 0x28;
uint64_t core::offsets::actor::eq_dur_ear1_id = core::offsets::actor::eq_dur_ring2 + 0x2C;
uint64_t core::offsets::actor::eq_dur_ear2 = core::offsets::actor::eq_dur_ear1 + 0x28;
uint64_t core::offsets::actor::eq_dur_ear2_id = core::offsets::actor::eq_dur_ear1 + 0x2C;
uint64_t core::offsets::actor::eq_dur_belt = core::offsets::actor::eq_dur_ear2 + 0x28;
uint64_t core::offsets::actor::eq_dur_belt_id = core::offsets::actor::eq_dur_ear2 + 0x2C;
