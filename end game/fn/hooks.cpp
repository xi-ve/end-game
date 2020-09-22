#include <inc.h>
//
static fn::t_packet_outbound fn::o_packet_outbound;
static fn::t_lua_to_string fn::o_lua_to_string;
static bool fn::executing = false;
//
bool fn::setup()
{
	if (!fn::hook((void*)core::offsets::hk::packet_outbound, &fn::f_packet_outbound, (void**)&fn::o_packet_outbound)) return false;
	if (!fn::hook((void*)core::offsets::hk::lua_to_string, &fn::f_lua_to_string, (void**)&fn::o_lua_to_string)) return false;
	sdk::util::log->add("hooking completed", sdk::util::e_info, true);
	return true;
}
bool fn::hook(LPVOID offset, LPVOID exchangee, LPVOID* backup)
{
	if (MH_CreateHook(offset, exchangee, backup) != MH_OK) return false;
	if (MH_EnableHook(offset) != MH_OK)					   return false;
	sdk::util::log->add(std::string(sdk::util::log->as_hex((uint64_t)offset)).append(" -> ").append(sdk::util::log->as_hex((uint64_t)exchangee)), sdk::util::e_info, true);
	return true;
}
void fn::send_packet(ByteBuffer p, int opc, int size)
{
	if (sys::pack_tp->param5 != 0) fn::o_packet_outbound(&p.buf[0], size, 1, 0, sys::pack_tp->param5, "eee");
}
uint64_t __fastcall fn::f_packet_outbound(void* pack, uint16_t size, uint8_t enc, uint8_t unk, uint64_t unk2, const CHAR* xkey)
{
	if (!pack) return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
	__int16* a = (__int16*)pack; if (a == nullptr) return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey); auto b = *a;
	ByteBuffer buf; for (auto c = 0; c < size; c++) buf.put(*(uint8_t*)((uint64_t)pack + c));
	sys::pack_tp->param5 = unk2;

	static auto ibypass_trial = sys::config->gvar("packet", "ibypass_trial");
	static auto iteleport_gen2 = sys::config->gvar("packet", "iteleport_gen2");

	if (ibypass_trial->iv)				if (b == 5875) return 0;
	if (sys::pack_tp->get_packet_again) sys::pack_tp->capture_packet(buf, (uint64_t)pack, size, b);

	sdk::menu::m_packet->work((uint64_t)pack, size, enc, unk, unk2, xkey);

	/*if (b == 4995)
	{
		fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		auto br = sys::pet_boost->work((uint64_t)pack);
		fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		return 0;
	}*/

	/*sdk::util::log->add(std::string(__FUNCTION__) \
		.append(" opcode: ").append(std::to_string(b)) \
		.append(" size  : ").append(std::to_string(size)) \
		.append(" packet: ").append(buf.printHex()), sdk::util::e_info, true);*/
	
	return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
}

uint64_t __fastcall fn::f_lua_to_string(void* a1)
{
	if (!a1) return fn::o_lua_to_string(a1);
	static auto execution_time = ULONGLONG(0);
	if (executing) return fn::o_lua_to_string(a1);
	executing = true;
	auto v = fn::o_lua_to_string(a1);
	//
	static auto iloot_enable = sys::config->gvar("loot", "ienable");
	static auto ikey_ctp = sys::config->gvar("keybinds", "itp_key");
	//
	if (GetTickCount64() > execution_time) execution_time = GetTickCount64() + 15;
	else { executing = false; return v; }
	auto self_actor_proxy = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!self_actor_proxy) { executing = false; return v; }
	auto can_play = *(byte*)(self_actor_proxy + core::offsets::actor::actor_can_play);
	if (!can_play) { executing = false; return v; }
	sdk::player::player_->update_actors(self_actor_proxy);
	sdk::player::player_->update_inventory(self_actor_proxy);
	sdk::player::player_->update_pets(self_actor_proxy);
	if (iloot_enable->iv) sys::loot->work(self_actor_proxy);
	if (GetAsyncKeyState(ikey_ctp->iv) & 1) sys::cursor_tp->work(self_actor_proxy);
	if (GetAsyncKeyState(VK_F5) & 1)
	{
		auto c = *(uint64_t*)(self_actor_proxy + core::offsets::actor::actor_char_ctrl);
		auto s = *(uint64_t*)(c + core::offsets::actor::actor_char_scene);
		auto cur = *(float*)(s + core::offsets::actor::actor_animation_speed);
		if (cur == 1.f) *(float*)(s + core::offsets::actor::actor_animation_speed) = 8000;
		else *(float*)(s + core::offsets::actor::actor_animation_speed) = 1.f;
	}
	executing = false;
	//
	return v;
}
