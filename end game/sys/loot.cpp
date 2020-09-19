#include <inc.h>
void sys::c_loot::spack(int k)
{
	ByteBuffer a;
	a.putShort(6219);
	a.putEmptyBytes(3);
	a.putInt(k);
	fn::send_packet(a, 6219, 9);
}
uint64_t sys::c_loot::gitem(int s)
{
	auto r = uint64_t(0);
	//
	typedef uint64_t(__fastcall* a)(int);
	static a b = (a)core::offsets::fn::loot_get_base;
	r = b(s);
	//
	return r;
}
sys::s_looting_item sys::c_loot::gctx(uint64_t p)
{
	typedef uint64_t(__fastcall* grarity)(uint64_t);
	static grarity rarity = (grarity)core::offsets::fn::loot_get_rarity;
	typedef const CHAR* (__fastcall* gname)(uint64_t);
	static gname name = (gname)core::offsets::fn::loot_get_name;
	auto i = *(uint64_t*)(p + 0x98);
	if (!i) return {};
	auto id = *(int*)(i + 0x0);
	auto c = *(int*)(i + 0x8);
	p += 0x8;
	auto r = rarity(p);
	return sys::s_looting_item(c, id, r, name(p));
}
uint64_t sys::c_loot::hnear()
{
	auto l = 9999.f; auto b = uint64_t(0);
	for (auto a : sdk::player::player_->corpses) if (a.rlt_dst < l && a.rlt_dst <= 250.f) { b = a.ptr; l = a.rlt_dst; }
	this->last_ent = b;
	return b;
}
void sys::c_loot::work(uint64_t self)
{
	this->self = self;
	static auto last_tick = ULONGLONG(0);
	if (GetTickCount64() > last_tick) last_tick = GetTickCount64() + 50;
	else return;
	typedef void(__fastcall* cislot)(BYTE, int);
	static cislot cslot = (cislot)core::offsets::fn::loot_click_slot;
	typedef int(__fastcall* gicnt)();
	static gicnt icnt = (gicnt)core::offsets::fn::loot_item_count;
	typedef bool(__fastcall* inmob)(uint64_t);
	static inmob imob = (inmob)core::offsets::fn::loot_deadactor;
	auto n = this->hnear(); if (!n) return; this->spack(*(int*)(n + core::offsets::actor::actor_proxy_key));
	auto i = icnt();		if (!i) return;
	if (*(BYTE*)(n + core::offsets::actor::actor_was_looted)) return;
	for (auto b = 0; b < i; b++)
	{
		auto o = this->gitem(b);
		if (!o) continue;
		auto ctx = this->gctx(o);
		//filter
		cslot(b, ctx.count);
	}
}
sys::c_loot* sys::loot;