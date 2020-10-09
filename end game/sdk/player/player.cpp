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
	for (auto a : i_proc)
	{
		if (!a.p) continue;
		auto i_nid = *(uint64_t*)(a.p + 0x10);
		auto i_id = *(uint16_t*)(a.p + 0x18);
		auto i_c = *(int*)(a.p + 0x20);
		auto i_d = *(uint16_t*)(a.p + 0x30);
		auto i_dm = *(uint16_t*)(a.p + 0x32);
		auto i_w = this->f_get_item_wrapper(0, a.s + 2);
		if (!i_w) continue;
		auto i_n = this->f_loot_get_name(i_w + 0x8);
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
	auto tmp_list_npcs = std::deque<sdk::player::s_blank_proxy>();
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
			auto hp = this->ghp(p);
			auto strc = sdk::player::s_blank_proxy();
			auto dst_3d = sdk::util::math->gdst_3d(pos, spos);
			auto a_wstr = std::wstring(n.name_ptr->name); auto a_str = std::string(a_wstr.begin(), a_wstr.end());
			auto state = *(BYTE*)(p + core::offsets::actor::actor_is_dead);
			strc.hp = hp; strc.key = k; strc.name = a_str; strc.ptr = p; strc.pos = pos; strc.type = t; strc.rlt_dst = dst_3d; strc.state = state;
			tmp_list.push_back(strc);
		}
		else if (t == 9)
		{
			auto pos = this->gpos(p);
			auto k = *(int*)(p + core::offsets::actor::actor_proxy_key);
			auto strc = sdk::player::s_blank_proxy();
			auto dst_3d = sdk::util::math->gdst_3d(pos, spos);
			strc.hp = 0; strc.key = k; strc.name = ""; strc.ptr = p; strc.pos = pos; strc.type = t; strc.rlt_dst = dst_3d; strc.state = 1;
			tmp_list_corpses.push_back(strc);
		}
		else if (t == 2)
		{
			auto n = *(sdk::player::c_proxy_name*)(p);
			if (!n.name_ptr) continue;
			auto pos = this->gpos(p);
			auto hp = this->ghp(p);
			auto strc = sdk::player::s_blank_proxy();
			auto dst_3d = sdk::util::math->gdst_3d(pos, spos);
			auto a_wstr = std::wstring(n.name_ptr->name); auto a_str = std::string(a_wstr.begin(), a_wstr.end());
			auto state = *(BYTE*)(p + core::offsets::actor::actor_is_dead);
			strc.hp = hp; strc.key = k; strc.name = a_str; strc.ptr = p; strc.pos = pos; strc.type = t; strc.rlt_dst = dst_3d; strc.state = state;
			tmp_list_npcs.push_back(strc);
		}
	}
	if (tmp_list.size()) { this->actors = tmp_list; }
	else this->actors.clear();
	if (tmp_list_corpses.size()) { this->corpses = tmp_list_corpses; }
	else this->corpses.clear();
	if (tmp_list_npcs.size()) { this->npcs = tmp_list_npcs; }
	else this->npcs.clear();
	return;
}
void sdk::player::c_player::update_pets(uint64_t self)
{
	auto gunsealed = [&]() -> std::deque<sdk::player::s_pet_data>
	{
		auto pmin = *(uint64_t*)(core::offsets::actor::unsealed_pet_start);
		auto pmax = *(uint64_t*)(core::offsets::actor::unsealed_pet_end);
		if (!pmin || !pmax) return {};
		auto d = (pmax - pmin) / sizeof(uint64_t);
		if (d == 0) return {};
		auto list = std::deque<sdk::player::s_pet_data>();
		for (auto a = 0; a < d * 8; a += sizeof(uint64_t))
		{
			auto p = *(uint64_t*)(pmin + a);
			if (!p) continue;
			auto strc = *(sdk::player::s_pet_data*)(p);
			if (!strc.i || strc.i <= 0 || !strc.n || wcslen(strc.n) <= 1 || strc.h <= 0 || strc.h > 400) continue;
			list.push_back(strc);
		}
		return list;
	};
	auto gsealed = [&]() -> std::deque<sdk::player::s_pet_data_s>
	{
		auto pmin = *(uint64_t*)(core::offsets::actor::sealed_pet_start);
		auto pmax = *(uint64_t*)(core::offsets::actor::sealed_pet_end);
		if (!pmin || !pmax) return {};
		auto d = (pmax - pmin) / sizeof(uint64_t);
		if (d == 0) return {};
		auto list = std::deque<sdk::player::s_pet_data_s>();
		for (auto a = 0; a < d * 8; a += sizeof(uint64_t))
		{
			auto p = *(uint64_t*)(pmin + a);
			if (!p) continue;
			auto strc = *(sdk::player::s_pet_data_s*)(p);
			if (!strc.i || strc.i <= 0 || !strc.n || wcslen(strc.n) <= 1 || strc.h <= 0 || strc.h > 400) continue;
			list.push_back(strc);
		}
		return list;
	};
	auto ul = gunsealed();
	auto sl = gsealed();
	if (ul.empty()) this->unsealed_pets.clear();
	else this->unsealed_pets = ul;
	if (sl.empty()) this->sealed_pets.clear();
	else this->sealed_pets = sl;
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
		if (!b.valid())
		{
			b.x = this->get<float>(a, core::offsets::actor::actor_mov_pure_alt_x);
			b.y = this->get<float>(a, core::offsets::actor::actor_mov_pure_alt_y);
			b.z = this->get<float>(a, core::offsets::actor::actor_mov_pure_alt_z);
		}
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
float sdk::player::c_player::grot(uint64_t s)
{
	auto a = *(uint64_t*)(s + core::offsets::actor::actor_char_ctrl);
	if (!a) return 0;
	auto b = *(uint64_t*)(a + 0x10);
	if (!b) return 0;
	return *(float*)(b + 0x43c);
}
sdk::util::c_vector3 sdk::player::c_player::ray_cast_rvec(sdk::util::c_vector3 pos1, sdk::util::c_vector3 pos2)
{
	auto r_vec = sdk::util::c_vector3(pos2.x - pos1.x, pos2.y - pos1.y, pos2.z - pos1.z);
	if (!r_vec.valid()) return r_vec;

	auto v1 = r_vec;
	auto v2 = r_vec.x;
	auto v3 = r_vec.y;
	auto v4 = r_vec.z;
	auto v5 = (float)((float)(v2 * v2) + (float)(v3 * v3)) + (float)(v4 * v4);
	if (v5 != 0.0)
	{
		auto v6 = sqrtf(v5);
		r_vec.x = v2 * (float)(1.0 / v6);
		r_vec.y = v3 * (float)(1.0 / v6);
		r_vec.z = v4 * (float)(1.0 / v6);
	}
	return r_vec;
}
sdk::player::s_trace sdk::player::c_player::trace(sdk::util::c_vector3 f, sdk::util::c_vector3 t, uint64_t s, float h, int fl, bool a)
{
	auto r = s_trace();
	//
	r.end_distance = 0.f;
	auto p1n = sdk::util::c_vector3(f.x + 1, f.y + h, f.z + 1);
	auto p2n = sdk::util::c_vector3();
	if (a) p2n = sdk::util::c_vector3(t.x + 1, t.y + h, t.z + 1);
	else p2n = sdk::util::c_vector3(t.x + 1, t.y + 20, t.z + 1);
	auto dst = sdk::util::math->gdst_3d(p1n, p2n);
	auto rv = this->ray_cast_rvec(p1n, p2n);
	float p1[3];    float p2[3];
	p1[0] = p1n.x;  p2[0] = rv.x;
	p1[1] = p1n.y;  p2[1] = rv.y;
	p1[2] = p1n.z;  p2[2] = rv.z;
	auto pc = *(uint64_t*)(core::offsets::cl::client_base);
	if (!pc) return r;
	auto _18 = *(uint64_t*)(pc + 0x18);
	if (!_18) return r;
	auto _D8 = *(uint64_t*)(_18 + 0xD8);
	if (!_D8) return r;
	float _a6[3]; float _a7 = 0.f;
	auto cast = this->f_func_trace(_D8, p1, 15, p2, dst, _a6, _a7, fl);
	if (cast) r.success = 0;
	else r.success = 1;
	if (!r.success)
	{
		r.start_point = sdk::player::player_->gpos(s); r.start_point.y += h;
		r.end_distance = _a7;
		r.end_point = sdk::util::c_vector3(_a6[0], _a6[1], _a6[2]);
	}
	else
	{
		r.start_point = sdk::player::player_->gpos(s); r.start_point.y += h;
		r.end_distance = dst;
		r.end_point = sdk::util::c_vector3(t.x,t.y + 20,t.z);
	}
	r.set_end = sdk::util::c_vector3(p2n.x, p2n.y, p2n.z);
	//
	return r;
}
std::string sdk::player::c_player::ganim(uint64_t p)
{
	auto r = std::string("");
	//
	auto pc = *(uint64_t*)(p + core::offsets::actor::actor_char_ctrl);
	if (!pc) return r;
	auto _x38 = *(uint64_t*)(pc + 0x38);
	if (!_x38) return r;
	auto _x20 = *(uint64_t*)(_x38 + 0x20);
	if (!_x20) return r;
	auto iv = *(uint32_t*)(_x20);
	//
	auto& table = *((uint64_t*)(core::offsets::cl::ascii_table));
	if (!table) return r;
	auto& _table = *((uint64_t*)(table));
	if (!_table) return r;
	auto entry_base = (_table + (0x10 * iv));
	r = std::string((char*)(*((uint64_t*)(entry_base))));
	//
	return r;
}
int sdk::player::c_player::gsp(uint64_t a)
{
	auto _x1d30 = *(uint64_t*)(a + 0x1d40); if (!_x1d30) return 0; _x1d30 = *(uint32_t*)(_x1d30);
	auto _x1d20 = *(uint64_t*)(a + 0x1d30); if (!_x1d20) return 0; auto key1 = _x1d20 >> 5;
	return (key1^_x1d30);
}
float sdk::player::c_player::ghp(uint64_t a)
{	
	auto _xa0 = *(uint32_t*)(a + 0xa0); if (!_xa0) return 0; auto key2 = _xa0 >> 5;
	auto _xb0 = *(uint64_t*)(a + 0xb0); if (!_xb0) return 0; auto key1 = *(uint32_t*)(_xb0); if (!key1) return 0;
	auto tv = (key1 ^ key2); auto ret = *((float*)&tv);
	return ret;
}
int sdk::player::c_player::gmsp(uint64_t a)
{
	return *(int*)(a + core::offsets::actor::actor_max_sp);
}
float sdk::player::c_player::gmhp(uint64_t a)
{
	auto _xa0 = *(uint32_t*)(a + 0xc0); if (!_xa0) return 0; auto key2 = _xa0 >> 5;
	auto _xb0 = *(uint64_t*)(a + 0xd0); if (!_xb0) return 0; auto key1 = *(uint32_t*)(_xb0); if (!key1) return 0;
	auto tv = (key1 ^ key2); auto ret = *((float*)&tv);
	return ret;
}
bool sdk::player::c_player::alive()
{
	auto p = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!p) return false;
	auto s = *(byte*)(p + core::offsets::actor::actor_can_play);
	if (!s) return false;
	return true;
}
sdk::player::c_player* sdk::player::player_;
