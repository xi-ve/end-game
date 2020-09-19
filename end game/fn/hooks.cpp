#include <inc.h>
//
static fn::t_packet_outbound fn::o_packet_outbound;
static fn::t_lua_to_string fn::o_lua_to_string;
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
uint64_t __fastcall fn::f_packet_outbound(void* pack, uint16_t size, uint8_t enc, uint8_t unk, uint64_t unk2, const CHAR* xkey)
{
	if (!pack )	return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
	__int16* a = (__int16*)pack; if (a == nullptr) return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey); auto b = *a;
	ByteBuffer buf; for (auto c = 0; c < size; c++) buf.put(*(uint8_t*)((uint64_t)pack + c));
	sys::pack_tp->param5 = unk2;

	if (b == 5875) return 0;

	/*sdk::util::log->add(std::string(__FUNCTION__) \
		.append(" opcode: ").append(std::to_string(b)) \
		.append(" size  : ").append(std::to_string(size)) \
		.append(" packet: ").append(buf.printHex()), sdk::util::e_info, true);*/

	if (GetAsyncKeyState(VK_NUMPAD2) & 1) sys::pack_tp->get_packet_again = true;
	if (GetAsyncKeyState(VK_NUMPAD3) & 1) sys::pack_tp->teleport_to_marker();
	if (GetAsyncKeyState(VK_NUMPAD4) & 1)
	{
		auto pck = sys::pack_tp->packet_copy;
		pck.putLong(GetTickCount64(), sys::pack_tp->time_signature);
		sdk::util::log->add("sending");
		sys::pack_tp->send_packet(pck, sys::pack_tp->packet_id, pck.buf.size());
	}
	if (GetAsyncKeyState(VK_NUMPAD5) & 1)
	{
		sys::pack_tp->_startPos.clear();
		sys::pack_tp->_endPos.clear();
		sys::pack_tp->_doneTp = 1;
		sys::pack_tp->_setTp = 0;
	}
	if (sys::pack_tp->get_packet_again && size <= 450 && size >= 300)
	{
		sys::pack_tp->x_pos.clear();
		auto self = *(uint64_t*)(core::offsets::actor::actor_self);
		if (!self) return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		if (!sdk::player::player_->get<BYTE>(self, core::offsets::actor::actor_can_play)) return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		auto pos = sdk::player::player_->gpos(self);
		auto t_min = GetTickCount64() - 5000;
		auto t_max = GetTickCount64() + 5000;
		for (auto c = 0; c < size; c++)
		{
			auto as_uulong = *(uint64_t*)((uint64_t)pack + c);
			if (as_uulong >= t_min && as_uulong <= t_max)
			{
				sys::pack_tp->time_signature = c;
				break;
			}
		}
		for (auto c = 0; c < size; c++)
		{
			auto as_flt = *(float*)((uint64_t)pack + c);
			if ((int)as_flt == (int)pos.x)
			{
				sys::pack_tp->x_pos.push_back(c);
			}
		}
		if (sys::pack_tp->x_pos.size() < 9) {
			sys::pack_tp->x_pos.clear(); return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		}
		sys::pack_tp->packet_copy = buf;
		sys::pack_tp->packet_id = b;
		sys::pack_tp->get_packet_again = false;
		sdk::util::log->add(std::string("found packet:").append(std::to_string(b)).append(" pos count:").append(std::to_string(sys::pack_tp->x_pos.size())), sdk::util::e_info, true);
	}
	return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
}

uint64_t __fastcall fn::f_lua_to_string(uint64_t a1)
{
	if (!a1) return fn::o_lua_to_string(a1);
	//
	auto self_actor_proxy = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!self_actor_proxy) return fn::o_lua_to_string(a1);
	auto can_play = *(byte*)(self_actor_proxy + core::offsets::actor::actor_can_play);
	if (!can_play) return fn::o_lua_to_string(a1);
	sdk::player::player_->update_actors(self_actor_proxy);
	if (GetAsyncKeyState(VK_NUMPAD1) & 1)
	{
		FreeConsole();
		AllocConsole(); freopen("CONIN$", "r", stdin); freopen("CONOUT$", "w", stdout); freopen("CONOUT$", "w", stderr);
		sdk::util::log->add("rebound console");
	}
	//
	return fn::o_lua_to_string(a1);
}
