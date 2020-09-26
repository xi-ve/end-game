#include <inc.h>
bool sys::c_loot::read_whitelist()
{
	static auto whitelist = sys::config->gvar("auto_loot", "string_whitelist_config");
	if (!whitelist) sdk::util::log->add("whitelist is null", sdk::util::e_info, true);
	if (whitelist->rval.size())
	{
		/*itemid;itemid*/
		this->whitelist.clear();
		auto str = whitelist->rval;
		while (str.size())
		{
			auto cpy = str;
			auto pos = cpy.find(";");
			if (pos == std::string::npos) { str.clear(); break; }
			cpy.erase(pos, cpy.size());

			auto item_idx = std::stoi(cpy);

			str.erase(0, pos + 1);

			this->whitelist.push_back(item_idx);
		}
	}
	return 1;
}
bool sys::c_loot::read_blacklist()
{
	static auto blacklist = sys::config->gvar("auto_loot", "string_blacklist_config");
	if (!blacklist) sdk::util::log->add("blacklist is null", sdk::util::e_info, true);
	if (blacklist->rval.size())
	{
		/*itemid;itemid*/
		this->blacklist.clear();
		auto str = blacklist->rval;
		while (str.size())
		{
			auto cpy = str;
			auto pos = cpy.find(";");
			if (pos == std::string::npos) { str.clear(); break; }
			cpy.erase(pos, cpy.size());

			auto item_idx = std::stoi(cpy);

			str.erase(0, pos + 1);

			//utils::cfg->cheat_log.push_back(std::string("(blacklist-load) id:").append(std::to_string(item_idx)));

			this->blacklist.push_back(item_idx);
		}
	}
	return 1;
}
void sys::c_loot::add_whitelist(int idx)
{
	static auto whitelist = sys::config->gvar("auto_loot", "string_whitelist_config");
	for (auto obj : this->whitelist) if (obj == idx) { return; }
	sdk::util::log->add(std::string("adding:").append(std::to_string(idx)).append(" conf:").append(sdk::util::log->as_hex((uint64_t)whitelist)), sdk::util::e_info, true);
	whitelist->rval.append(std::string(std::to_string(idx).append(";")));
	this->whitelist.push_back(idx);
}
void sys::c_loot::add_blacklist(int idx)
{
	static auto blacklist = sys::config->gvar("auto_loot", "string_blacklist_config");
	for (auto obj : this->blacklist) if (obj == idx) { return; }
	sdk::util::log->add(std::string("adding:").append(std::to_string(idx)).append(" conf:").append(sdk::util::log->as_hex((uint64_t)blacklist)), sdk::util::e_info, true);
	blacklist->rval.append(std::string(std::to_string(idx).append(";")));
	this->blacklist.push_back(idx);
}
void sys::c_loot::reset_whitelist()
{
	static auto whitelist = sys::config->gvar("auto_loot", "string_whitelist_config");
	whitelist->rval.clear();
	this->whitelist.clear();
}
void sys::c_loot::reset_blacklist()
{
	static auto blacklist = sys::config->gvar("auto_loot", "string_blacklist_config");
	blacklist->rval.clear();
	this->blacklist.clear();
}
void sys::c_loot::spack(int k)
{
	ByteBuffer a;
	a.putShort(6220);
	a.putEmptyBytes(4);
	a.putInt(k);
	fn::send_packet(a, 6220, 10);
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
	auto l = 9999.f; auto b = uint64_t(0); auto sp = sdk::player::player_->gpos(this->self);
	for (auto a : sdk::player::player_->corpses)
	{
		if (!a.ptr) continue;
		if (*(BYTE*)(a.ptr + core::offsets::actor::actor_was_looted)) continue;
		auto ap = sdk::player::player_->gpos(a.ptr);
		auto rd = sdk::util::math->gdst_3d(ap, sp);
		if (rd <= l && rd <= 300)
		{
			l = rd;
			b = a.ptr;
			continue;
		}
	}
	this->last_ent = b;
	return b;
}
bool sys::c_loot::pick(s_looting_item ctx)
{
	/*	
	this->proc("auto_loot", "ipick_grey", "1");
	this->proc("auto_loot", "ipick_green", "1");
	this->proc("auto_loot", "ipick_blue", "1");
	this->proc("auto_loot", "ipick_orange", "1");
	this->proc("auto_loot", "ipick_yellow", "1");	
	*/
	static auto grey = sys::config->gvar("auto_loot", "ipick_grey");
	static auto green = sys::config->gvar("auto_loot", "ipick_green");
	static auto blue = sys::config->gvar("auto_loot", "ipick_blue");
	static auto orange = sys::config->gvar("auto_loot", "ipick_orange");
	static auto yellow = sys::config->gvar("auto_loot", "ipick_yellow");
	for (auto a : this->blacklist) if (a == ctx.id) return false;
	for (auto a : this->whitelist) if (a == ctx.id) return true;
	switch (ctx.rarity)
	{
	case 0:
	{
		if (grey->iv) return true;
		break;
	}
	case 1:
	{
		if (green->iv) return true;
		break;
	}
	case 2:
	{
		if (blue->iv) return true;
		break;
	}
	case 3:
	{
		if (orange->iv) return true;
		break;
	}
	case 4:
	{
		if (yellow->iv) return true;
		break;
	}
	}
	return false;
}
void sys::c_loot::work(uint64_t self)
{
	this->self = self;
	static auto last_tick = ULONGLONG(0);
	if (GetTickCount64() > last_tick) last_tick = GetTickCount64() + 50;
	else return;
	static auto ienable = sys::config->gvar("auto_loot", "ienable");
	if (!ienable->iv) return;
	typedef void(__fastcall* cislot)(BYTE, int);
	static cislot cslot = (cislot)core::offsets::fn::loot_click_slot;
	typedef int(__fastcall* gicnt)();
	static gicnt icnt = (gicnt)core::offsets::fn::loot_item_count;
	typedef bool(__fastcall* inmob)(uint64_t);
	static inmob imob = (inmob)core::offsets::fn::loot_deadactor;
	auto n = this->hnear(); if (!n) return; 
	this->spack(*(int*)(n + core::offsets::actor::actor_proxy_key));
	auto i = icnt();		if (!i) return;
	static auto ienable_filter = sys::config->gvar("auto_loot", "ienable_filter");
	for (auto b = 0; b < i; b++)
	{
		auto o = this->gitem(b);
		if (!o) continue;
		auto ctx = this->gctx(o);
		if (ienable_filter->iv) if (!this->pick(ctx)) continue;
		cslot(b, ctx.count);
	}
}
sys::c_loot* sys::loot;