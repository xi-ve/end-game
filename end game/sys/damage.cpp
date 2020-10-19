#include <inc.h>
void sys::c_damage::work(int target)
{
	uint64_t t = 0;
	for (auto a : sdk::player::player_->actors)
	{
		if (a.key == target) { t = a.ptr; break; }
	}
	if (!t) return;/*lel?*/
	if (GetTickCount64() >= this->timer)
	{
		this->timer = GetTickCount64() + 1000;
		this->buffer_dps = this->total_dps;
		this->buffer_hps = this->total_hps;
		this->total_dps = 0;
		this->total_hps = 0;
	}
	this->total_hps++;
	auto cur_hp = sdk::player::player_->ghp(t);
	auto max_hp = sdk::player::player_->gmhp(t);
	auto n = *(sdk::player::c_proxy_name*)(t);
	auto a_wstr = std::wstring(n.name_ptr->name); auto a_str = std::string(a_wstr.begin(), a_wstr.end());
	if (cur_hp <= 0)
	{
		auto exist = false;
		for (auto&& p : this->killed_mobs) if (strstr(p.name.c_str(), a_str.c_str())) { exist = true; p.count++; break; }
		if (!exist) this->killed_mobs.emplace_back(a_str);		
	}
	if (this->actors_hp[target] <= 0)
	{
		auto dmg = max_hp - cur_hp;
		if (dmg < 0 || cur_hp <= 0)
		{
			this->actors_hp[target] = 0;
			return;
		}
		this->actors_hp[target] = cur_hp;
		if (this->dmg_events.size() > 256) this->dmg_events.erase(this->dmg_events.begin(), this->dmg_events.begin() + 124);
		this->dmg_events.emplace_back(t, dmg, a_str); 
		this->total_dps += dmg;
		return;
	}
	auto dmg = this->actors_hp[target] - cur_hp;
	this->actors_hp[target] = cur_hp;
	if (this->dmg_events.size() > 256) this->dmg_events.erase(this->dmg_events.begin(), this->dmg_events.begin() + 124);
	if (dmg > 0)
	{
		this->total_dps += dmg;
		this->dmg_events.emplace_back(t, dmg, a_str);
	}
}
std::vector<sys::s_damage_event> sys::c_damage::gevents()
{
	return this->dmg_events;
}
sys::c_damage* sys::damage;