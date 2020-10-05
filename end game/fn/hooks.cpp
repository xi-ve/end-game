#include <inc.h>
//
fn::t_packet_outbound fn::o_packet_outbound;
fn::t_lua_to_string fn::o_lua_to_string;
fn::t_lua_dobuffer fn::o_lua_dobuffer;
fn::t_strc_pack fn::o_strc_pack;
fn::t_proxy_deadbody fn::o_proxy_deadbody;
fn::t_proxy_delete fn::o_proxy_delete;
fn::t_reset_input_class fn::o_reset_input_class;
fn::t_is_key_pressed fn::o_is_key_ressed;
bool fn::log_dobuffer = false;
//
sys::s_cfg_v* fn::ibypass_trial = NULL; sys::s_cfg_v* fn::iteleport_gen2 = NULL; sys::s_cfg_v* fn::iloot_enable = NULL;
sys::s_cfg_v* fn::ikey_ctp = NULL; sys::s_cfg_v* fn::ilock_key = NULL;
bool fn::executing = false;
ULONGLONG fn::execution_time = 0;
ULONGLONG fn::time_since_player_playable = 0;
//
bool fn::setup()
{
	CodeReplaceStart();
	void* asdf;
	if (!fn::hook((void*)core::offsets::hk::packet_outbound, &fn::f_packet_outbound, (void**)&fn::o_packet_outbound)) return false;
	if (!fn::hook((void*)core::offsets::hk::lua_to_string, &fn::f_lua_to_string, (void**)&fn::o_lua_to_string)) return false;
	if (!fn::hook((void*)core::offsets::hk::lua_do_buffer, &fn::f_lua_dobuffer, (void**)&fn::o_lua_dobuffer)) return false;
	if (!fn::hook((void*)core::offsets::hk::proxy_deadbody, &fn::f_proxy_deadbody, (void**)&fn::o_proxy_deadbody)) return false;
	if (!fn::hook((void*)core::offsets::hk::proxy_delete, &fn::f_proxy_delete, (void**)&fn::o_proxy_delete)) return false;
	if (!fn::hook((void*)core::offsets::hk::is_key_pressed, &fn::f_is_key_pressed, (void**)&fn::o_is_key_ressed)) return false;
	if (!fn::hook((void*)core::offsets::hk::reset_input_class, &fn::f_reset_input_class, (void**)&fn::o_reset_input_class)) return false;
	if (!fn::hook((void*)&GetFocus, &fn::f_get_focus, (void**)&asdf)) return false;
	sdk::util::log->add("hooking completed", sdk::util::e_info, true);
	return true;
	CodeReplaceEnd();
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

	if (!ibypass_trial) ibypass_trial = sys::config->gvar("packet", "ibypass_trial");
	if (!iteleport_gen2) iteleport_gen2 = sys::config->gvar("packet", "iteleport_gen2");

	if (ibypass_trial->iv)				if (b == 5471) return 0;
	if (sys::pack_tp->get_packet_again) sys::pack_tp->capture_packet(buf, (uint64_t)pack, size, b);

	sdk::menu::m_packet->work((uint64_t)pack, size, enc, unk, unk2, xkey);

	/*if (b == 4995)
	{
		fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		auto br = sys::pet_boost->work((uint64_t)pack);
		fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
		return 0;
	}*/

	//sdk::util::log->add(std::string(__FUNCTION__) \
	//	.append(" opcode: ").append(std::to_string(b)) \
	//	.append(" size  : ").append(std::to_string(size)) \
	//	//.append(" packet: ").append(buf.printHex()),
	//	,sdk::util::e_info, true);
	
	return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
}

uint64_t __fastcall fn::f_lua_to_string(void* a1)
{
	if (!a1) return fn::o_lua_to_string(a1);
	if (executing) return fn::o_lua_to_string(a1);
	executing = true;
	auto v = fn::o_lua_to_string(a1);
	sys::backend->work();
	//
	if (!iloot_enable) iloot_enable = sys::config->gvar("loot", "ienable");
	if (!ikey_ctp) ikey_ctp = sys::config->gvar("keybinds", "itp_key");
	if (!ilock_key) ilock_key = sys::config->gvar("keybinds", "ilock_key");
	//
	if (GetTickCount64() > execution_time) execution_time = GetTickCount64() + 15;
	else { executing = false; return v; }
	auto self_actor_proxy = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!self_actor_proxy) { executing = false; return v; }
	auto can_play = *(byte*)(self_actor_proxy + core::offsets::actor::actor_can_play);
	if (!can_play) { time_since_player_playable = GetTickCount64(); executing = false; return v; }
	sys::lua_q->work(); sys::key_q->work();
	sdk::player::player_->update_actors(self_actor_proxy);
	sdk::player::player_->update_inventory(self_actor_proxy);
	sys::rebuff->work(self_actor_proxy);
	//sdk::player::player_->update_pets(self_actor_proxy);
	if (iloot_enable->iv) sys::loot->work(self_actor_proxy);
	sys::roar_bot->work(self_actor_proxy);
	if (GetAsyncKeyState(ikey_ctp->iv) & 1) sys::cursor_tp->work(self_actor_proxy);
	if (GetAsyncKeyState(ilock_key->iv) & 1)
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
uint64_t fn::f_lua_dobuffer(void* arg1, const char* arg2) 
{
	if (!arg1) return fn::o_lua_dobuffer(arg1, arg2);
	sys::lua_q->sparam(arg1);
	if (strstr(arg2, "Over")
		|| strstr(arg2, "MouseOn")
		|| strstr(arg2, "Tooltip") || strstr(arg2, "ToolTip")
		|| strstr(arg2, "ANI") || strstr(arg2, "Ani")
		|| strstr(arg2, "Update")
		|| strstr(arg2, "Frame")
		|| strstr(arg2, "Help")
		|| strstr(arg2, "Pushed")
		|| strstr(arg2, "Chat")
		|| strstr(arg2, "quest") || strstr(arg2, "Quest")
		|| strstr(arg2, "MenuRemake")
		|| strstr(arg2, "Icon")
		|| strstr(arg2, "QuickSlot")
		|| strstr(arg2, "Hide")
		|| strstr(arg2, "collect")
		|| arg2[0] == '\0') return fn::o_lua_dobuffer(arg1, arg2);
	if (fn::log_dobuffer) sdk::util::log->add(arg2, sdk::util::e_info, true);
	if (sys::roar_bot->glua_actions)
	{
		sys::roar_bot->last_lua_actions.push_back(arg2);
	}
	//sdk::util::log->add(std::string("arg1:").append(sdk::util::log->as_hex((uint64_t)arg1)).append(" arg2:").append(arg2), sdk::util::e_info, true);
	return fn::o_lua_dobuffer(arg1, arg2);
}
bool fn::f_self_gm()
{
	return 1;
}
uint64_t fn::f_strc_pack(uint64_t a)
{
	auto r = fn::o_strc_pack(a);

	auto ptr = *(uint64_t*)(a + 0x13e0);
	if (!ptr) return r;
	auto tb = core::get_vtable_name(*(uint64_t*)(ptr));
	if (!tb.empty()) sdk::util::log->add(std::string("a:").append(sdk::util::log->as_hex(a)).append(" tb:").append(tb), sdk::util::e_info, true);

	//sdk::util::log->add(std::string("arg1:").append(sdk::util::log->as_hex(a)).append(" r:").append(sdk::util::log->as_hex(r)), sdk::util::e_info, true);
	return r;
}

uint64_t fn::f_proxy_deadbody(uint64_t a, uint64_t b, int c)
{
	auto r = fn::o_proxy_deadbody(a, b, c);
	if (!iloot_enable) iloot_enable = sys::config->gvar("loot", "ienable");
	//sdk::util::log->add(std::string("[deadbody] key:").append(sdk::util::log->as_hex(*(int*)(r + core::offsets::actor::actor_proxy_key))), sdk::util::e_info, true);
	if (iloot_enable->iv)
	{
		auto self_key = *(int*)(*(uint64_t*)(core::offsets::actor::actor_self) + core::offsets::actor::actor_proxy_key);
		auto owner = *(int*)(r + core::offsets::actor::actor_loot_owner);
		if (self_key != owner) return r;
		sys::loot->loot_proxys.push_back(r);
	}
	return r;
}

bool fn::f_proxy_delete(uint64_t a, int b)
{
	if (sys::loot->loot_proxys.size())
	{
		for (auto f = 0; f < sys::loot->loot_proxys.size(); f++)
		{
			auto c = sys::loot->loot_proxys[f]; if (!c) continue;
			auto k = *(int*)(c + core::offsets::actor::actor_proxy_key);
			if (k == b) sys::loot->loot_proxys.erase(sys::loot->loot_proxys.begin() + f);
		}
	}
	//sdk::util::log->add(std::string("[delete] a:").append(sdk::util::log->as_hex(a)), sdk::util::e_info, true);
	auto r = fn::o_proxy_delete(a, b);
	return r;
}
int __fastcall fn::f_reset_input_class(uint64_t a)
{
	if (sys::key_q->thread_working) return 1;
	else return fn::o_reset_input_class(a);
}
bool __fastcall fn::f_is_key_pressed(uint64_t a, int b, BYTE c)
{
	for (auto t : sys::key_q->gq())
	{
		for (auto g : t->k)
		{
			if (g == b) return 1;
		}
	}
	return fn::o_is_key_ressed(a,b,c);
}
HWND __fastcall fn::f_get_focus()
{
	if (!lib::d3d11->h) return GetForegroundWindow();
	return lib::d3d11->h;
}
