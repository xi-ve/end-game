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
		if (*(BYTE*)(b.ptr + core::offsets::actor::actor_was_looted)) continue;
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
void sys::c_visuals::trace_debug()
{
	auto ps = sdk::player::player_->gpos(this->self);
	auto rot = sdk::player::player_->grot(this->self);
	auto x = (std::sin(rot) * -1); auto y = (std::cos(rot) * -1);
	auto v =  sdk::util::c_vector3(ps.x + (200 * x), ps.y + 200, ps.z + (200 * y));

	auto wv = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(v, wv)) return;

	auto t = sdk::player::player_->trace(ps, v, this->self, 100, filter);

	if (t.success) sdk::render::render->DrawCircle(wv.x, wv.z, 16, 0xff00ff00);
	else sdk::render::render->DrawCircle(wv.x, wv.z, 16, 0xffff0000);

	if (!sdk::util::math->w2s(t.end_point, wv)) return;
	sdk::render::render->DrawCircle(wv.x, wv.z, 16, 0xff000fff);

	if (!sdk::util::math->w2s(t.start_point, wv)) return;
	sdk::render::render->DrawCircle(wv.x, wv.z, 16, 0xff000fff);

	sdk::render::render->RenderText(200, 200, 0xff00ff00, (char*)std::string("dst:").append(std::to_string(t.end_distance)).c_str());
	sdk::render::render->RenderText(200 ,230,0xff00ff00, (char*)std::string("state:").append(std::to_string(t.success)).c_str());
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
	//this->trace_debug();
}
sys::c_visuals* sys::visuals;