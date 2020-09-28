#pragma once
#include <inc.h>
namespace fn
{
	extern bool executing;

	extern bool setup();
	extern bool hook(LPVOID offset, LPVOID exchangee, LPVOID* backup);
	extern void send_packet(ByteBuffer p, int opc, int size);
	typedef uint64_t(__fastcall* t_packet_outbound)(void*, uint16_t, uint8_t, uint8_t, uint64_t, const CHAR*);
	extern t_packet_outbound o_packet_outbound;
	extern uint64_t __fastcall f_packet_outbound(void* pack, uint16_t size, uint8_t enc, uint8_t unk, uint64_t unk2, const CHAR* xkey);
	typedef uint64_t(__fastcall* t_lua_to_string)(void*);
	extern t_lua_to_string o_lua_to_string;
	extern uint64_t __fastcall f_lua_to_string(void* a1);
	extern uint64_t f_lua_dobuffer(void*, const char*, size_t, const char*);
	typedef uint64_t(__stdcall* t_lua_dobuffer)(void* arg1, const char* arg2, size_t arg3, const char* arg4);
	extern t_lua_dobuffer o_lua_dobuffer;
	extern bool f_self_gm();
	typedef uint64_t(__fastcall* t_strc_pack)(uint64_t);
	extern t_strc_pack o_strc_pack;
	extern uint64_t f_strc_pack(uint64_t a);
	typedef uint64_t(__fastcall* t_proxy_deadbody)(uint64_t, uint64_t, int);
	extern t_proxy_deadbody o_proxy_deadbody;
	extern uint64_t f_proxy_deadbody(uint64_t a, uint64_t b, int c);
	//char __fastcall sub_1407A6300(__int64 a1, int a2)
	typedef bool(__fastcall* t_proxy_delete)(uint64_t, int);
	extern t_proxy_delete o_proxy_delete;
	extern bool f_proxy_delete(uint64_t a, int b);
	//
	extern sys::s_cfg_v* ibypass_trial;
	extern sys::s_cfg_v* iteleport_gen2;
	extern sys::s_cfg_v* iloot_enable;
	extern sys::s_cfg_v* ikey_ctp;
	//
	extern ULONGLONG execution_time;
}