#pragma once
#include <inc.h>
static void __stdcall init_thread()
{
	sdk::player::player_ = new ::sdk::player::c_player();
	sdk::util::log = new sdk::util::c_log();
	sdk::util::math = new sdk::util::c_math();
	lib::d3d11 = new lib::c_d3d11();
	sdk::render::render = new sdk::render::c_render();
	sdk::menu::menu = new sdk::menu::c_menu();
	sys::config = new sys::c_config();
	sys::visuals = new sys::c_visuals();
	sys::pack_tp = new sys::c_pack_tp();
	fn::patcher = new fn::c_patcher();
	sys::loot = new sys::c_loot();
	sys::cursor_tp = new sys::c_cursor_tp();
	sdk::menu::m_packet = new sdk::menu::c_m_packet();
	sys::pet_boost = new sys::c_pet_boost();
	sys::roar_bot = new sys::c_roar_bot();
	sdk::util::file = new sdk::util::c_file();
	sys::lua_q = new sys::c_lua_q();
	sys::key_q = new sys::c_key_q();
	sdk::util::log->add("starting init", sdk::util::e_info, true);
	//
	if (MH_Initialize() != MH_OK) { sdk::util::log->add("mh failed launch", sdk::util::e_log_type::e_critical, true); ExitProcess(0); }
	//
	auto hk_status = fn::setup(); if (hk_status == false) { sdk::util::log->add("failed hooking!", sdk::util::e_log_type::e_critical, true); ExitProcess(0); }
	//	
	sys::config->read();
	sys::config->vars();
	lib::d3d11->setup();
	sdk::util::file->update();
	sys::loot->read_blacklist(); sys::loot->read_whitelist();
	fn::patcher->create_patches();
	sdk::util::log->add("done init_thread", sdk::util::e_info, true);
}