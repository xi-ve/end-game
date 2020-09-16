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
	sdk::util::log->add("starting init", sdk::util::e_info, true);
	//
	if (MH_Initialize() != MH_OK) { sdk::util::log->add("mh failed launch", sdk::util::e_log_type::e_critical, true); ExitProcess(0); }
	//
	auto hk_status = fn::setup(); if (hk_status == false) { sdk::util::log->add("failed hooking!", sdk::util::e_log_type::e_critical, true); ExitProcess(0); }
	//
	lib::d3d11->setup();
	//
	sdk::util::log->add("done init_thread", sdk::util::e_info, true);
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)core::core_cheat_worker, 0, 0, 0);
}