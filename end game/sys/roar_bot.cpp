#include <inc.h>
void sys::c_roar_bot::repath(int a, int b)
{
	if (a == 0) for (auto a : this->grind) this->cur_route.emplace_back(a, "NONE", "NONE", a.pause);
}
bool sys::c_roar_bot::pause(uint64_t s, float p)
{
	if (p == 0.1f || p == 1.f) return true;
	static ULONGLONG pause_ending_tick = 0;
	if (this->p_mode == 0)
	{
		auto mobs = [&]() -> bool
		{
			static auto ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");
			for (auto a : sdk::player::player_->actors)
			{
				if (a.ptr == s) continue;
				if (a.hp <= 0) continue;
				if (a.state == 1) continue;
				if (a.rlt_dst >= ibot_lootrange->iv) continue;
				return false;
			}
			return true;
		};
		if (mobs()) return true;
		else return false;
	}

	auto tick = GetTickCount64();
	if (!pause_ending_tick) { pause_ending_tick = tick + (p * 1000.f); return 0; }
	else { if (tick > pause_ending_tick) { pause_ending_tick = 0; return 1; } }

	return false;
}
bool sys::c_roar_bot::has_lootables(std::vector<sdk::player::s_blank_proxy>& olist, sdk::util::c_vector3 spp)
{
	static std::vector<sdk::player::s_blank_proxy> list;
	static ULONGLONG list_clear_time = 0;
	static auto ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");

	if (GetTickCount64() > list_clear_time) { list_clear_time = GetTickCount64() + 30000; list.clear(); }

	sdk::player::player_->update_actors(this->self);
	olist.clear();
	for (auto a : sdk::player::player_->corpses)
	{
		auto hloot = *(BYTE*)(a.ptr + core::offsets::actor::actor_was_looted);
		if (hloot || a.rlt_dst > ibot_lootrange->iv) continue;
		auto s = false;
		for (auto b : list) { if (a.ptr == b.ptr) { s = 1; break; } }
		if (s) continue;
		auto tr = sdk::player::player_->trace(spp, a.pos, this->self, 400, 34, false);
		if (!tr.success) continue;
		olist.push_back(a); list.push_back(a);
	}
	if (olist.size()) return true;
	return false;
}
bool sys::c_roar_bot::loot_near(sdk::util::c_vector3 o)
{
	static ULONGLONG ltp;
	static std::vector<sdk::player::s_blank_proxy> llist;

	if (llist.empty())
	{
		auto has = this->has_lootables(llist, sdk::player::player_->gpos(this->self));
		if (!has) { llist.clear(); sys::cursor_tp->set_pos(this->self, sdk::util::c_vector3(o.x / 100, o.y / 100, o.z / 100)); return true; }
		return false;
	}
	if (GetTickCount64() > ltp)
	{
		ltp = GetTickCount64() + 350;
		auto c = llist.back();
		if (!c.pos.valid()) { llist.pop_back(); ltp = 0; return false; }
		sys::cursor_tp->set_pos(this->self, sdk::util::c_vector3(c.pos.x / 100, c.pos.y / 100, c.pos.z / 100));
		llist.pop_back();
		return false;
	}

	return false;
}
void sys::c_roar_bot::gpoint()
{
	auto p = sdk::player::player_->gpos(this->self);
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "[gp](" << p.x << ")(" << p.y << ")(" << p.z << ")(0.1)\n";
	f.close();
	this->grind.push_back(p);
	sdk::util::log->add("gpoint add", sdk::util::e_info, true);
}
void sys::c_roar_bot::spoint()
{
	auto p = sdk::player::player_->gpos(this->self);
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "(sp){" << p.x << "}{" << p.y << "}{" << p.z << "}{" << "NONE" << "}{" << "NONE" << "}" << "\n";
	f.close();
	this->grind.push_back(p);
	sdk::util::log->add("gpoint add", sdk::util::e_info, true);
}
void sys::c_roar_bot::gppoint(float t)
{
	auto p = sdk::player::player_->gpos(this->self);
	std::ofstream f(this->pathname, std::ios::app);
	if (!f.is_open()) return;
	f << "[gp](" << p.x << ")(" << p.y << ")(" << p.z << ")(" << t << ")\n";
	f.close();
	this->grind.push_back(p);
	sdk::util::log->add("gppoint add", sdk::util::e_info, true);
}
void sys::c_roar_bot::record()
{
	this->self = *(uint64_t*)(core::offsets::actor::actor_self);
	auto p = sdk::player::player_->gpos(this->self);
	if (!lp.valid())
	{
		this->grind.clear(); this->allowed_sell_items.clear(); this->store.clear();
		lp = p; this->grind.push_back(p);
		return;
	}
	auto d = sdk::util::math->gdst_3d(p, lp);
	if (d >= 300)
	{
		lp = p;
		if (this->recording_g) this->gpoint();
	}
}
void sys::c_roar_bot::load(std::string p)
{
	auto parse_position = [&](std::string l) -> sdk::util::c_vector3
	{
		auto line = l;
		sdk::util::c_vector3 res; res.clear(); res.pause = 0;

		while (line.size() > 0)
		{
			if (res.pause != 0) break; /*finish*/
			/*parse all 4 vector parts*/
			auto pos = line.find("(");

			if (!pos) break;
			line.erase(0, pos + 1);
			pos = line.find(")");

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
		//"(sp){" << obj.pos.x << "}{" << obj.pos.y << "}{" << obj.pos.z << "}{" << obj.npc_name << "}{" << obj.script << "}"
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
				/* "NONE" = no npc*/
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
				/* "NONE" = no scr*/
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
		auto pos = line.find("(");

		line.erase(0, pos + 1);

		pos = line.find(")");
		line.erase(pos, line.size());

		return std::stoi(line);
	};
	this->grind.clear();
	std::ifstream v(p); std::string s;
	if (!v.is_open()) return;
	while (std::getline(v, s))
	{
		if (s.empty()) continue;
		if (strstr(s.c_str(), "(sp)"))
		{
			auto res = parse_storage(s);
			if (res.script != "NONE") { res.special_event = 1; res.pause = 1.2f; }
			if (res.npc_name != "NONE") { res.special_event = 1; res.pause = 8.0f; }
			if (res.pos.valid() && res.script.size() > 0) { this->store.push_back(res); continue; }
		}
		if (strstr(s.c_str(), "[gp]"))
		{
			/*grinding path line would look like __gp__1234_12__1234_12__28973007_dec */
			/*                                    head   x         y        z     pause  */
			auto res = parse_position(s);
			if (res.valid()) { this->grind.push_back(res); continue; }
			else { v.close(); return; }
			continue;
		}
		if (strstr(s.c_str(), "[item]"))
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
	sdk::util::log->add(std::string("done load"), sdk::util::e_info, true);
}
void sys::c_roar_bot::work(uint64_t s)
{
	this->self = s;
	if (this->recording_g || this->recording_s) { this->record(); return; }
	if (!this->dwork) return;
	static auto ibot_timescale = sys::config->gvar("roar_bot", "ibot_timescale");
	static auto iloot_tp = sys::config->gvar("roar_bot", "iloot_tp");
	if (!this->execution) this->execution = GetTickCount64() + ibot_timescale->iv;
	if (GetTickCount64() > this->execution) this->execution = GetTickCount64() + ibot_timescale->iv;
	else return;
	//sp etc.
	if (!this->cur_route.size()) this->repath(0, 0);
	//
	auto cur_point = this->cur_route.front();
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
	sdk::util::log->add(std::string("sscr:").append(a), sdk::util::e_info, true);
	this->s_scr = a;
}
sys::c_roar_bot* sys::roar_bot;