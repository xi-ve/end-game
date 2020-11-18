#pragma once
#include <inc.h>
static void __stdcall init_thread()
{
	ClearStart();
	sys::str = new sys::c_strenc();
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
	sys::rebuff = new sys::c_rebuff();
	sys::backend = new sys::c_backend();
	sys::protection = new sys::c_protection();
	sys::legit_bot = new sys::c_legit_bot();
	sys::scrollbot = new sys::c_scrollbot();
	sys::damage = new sys::c_damage();
	sdk::dialog::dialog = new sdk::dialog::c_dialog();
	sys::reconnect = new sys::c_reconnect();
	sdk::engine::symvar = new sdk::engine::c_symvar();
	sys::gear_exchanger = new sys::c_gear_exchanger();
	//
	auto i = 0;
	SECheckCodeIntegrity(&i, 666);
	SECheckProtection(&i, 666);
	SECheckVirtualPC(&i, 666);
	if (i != 666) ExitProcess(0);
	//
	if (MH_Initialize() != MH_OK) ExitProcess(0);
	//
	auto hk_status = fn::setup(); if (hk_status == false) ExitProcess(0);
	//	
	sys::config->read();
	sys::config->vars();
	lib::d3d11->setup();
	sdk::util::file->update();
	sys::loot->read_blacklist(); sys::loot->read_whitelist();
	fn::patcher->create_patches();
	sys::rebuff->load();
	ClearEnd();
}