#include <inc.h>
bool sdk::player::c_player::update_actors(uint64_t self)
{
	auto s = *(uint64_t*)(core::offsets::actor::actor_list_start);
	auto e = *(uint64_t*)(core::offsets::actor::actor_list_end);
	if (s == NULL || e == NULL) return false;
	auto se_delta = (e - s) / sizeof(decltype(s));
	if (se_delta < 1) { this->actors.clear(); this->corpses.clear(); return false; }
	auto tmp_list = std::deque<sdk::player::s_blank_proxy>();
	auto tmp_list_corpses = std::deque<sdk::player::s_blank_proxy>();
	auto spos = sdk::player::player_->gpos(self);
	for (auto c = 0; c < se_delta * 8; c += sizeof(uint64_t))
	{
		auto p = *(uint64_t*)(s + c);
		if (!p) continue;
		auto t = *(BYTE*)(p + core::offsets::actor::actor_proxy_type);
		if (t == 0 || t == 1)
		{
			/*
			std::string			 name;
			uint64_t			 ptr;
			sdk::util::c_vector3 pos;
			int					 type;
			int					 key;
			float				 rlt_dst;
			int					 key_target;
			int					 hp;
			BYTE				 state;
			*/
			auto n = *(sdk::player::c_proxy_name*)(p);
			if (!n.name_ptr) continue;
			auto pos = this->gpos(p);
			auto k = *(int*)(p + core::offsets::actor::actor_proxy_key);
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
	if (tmp_list.size()) { this->actors.clear(); this->actors = tmp_list; }
	else this->actors.clear();
	if (tmp_list_corpses.size()) { this->corpses.clear(); this->corpses = tmp_list_corpses; }
	else this->corpses.clear();
	return true;
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
sdk::player::c_player* sdk::player::player_;
