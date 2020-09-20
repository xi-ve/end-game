#include <inc.h>
void sys::c_visuals::monster_proxy_debug()
{
	auto a = sdk::player::player_->corpses;
	if (a.size() <= 1) return;
	auto sv = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(sdk::player::player_->gpos(this->self), sv)) return;
	for (auto b : a)
	{
		if (!b.pos.valid() || b.ptr == NULL) continue;
		auto v = sdk::util::c_vector3();
		if (!sdk::util::math->w2s(b.pos, v)) continue;
		sdk::render::render->DrawLine(sv.x, sv.z, v.x, v.z, 0xff00ff0f);
		sdk::render::render->RenderText(v.x, v.z - 30, 0xff00ff00, (char*)b.name.c_str());
		sdk::render::render->RenderText(v.x, v.z - 50, 0xff00ff00, (char*)sdk::util::log->as_hex(b.ptr).c_str());
	}
}
void sys::c_visuals::portal()
{
	auto a = sdk::player::player_->actors;
	if (a.size() <= 1) return;
	auto sv = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(sdk::player::player_->gpos(this->self), sv)) return;
	for (auto b : a)
	{
		if (!b.pos.valid() || b.ptr == NULL) continue;
		if (!strstr(b.name.c_str(), "Ancient Mobility Device")) continue;
		auto v = sdk::util::c_vector3();
		if (!sdk::util::math->w2s(b.pos, v)) continue;
		sdk::render::render->DrawLine(sv.x, sv.z, v.x, v.z, 0xff00ffff);
		sdk::render::render->RenderText(v.x, v.z - 30, 0xff00ff00, (char*)b.name.c_str());
		sdk::render::render->RenderText(v.x, v.z - 50, 0xff00ff00, (char*)sdk::util::log->as_hex(b.ptr).c_str());
	}
}
void sys::c_visuals::work()
{
	auto self_actor_proxy = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!self_actor_proxy) return;
	auto can_play = *(BYTE*)(self_actor_proxy + core::offsets::actor::actor_can_play);
	if (!can_play) return;
	this->self = self_actor_proxy;
	this->monster_proxy_debug();
	this->portal();
}
sys::c_visuals* sys::visuals;