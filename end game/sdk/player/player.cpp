#include <inc.h>
bool sdk::player::c_player::update()
{
	auto a = *(uint64_t*)(core::offsets::actor::actor_self);
	if (a == NULL) { this->self = 0; return false; }
	auto t = new sdk::player::s_self_actor_proxy();
	t->ptr = a;
	this->self = t;
	return true;
}
bool sdk::player::c_player::gself_valid()
{
	if (this->self != nullptr && this->self->ptr != 0) return true;
	return false;
}
sdk::player::s_self_actor_proxy* sdk::player::c_player::gself()
{
	return this->self;
}
sdk::util::c_vector3 sdk::player::c_player::gpos(uint64_t a)
{
	auto b = util::c_vector3();
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
		p = this->get<uint64_t>(a, core::offsets::actor::actor_mov_base);		if (!p) return b;
		p = this->get<uint64_t>(a, core::offsets::actor::actor_networked_move); if (!p) return b;
		b.x = this->get<float>(a, core::offsets::actor::actor_mov_cx);
		b.y = this->get<float>(a, core::offsets::actor::actor_mov_cy);
		b.z = this->get<float>(a, core::offsets::actor::actor_mov_cz);
	}
	return b;
}
sdk::player::c_player* sdk::player::player_;
