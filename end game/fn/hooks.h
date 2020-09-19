#pragma once
#include <inc.h>
namespace fn
{
	extern bool setup();
	extern bool hook(LPVOID offset, LPVOID exchangee, LPVOID* backup);
	extern void send_packet(ByteBuffer p, int opc, int size);
	typedef uint64_t(__fastcall* t_packet_outbound)(void*, uint16_t, uint8_t, uint8_t, uint64_t, const CHAR*);
	extern t_packet_outbound o_packet_outbound;
	extern uint64_t __fastcall f_packet_outbound(void* pack, uint16_t size, uint8_t enc, uint8_t unk, uint64_t unk2, const CHAR* xkey);
	typedef uint64_t(__fastcall* t_lua_to_string)(uint64_t);
	extern t_lua_to_string o_lua_to_string;
	extern uint64_t __fastcall f_lua_to_string(uint64_t a1);
}