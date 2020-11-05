#include <inc.h>
bool sys::c_loot::read_whitelist()
{
	if (!whitelistv) whitelistv = sys::config->gvar("auto_loot", "string_whitelist_config");
	if (whitelistv->rval.size())
	{
		/*itemid;itemid*/
		this->whitelist.clear();
		auto str = whitelistv->rval;
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
	if (!blacklistv) blacklistv = sys::config->gvar("auto_loot", "string_blacklist_config");
	if (blacklistv->rval.size())
	{
		/*itemid;itemid*/
		this->blacklist.clear();
		auto str = blacklistv->rval;
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
	if (!whitelistv) whitelistv = sys::config->gvar("auto_loot", "string_whitelist_config");
	for (auto obj : this->whitelist) if (obj == idx) { return; }
	whitelistv->rval.append(std::string(std::to_string(idx).append(";")));
	sdk::util::log->a("added item wiith id %i to whitelist", idx);
	this->whitelist.push_back(idx);
}
void sys::c_loot::add_blacklist(int idx)
{
	if (!blacklistv) blacklistv = sys::config->gvar("auto_loot", "string_blacklist_config");
	for (auto obj : this->blacklist) if (obj == idx) { return; }
	blacklistv->rval.append(std::string(std::to_string(idx).append(";")));
	sdk::util::log->a("added item wiith id %i to blacklist", idx);
	this->blacklist.push_back(idx);
}
void sys::c_loot::reset_whitelist()
{
	if (!whitelistv) whitelistv = sys::config->gvar("auto_loot", "string_whitelist_config");
	whitelistv->rval.clear();
	this->whitelist.clear();
}
void sys::c_loot::reset_blacklist()
{
	if (!blacklistv) blacklistv = sys::config->gvar("auto_loot", "string_blacklist_config");
	blacklistv->rval.clear();
	this->blacklist.clear();
}
std::vector<std::string> sys::c_loot::gwl()
{
	auto r = std::vector<std::string>();
	for (auto a : this->whitelist) r.push_back(std::to_string(a));
	return r;
}
std::vector<std::string> sys::c_loot::gbl()
{
	auto r = std::vector<std::string>();
	for (auto a : this->blacklist) r.push_back(std::to_string(a));
	return r;
}
void sys::c_loot::spack(int k)
{
	ByteBuffer a;
	a.putShort(5707);
	a.putInt(k);
	a.putEmptyBytes(3);
	fn::send_packet(a, 5707, 9);
}
void sys::c_loot::spick(int k, int sk, int s, int c)
{
	//looted x2  pos 0
	//2e 0d 00 02 2c 0e 03 00 34 b3 02 00 00 00 00 00 00 00 01 00 01 00 00 00 00 00 34 09 00 00 
	//looted x83 pos 1
	//opc   target key  unknown----	c											 self  key   slot
	//2e 0d 00 02 04 6f 02 00 d0 47 53 00 00 00 00 00 00 00 01 00 01 00 00 00 00 00 34 09 00 01 
	ByteBuffer a;
	a.putShort(3374);
	a.putEmptyBytes(1); 
	a.putInt(k);
	a.putEmptyBytes(1);
	a.put(0xd0);
	a.put(0x47);
	a.putShort(c);
	a.putEmptyBytes(6);
	a.put(1);
	a.putEmptyBytes(1);
	a.put(1);
	a.putEmptyBytes(4);
	a.putInt(sk);
	a.put(s);
	fn::send_packet(a, 3374, 30);
}
uint64_t sys::c_loot::gitem(int s)
{
	auto r = uint64_t(0);
	//
	r = this->f_loot_get_base(s);
	//
	return r;
}
sys::s_looting_item sys::c_loot::gctx(uint64_t p)
{
	auto i = *(uint64_t*)(p + 0x98);
	if (!i) return {};
	auto id = *(int*)(i + 0x0);
	auto c = *(int*)(i + 0x8);
	p += 0x8;
	auto r = this->f_loot_get_rarity(p);
	return sys::s_looting_item(c, id, r, this->f_loot_get_name(p));
}
uint64_t sys::c_loot::hnear()
{
	if (this->loot_proxys.empty()) return 0;
	auto l = 9999.f; auto rr = uint64_t(0); auto sp = sdk::player::player_->gpos(this->self);
	for (auto b = 0; b < this->loot_proxys.size(); b++)
	{
		auto a = this->loot_proxys[b];
		if (*(BYTE*)(a.ptr + core::offsets::actor::actor_was_looted))
		{  
			this->loot_proxys.erase(this->loot_proxys.begin() + b);
			continue;
		}
		auto ap = sdk::player::player_->gpos(a.ptr);
		auto rd = sdk::util::math->gdst_3d(ap, sp);
		if (rd <= l && rd <= 250)
		{
			l = rd;
			rr = a.ptr;
			continue;
		}
	}
	return rr;
}
bool sys::c_loot::pick(s_looting_item ctx)
{
	if (!grey) grey = sys::config->gvar("auto_loot", "ipick_grey");
	if (!green) green = sys::config->gvar("auto_loot", "ipick_green");
	if (!blue) blue = sys::config->gvar("auto_loot", "ipick_blue");
	if (!orange) orange = sys::config->gvar("auto_loot", "ipick_orange");
	if (!yellow) yellow = sys::config->gvar("auto_loot", "ipick_yellow");
	if (!idont_pick_event) idont_pick_event = sys::config->gvar("auto_loot", "idont_pick_event");
	if (ienable_filter->iv == 0) return true;
	if (ctx.name == "Silver") return true;
	if (idont_pick_event->iv && strstr(ctx.name.c_str(), "Event")) return false;
	for (auto a : this->blacklist) 
	{
		if (a == ctx.id)
		{
			//sdk::util::log->a("should not take %s -> %i", ctx.name.c_str(), ctx.id);
			return false;
		}
	}
	for (auto b : this->whitelist) if (b == ctx.id) return true;
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
		//sdk::util::log->a("orange item -> %s -> %i", ctx.name.c_str(), ctx.id);
		if (yellow->iv) return true;
		break;
	}
	case 4:
	{
		if (orange->iv) return true;
		break;
	}
	}
	return false;
}
bool sys::c_loot::lhas(int s)
{
	if (s <= 0) return false;
	auto m = sdk::player::player_->gpos(this->self);
	for (auto a : this->loot_proxys)
	{
		auto k = *(int*)(a.ptr + core::offsets::actor::actor_proxy_key);
		if (k == s)
		{
			auto p = sdk::player::player_->gpos(a.ptr);
			auto d = sdk::util::math->gdst_3d(m, p);
			if (d <= 250) return true;
			else return false;
		}
	}
	return false;
}
void sys::c_loot::work(uint64_t self)
{
	this->self = self;
	if (!ienable) ienable = sys::config->gvar("auto_loot", "ienable");
	if (!ienable->iv) return;

	auto n = this->hnear();						   if (!n) return;
	auto actid = *(int*)(n + core::offsets::actor::actor_proxy_key);
	auto sk = *(int*)(self + core::offsets::actor::actor_proxy_key);
	if (!this->lhas(actid)) return;
	//Panel_Window_Looting_All
	auto cur_loot_window_k = *(int*)(core::offsets::cl::loot_base); 
	if (cur_loot_window_k != actid) 
	{ 
		this->spack(actid); 
		return;
	}
	auto i = this->f_loot_get_item_count();		   if (!i) { return; }
	if (!ienable_filter) ienable_filter = sys::config->gvar("auto_loot", "ienable_filter");
	auto did_loot_good_item = false;
	for (auto b = 0; b < i; b++)
	{
		auto o = this->gitem(b);
		if (!o) continue;
		auto ctx = this->gctx(o);
		if (!this->pick(ctx)) continue;
		this->spick(actid, sk, b, ctx.count);
		did_loot_good_item = true;
		if (last_actor == actid) continue;
		if (this->looted_log.size() > 100) this->looted_log.erase(this->looted_log.begin(), this->looted_log.begin() + 50);
		this->looted_log.push_back(ctx);
		switch (ctx.rarity)
		{
		case 0:
		{
			if (strstr(ctx.name.c_str(), "Silver")) break;
			this->loot_count_grey += ctx.count;
			break;
		}
		case 1:
		{
			this->loot_count_green += ctx.count;
			break;
		}
		case 2:
		{
			this->loot_count_blue += ctx.count;
			break;
		}
		case 3:
		{
			this->loot_count_yellow += ctx.count;
			break;
		}
		case 4:
		{
			this->loot_count_orange += ctx.count;
			break;
		}
		}
		if (this->looted_items[ctx.id].name.empty())
		{
			this->looted_items[ctx.id] = ctx;
			this->looted_items[ctx.id].count = ctx.count;;
		}
		else this->looted_items[ctx.id].count += ctx.count;
	}
	last_actor = actid;
	if (!did_loot_good_item && this->f_loot_get_item_count())
	{
		if (sys::loot->loot_proxys.size())
		{
			for (auto f = 0; f < sys::loot->loot_proxys.size(); f++)
			{
				auto c = sys::loot->loot_proxys[f]; if (!c.ptr) continue;
				auto k = *(int*)(c.ptr + core::offsets::actor::actor_proxy_key);
				if (k == actid) { sys::loot->loot_proxys.erase(sys::loot->loot_proxys.begin() + f); break; }
			}
		}
	}
}
sys::c_loot* sys::loot;