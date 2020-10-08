#include <inc.h>
bool sys::c_protection::players_in_range(uint64_t s)
{
	if (!this->iheight_range || !this->iprotection_range || !this->smart_detect || !this->iexit_on_player)
	{
		this->iheight_range = sys::config->gvar("protection", "iheight_range");
		this->iprotection_range = sys::config->gvar("protection", "iprotection_range");
		this->smart_detect = sys::config->gvar("protection", "ismart_detect"); 
		this->iexit_on_player = sys::config->gvar("protection", "iexit_on_player");
	}
	if (this->iheight_range->iv < 1000) this->iheight_range->iv = 1500;
	if (this->iprotection_range->iv < 1000) this->iprotection_range->iv = 1500;
	auto t = sdk::player::player_->gpos(s);
	for (auto a : sdk::player::player_->actors)
	{
		if (a.ptr == s) continue;
		if (a.type != 0) continue;
		auto hdst = sdk::util::math->gdst_1d(a.pos.y, t.y);
		if (hdst > this->iheight_range->iv) continue;
		hdst = sdk::util::math->gdst_2d(a.pos, t);
		if (hdst > this->iprotection_range->iv) continue;
		if (this->smart_detect->iv) if (!sdk::player::player_->trace(t, a.pos, s, 450).success) continue;		
		auto ctrl = *(uint64_t*)(s + core::offsets::actor::actor_char_ctrl);
		if (!ctrl) continue;
		auto scene = *(uint64_t*)(ctrl + core::offsets::actor::actor_char_scene);
		if (!scene) continue;
		auto speed = *(float*)(scene + core::offsets::actor::actor_animation_speed);
		*(float*)(scene + core::offsets::actor::actor_animation_speed) = 1.f;
		if (iexit_on_player->iv)
		{
			sdk::util::log->add("game closed due to player detection", sdk::util::e_critical, true);
			ExitProcess(0);
		}
		return true;
	}
	return false;
}
sys::c_protection* sys::protection;
