#include <inc.h>
void sys::c_visuals::monster_proxy_debug()
{
	auto a = sdk::player::player_->corpses;
	if (a.size() <= 1) return;
	auto sv = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(sdk::player::player_->gpos(this->self), sv)) return;
	for (auto b : a)
	{
		if (!b.pos.valid() || b.ptr == NULL || b.type != 9 || b.hp <= 0 || b.rlt_dst >= 1000.f) continue;
		auto v = sdk::util::c_vector3();
		if (!sdk::util::math->w2s(b.pos, v)) continue;
		if (!v.valid()) continue;
		sdk::render::render->DrawLine(sv.x, sv.z, v.x, v.z, 0xff00ff0f);
		sdk::render::render->RenderText(v.x, v.z - 30, 0xff00ff00, (char*)b.name.c_str());
		sdk::render::render->RenderText(v.x, v.z - 50, 0xff00ff00, (char*)sdk::util::log->as_hex(b.ptr).c_str());
	}
}
void sys::c_visuals::teleport_points()
{
	if (sys::pack_tp->_poslist.empty()) return;
	std::vector<sdk::util::c_vector3> list;
	list.push_back(sys::pack_tp->_poslist.front());
	list.push_back(sys::pack_tp->_poslist.back());
	auto sv = sdk::util::c_vector3();
	auto p = sdk::player::player_->gpos(this->self);
	if (!sdk::util::math->w2s(p, sv)) return;
	sdk::render::render->RenderText(sv.x, sv.z, 0xff00ff00, (char*)"#+#+#");
	for (auto a : list)
	{
		sdk::util::c_vector3 p;
		if (!sdk::util::math->w2s(a, p)) continue;
		sdk::render::render->DrawCircle(p.x, p.z, 12, 0xFF00FF00);
	}
}
void sys::c_visuals::work()
{
	auto self_actor_proxy = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!self_actor_proxy) return;
	auto can_play = *(byte*)(self_actor_proxy + core::offsets::actor::actor_can_play);
	if (!can_play) return;
	this->self = self_actor_proxy;
	this->monster_proxy_debug();
	this->teleport_points();
}
sys::c_visuals* sys::visuals;