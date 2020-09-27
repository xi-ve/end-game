#include <inc.h>
//
static fn::t_packet_outbound fn::o_packet_outbound;
static fn::t_lua_to_string fn::o_lua_to_string;
static fn::t_lua_dobuffer fn::o_lua_dobuffer;
static fn::t_strc_pack fn::o_strc_pack;
static fn::t_proxy_deadbody fn::o_proxy_deadbody;
static fn::t_proxy_delete fn::o_proxy_delete;
static bool fn::executing = false;
//
bool fn::setup()
{
	void* asdf;
	if (!fn::hook((void*)core::offsets::hk::packet_outbound, &fn::f_packet_outbound, (void**)&fn::o_packet_outbound)) return false;
	if (!fn::hook((void*)core::offsets::hk::lua_to_string, &fn::f_lua_to_string, (void**)&fn::o_lua_to_string)) return false;
	if (!fn::hook((void*)core::offsets::hk::lua_do_buffer, &fn::f_lua_dobuffer, (void**)&fn::o_lua_dobuffer)) return false;
	if (!fn::hook((void*)0x1407BCF80, &fn::f_proxy_deadbody, (void**)&fn::o_proxy_deadbody)) return false;
	if (!fn::hook((void*)0x1407A6300, &fn::f_proxy_delete, (void**)&fn::o_proxy_delete)) return false;
	if (!fn::hook((void*)0x140AE62B0, &fn::f_self_gm, (void**)&asdf)) return false;
	if (!fn::hook((void*)0x140AE62F0, &fn::f_self_gm, (void**)&asdf)) return false;
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
	//sdk::player::player_->update_pets(self_actor_proxy);
	if (iloot_enable->iv) sys::loot->work(self_actor_proxy);
	sys::roar_bot->work(self_actor_proxy);
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
uint64_t fn::f_lua_dobuffer(void* arg1, const char* arg2, size_t arg3, const char* arg4) 
{
	if (!arg1) return fn::o_lua_dobuffer(arg1, arg2, arg3, arg4);
	static auto str6_14785_Update17 = new s_str_container(std::vector<int>{92, 121, 109, 104, 125, 108}); /*Update*/ static auto _Update1487014964_dec = str6_14785_Update17->get(); static auto str5_21568_Frame16 = new s_str_container(std::vector<int>{79, 123, 104, 100, 108}); /*Frame*/ static auto _Frame1487014963_dec = str5_21568_Frame16->get(); static auto str3_14785_Ani14 = new s_str_container(std::vector<int>{72, 103, 96}); /*Ani*/ static auto _Ani1487014961_dec = str3_14785_Ani14->get();
	static auto str4_7420_Over14 = new s_str_container(std::vector<int>{70, 127, 108, 123}); /*Over*/ static auto _Over75057595_dec = str4_7420_Over14->get(); static auto str7_7472_MouseOn17 = new s_str_container(std::vector<int>{68, 102, 124, 122, 108, 70, 103}); /*MouseOn*/ static auto _MouseOn75577651_dec = str7_7472_MouseOn17->get(); static auto str7_20197_Tooltip18 = new s_str_container(std::vector<int>{93, 102, 102, 101, 125, 96, 121}); /*Tooltip*/ static auto _Tooltip75577651_dec = str7_20197_Tooltip18->get(); static auto str7_7472_ToolTip17 = new s_str_container(std::vector<int>{93, 102, 102, 101, 93, 96, 121}); /*ToolTip*/ static auto _ToolTip75577651_dec = str7_7472_ToolTip17->get(); static auto str3_20197_ANI14 = new s_str_container(std::vector<int>{72, 71, 64}); /*ANI*/ static auto _ANI75577647_dec = str3_20197_ANI14->get(); static auto str3_7472_Ani13 = new s_str_container(std::vector<int>{72, 103, 96}); /*Ani*/ static auto _Ani75577647_dec = str3_7472_Ani13->get(); static auto str6_20197_Update17 = new s_str_container(std::vector<int>{92, 121, 109, 104, 125, 108}); /*Update*/ static auto _Update75577650_dec = str6_20197_Update17->get(); static auto str5_7472_Frame15 = new s_str_container(std::vector<int>{79, 123, 104, 100, 108}); /*Frame*/ static auto _Frame75577649_dec = str5_7472_Frame15->get(); static auto str4_20197_Help15 = new s_str_container(std::vector<int>{65, 108, 101, 121}); /*Help*/ static auto _Help75577648_dec = str4_20197_Help15->get(); static auto str6_7472_Pushed16 = new s_str_container(std::vector<int>{89, 124, 122, 97, 108, 109}); /*Pushed*/ static auto _Pushed75577650_dec = str6_7472_Pushed16->get(); static auto str4_20197_Chat15 = new s_str_container(std::vector<int>{74, 97, 104, 125}); /*Chat*/ static auto _Chat75577648_dec = str4_20197_Chat15->get(); static auto str5_7472_quest15 = new s_str_container(std::vector<int>{120, 124, 108, 122, 125}); /*quest*/ static auto _quest75577649_dec = str5_7472_quest15->get(); static auto str5_20197_Quest16 = new s_str_container(std::vector<int>{88, 124, 108, 122, 125}); /*Quest*/ static auto _Quest75577649_dec = str5_20197_Quest16->get(); static auto str10_7472_MenuRemake21 = new s_str_container(std::vector<int>{68, 108, 103, 124, 91, 108, 100, 104, 98, 108}); /*MenuRemake*/ static auto _MenuRemake75577654_dec = str10_7472_MenuRemake21->get(); static auto str4_20197_Icon15 = new s_str_container(std::vector<int>{64, 106, 102, 103}); /*Icon*/ static auto _Icon75577648_dec = str4_20197_Icon15->get(); static auto str9_7472_QuickSlot19 = new s_str_container(std::vector<int>{88, 124, 96, 106, 98, 90, 101, 102, 125}); /*QuickSlot*/ static auto _QuickSlot75577653_dec = str9_7472_QuickSlot19->get(); static auto str4_20197_Hide15 = new s_str_container(std::vector<int>{65, 96, 109, 108}); /*Hide*/ static auto _Hide75577648_dec = str4_20197_Hide15->get(); static auto str7_7472_collect17 = new s_str_container(std::vector<int>{106, 102, 101, 101, 108, 106, 125}); /*collect*/ static auto _collect75577651_dec = str7_7472_collect17->get();
	if (strstr(arg2, _Over75057595_dec.c_str())
		|| strstr(arg2, _MouseOn75577651_dec.c_str())
		|| strstr(arg2, _Tooltip75577651_dec.c_str()) || strstr(arg2, _ToolTip75577651_dec.c_str())
		|| strstr(arg2, _ANI75577647_dec.c_str()) || strstr(arg2, _Ani75577647_dec.c_str())
		|| strstr(arg2, _Update75577650_dec.c_str())
		|| strstr(arg2, _Frame75577649_dec.c_str())
		|| strstr(arg2, _Help75577648_dec.c_str())
		|| strstr(arg2, _Pushed75577650_dec.c_str())
		|| strstr(arg2, _Chat75577648_dec.c_str())
		|| strstr(arg2, _quest75577649_dec.c_str()) || strstr(arg2, _Quest75577649_dec.c_str())
		|| strstr(arg2, _MenuRemake75577654_dec.c_str())
		|| strstr(arg2, _Icon75577648_dec.c_str())
		|| strstr(arg2, _QuickSlot75577653_dec.c_str())
		|| strstr(arg2, _Hide75577648_dec.c_str())
		|| strstr(arg2, _collect75577651_dec.c_str())
		|| strstr(arg2, "Lua")
		|| arg2[0] == '\0'
		|| arg3 > 45) return fn::o_lua_dobuffer(arg1, arg2, arg3, arg4);
	if (sys::roar_bot->glua_actions)
	{
		sys::roar_bot->last_lua_actions.push_back(arg2);
	}
	return fn::o_lua_dobuffer(arg1, arg2, arg3, arg4);
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
	//
	//sdk::util::log->add(std::string("[f_proxy_deadbody] r:").append(sdk::util::log->as_hex(r)), sdk::util::e_info, true);
	sys::loot->loot_proxys.push_back(r);
	//
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
	auto r = fn::o_proxy_delete(a, b);
	//
	//sdk::util::log->add(std::string("[f_proxy_delete] a:").append(sdk::util::log->as_hex(a)).append(" b:").append(sdk::util::log->as_hex(b)).append(" r:").append(sdk::util::log->as_hex(r)), sdk::util::e_info, true);
	//
	return r;
}
