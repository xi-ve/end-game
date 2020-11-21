#include <inc.h>
bool sys::c_roar_bot::ssp(s_path_script s)
{

	if (this->path_contains_repair) if (this->is_arsha_low_dur())
	{
		sdk::util::log->b("going to storage reason: arsha gear swap");
		return true;
	}

	if (this->force_store)
	{
		sdk::util::log->add("going storage reason: force_store", sdk::util::e_critical, true);
		return true;
	}

	auto in_m = *(int*)(this->self + core::offsets::actor::actor_inv_max_weight) / 10000;
	auto in_w = (*(int*)(this->self + core::offsets::actor::actor_inv_raw_weight) + *(int*)(this->self + core::offsets::actor::actor_inv_gear_weight)) / 10000;
	if (in_w >= in_m)
	{
		sdk::util::log->add(std::string("going storage reason: in_w >= in_m > in_w:").append(std::to_string(in_w)).append(" in_m:").append(std::to_string(in_m)), sdk::util::e_critical, true);
		return true;
	}
	//
	auto in_l = *(int*)(this->self + core::offsets::actor::actor_inv_left);
	if (in_l < 0) return false;
	if (in_l <= 2)
	{
		sdk::util::log->add(std::string("going storage reason: in_l <= 2 > in_l:").append(std::to_string(in_l)), sdk::util::e_critical, true);
		return true;
	}
	//
	return false;
}
void sys::c_roar_bot::repath(int a, int b)
{
	if (a == 0) { this->cur_route.clear(); for (auto c : this->grind) this->cur_route.emplace_back(c, "X", "X", c.pause); }
	if (a == 1)
	{
		this->cur_route.clear();
		if (b) this->cur_route = this->store;
		else
		{
			this->cur_route = this->store;
			std::reverse(this->cur_route.begin(), this->cur_route.end());
		}
		this->reversed = b;
	}
}
bool sys::c_roar_bot::pause(uint64_t s, float p)
{
	if (p == 0.1f || p == 1.f) return true;
	if (this->p_mode == 0)
	{
		auto mobs = [&]() -> bool
		{
			if (!ibot_lootrange) ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");
			auto sk = *(int*)(s + core::offsets::actor::actor_proxy_key);
			for (auto a : sdk::player::player_->actors)
			{
				if (a.ptr == s) continue;
				if (a.type != 1) continue;
				if (a.hp <= 0) continue;
				if (a.state == 1) continue;
				if (a.rlt_dst >= ibot_lootrange->iv) continue;
				auto ak = *(int*)(a.ptr + core::offsets::actor::actor_attack_target);
				if (ak != sk) return true;
				return false;
			}
			return true;
		};
		if (mobs()) return true;
		else
		{
			if (!this->max_cooltime) this->max_cooltime = GetTickCount64() + 30000;
			else if (GetTickCount64() > this->max_cooltime) { this->max_cooltime = 0; return true; }
			return false;
		}
	}

	auto tick = GetTickCount64();
	if (!pause_ending_tick) { pause_ending_tick = tick + (p * 1000.f); return 0; }
	else { if (tick > pause_ending_tick) { pause_ending_tick = 0; return 1; } }

	return false;
}
bool sys::c_roar_bot::has_lootables(sdk::util::c_vector3 spp)
{
	if (!ibot_lootrange) ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");
	if (sys::loot->loot_proxys.empty()) return 0;
	auto l = 9999.f; auto rr = uint64_t(0);
	auto selfpos = sdk::player::player_->gpos(this->self);
	for (auto b = 0; b < sys::loot->loot_proxys.size(); b++)
	{
		auto a = sys::loot->loot_proxys[b];
		if (*(BYTE*)(a.ptr + core::offsets::actor::actor_was_looted))
		{
			sys::loot->loot_proxys.erase(sys::loot->loot_proxys.begin() + b);
			continue;
		}
		auto ap = sdk::player::player_->gpos(a.ptr);
		auto rd = sdk::util::math->gdst_3d(ap, spp);
		if (rd <= l && rd <= ibot_lootrange->iv)
		{
			if (!sdk::player::player_->trace(selfpos, ap, this->self, 200, 34, false).success) continue;
			l = rd;
			rr = a.ptr;
			continue;
		}
	}
	return rr;
}
bool sys::c_roar_bot::loot_near(sdk::util::c_vector3 o)
{
	if (!ibot_lootrange) ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");

	auto has = this->has_lootables(o);
	if (!has) { sys::cursor_tp->set_pos(this->self, sdk::util::c_vector3(o.x / 100, o.y / 100, o.z / 100)); return true; }

	auto selfpos = sdk::player::player_->gpos(this->self);

	auto l = 9999.f; auto rr = uint64_t(0);
	for (auto b = 0; b < sys::loot->loot_proxys.size(); b++)
	{
		auto a = sys::loot->loot_proxys[b];
		if (*(BYTE*)(a.ptr + core::offsets::actor::actor_was_looted))
		{
			sys::loot->loot_proxys.erase(sys::loot->loot_proxys.begin() + b);
			continue;
		}
		auto ap = sdk::player::player_->gpos(a.ptr);
		auto rd = sdk::util::math->gdst_3d(ap, o);
		if (rd <= l && rd <= ibot_lootrange->iv)
		{
			if (!sdk::player::player_->trace(selfpos, ap, this->self, 200, 34, false).success) continue;
			l = rd;
			rr = a.ptr;
			continue;
		}
	}
	if (rr)
	{
		auto lpos = sdk::player::player_->gpos(rr);
		sys::cursor_tp->set_pos(this->self, sdk::util::c_vector3((int)lpos.x / 100, (int)lpos.y / 100, (int)lpos.z / 100));
		this->loot_act_k = *(int*)(rr + core::offsets::actor::actor_proxy_key);
		if (rr != this->last_loot_actor)//test this ok
		{
			this->last_loot_actor = rr;
			this->last_loot_time = GetTickCount64() + 5000;
		}
		else
		{
			if (GetTickCount64() > this->last_loot_time)
			{
				for (auto b = 0; b < sys::loot->loot_proxys.size(); b++)
				{
					auto a = sys::loot->loot_proxys[b];
					if (a.ptr != this->last_loot_actor) continue;
					sys::loot->loot_proxys.erase(sys::loot->loot_proxys.begin() + b);
					break;
				}
				this->last_loot_actor = 0;
				this->last_loot_time = 0;
			}
		}
	}

	return false;
}
bool sys::c_roar_bot::has_aggro()
{
	auto sk = *(int*)(this->self + core::offsets::actor::actor_proxy_key);
	for (auto a : sdk::player::player_->actors)
	{
		if (a.type != 1 || a.hp <= 0 || a.state == 1 || a.rlt_dst >= 2000) continue;
		auto ag = *(int*)(a.ptr + core::offsets::actor::actor_attack_target);
		if (sk == ag) return true;
	}
	return false;
}
bool sys::c_roar_bot::stance()
{
	//BT_ACTION_CHANGE
	auto a = sdk::player::player_->ganim(this->self);
	if (strstr(a.c_str(), "BT_ACTION_CHANGE")) return true;
	if (strstr(a.c_str(), "BT_skill_AggroShout_Ing_UP")) return true;//autoskip
	if (strstr(a.c_str(), "BT_WAIT")) return true;//autoskip
	if (GetTickCount64() > this->sct) this->sct = GetTickCount64() + 5000;
	else return false;
	if (strstr(a.c_str(), "WAIT"))
	{
		sys::key_q->add(new sys::s_key_input({ VK_TAB }, 500));
		return false;
	}
	return true;
}
void sys::c_roar_bot::skill()
{
	if (this->cur_route.empty()) return;
	if ((this->npc_interacted && this->p_mode == 1)
		|| (!this->ibot_storage_roar->iv && this->p_mode == 1))
	{
		auto ctrl = *(uint64_t*)(this->self + core::offsets::actor::actor_char_ctrl);
		if (!ctrl) return;
		auto scene = *(uint64_t*)(ctrl + core::offsets::actor::actor_char_scene);
		if (!scene) return;
		auto cv = *(float*)(scene + core::offsets::actor::actor_animation_speed);
		if (cv >= 800000.f) *(float*)(scene + core::offsets::actor::actor_animation_speed) = 1.f;
		return;
	}
	if (this->cur_route.front().script != "X") return;
	if (this->skill_delay > GetTickCount64()) return;
	auto an = sdk::player::player_->ganim(this->self);
	if (!an.size()) return;
	if ((strstr(an.c_str(), "BT_skill_AggroShout_Ing_UP") && !this->skill_locked))
	{
		this->skill_locked = 1;
		auto ctrl = *(uint64_t*)(this->self + core::offsets::actor::actor_char_ctrl);
		if (!ctrl) return;
		auto scene = *(uint64_t*)(ctrl + core::offsets::actor::actor_char_scene);
		if (!scene) return;
		*(float*)(scene + core::offsets::actor::actor_animation_speed) = 800000.f;
		return;
	}
	else if (!strstr(an.c_str(), "BT_skill_AggroShout_Ing_UP"))
	{
		if (sdk::player::player_->gsp(this->self) < 65)
		{
			auto used = 0;
			for (auto a : sdk::player::player_->inventory_items)
			{
				if (std::find(this->wp_items.begin(), this->wp_items.end(), a.item_index) != this->wp_items.end())
				{
					sys::lua_q->useitem(a.item_slot);
					used = true;
					break;
				}
			}
			if (!used) { this->skill_delay = GetTickCount64() + 1000; this->skill_locked = 0; return; }
		}

		auto ctrl = *(uint64_t*)(this->self + core::offsets::actor::actor_char_ctrl);
		if (!ctrl) return;
		auto scene = *(uint64_t*)(ctrl + core::offsets::actor::actor_char_scene);
		if (!scene) return;
		*(float*)(scene + core::offsets::actor::actor_animation_speed) = 1.f;

		this->skill_delay = GetTickCount64() + 1000;
		this->skill_locked = 0;
		sys::key_q->add(new sys::s_key_input({ 81 }, 200));
	}
}
bool sys::c_roar_bot::snear()
{
	if (this->p_mode == 1) return false;
	this->self = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!this->self) return false;
	auto p = sdk::player::player_->gpos(this->self); auto ldst = 9999.f; sdk::util::c_vector3 lv;
	this->cur_route.clear();
	this->repath(0, 0);
	for (auto a : this->cur_route)
	{
		auto d = sdk::util::math->gdst_3d(p, a.pos);
		if (d < ldst)
		{
			ldst = d;
			lv = a.pos;
		}
	}
	for (auto a : this->cur_route)
	{
		if (!a.pos.cmp(lv)) this->cur_route.pop_front();
		else
		{
			sdk::util::log->add("set start to nearest pos");
			break;
		}
	}
	return true;
}
void sys::c_roar_bot::reset()
{
	this->cur_route.clear(); this->grind.clear(); this->store.clear(); this->allowed_sell_items.clear(); this->items_left_sell.clear();
	this->p_mode = 0;
	this->reversed = 0;
	this->s_npc = "X";
	this->s_scr = "X";
	this->lp.clear();
	this->path_contains_repair = false;
	this->arsha_char = false;
}
bool sys::c_roar_bot::is_arsha_low_dur()
{
	auto is_arsha = [&](uint64_t adr, byte slot) -> bool
	{
		auto id = *(WORD*)(this->self + adr);
		auto id_dur = *(byte*)(this->self + (adr + 0x4));
		if (id < 1 || id == 0xFFFF) return 0;
		if (id_dur > 20) return 0;
		for (auto obj : arsha_items) if (obj == id) { this->arsha_char = true; return 1; }
		for (auto obj : arsha_weapons) if (obj == id) { this->arsha_char = true; return 1; }
		return 0;
	};
	if (is_arsha(core::offsets::actor::eq_dur_main_weapon, 0)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_awak, 29)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_sub_weapon, 1)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_ear1, 10)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_ear2, 11)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_armor, 3)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_helmet, 6)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_neck, 7)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_gloves, 4)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_shoes, 5)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_belt, 12)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_ring1, 8)) return 1;
	if (is_arsha(core::offsets::actor::eq_dur_ring2, 9)) return 1;
	if (this->force_store) { this->arsha_char=true; return 1; }
	return 0;
}
void sys::c_roar_bot::gpoint()
{
	auto p = sdk::player::player_->gpos(this->self);
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "(grinding){" << p.x << "}{" << p.y << "}{" << p.z << "}{0.1}\n";
	f.close();
	this->grind.push_back(p);
	sdk::util::log->add("gpoint add", sdk::util::e_info, true);
}
void sys::c_roar_bot::spoint()
{
	auto p = sdk::player::player_->gpos(this->self);
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "(sellstore){" << p.x << "}{" << p.y << "}{" << p.z << "}{" << "X" << "}{" << "X" << "}" << "\n";
	f.close();
	sdk::util::log->add("spoint add", sdk::util::e_info, true);
	this->store.emplace_back(p, "X", "X", false);
}
void sys::c_roar_bot::sepoint()
{
	auto p = sdk::player::player_->gpos(this->self);
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "(sellstore){" << p.x << "}{" << p.y << "}{" << p.z << "}{" << this->s_npc << "}{" << this->s_scr << "}\n";
	f.close();
	this->s_npc = "X"; this->s_scr = "X"; this->glua_actions = false; this->last_lua_actions.clear();
	this->store.emplace_back(p, this->s_npc, this->s_scr, true);
	sdk::util::log->add("sepoint add", sdk::util::e_info, true);
}
void sys::c_roar_bot::sitem(int i)
{
	for (auto a : this->allowed_sell_items) if (a == i) return;
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "(sellstoreitem){" << i << "}\n";
	this->allowed_sell_items.push_back(i);
	sdk::util::log->add("sitem add", sdk::util::e_info, true);
}
std::vector<std::string> sys::c_roar_bot::gitm()
{
	auto r = std::vector<std::string>();
	//
	for (auto a : sdk::player::player_->inventory_items) r.push_back(a.name);
	//
	return r;
}
std::vector<int> sys::c_roar_bot::gitm_left()
{
	return this->items_left_sell;
}
int sys::c_roar_bot::gitem_bn(std::string s)
{
	for (auto a : sdk::player::player_->inventory_items) if (a.name == s) return a.item_index;
	return {};
}
void sys::c_roar_bot::gppoint(float t)
{
	auto p = sdk::player::player_->gpos(this->self); p.pause = t;
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "(grinding){" << p.x << "}{" << p.y << "}{" << p.z << "}{" << t << "}\n";
	f.close();
	this->grind.push_back(p);
	sdk::util::log->add("gppoint add", sdk::util::e_info, true);
}
void sys::c_roar_bot::record()
{
	this->self = *(uint64_t*)(core::offsets::actor::actor_self);
	auto p = sdk::player::player_->gpos(this->self);
	if (!this->store_can_path && this->recording_s) return;
	if (!lp.valid())
	{
		this->grind.clear(); this->allowed_sell_items.clear(); this->store.clear();
		lp = p;
		if (this->recording_g) this->grind.push_back(p);
		if (this->recording_s) this->store.emplace_back(p, "X", "X", false);
		return;
	}
	auto d = sdk::util::math->gdst_3d(p, lp);
	if (d >= this->recording_step_size)
	{
		lp = p;
		if (this->recording_g) this->gpoint();
		if (this->recording_s) this->spoint();
	}
}
void sys::c_roar_bot::load()
{
	sdk::dialog::dialog->sell_reset();
	this->reset(); this->grind.clear(); this->store.clear();
	auto parse_position = [&](std::string l) -> sdk::util::c_vector3
	{
		auto line = l;
		sdk::util::c_vector3 res; res.clear(); res.pause = 0;

		while (line.size() > 0)
		{
			if (res.pause != 0) break; /*finish*/
			/*parse all 4 vector parts*/
			auto pos = line.find("{");

			if (!pos) break;
			line.erase(0, pos + 1);
			pos = line.find("}");

			auto cpy = line;
			cpy.erase(pos, cpy.size()); /*cpy only contains the seperated string now*/

			line.erase(0, pos); /*line now has the seperated part removed from it*/

			auto flt = std::stof(cpy);

			//sdk::util::log->add(std::string(">f:").append(std::to_string(flt)).append(" s:").append(std::to_string(line.size())), sdk::util::e_info, true);

			if (res.x == 0) res.x = flt;
			else if (res.y == 0) res.y = flt;
			else if (res.z == 0) res.z = flt;
			else if (res.pause == 0) res.pause = flt;
		}

		return res;
	};
	auto parse_storage = [&](std::string l) -> s_path_script
	{
		auto line = l;
		s_path_script res;
		//"(sellstore){" << obj.pos.x << "}{" << obj.pos.y << "}{" << obj.pos.z << "}{" << obj.npc_name << "}{" << obj.script << "}"
		while (line.size() > 0)
		{
			if (res.script.size() > 0) break;/*done parsing*/

			if (res.pos.hasZero()) /*parse pos vec3*/
			{
				auto pos = line.find("{");
				line.erase(0, pos + 1); /*delete header and first {*/

				pos = line.find("}");

				auto cpy = line;
				cpy.erase(pos, cpy.size());/*only leaves var behind*/

				line.erase(0, pos); /*erase current vec entry*/

				auto var = std::stof(cpy);

				if (res.pos.x == 0) res.pos.x = var;
				else if (res.pos.y == 0) res.pos.y = var;
				else if (res.pos.z == 0) res.pos.z = var;
			}
			else if (res.npc_name.empty()) /*parse npc name from script*/
			{
				/* "X" = no npc*/
				auto pos = line.find("{");
				line.erase(0, pos + 1);

				pos = line.find("}");

				auto cpy = line;
				cpy.erase(pos, cpy.size()); /*erase all after npc name*/

				line.erase(0, pos); /*delete npc name from line*/

				res.npc_name = cpy;
			}
			else if (res.script.empty()) /*parse lua script line*/
			{
				/* "X" = no scr*/
				auto pos = line.find("{");
				line.erase(0, pos + 1);

				pos = line.find("}");

				auto cpy = line;
				cpy.erase(pos, cpy.size()); /*erase all after scr*/

				line.erase(0, pos); /*delete scr from line*/

				res.script = cpy;
			}
		}
		res.pause = 0.1f;
		res.pos.pause = 0.1f;
		return res;
	};
	auto parse_item = [&](std::string l) -> int
	{
		auto line = l;
		auto pos = line.find("{");

		line.erase(0, pos + 1);

		pos = line.find("}");
		line.erase(pos, line.size());

		return std::stoi(line);
	};
	this->grind.clear();
	std::ifstream v(this->pathname); std::string s;
	if (!v.is_open()) return;
	while (std::getline(v, s))
	{
		if (s.empty()) continue;
		if (strstr(s.c_str(), "(sellstore)"))
		{
			auto res = parse_storage(s);
			if (res.script != "X") { res.special_event = 1; res.pause = 1.2f; }
			if (res.npc_name != "X") { res.special_event = 1; res.pause = 8.0f; }					
			if (res.pos.valid() && res.script.size() > 0) 
			{ 
				if (strstr(res.script.c_str(), "repair_routine()")) this->path_contains_repair = true;
				this->store.push_back(res); continue; 
			}
		}
		if (strstr(s.c_str(), "(grinding)"))
		{
			/*grinding path line would look like __gp__1234_12__1234_12__28973007_dec */
			/*                                    head   x         y        z     pause  */
			auto res = parse_position(s);
			if (res.valid()) { this->grind.push_back(res); continue; }
			else { v.close(); return; }
			continue;
		}
		if (strstr(s.c_str(), "(sellstoreitem)"))
		{
			/*item whitelist line would look like __item__1234_1643616536_dec */
			/*                                      head  item idx*/
			auto res = parse_item(s);
			if (res != 0) { this->allowed_sell_items.push_back(res); continue; }
			else v.close(); return;
			continue;
		}
	}
	v.close();
	this->items_left_sell = this->allowed_sell_items;
}
void sys::c_roar_bot::save()
{
	std::ofstream p(this->pathname);
	if (!p.is_open()) return;
	for (auto a : this->grind)
	{
		if (a.pause > 0.1f && a.pause != 0.f) p << "(grinding){" << a.x << "}{" << a.y << "}{" << a.z << "}{" << a.pause << "}\n";
		else p << "(grinding){" << a.x << "}{" << a.y << "}{" << a.z << "}{" << 0.1f << "}\n";
	}
	for (auto a : this->store) p << "(sellstore){" << a.pos.x << "}{" << a.pos.y << "}{" << a.pos.z << "}{" << a.npc_name << "}{" << a.script << "}\n";
	for (auto a : this->allowed_sell_items)	p << "(sellstoreitem)(" << a << ")\n";
	sdk::util::log->add("resaved path");
}
void sys::c_roar_bot::work(uint64_t s)
{
	this->self = s;
	if (this->recording_g || this->recording_s) { this->record(); return; }
	if (!this->dwork) return;
	if (!ibot_timescale) ibot_timescale = sys::config->gvar("roar_bot", "ibot_timescale");
	if (!ibot_storage_roar) ibot_storage_roar = sys::config->gvar("roar_bot", "ibot_storage_roar");
	if (!iloot_tp) iloot_tp = sys::config->gvar("roar_bot", "iloot_tp");
	if (!istop_on_player) istop_on_player = sys::config->gvar("protection", "istop_on_player");
	if (!iexit_on_player) this->iexit_on_player = sys::config->gvar("protection", "iexit_on_player");
	if (!iauto_disable_render) iauto_disable_render = sys::config->gvar("visuals", "iauto_disable_render");
	if (!this->execution) this->execution = GetTickCount64() + ibot_timescale->iv;
	if (GetTickCount64() > this->execution) this->execution = GetTickCount64() + ibot_timescale->iv;
	else return;
	//
	if (sdk::player::player_->ghp(this->self) <= 0) return;
	if ((istop_on_player->iv || iexit_on_player->iv) && !this->p_mode) if (sys::protection->players_in_range(s)) return;
	//
	if (!this->stance()) return;
	this->skill();
	if (!iauto_disable_render->iv)
	{
		auto base = *(uint64_t*)(core::offsets::cl::client_base);
		if (!base) return;
		auto _x18 = *(uint64_t*)(base + 0x18);
		if (!_x18) return;
		auto _x178 = *(uint64_t*)(_x18 + 0x178);
		if (!_x178) return;
		*(byte*)(_x178 + 0x800) = 0;
	}
	else
	{
		auto base = *(uint64_t*)(core::offsets::cl::client_base);
		if (!base) return;
		auto _x18 = *(uint64_t*)(base + 0x18);
		if (!_x18) return;
		auto _x178 = *(uint64_t*)(_x18 + 0x178);
		if (!_x178) return;
		*(byte*)(_x178 + 0x800) = 1;
	}
	//e.g auto scroll combine/event items
	//
	if (this->gssize() && this->cur_route.empty() && this->ssp({}) && this->p_mode == 0)
	{
		this->repath(1, 1);
		this->p_mode = 1;
		this->force_store = false;
		sdk::util::log->add("should SP NOW", sdk::util::e_info, true);
	}
	if (!this->cur_route.size() && this->p_mode == 0) this->repath(0, 0);
	if (!this->cur_route.size() && this->p_mode == 1 && this->reversed)
	{
		//remove events
		this->repath(1, 0);
		for (auto a = 0; a < this->cur_route.size(); a++)
		{
			auto obj = this->cur_route[a];
			if (obj.special_event) this->cur_route.erase(this->cur_route.begin() + a);
		}
		sdk::util::log->add("repathed SP conform", sdk::util::e_info, true);
	}
	//
	auto cur_point = this->cur_route.front();
	if (this->p_mode == 1)
	{
		if (this->reversed)//path to
		{
			if (cur_point.special_event)
			{
				if (cur_point.npc_name != "X")//npc
				{
					if (this->has_aggro()) return;

					sdk::dialog::dialog->sell_reset();

					sdk::dialog::dialog->sell_reset();
					std::string npc_wanted = ""; uint64_t npc_wanted_ptr = 0;
					for (auto b : this->store) if (b.npc_name != "X") { npc_wanted = b.npc_name; break; }
					for (auto b : sdk::player::player_->npcs) if (strstr(b.name.c_str(), npc_wanted.c_str())) { npc_wanted_ptr = b.ptr; break; }

					if (!npc_wanted_ptr)
					{
						sdk::util::log->b("npc cannot be found");
						return;
					}

					this->f_npc_interaction(npc_wanted_ptr);
					auto cinteract = *(uint64_t*)(core::offsets::actor::interaction_current);
					if (!cinteract || cinteract != npc_wanted_ptr) return;

					sys::cursor_tp->set_pos(s, sdk::util::c_vector3(cur_point.pos.x / 100, cur_point.pos.y / 100, cur_point.pos.z / 100));
					this->cur_route.pop_front();

					auto ctrl = *(uint64_t*)(this->self + core::offsets::actor::actor_char_ctrl);
					if (!ctrl) return;
					auto scene = *(uint64_t*)(ctrl + core::offsets::actor::actor_char_scene);
					if (!scene) return;
					auto speed = *(float*)(scene + core::offsets::actor::actor_animation_speed);
					*(float*)(scene + core::offsets::actor::actor_animation_speed) = 1.f;

					this->items_left_sell = this->allowed_sell_items;
					this->last_interaction_name = npc_wanted;

					sdk::util::log->b("wanted interaction setup for %s", this->last_interaction_name.c_str());

					return;
				}
				else if (cur_point.script != "X")//scr
				{
					if (cur_point.script == "sell_routine()")
					{
						if (sdk::dialog::dialog->completed_sales)
						{
							sdk::dialog::dialog->sell_reset();
							sdk::dialog::dialog->thread_running = false;
							sdk::dialog::dialog->completed_sales = false;
							this->items_left_sell.clear();
							this->cur_route.pop_front();
							this->npc_interacted = true;
							this->execution = GetTickCount64() + 1000;
							return;
						}
						if (!strstr(sdk::player::player_->ganim(this->self).c_str(), "WAIT")) return;

						if (!sdk::dialog::dialog->completed_sales && !sdk::dialog::dialog->thread_running)
						{
							sdk::util::log->b("starting sell routine");
							sdk::util::log->b("for %s", this->last_interaction_name.c_str());
							sdk::dialog::dialog->completed_sales = false;
							sdk::dialog::dialog->thread_running = true;
							auto stru = new sdk::dialog::s_thread_p();
							stru->npc = this->last_interaction_name;
							stru->items = this->items_left_sell;
							CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sdk::dialog::do_sell, (PVOID)stru, 0, 0);
							this->execution = GetTickCount64() + 1000;
							return;
						}

						return;
					}
					else if (cur_point.script == "store_routine()")
					{
						if (sdk::dialog::dialog->completed_sales)
						{
							sdk::util::log->b("completed store routine");
							sdk::dialog::dialog->sell_reset();
							sdk::dialog::dialog->thread_running = false;
							sdk::dialog::dialog->completed_sales = false;
							this->items_left_sell.clear();
							this->cur_route.pop_front();
							this->npc_interacted = true;
							this->execution = GetTickCount64() + 1000;
							return;
						}
						if (!strstr(sdk::player::player_->ganim(this->self).c_str(), "WAIT")) return;

						if (!sdk::dialog::dialog->completed_sales && !sdk::dialog::dialog->thread_running)
						{
							sdk::util::log->b("starting store routine <now>");
							sdk::dialog::dialog->completed_sales = false;
							sdk::dialog::dialog->thread_running = true;
							auto stru = new sdk::dialog::s_thread_p();
							stru->npc = this->last_interaction_name;
							stru->items = this->items_left_sell;
							CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sdk::dialog::do_store, (PVOID)stru, 0, 0);
							this->execution = GetTickCount64() + 1000;
							return;
						}

						return;
					}
					else if (cur_point.script == "repair_routine()")
					{
						if (sdk::dialog::dialog->completed_repair)
						{
							if (this->arsha_char)
							{
								if (sys::gear_exchanger->done_exchange)
								{
									sdk::dialog::dialog->completed_repair = false;
									sdk::dialog::dialog->thread_running = false;
									sys::gear_exchanger->done_exchange = false;
									sys::gear_exchanger->thread_is_working = false;
									this->arsha_char = false;
									this->npc_interacted = false;
									this->cur_route.pop_front();
									this->execution = GetTickCount64() + 1000;
									sdk::util::log->b("exchange done");
									return;
								}
								if (!sys::gear_exchanger->thread_is_working && !sys::gear_exchanger->done_exchange)
								{
									sys::gear_exchanger->work();
									sdk::util::log->b("exchange started");
									return;
								}
								if (!sys::gear_exchanger->thread_is_working)
								{
									sdk::dialog::dialog->completed_repair = false;
									sdk::dialog::dialog->thread_running = false;
									sys::gear_exchanger->done_exchange = false;
									sys::gear_exchanger->thread_is_working = false;
									this->arsha_char = false;
									this->npc_interacted = false;
									this->cur_route.pop_front();
									this->execution = GetTickCount64() + 1000;
									sdk::util::log->b("exchange not needed, done");
									return;
								}
								return;
							}
							else
							{
								this->arsha_char = false;
								sdk::dialog::dialog->completed_repair = false;
								sdk::dialog::dialog->thread_running = false;
								this->npc_interacted = false;
								this->cur_route.pop_front();
								this->execution = GetTickCount64() + 1000;
								return;
							}
						}
						if (!strstr(sdk::player::player_->ganim(this->self).c_str(), "WAIT")) return;

						if (!sdk::dialog::dialog->completed_repair && !sdk::dialog::dialog->thread_running)
						{
							sdk::dialog::dialog->completed_repair = false;
							sdk::dialog::dialog->thread_running = true;
							auto stru = new sdk::dialog::s_thread_p();
							stru->npc = this->last_interaction_name;
							CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sdk::dialog::repair_eq, (PVOID)stru, 0, 0);
							this->execution = GetTickCount64() + 1000;
							return;
						}
						return;
					}
					return;
				}
			}
			else
			{
				sys::cursor_tp->set_pos(s, sdk::util::c_vector3(cur_point.pos.x / 100, cur_point.pos.y / 100, cur_point.pos.z / 100));
				this->cur_route.pop_front();
				return;
			}
		}
		else//path back
		{
			this->npc_interacted = false;
			sys::cursor_tp->set_pos(s, sdk::util::c_vector3(cur_point.pos.x / 100, cur_point.pos.y / 100, cur_point.pos.z / 100));
			this->cur_route.pop_front();
			if (this->cur_route.empty())
			{
				this->p_mode = 0;
				this->repath(0, 0);
				sdk::util::log->add("completed SP", sdk::util::e_info, true);
				this->npc_interacted = false;
			}
		}
		return;
	}
	//
	auto x = this->pause(this->self, cur_point.pos.pause);
	if (!x) return;
	else this->cur_route.front().pause = 0.1f;
	//
	if (iloot_tp->iv)
	{
		auto looting = this->loot_near(cur_point.pos);
		if (!looting) return;
	}
	//
	sys::cursor_tp->set_pos(s, sdk::util::c_vector3(cur_point.pos.x / 100, cur_point.pos.y / 100, cur_point.pos.z / 100));
	this->cur_route.pop_front();
}
void sys::c_roar_bot::snpc(std::string a)
{
	this->s_npc = a;
}
void sys::c_roar_bot::sscr(std::string a)
{
	this->s_scr = a;
}
void sys::c_roar_bot::sgpos(sdk::util::c_vector3 to_replace, sdk::util::c_vector3 new_pos)
{
	for (auto&& a : this->grind)
	{
		if (!a.cmp(to_replace)) continue;
		a = new_pos;
		break;
	}
}
std::vector<std::string> sys::c_roar_bot::gnpcs()
{
	auto r = std::vector<std::string>();
	for (auto a : sdk::player::player_->npcs)
	{
		r.push_back(a.name);
	}
	return r;
}
sys::c_roar_bot* sys::roar_bot;