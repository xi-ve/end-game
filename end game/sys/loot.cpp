#include <inc.h>
void sys::c_loot::mloot()
{
	if (this->act_id_cur != 0) this->spack(this->act_id_cur);
}
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
	this->whitelist.push_back(idx);
}
void sys::c_loot::add_blacklist(int idx)
{
	if (!blacklistv) blacklistv = sys::config->gvar("auto_loot", "string_blacklist_config");
	for (auto obj : this->blacklist) if (obj == idx) { return; }
	blacklistv->rval.append(std::string(std::to_string(idx).append(";")));
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
void sys::c_loot::starget(int k)
{
	this->act_id_cur = k;
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
		if (*(BYTE*)(a + core::offsets::actor::actor_was_looted))
		{  
			this->loot_proxys.erase(this->loot_proxys.begin() + b);
			continue;
		}
		auto ap = sdk::player::player_->gpos(a);
		auto rd = sdk::util::math->gdst_3d(ap, sp);
		if (rd <= l && rd <= 300)
		{
			l = rd;
			rr = a;
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
bool sys::c_loot::lhas(int s)
{
	if (s <= 0) return false;
	auto m = sdk::player::player_->gpos(this->self);
	for (auto a : this->loot_proxys)
	{
		auto k = *(int*)(a + core::offsets::actor::actor_proxy_key);
		if (k == s)
		{
			auto p = sdk::player::player_->gpos(a);
			auto d = sdk::util::math->gdst_3d(m, p);
			if (d <= 300) return true;
			else return false;
		}
	}
	return false;
}
void sys::c_loot::work(uint64_t self)
{
	this->self = self;
	if (GetTickCount64() > last_tick) last_tick = GetTickCount64() + 25;
	else return;
	if (!ienable) ienable = sys::config->gvar("auto_loot", "ienable");
	if (!ienable->iv) return;
	auto n = this->hnear();						   if (!n) return;
	auto actid = *(int*)(n + core::offsets::actor::actor_proxy_key);
	if (this->act_id_cur == 0)
	{
		this->spack(actid);
		this->act_id_cur = actid;
		this->pack_time = GetTickCount64();
		return;
	}
	if (!this->lhas(this->act_id_cur))
	{
		this->act_id_cur = 0;
		return;
	}
	auto cur_loot_window_k = *(int*)(core::offsets::cl::loot_base); if (cur_loot_window_k != this->act_id_cur) return;
	auto i = this->f_loot_get_item_count();		   if (!i) { this->act_id_cur = 0; return; }
	if (!ienable_filter) ienable_filter = sys::config->gvar("auto_loot", "ienable_filter");
	auto did_loot_good_item = false;
	for (auto b = 0; b < i; b++)
	{
		auto o = this->gitem(b);
		if (!o) continue;
		auto ctx = this->gctx(o);
		if (ienable_filter->iv) if (!this->pick(ctx)) continue; 					
		this->f_loot_click_slot(b, ctx.count);
		did_loot_good_item = true;
	}
	if (!did_loot_good_item && this->f_loot_get_item_count())
	{
		if (sys::loot->loot_proxys.size())
		{
			for (auto f = 0; f < sys::loot->loot_proxys.size(); f++)
			{
				auto c = sys::loot->loot_proxys[f]; if (!c) continue;
				auto k = *(int*)(c + core::offsets::actor::actor_proxy_key);
				if (k == this->act_id_cur) { sys::loot->loot_proxys.erase(sys::loot->loot_proxys.begin() + f); break; }
			}
		}
	}
	this->act_id_cur = 0;
}
sys::c_loot* sys::loot;