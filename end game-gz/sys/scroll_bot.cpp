#include <inc.h>
std::string sys::c_scrollbot::get_main_boss()
{
	return this->boss_name;
}
bool sys::c_scrollbot::set_scroll_type()
{
	if (this->scroll_id) return true;
	else return false;
}
void sys::c_scrollbot::set_scroll_type_by_pos(uint64_t self)
{
	if (this->scroll_types.empty())
	{
		this->scroll_types.push_back(sys::s_scroll_type(
			sdk::util::c_vector3(403458.f, -3918.f, 5948.f),
			41595,
			"Magram",
			"",
			"Khalk"));

		this->scroll_types.push_back(sys::s_scroll_type(
			sdk::util::c_vector3(-261046.f, -413.f, 173669.f),
			41583,
			"Org",
			"Gehaku",
			"Saunil Siege Captain"));

		this->scroll_types.push_back(sys::s_scroll_type(
			sdk::util::c_vector3(276938.f, -6687.f, 23951.f),
			41587,
			"Abandoned Iron Mine Executor",
			"Illezra's Servant",
			"Skeleton King"));

		this->scroll_types.push_back(sys::s_scroll_type(
			sdk::util::c_vector3(395836.f, -3396.f, 13596),
			41619,
			"",
			"",
			"Narc Brishka"));
	}
	auto pos_self = sdk::player::player_->gpos(self);
	for (auto obj : this->scroll_types)
	{
		auto dst_to = sdk::util::math->gdst_2d(obj.position, pos_self);
		if (dst_to <= 1800)
		{
			this->scroll_id = obj.scroll_id;
			this->boss_name = obj.boss;
			this->boss_pre_name = obj.pre_boss;
			this->boss_pre_name_2 = obj.pre_boss_2;
			this->scroll_spawn_pos = obj.position;

			sdk::util::log->add(std::string("nearest point, scroll type:").append(obj.boss));
			return;
		}
	}
}
void sys::c_scrollbot::work(uint64_t self, ULONGLONG tick)
{
	if (tick < last_tick) return;
	else last_tick = tick + 35;

	sys::legit_bot->autopot();

	if (!this->ienable_do_all || !this->ienable_do_num)
	{
		this->ienable_do_all = sys::config->gvar("scroll_bot", "ienable_do_all");
		this->ienable_do_num = sys::config->gvar("scroll_bot", "ienable_do_num");
	}

	/*start of routine - get the scroll up*/
	if (!this->did_use_scroll(self)) return;
	/*if scroll has pre boss 1*/
	if (this->boss_pre_name.size())
	{
		/*look for the first boss*/
		if (!this->find_pre_boss(self)) return;
		/*kill the first boss*/
		if (!this->kill_pre_boss(self)) return;
	}
	/*if scroll has a second boss*/
	if (this->boss_pre_name_2.size())
	{
		/*walk back to start*/
		if (!this->walk_to_start_after_1(self)) return;
		/*look for the second boss*/
		if (!this->find_pre_2_boss(self)) return;
		/*kill second boss*/
		if (!this->kill_pre_2_boss(self)) return;
	}
	/*walk back to start*/
	if (!this->walk_to_start_after_2(self)) return;
	/*look for the main boss*/
	if (!this->find_boss(self)) return;
	/*kill the main boss*/
	if (!this->kill_boss(self)) return;
	/*take rewards*/
	if (!this->take_reward(self)) return;
	/*go back to spawning position*/
	if (!this->walk_back_to_start(self)) return;

	sdk::util::log->b("done scroll, resetting %i %i", this->took_rewards, this->walked_back);
	this->reset();

	scrolls_done++;

	if (!ienable_do_all->iv && ienable_do_num->iv >= scrolls_done)
	{
		scrollbot_toggle->iv = 0;
		scrolls_done = 0;
		return;
	}
}
void sys::c_scrollbot::reset()
{
	this->boss_detected = 0;
	this->boss_pre_detected = 0;

	this->boss_died = 0;
	this->boss_pre_died = 0;

	this->took_rewards = 0;
	this->is_ready_next = 1;
	this->used_scroll = 0;
	this->boss_act = 0;
	this->boss_pre_act = 0;
	this->boss_pre_2_act = 0;
	this->boss_pre_2_detected = 0;
	this->boss_pre_2_died = 0;

	this->walked_back = 0;
	this->walked_back_1 = 0;
	this->walked_back_2 = 0;
	sdk::util::log->b("reset done");
}
bool sys::c_scrollbot::did_use_scroll(uint64_t self)
{
	if (this->used_scroll) return 1;

	if (!this->scrollbot_toggle)
	{
		scrollbot_toggle = sys::config->gvar("scroll_bot", "ienable");
	}

	if (GetTickCount64() < last_use) return 0;
	else
	{
		last_use = GetTickCount64() + 1200;

		if (strstr(sdk::player::player_->ganim(self).c_str(), "SUMMON"))
		{
			sdk::util::log->b("summon confirmed! %s", sdk::player::player_->ganim(self).c_str());
			this->used_scroll = 1;
			return 1;
		}

		this->scrolls_left = 0;
		for (auto obj : sdk::player::player_->inventory_items) if (obj.item_index == this->scroll_id) this->scrolls_left++;
		if (!this->scrolls_left)
		{
			this->reset();
			scrollbot_toggle->iv = 0;
			return 0;
		}
		sys::lua_q->useitem_id(this->scroll_id);
		return 0;
	}

	return 0;
}
bool sys::c_scrollbot::find_pre_boss(uint64_t self)
{
	if (this->boss_pre_detected) return 1;
	auto self_key = *(int*)(self + core::offsets::actor::actor_proxy_key);
	for (auto obj : sdk::player::player_->actors)
	{
		if (obj.type != 1) continue;
		if (obj.name.empty()) continue;
		if (strstr(obj.name.c_str(), this->boss_pre_name.c_str()))
		{
			auto obj_target = *(int*)(obj.ptr + core::offsets::actor::actor_attack_target);
			if (obj_target != self_key) continue;
			if (obj.hp <= 0) continue;
			if (obj.state == 1) continue;
			this->boss_pre_detected = 1;
			this->boss_pre_act = obj.ptr;
			sdk::util::log->b("detected boss %s %i", this->boss_pre_name.c_str(), obj.hp);
			break;
		}
	}
	return this->boss_pre_detected;
}
bool sys::c_scrollbot::find_pre_2_boss(uint64_t self)
{
	if (this->boss_pre_2_detected) return 1;
	auto self_key = *(int*)(self + core::offsets::actor::actor_proxy_key);
	for (auto obj : sdk::player::player_->actors)
	{
		if (obj.type != 1) continue;
		if (obj.name.empty()) continue;
		if (strstr(obj.name.c_str(), this->boss_pre_name_2.c_str()))
		{
			auto obj_target = *(int*)(obj.ptr + core::offsets::actor::actor_attack_target);
			if (obj_target != self_key) continue;
			if (obj.hp <= 0) continue;
			if (obj.state == 1) continue;
			this->boss_pre_2_detected = 1;
			this->boss_pre_2_act = obj.ptr;
			sdk::util::log->b("detected boss 2 %s", this->boss_pre_name_2.c_str());
			break;
		}
	}
	return this->boss_pre_2_detected;
}
bool sys::c_scrollbot::find_boss(uint64_t self)
{
	if (this->boss_detected) return 1;
	auto self_key = *(int*)(self + core::offsets::actor::actor_proxy_key);
	for (auto obj : sdk::player::player_->actors)
	{
		if (obj.type != 1) continue;
		if (obj.name.empty()) continue;
		if (strstr(obj.name.c_str(), this->boss_name.c_str()))
		{
			auto obj_target = *(int*)(obj.ptr + core::offsets::actor::actor_attack_target);
			if (obj_target != self_key) continue;
			if (obj.hp <= 0) continue;
			if (obj.state == 1) continue;
			this->boss_detected = 1;
			this->boss_act = obj.ptr;
			sdk::util::log->b("detected boss 3 %s", this->boss_name.c_str());
			break;
		}
	}
	return boss_detected;
}
bool sys::c_scrollbot::kill_logic(uint64_t self, uint64_t target)
{
	/*uses legit bot as attacking guide*/
	auto spos = sdk::player::player_->gpos(self);
	auto tpos = sdk::player::player_->gpos(target);
	auto dstp = sdk::util::math->gdst_3d(spos, tpos);
	sys::key_q->bypass();
	sys::legit_bot->autopot();
	if (dstp >= this->max_range_from_mob)
	{
		/*need to get closer*/
		sys::legit_bot->aim_pos(tpos, spos);
		sys::key_q->add(new sys::s_key_input({87}, 500));
	}
	else
	{
		/*close enough attack*/
		sys::legit_bot->aim_pos(tpos, spos);
		sys::legit_bot->rskill();
	}
	return 1;
}
bool sys::c_scrollbot::kill_pre_boss(uint64_t self)
{
	if (this->boss_pre_died) return 1;
	auto is_invaild = 1;
	for (auto obj : sdk::player::player_->actors) if (obj.ptr == this->boss_pre_act) { is_invaild = 0; break; }
	if (is_invaild)
	{
		this->boss_pre_act = 0;
		this->boss_pre_died = 1;
		return 1;
	}
	else
	{
		auto health = sdk::player::player_->ghp(this->boss_pre_act);
		auto died = *(bool*)(this->boss_pre_act + core::offsets::actor::actor_is_dead);
		if (!health || died)
		{
			this->boss_pre_act = 0;
			this->boss_pre_died = 1;
			sdk::util::log->b("killed boss %s", this->boss_pre_name.c_str());
			return 1;
		}
		this->kill_logic(self, this->boss_pre_act);
	}
	return this->boss_pre_died;
}
bool sys::c_scrollbot::kill_pre_2_boss(uint64_t self)
{
	if (this->boss_pre_2_died) return 1;
	auto is_invaild = 1;
	for (auto obj : sdk::player::player_->actors) if (obj.ptr == this->boss_pre_2_act) { is_invaild = 0; break; }
	if (is_invaild)
	{
		this->boss_pre_2_act = 0;
		this->boss_pre_2_died = 1;
		return 1;
	}
	else
	{
		auto health = sdk::player::player_->ghp(this->boss_pre_2_act);
		auto died = *(bool*)(this->boss_pre_2_act + core::offsets::actor::actor_is_dead);
		if (!health || died)
		{
			this->boss_pre_2_act = 0;
			this->boss_pre_2_died = 1;
			sdk::util::log->b("killed boss 2 %s", this->boss_pre_name_2.c_str());
			return 1;
		}
		this->kill_logic(self, this->boss_pre_2_act);
	}
	return this->boss_pre_2_died;
}
bool sys::c_scrollbot::kill_boss(uint64_t self)
{
	if (this->boss_died) return 1;
	auto is_invaild = 1;
	for (auto obj : sdk::player::player_->actors) if (obj.ptr == this->boss_act) { is_invaild = 0; break; }
	if (is_invaild)
	{
		this->boss_act = 0;
		this->boss_died = 1;
		return 1;
	}
	else
	{
		auto health = sdk::player::player_->ghp(this->boss_act);
		auto died = *(bool*)(this->boss_act + core::offsets::actor::actor_is_dead);
		if (!health || died)
		{
			this->boss_act = 0;
			this->boss_died = 1;
			sdk::util::log->b("killed boss 3 %s", this->boss_name.c_str());
			return 1;
		}
		this->kill_logic(self, this->boss_act);
	}
	return this->boss_died;
}
bool sys::c_scrollbot::take_reward(uint64_t self)
{
	static auto step = 0;
	static ULONGLONG last_use = 0;

	if (this->took_rewards) return 1;

	if (GetTickCount64() < last_use) return 0;
	else last_use = GetTickCount64() + 2550;

	switch (step)
	{

	case 0:
	{
		last_use = GetTickCount64() + 2500;
		step++;
		return 0;
	}

	case 1:
	{
		if (!strstr(sdk::player::player_->ganim(self).c_str(), "WAIT")) { last_use = GetTickCount64() + 1000; return 0; }

		sys::lua_q->add("PaGlobalFunc_Widget_Alert_HandleLClick(8)");
		step++;
		return 0;
	}

	case 2:
	{
		sys::lua_q->add("HandleEventEnter_DialogQuest_All_SelectConfirmReward()");
		step++;
		return 0;
	}

	case 3:
	{
		sys::lua_q->add("HandleEventLUp_DialogMain_All_ExitClick()");
		step++;
		return 0;
	}

	case 4:
	{
		sdk::util::log->b("rewards taken");
		this->took_rewards = 1;
		step = 0;
		return 1;
	}

	}
	return this->took_rewards;
}
bool sys::c_scrollbot::walk_to_start_after_1(uint64_t self)
{
	if (this->walked_back_1) return 1;

	static bool is_stil_before_movement = 0;
	if (!is_stil_before_movement) if (strstr(sdk::player::player_->ganim(self).c_str(), "WAIT")) is_stil_before_movement = 1;
	if (!is_stil_before_movement) return 0;

	auto spos = sdk::player::player_->gpos(self);
	auto dstp = sdk::util::math->gdst_2d(this->scroll_spawn_pos, spos);
	if (dstp >= 300)
	{
		/*need to get closer*/
		sys::legit_bot->aim_pos(this->scroll_spawn_pos, spos);
		if (!sys::key_q->thread_working) sys::key_q->add(new sys::s_key_input({ 87 }, 75));
		return 0;
	}
	else
	{
		is_stil_before_movement = 0;
		this->walked_back_1 = 1;
		return 1;
	}

	return this->walked_back_1;
}
bool sys::c_scrollbot::walk_to_start_after_2(uint64_t self)
{
	if (this->walked_back_2) return 1;

	static bool is_stil_before_movement = 0;
	if (!is_stil_before_movement) if (strstr(sdk::player::player_->ganim(self).c_str(), "WAIT")) is_stil_before_movement = 1;
	if (!is_stil_before_movement) return 0;

	auto spos = sdk::player::player_->gpos(self);
	auto dstp = sdk::util::math->gdst_2d(this->scroll_spawn_pos, spos);
	if (dstp >= 300)
	{
		/*need to get closer*/
		sys::legit_bot->aim_pos(this->scroll_spawn_pos, spos);
		if (!sys::key_q->thread_working) sys::key_q->add(new sys::s_key_input({ 87 }, 75));
		return 0;
	}
	else
	{
		is_stil_before_movement = 0;
		this->walked_back_2 = 1;
		return 1;
	}

	return this->walked_back_2;
}
bool sys::c_scrollbot::walk_back_to_start(uint64_t self)
{
	if (this->walked_back) return 1;

	auto spos = sdk::player::player_->gpos(self);
	auto dstp = sdk::util::math->gdst_2d(this->scroll_spawn_pos, spos);
	if (dstp >= 300)
	{
		/*need to get closer*/
		sys::legit_bot->aim_pos(this->scroll_spawn_pos, spos);
		if (!sys::key_q->thread_working) sys::key_q->add(new sys::s_key_input({ 87 }, 75));
		return 0;
	}
	else
	{
		sdk::util::log->b("back at start!");
		this->walked_back = 1;
		return 1;
	}

	return this->walked_back;
}
sys::c_scrollbot* sys::scrollbot;