#pragma once
#include <inc.h>
namespace core
{
	namespace offsets
	{
		namespace hk
		{
			extern uint64_t packet_outbound;
			extern uint64_t lua_to_string;
			extern uint64_t lua_do_buffer;
			extern uint64_t proxy_deadbody;
			extern uint64_t proxy_delete;
			extern uint64_t is_key_pressed;
			extern uint64_t reset_input_class;
			extern uint64_t focus_validator;
		}
		namespace patch
		{
			extern uint64_t walk_to_pos;
			extern uint64_t walk_mouse;
			extern uint64_t window_focus_validity;
			extern uint64_t window_base;
		}
		namespace cl
		{
			extern uint64_t client_base;
			extern uint64_t camera_matrice;
			extern uint64_t ascii_table;
			extern uint64_t loot_base;
			extern uint64_t cursor_world;
		}
		namespace fn
		{
			extern uint64_t cast_ray;
			extern uint64_t actor_get_hp;
			extern uint64_t start_npc_dialog;
			extern uint64_t start_npc_interaction;
			extern uint64_t loot_get_rarity;
			extern uint64_t loot_get_name;
			extern uint64_t loot_get_base;
			extern uint64_t loot_click_slot;
			extern uint64_t loot_item_count;
			extern uint64_t loot_deadactor;
			extern uint64_t inv_get_item;
			extern uint64_t buff_get_name;
		}
		namespace actor
		{
			extern uint64_t actor_self;
			extern uint64_t interaction_current;
			extern uint64_t actor_list_base;
			extern uint64_t actor_list_start;
			extern uint64_t actor_list_end;
			extern uint64_t unsealed_pet_start;
			extern uint64_t unsealed_pet_end;
			extern uint64_t sealed_pet_start;
			extern uint64_t sealed_pet_end;
			extern uint64_t actor_was_looted;
			extern uint64_t actor_proxy_key;
			extern uint64_t actor_proxy_type;
			extern uint64_t actor_char_ctrl;
			extern uint64_t actor_mov_base;
			extern uint64_t actor_char_scene;
			extern uint64_t actor_loot_owner;
			extern uint64_t actor_networked_move;
			extern uint64_t actor_animation_speed;
			extern uint64_t actor_is_dead;
			extern uint64_t actor_mov_cx;
			extern uint64_t actor_mov_cy;
			extern uint64_t actor_mov_cz;
			extern uint64_t actor_mov_pure_alt_x;
			extern uint64_t actor_mov_pure_alt_y;
			extern uint64_t actor_mov_pure_alt_z;
			extern uint64_t actor_mov_pure_x;
			extern uint64_t actor_mov_pure_y;
			extern uint64_t actor_mov_pure_z;
			extern uint64_t actor_inv_base;
			extern uint64_t actor_inv_left;
			extern uint64_t actor_inv_max;
			extern uint64_t actor_can_play;
			extern uint64_t actor_cursor_3d_x;
			extern uint64_t actor_cursor_3d_y;
			extern uint64_t actor_cursor_3d_z;
			extern uint64_t actor_inv_raw_weight;
			extern uint64_t actor_inv_max_weight;
			extern uint64_t actor_guild_name;
			extern uint64_t actor_inv_gear_weight;
			extern uint64_t actor_attack_target;
			extern uint64_t actor_max_sp;
			extern uint64_t actor_combat_stance;
		}
	}
}