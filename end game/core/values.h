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
			extern uint64_t add_damage;
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
			extern uint64_t dialog_base;
			extern uint64_t ui_manager;
			extern uint64_t symvar_base;
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
			extern uint64_t dialog_gettext;
			extern uint64_t dialog_getbutton;
			extern uint64_t canjump;
			extern uint64_t delete_item;
			extern uint64_t uneq_item;
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
			extern uint64_t eq_dur_main_weapon;
			extern uint64_t eq_dur_main_weapon_id;
			extern uint64_t eq_dur_sub_weapon;
			extern uint64_t eq_dur_sub_weapon_id;
			extern uint64_t eq_dur_gather_tool;
			extern uint64_t eq_dur_gather_tool_id;
			extern uint64_t eq_dur_armor;
			extern uint64_t eq_dur_armor_id;
			extern uint64_t eq_dur_gloves;
			extern uint64_t eq_dur_gloves_id;
			extern uint64_t eq_dur_shoes;
			extern uint64_t eq_dur_shoes_id;
			extern uint64_t eq_dur_helmet;
			extern uint64_t eq_dur_helmet_id;
			extern uint64_t eq_dur_neck;
			extern uint64_t eq_dur_neck_id;
			extern uint64_t eq_dur_ring1;
			extern uint64_t eq_dur_ring1_id;
			extern uint64_t eq_dur_ring2;
			extern uint64_t eq_dur_ring2_id;
			extern uint64_t eq_dur_ear1;
			extern uint64_t eq_dur_ear1_id;
			extern uint64_t eq_dur_ear2;
			extern uint64_t eq_dur_ear2_id;
			extern uint64_t eq_dur_belt;
			extern uint64_t eq_dur_belt_id;
			extern uint64_t eq_dur_awak;
			extern uint64_t eq_dur_awak_id;
		}
	}
}