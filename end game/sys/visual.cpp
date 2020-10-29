#include <inc.h>
std::vector<sdk::util::c_vector3> sys::c_visuals::gcircle(sdk::util::c_vector3 from, float dst, int deg, int rad)
{
	auto r = std::vector<sdk::util::c_vector3>();
#define M_PI		3.14159265358979323846
	for (auto c = 0; c < rad; c += deg)
	{
		auto x = from.x + (dst * std::cos(c / (180 / M_PI)));
		auto y = from.y;
		auto z = from.z + (dst * std::sin(c / (180 / M_PI)));
		r.emplace_back(x, y, z);
	}
	r.push_back(r.front());//completes circle
	return r;
}
std::vector<sdk::util::c_vector3> sys::c_visuals::gcircle_front(sdk::util::c_vector3 from, float dst, int deg, int rad)
{
#define M_PI		3.14159265358979323846
	auto r = std::vector<sdk::util::c_vector3>();
	auto controller = *(uint64_t*)(this->self + core::offsets::actor::actor_char_ctrl);
	if (!controller) return {};
	auto c_base = *(uint64_t*)(controller + 0x10);
	if (!c_base) return {};
	auto rot = *(float*)(c_base + 0x43C);
	if (!rot) return r;
	auto xr = (std::sin(rot) * -1);
	auto zr = (std::cos(rot) * -1);
	auto start_x = from.x;
	auto start_z = from.z;
	auto radius = dst;
	for (auto c = 0; c < deg; c += rad)
	{
		auto angle = 11 - (c)*M_PI / 180;
		auto x = start_x + radius * std::sin((rot)+angle);
		auto z = start_z + radius * std::cos((rot)+angle);
		r.push_back(sdk::util::c_vector3(x, from.y, z));
	}
	return r;
}
void sys::c_visuals::monster_proxy_debug()
{
	auto a = sdk::player::player_->actors;
	if (a.size() <= 1) return;
	auto sv = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(sdk::player::player_->gpos(this->self), sv)) return;
	for (auto b : a)
	{
		if (b.ptr == NULL) continue;
		auto bpos = sdk::player::player_->gpos(b.ptr);
		auto v = sdk::util::c_vector3();
		if (!sdk::util::math->w2s(bpos, v)) continue;
		sdk::render::render->DrawLine(sv.x, sv.z, v.x, v.z, 0xff00ff0f);
		sdk::render::render->RenderText(v.x, v.z - 50, 0xff00ff00, (char*)sdk::util::log->as_hex(b.ptr).c_str());
	}
}
void sys::c_visuals::alive_proxy_debug()
{
	auto a = sdk::player::player_->actors;
	if (a.size() <= 1) return;
	auto sv = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(sdk::player::player_->gpos(this->self), sv)) return;
	for (auto b : a)
	{
		if (!b.pos.valid() || b.ptr == NULL || b.type != 1) continue;
		if (!strstr(b.name.c_str(), sdk::menu::menu->mob_target)) continue;
		auto v = sdk::util::c_vector3();
		if (!sdk::util::math->w2s(b.pos, v)) continue;
		sdk::render::render->DrawLine(sv.x, sv.z, v.x, v.z, 0xff00ff0f);
		sdk::render::render->RenderText(v.x, v.z - 30, 0xff00ff00, (char*)b.name.c_str());
		sdk::render::render->RenderText(v.x, v.z - 50, 0xff00ff00, (char*)sdk::util::log->as_hex(b.ptr).c_str());
		sdk::render::render->RenderText(v.x, v.z - 70, 0xff00ff00, (char*)sdk::util::log->as_hex(b.key).c_str());
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
void sys::c_visuals::ptrace()
{
	this->t_map.clear();
	sdk::util::c_vector3 t; auto f = sdk::player::player_->gpos(this->self);
	for (auto g = 100; g < 1000; g += 200)
	{
		auto i_c = this->gcircle(f, g, 4);
		for (auto a : i_c)
		{
			auto c_f = this->gcircle(a, 350, 4);
			for (auto b : c_f)
			{
				auto c = sdk::util::c_vector3(b.x, b.y + 600, b.z);
				auto r = sdk::player::player_->trace(c, b, this->self, 600, 34, false);
				if (!sdk::util::math->w2s(r.end_point, t)) continue;
				this->t_map.push_back(r);
			}
		}
	}
	/*for (auto a = 100; a < 1500; a += 100)
	{
		auto c_e = this->gcircle(f, a, 4);
		for (auto b : c_e)
		{
			auto c = sdk::util::c_vector3(b.x, b.y + 600, b.z);
			auto r = sdk::player::player_->trace(c, b, this->self, 600, 34, false);
			if (!sdk::util::math->w2s(r.end_point, t)) continue;
			this->t_map.push_back(r);
		}
	}*/
}
void sys::c_visuals::trace_debug()
{
	if (this->t_map.empty()) return;
	sdk::util::c_vector3 t; auto f = sdk::player::player_->gpos(this->self);
	for (auto a : this->t_map)
	{
		if (!sdk::util::math->w2s(a.end_point, t)) continue;
		if (!a.success)
		{
			sdk::render::render->DrawPoint(t.x, t.z, 0xffff0000);
		}
	}
}
void sys::c_visuals::roar_path()
{
	if (!iroar_pause) iroar_pause = sys::config->gvar("visuals", "ienable_roar_path_pauses");
	if (!ibot_lootrange) ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");
	bool b_last_pause = false; std::vector<sdk::util::c_vector3> last, last2; sdk::util::c_vector3 rp;
	auto spos = sdk::player::player_->gpos(this->self);
	for (auto b : sys::roar_bot->g_p())
	{
		auto ds = sdk::util::math->gdst_3d(b, spos);
		if (ds >= 5000) { last.clear(); continue; }
		sdk::util::c_vector3 l;
		if (!sdk::util::math->w2s(b, l)) { last.clear(); continue; }
		if (!last.size())
		{
			last.push_back(l);
			rp = b;
		}
		else
		{
			sdk::render::render->DrawLine(l.x, l.z, last.back().x, last.back().z, 0xff00ff00);
			last.clear(); last.push_back(l); rp = b;
			if (iroar_pause->iv)
			{
				if (b.pause > 0.1f || rp.pause > 0.1f)
				{
					if (ds <= 1200)
					{
						auto ta = b;
						if (b.pause <= 0.1f && rp.pause > 0.1f) ta = rp;
						auto cir = this->gcircle(ta, ibot_lootrange->iv, 6);
						for (auto h : cir)
						{
							if (!sdk::util::math->w2s(h, l)) { last2.clear(); continue; }
							if (!last2.size()) last2.push_back(l);
							else
							{
								sdk::render::render->DrawLine(l.x, l.z, last2.back().x, last2.back().z, 0xff00fff1);
								last2.clear(); last2.push_back(l);
							}
						}
					}
				}
			}
		}
	}
}
void sys::c_visuals::store_path()
{
	if (!istore_path) istore_path = sys::config->gvar("visuals", "ienable_store_path");
	if (!sys::roar_bot->gssize()) return;
	bool b_last_pause = false; std::vector<sdk::util::c_vector3> last, last2; sdk::util::c_vector3 rp;
	auto spos = sdk::player::player_->gpos(this->self);
	for (auto b : sys::roar_bot->g_s())
	{
		auto ds = sdk::util::math->gdst_3d(b.pos, spos);
		if (ds >= 5000) { last.clear(); continue; }
		sdk::util::c_vector3 l;
		if (!sdk::util::math->w2s(b.pos, l)) { last.clear(); continue; }
		if (!last.size()) last.push_back(l);
		else
		{
			sdk::render::render->DrawLine(l.x, l.z, last.back().x, last.back().z, 0xff00ff00);
			last.clear(); last.push_back(l); rp = b.pos;
		}
	}
}
void sys::c_visuals::lineto_roar()
{
	if (sys::roar_bot->g_p().empty()) return;
	auto fp = sys::roar_bot->g_p().front();
	auto sv = sdk::util::c_vector3(); auto sp = sdk::util::c_vector3();
	if (!sdk::util::math->w2s(sdk::player::player_->gpos(this->self), sv)) return;
	if (!sdk::util::math->w2s(fp, sp)) return;
	sdk::render::render->DrawLine(sv.x, sv.z, sp.x, sp.z, 0xff00ddff);
}
void sys::c_visuals::debug_mobs()
{
	auto spos = sdk::player::player_->gpos(this->self);
	auto circle = this->gcircle_front(spos, 160, 360, 1);

}
void sys::c_visuals::editor_debug()
{
	if (!sys::roar_bot->gpsize()) return;
	sdk::util::c_vector3 closest = {}, res = {}; float dst_last = 9999.f;
	auto cpos = *(sdk::util::c_vector3*)(core::offsets::cl::cursor_world);
	if (!cpos.valid()) return;
	if (!sdk::util::math->w2s(cpos, closest)) return;
	sdk::render::render->DrawBox(closest.x, closest.z, 14, 14, 0xff00ffdd, 0xffff0000);

	if (!sdk::menu::menu->gactive()) sdk::menu::menu->sactive();

	if (!this->first_click)
	{
		for (auto a : sys::roar_bot->g_p())
		{
			auto dst = sdk::util::math->gdst_3d(a, cpos);
			if (dst < dst_last && dst < 300)
			{
				closest = a;
				dst_last = dst;
			}
		}
		if (!sdk::util::math->w2s(closest, res)) return;
		if (!res.valid()) return;

		sdk::render::render->RenderText(res.x, res.z, 0xff00ffdd, (char*)"(X)");
		if (ImGui::IsMouseClicked(ImGuiMouseButton_::ImGuiMouseButton_Left) && !ImGui::GetIO().WantCaptureMouse)
		{
			this->selected_pos = closest;
			this->first_click = true;
			this->shown_modal = true;
			this->changed_pos = false;
			return;
		}
		if (ImGui::IsMouseClicked(ImGuiMouseButton_::ImGuiMouseButton_Right) && !ImGui::GetIO().WantCaptureMouse && dst_last <= 300)
		{
			this->selected_pos = closest;
			this->shown_modal = false;
			this->first_click = true;
			return;
		}
	}
	else
	{
		for (auto a : sys::roar_bot->g_p())
		{
			auto dst = sdk::util::math->gdst_3d(a, cpos);
			if (dst < dst_last && dst < 300)
			{
				closest = a;
				dst_last = dst;
			}
		}

		if (ImGui::IsMouseClicked(ImGuiMouseButton_::ImGuiMouseButton_Left) && !ImGui::GetIO().WantCaptureMouse && !this->changed_pos)
		{
			this->new_pos = cpos;
			this->new_pos.pause = this->selected_pos.pause;
			this->changed_pos = true;

			sys::roar_bot->sgpos(sys::visuals->selected_pos, this->new_pos);
			sys::roar_bot->save();
			sys::roar_bot->load();
			sys::visuals->selected_pos.clear();
			sys::visuals->new_pos.clear();
			sys::visuals->first_click = false;
			sys::visuals->shown_modal = false;
			sys::visuals->changed_pos = false;
			return;
		}

		sdk::util::c_vector3 res_to;
		if (!this->changed_pos)
		{
			if (!sdk::util::math->w2s(this->selected_pos, res)) return;
			if (sdk::util::math->w2s(cpos, res_to)) sdk::render::render->DrawLine(res.x, res.z, res_to.x, res_to.z, 0xffff0000);
		}

		if (!this->new_pos.valid()) return;
		if (!sdk::util::math->w2s(this->selected_pos, res)) return;
		if (!sdk::util::math->w2s(this->new_pos, res_to)) return;
		sdk::render::render->RenderText(res_to.x, res_to.z, 0xff00ffdd, (char*)"(+)");
		sdk::render::render->RenderText(res.x, res.z, 0xff00ffdd, (char*)"(X)");
		sdk::render::render->DrawLine(res_to.x, res_to.z, res.x, res.z, 0xffff0000);
	}
}
void sys::c_visuals::legit_path()
{
	if (!sys::legit_bot->g_p().size()) return;
	bool b_last_pause = false; std::vector<sdk::util::c_vector3> last, last2; sdk::util::c_vector3 rp;
	auto spos = sdk::player::player_->gpos(this->self);

	if (!sys::legit_bot->scan_nodes.empty())
	{
		for (auto q : sys::legit_bot->scan_nodes)
		{
			sdk::util::c_vector3 l;
			if (!sdk::util::math->w2s(q, l)) continue;
			sdk::render::render->DrawPoint(l.x, l.z, 0xff00ff00);
		}
	}
	if (sys::legit_bot->walk_node.valid())
	{
		sdk::util::c_vector3 l;
		if (sdk::util::math->w2s(sys::legit_bot->walk_node, l)) sdk::render::render->DrawPoint(l.x, l.z, 0xffff0000);
	}
	if (sys::legit_bot->cur_route.size())
	{
		sdk::util::c_vector3 l;
		if (sdk::util::math->w2s(sys::legit_bot->cur_route.front().pos, l)) sdk::render::render->DrawPoint(l.x, l.z, 0xffff0000);
	}

	for (auto b : sys::legit_bot->g_p())
	{
		auto ds = sdk::util::math->gdst_3d(b, spos);
		if (ds >= 5000) { last.clear(); continue; }
		sdk::util::c_vector3 l;
		if (!sdk::util::math->w2s(b, l)) { last.clear(); continue; }
		//sdk::render::render->RenderText(l.x, l.z,  0xff00ff00, (char*)std::string(std::to_string(b.pause)).c_str());
		if (!last.size()) last.push_back(l);
		else
		{
			sdk::render::render->DrawLine(l.x, l.z, last.back().x, last.back().z, 0xff00ff00);
			last.clear(); last.push_back(l); rp = b;
		}
	}
}
void sys::c_visuals::player_esp()
{
	auto m = sdk::player::player_->gpos(this->self); sdk::util::c_vector3 t, d;
	for (auto a : sdk::player::player_->actors)
	{
		if (a.type != 0
			|| a.state != 0
			|| a.ptr == this->self
			|| a.hp <= 0
			|| !a.ptr) continue;
		if (!sdk::util::math->w2s(a.pos, t)) continue;
		if (!sdk::util::math->w2s(m, d)) continue;
		auto mhp = sdk::player::player_->gmhp(a.ptr);
		sdk::render::render->DrawLine(t.x, t.z, d.x, d.z, 0xff00ff00);
		sdk::render::render->RenderText(t.x, t.z, 0xff00ff00, (char*)std::string(a.name).c_str());
		sdk::render::render->RenderText(t.x, t.z + 20, 0xff00ff00, (char*)std::string("dst:").append(std::to_string((int)a.rlt_dst)).c_str());
		sdk::render::render->RenderText(t.x, t.z + 40, 0xff00ff00, (char*)std::string("hp :").append(std::to_string((int)a.hp)).append("/").append(std::to_string((int)mhp)).c_str());
	}
}
void sys::c_visuals::hit_popups()
{

	for (auto a : sys::damage->actors_last_dmg)
	{
		if (!a.second) continue;
		auto exist = false; sdk::util::c_vector3 p;
		for (auto b : sdk::player::player_->actors) if (b.key == a.first && b.rlt_dst <= 2000 && b.state == 0 && b.type == 1) { exist = true; p = b.pos; break; }
		if (!p.valid()) continue;
		sdk::util::c_vector3 s;
		if (!sdk::util::math->w2s(p, s)) continue;
		sdk::render::render->RenderText(s.x, s.z, D3DCOLOR_ARGB(255, 255, 0, 0), (char*)std::string(std::to_string(a.second)).c_str());
	}

	/*if (sys::damage->dmg_events.size())
	{
		auto b = sys::damage->dmg_events.back();
		auto exist = false;
		for (auto a : sdk::player::player_->actors) if (a.ptr == b.ptr && a.state == 0) { exist = true; break; }
		if (!exist) return;
		auto pos = sdk::player::player_->gpos(b.ptr);
		pos.z += 150;
		sdk::util::c_vector3 p;
		if (!sdk::util::math->w2s(pos,p)) return;
		if (b.efftype == 1) sdk::render::render->RenderText(p.x, p.z, 0xff00ffd0, (char*)std::string(std::to_string((int)b.damage)).append(" - CRIT").c_str());
		else sdk::render::render->RenderText(p.x,p.z, 0xff00ffd0, (char*)std::string(std::to_string((int)b.damage)).c_str());
	}*/
}
void sys::c_visuals::work()
{
	auto self_actor_proxy = *(uint64_t*)(core::offsets::actor::actor_self);
	if (!self_actor_proxy) return;
	auto can_play = *(BYTE*)(self_actor_proxy + core::offsets::actor::actor_can_play);
	if (!can_play) return;
	this->self = self_actor_proxy;
	if (!iroar_visual) iroar_visual = sys::config->gvar("visuals", "ienable_roar_path");
	if (!ienable_portal) ienable_portal = sys::config->gvar("visuals", "ienable_portal");
	if (!ienable_debug) ienable_debug = sys::config->gvar("visuals", "ienable_debug");
	if (!istore_path) istore_path = sys::config->gvar("visuals", "ienable_store_path");
	if (!ivis_linestart) ivis_linestart = sys::config->gvar("roar_bot", "ivis_linestart");
	if (!ialive_byname) ialive_byname = sys::config->gvar("visuals", "ialive_byname");
	if (!ienable_legit_path_pauses) ienable_legit_path_pauses = sys::config->gvar("visuals", "ienable_legit_path_pauses");
	if (!ienable_legit_path) ienable_legit_path = sys::config->gvar("visuals", "ienable_legit_path");
	if (!ienable_player) ienable_player = sys::config->gvar("visuals", "ienable_player");
	if (!itrace_debug) itrace_debug = sys::config->gvar("debug", "itrace_debug");
	if (ienable_debug->iv) this->monster_proxy_debug();
	if (ienable_portal->iv) this->portal();
	if (iroar_visual->iv) this->roar_path();
	if (istore_path->iv) this->store_path();
	if (ivis_linestart->iv) this->lineto_roar();
	if (ialive_byname->iv) this->alive_proxy_debug();
	if (ienable_legit_path->iv) this->legit_path();
	if (ienable_player->iv) this->player_esp();
	if (itrace_debug->iv) this->trace_debug();
	if (this->debug_editor) this->editor_debug();
	this->hit_popups();
	//this->debug_mobs();
	//this->trace_debug();
}
sys::c_visuals* sys::visuals;