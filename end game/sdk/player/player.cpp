#include <inc.h>
void sdk::player::c_player::update_inventory(uint64_t self)
{
	auto ib = *(uint64_t*)(self + core::offsets::actor::actor_inv_base);
	if (!ib) return;
	auto im = *(byte*)(self + core::offsets::actor::actor_inv_max);
	auto il = *(byte*)(self + core::offsets::actor::actor_inv_left);
	struct s_item_q
	{
		s_item_q(uint64_t a, int b)
		{
			p = a; s = b;
		}
		uint64_t p;
		int      s;
	};
	std::deque<s_item_q>	i_proc; std::deque<s_item_info> i_info;
	uint64_t i_cur = 0;
	for (byte c = 0; c < im; c++)
	{
		if (!i_cur) i_cur += 0x170;
		else i_cur += 0xc0;
		i_proc.emplace_back((uint64_t)ib + i_cur, c);
	}
	typedef uint64_t(__fastcall* t_get_item_wrapper)(byte, byte);
	static auto d_get_item_wrapper = (t_get_item_wrapper)core::offsets::fn::inv_get_item;
	typedef const CHAR* (__fastcall* gname)(uint64_t);
	static gname name = (gname)core::offsets::fn::loot_get_name;
	for (auto a : i_proc)
	{
		if (!a.p) continue;
		auto i_nid = *(uint64_t*)(a.p + 0x10);
		auto i_id = *(uint16_t*)(a.p + 0x18);
		auto i_c = *(int*)(a.p + 0x20);
		auto i_d = *(uint16_t*)(a.p + 0x30);
		auto i_dm = *(uint16_t*)(a.p + 0x32);
		auto i_w = d_get_item_wrapper(0, a.s + 2);
		if (!i_w) continue;
		auto i_n = name(i_w + 0x8);
		i_info.emplace_back(a.p, i_id, i_c, i_d, i_dm, a.s, i_nid, i_n);
	}
	i_proc.clear();
	this->inventory_items = i_info;
}
void sdk::player::c_player::update_actors(uint64_t self)
{
	auto s = *(uint64_t*)(core::offsets::actor::actor_list_start);
	auto e = *(uint64_t*)(core::offsets::actor::actor_list_end);
	if (s == NULL || e == NULL) return;
	auto se_delta = (e - s) / sizeof(decltype(s));
	if (se_delta < 1) { this->actors.clear(); this->corpses.clear(); return; }
	auto tmp_list = std::deque<sdk::player::s_blank_proxy>();
	auto tmp_list_corpses = std::deque<sdk::player::s_blank_proxy>();
	auto spos = sdk::player::player_->gpos(self);
	for (auto c = 0; c < se_delta * 8; c += sizeof(uint64_t))
	{
		auto p = *(uint64_t*)(s + c);
		if (!p) continue;
		auto k = *(int*)(p + core::offsets::actor::actor_proxy_key);
		if (!k) continue;
		auto t = *(BYTE*)(p + core::offsets::actor::actor_proxy_type);
		if (t == 0 || t == 1)
		{
			auto n = *(sdk::player::c_proxy_name*)(p);
			if (!n.name_ptr) continue;
			auto pos = this->gpos(p);
			auto hp = sdk::engine::d_actor_get_hp(p);
			auto strc = sdk::player::s_blank_proxy();
			auto dst_3d = sdk::util::math->gdst_3d(pos, spos);
			auto a_wstr = std::wstring(n.name_ptr->name); auto a_str = std::string(a_wstr.begin(), a_wstr.end());
			strc.hp = hp; strc.key = k; strc.name = a_str; strc.ptr = p; strc.pos = pos; strc.type = t; strc.rlt_dst = dst_3d;
			tmp_list.push_back(strc);
		}
		else if (t == 9)
		{
			auto pos = this->gpos(p);
			auto k = *(int*)(p + core::offsets::actor::actor_proxy_key);
			auto strc = sdk::player::s_blank_proxy();
			auto dst_3d = sdk::util::math->gdst_3d(pos, spos);
			strc.hp = 0; strc.key = k; strc.name = ""; strc.ptr = p; strc.pos = pos; strc.type = t; strc.rlt_dst = dst_3d;
			tmp_list_corpses.push_back(strc);
		}
	}
	if (tmp_list.size()) { this->actors = tmp_list; }
	else this->actors.clear();
	if (tmp_list_corpses.size()) { this->corpses = tmp_list_corpses; }
	else this->corpses.clear();
	return;
}
sdk::util::c_vector3 sdk::player::c_player::gpos(uint64_t a, bool raw)
{
	auto b = util::c_vector3(1234,1234,1234);
	auto t = this->get<BYTE>(a, core::offsets::actor::actor_proxy_type);
	if (t > 1)
	{
		b.x = this->get<float>(a, core::offsets::actor::actor_mov_pure_x);
		b.y = this->get<float>(a, core::offsets::actor::actor_mov_pure_y);
		b.z = this->get<float>(a, core::offsets::actor::actor_mov_pure_z);
		return b;
	}
	else
	{
		auto p = this->get<uint64_t>(a, core::offsets::actor::actor_char_ctrl); if (!p) return b;
		p = this->get<uint64_t>(p, core::offsets::actor::actor_mov_base);		if (!p) return b;
		p = this->get<uint64_t>(p, core::offsets::actor::actor_networked_move); if (!p) return b;
		b.x = this->get<float>(p, core::offsets::actor::actor_mov_cx);
		b.y = this->get<float>(p, core::offsets::actor::actor_mov_cy);
		b.z = this->get<float>(p, core::offsets::actor::actor_mov_cz);
		if (!raw) b.x *= 100.f; b.y *= 100.f; b.z *= 100.f;
	}
	return b;
}
float sdk::player::c_player::ghp(uint64_t a)
{
	return sdk::engine::d_actor_get_hp(a);
}
std::vector<std::string> sdk::player::c_player::ginv()
{
	auto r = std::vector<std::string>();
	for (auto a : this->inventory_items) r.push_back(a.name);
	return r;
}
int sdk::player::c_player::gitm_by_name(std::string n)
{
	for (auto a : this->inventory_items) if (strstr(a.name.c_str(), n.c_str())) return a.item_index;
	return 0;
}
sdk::player::c_player* sdk::player::player_;
