#include <inc.h>
namespace ImGui
{
	static auto vector_getter = [](void* vec, int idx, const char** out_text)
	{
		auto& vector = *static_cast<std::vector<std::string>*>(vec);
		if (idx < 0 || idx >= static_cast<int>(vector.size())) { return false; }
		*out_text = vector.at(idx).c_str();
		return true;
	};
	void Button_new_b2(const char* label, bool& value, const char* tooltip = "")
	{
		if (value) { ImGui::TextColored(ImVec4(0, 255, 0, 255), "[ON ]"); ImGui::SameLine(); if (ImGui::SmallButton(label)) value = !value; }
		else { ImGui::TextColored(ImVec4(255, 0, 0, 255), "[OFF]"); ImGui::SameLine(); if (ImGui::SmallButton(label)) value = !value; }
		if (tooltip != "") if (ImGui::IsItemHovered()) ImGui::SetTooltip(tooltip);
	}
	bool Combo2(const char* label, int* currIndex, std::vector<std::string>& values)
	{
		if (values.empty()) { return false; }
		return Combo(label, currIndex, vector_getter,
			static_cast<void*>(&values), values.size());
	}
}
void sdk::menu::c_menu::tab(size_t Index, const char* Text, int height)
{
	if (this->TabHeight == 0) this->TabHeight = height;

	ImGui::PushID(Index);
	ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, 1);

	if (Index == 1)
		ImGui::SameLine(Index * (TabWidth + 5));
	else if (Index > 1)
		ImGui::SameLine(Index * (TabWidth + 5 - Index));

	if (ctab == Index)
		ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor(15, 15, 15));			// Color on tab open
	else
		ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor(30, 30, 30));			// Color on tab closed

	ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor(40, 40, 40));			// Color on mouse hover in tab
	ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor(35, 35, 35));			// Color on click tab

	if (ctab == Index) ImGui::PushStyleColor(ImGuiCol_Border, (ImVec4)ImColor(0, 255, 0, 255));
	else ImGui::PushStyleColor(ImGuiCol_Border, (ImVec4)ImColor(255, 0, 0, 255));

	if (ImGui::Button(Text, ImVec2(TabWidth, TabHeight)))	// If tab clicked
		ctab = Index;

	ImGui::PopStyleVar();
	ImGui::PopStyleColor(3);
	ImGui::PopID();
}
void sdk::menu::c_menu::work()
{
	ImGui_ImplDX11_NewFrame();
	ImGui_ImplWin32_NewFrame();
	ImGui::NewFrame();
	//
	if (!this->was_setup)
	{
		ImGui::StyleColorsDark();
		this->was_setup = true;
	}
	if (!this->menu_active) return;

	ImGui::Begin("  28802  ", 0, ImGuiWindowFlags_::ImGuiWindowFlags_NoResize | ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize);
	{
		auto s = *(uint64_t*)(core::offsets::actor::actor_self);
		this->tab(0, "pack-fn", 18);
		this->tab(1, "pack-bypasses", 18);
		this->tab(2, "looting", 18);
		this->tab(3, "menu", 18);
		this->tab(4, "roar-bot", 18);
		this->tab(5, "visuals", 18);
		this->tab(6, "debug-info", 18);
		switch (this->ctab)
		{
		case 0://pack-fn
		{
			if (!iteleport_gen2) iteleport_gen2 = sys::config->gvar("packet", "iteleport_gen2");
			ImGui::Checkbox("teleport-gen2", (bool*)&iteleport_gen2->iv);
			ImGui::Checkbox("teleport-setup", (bool*)&sys::pack_tp->get_packet_again);
			if (ImGui::Button("teleport-to-marker")) sys::pack_tp->teleport_to_marker();
			break;
		}
		case 1://pack-bypasses
		{
			if (!ibypass_trial) ibypass_trial = sys::config->gvar("packet", "ibypass_trial");
			ImGui::Checkbox("trial-escape-bypass", (bool*)&ibypass_trial->iv);
			break;
		}
		case 2://looting
		{
			if (!iloot_enable) iloot_enable = sys::config->gvar("loot", "ienable");
			if (!iloot_enable_filter) iloot_enable_filter = sys::config->gvar("loot", "ienable_filter");
			if (!grey) grey = sys::config->gvar("auto_loot", "ipick_grey");
			if (!green) green = sys::config->gvar("auto_loot", "ipick_green");
			if (!blue) blue = sys::config->gvar("auto_loot", "ipick_blue");
			if (!orange) orange = sys::config->gvar("auto_loot", "ipick_orange");
			if (!yellow) yellow = sys::config->gvar("auto_loot", "ipick_yellow");
			ImGui::Checkbox("enable", (bool*)&iloot_enable->iv); ImGui::SameLine();
			ImGui::Checkbox("use-filter", (bool*)&iloot_enable_filter->iv);

			ImGui::Checkbox("pick-grey", (bool*)&grey->iv); ImGui::SameLine();
			ImGui::Checkbox("pick-green", (bool*)&green->iv); ImGui::SameLine();
			ImGui::Checkbox("pick-blue", (bool*)&blue->iv); ImGui::SameLine();
			ImGui::Checkbox("pick-orange", (bool*)&orange->iv); ImGui::SameLine();
			ImGui::Checkbox("pick-yellow", (bool*)&yellow->iv);
			if (s)
			{
				if (*(BYTE*)(s + core::offsets::actor::actor_can_play))
				{
					auto il = sdk::player::player_->ginv();
					if (il.size() > 2)
					{						
						ImGui::Combo2("select-item", &selected_whitelist, il);
						if (ImGui::Button("add-item-to-whitelist")) sys::loot->add_whitelist(sdk::player::player_->gitm_by_name(il[selected_whitelist])); ImGui::SameLine();
						if (ImGui::Button("add-item-to-blacklist")) sys::loot->add_blacklist(sdk::player::player_->gitm_by_name(il[selected_whitelist]));
						if (ImGui::Button("clear-whitelist")) sys::loot->read_whitelist(); ImGui::SameLine();
						if (ImGui::Button("clear-blacklist")) sys::loot->read_blacklist();
					}
				}
			}
			if (!sys::loot->loot_proxys.empty())
			{
				ImGui::Text("loot-acs"); ImGui::Separator();
				for (auto b : sys::loot->loot_proxys)
				{
					ImGui::Text(std::string("actor:").append(sdk::util::log->as_hex(b)).c_str());
				}
			}
			break;
		}
		case 3://menu
		{
			if (ImGui::Button("reload config")) sys::config->read();
			if (!ikey_ctp) ikey_ctp = sys::config->gvar("keybinds", "itp_key");
			ImGui::Text(std::string("ikey_tp:").append(std::to_string(ikey_ctp->iv)).c_str());
			break;
		}
		case 4://roar-bot
		{
			if (!ibot_timescale) ibot_timescale = sys::config->gvar("roar_bot", "ibot_timescale");
			if (!ibot_lootrange) ibot_lootrange = sys::config->gvar("roar_bot", "ibot_lootrange");
			if (!sys::roar_bot->dwork) if (ImGui::Button("toggle on")) { sys::roar_bot->snear(); sys::roar_bot->dwork = true; }
			if (sys::roar_bot->dwork) if (ImGui::Button("toggle off")) { sys::roar_bot->dwork = false; sys::roar_bot->reset(); }
			ImGui::Text(std::string("gp:").append(std::to_string(sys::roar_bot->gpsize())).c_str()); ImGui::SameLine();
			ImGui::Text(std::string("sp:").append(std::to_string(sys::roar_bot->gssize())).c_str()); ImGui::SameLine();
			ImGui::Text(std::string("si:").append(std::to_string(sys::roar_bot->assize())).c_str());
			ImGui::InputText("path-name", ct, 128); ImGui::SameLine(); if (ImGui::Button("set-path##ct")) sys::roar_bot->pathname = ct;
			if (!sdk::util::file->roar_paths.empty())
			{
				ImGui::Combo2("##path-select", &ps, sdk::util::file->roar_paths); ImGui::SameLine();
				if (ImGui::Button("set-path##cs")) sys::roar_bot->pathname = sdk::util::file->roar_paths[ps];
			}
			ImGui::SliderInt("bot-timescale(ms)", &ibot_timescale->iv, 250, 1000);
			ImGui::SliderInt("bot-loot-range", &ibot_lootrange->iv, 300, 800);
			//
			if (sdk::player::player_->inventory_items.size())
			{
				auto v = sys::roar_bot->gitm();
				if (v.size()) ImGui::Combo2("##iselect", &this->witem_s, v);
				if (ImGui::Button("add-to-sell-list")) sys::roar_bot->sitem(sys::roar_bot->gitem_bn(v[this->witem_s]));
			}
			//
			if (ImGui::Button("load path")) sys::roar_bot->load(); ImGui::SameLine(); if (ImGui::Button("reset-full")) sys::roar_bot->reset();
			if (ImGui::Button("test-SP")) sys::roar_bot->force_store = true;
			if (!sys::roar_bot->recording_s) ImGui::Checkbox("record-grind", &sys::roar_bot->recording_g);
			if (!sys::roar_bot->recording_g) ImGui::Checkbox("record-store", &sys::roar_bot->recording_s);
			if (sys::roar_bot->recording_g)
			{
				ImGui::SliderFloat("pause-time(ms)", &t, 1.1f, 60.f);
				if (ImGui::Button("add-pause")) sys::roar_bot->gppoint(t);
			}
			if (si == 0 && sys::roar_bot->recording_s)
			{
				sys::roar_bot->store_can_path = true;
				if (ImGui::Button("done-store-path")) si++;
			}
			if (si == 1 && sys::roar_bot->recording_s)
			{
				sys::roar_bot->store_can_path = false;
				auto npcs = sys::roar_bot->gnpcs(); 
				if (npcs.size())
				{
					ImGui::Combo2("##select-npc", &ni, npcs); ImGui::SameLine();
					if (ImGui::Button("set-npc")) { sys::roar_bot->glua_actions = true; sys::roar_bot->snpc(npcs[ni]); sys::roar_bot->sscr("NONE"); sys::roar_bot->sepoint(); sys::roar_bot->snpc("NONE"); si++; }
				}
				else ImGui::TextColored(ImColor(255, 0, 0), "no npc nearby!");
			}
			if (si == 2 && sys::roar_bot->recording_s)
			{
				sys::roar_bot->glua_actions = true;
				if (!sys::roar_bot->last_lua_actions.empty())
				{
					ImGui::Combo2("##script", &is_scr, sys::roar_bot->last_lua_actions); ImGui::SameLine();
					if (ImGui::Button("add-scr")) { sys::roar_bot->sscr(sys::roar_bot->last_lua_actions[is_scr]); sys::roar_bot->sepoint(); sys::roar_bot->last_lua_actions.clear(); }
				}
				if (ImGui::Button("done-store")) { si = 0; sys::roar_bot->glua_actions = false; sys::roar_bot->store_can_path = true; sys::roar_bot->recording_s = false; sys::roar_bot->load(); sys::roar_bot->sscr("NONE"); sys::roar_bot->snpc("NONE"); }
			}			
			break;
		}
		case 5://visuals
		{
			if (!iroar_path) iroar_path = sys::config->gvar("visuals", "ienable_roar_path");
			if (!iroar_pause) iroar_pause = sys::config->gvar("visuals", "ienable_roar_path_pauses");
			if (!ienable_portal) ienable_portal = sys::config->gvar("visuals", "ienable_portal");
			if (!ienable_debug) ienable_debug = sys::config->gvar("visuals", "ienable_debug");
			if (!istore_path) istore_path = sys::config->gvar("visuals", "ienable_store_path");
			ImGui::Checkbox("roar-path ", (bool*)&iroar_path->iv); ImGui::SameLine(); ImGui::Checkbox("roar-pause", (bool*)&iroar_pause->iv); ImGui::SameLine(); ImGui::Checkbox("portals", (bool*)&ienable_portal->iv); ImGui::SameLine();  ImGui::Checkbox("mob-debug", (bool*)&ienable_debug->iv); 
			ImGui::Checkbox("store-path", (bool*)&istore_path->iv);
			//
			if (iroar_path->iv && istore_path->iv) { istore_path->iv = 0; iroar_path->iv = 0; }
			break;
		}
		case 6://debug
		{
			/*if (ImGui::Button("test-op"))
			{
				auto ptr = uint64_t(0x143D2F8C0);
				while (ptr != NULL)
				{
					if (ptr == NULL) break;
					auto xx = *(uint64_t*)ptr;
					if (xx == NULL) break;
					auto name_t = core::get_vtable_name(xx);
					auto opc = *(int*)(ptr + 0x8);
					ptr += 0x110;

					if (*(uint64_t*)(ptr) >= 0x14fffffff || *(uint64_t*)(ptr) == NULL)
					{
						ptr += 0x10;
						auto t = core::get_vtable_name(xx);
						if (t == "") break;
					}
					sdk::util::log->add(std::string("op:").append(std::to_string(opc)).append(" t:").append(name_t), sdk::util::e_info, true);
				}
			}*/
			auto self = *(uint64_t*)(core::offsets::actor::actor_self);
			if (!self) 
			{
				ImGui::Text("log"); ImGui::Separator(); auto n = sdk::util::log->gcollector(); std::reverse(std::begin(n), std::end(n));
				for (auto a : n) ImGui::Text(a.c_str());

				break;
			}
			ImGui::Text(std::string("unsealed-pets:").append(std::to_string(sdk::player::player_->unsealed_pets.size())).c_str());
			ImGui::Text(std::string("sealed-pets  :").append(std::to_string(sdk::player::player_->sealed_pets.size())).c_str());

			if (sdk::player::player_->sealed_pets.size())
			{
				for (auto a : sdk::player::player_->sealed_pets)
				{
					auto aws = std::wstring(a.n); auto as = std::string(aws.begin(), aws.end());
					ImGui::Text(std::string("(sealed)   pet:").append(as).append(" id:").append(std::to_string(a.i)).append(" hunger:").append(std::to_string(a.h)).c_str());
				}
			}
			if (sdk::player::player_->unsealed_pets.size())
			{
				for (auto a : sdk::player::player_->unsealed_pets)
				{
					auto aws = std::wstring(a.n); auto as = std::string(aws.begin(), aws.end());
					ImGui::Text(std::string("(unsealed) pet:").append(as).append(" id:").append(std::to_string(a.i)).append(" hunger:").append(std::to_string(a.h)).c_str());
				}
			}

			if (!ient_alt) ient_alt = sys::config->gvar("debug", "ientity_alt");
			ImGui::Checkbox("ent-alt", (bool*)&ient_alt->iv);
			ImGui::SliderInt("filter", &sys::visuals->filter, 1, 100);
			ImGui::Checkbox("dobuffer-log", &fn::log_dobuffer);

			auto max_weight = *(int*)(self + core::offsets::actor::actor_inv_max_weight) / 10000;
			auto inv_weight = *(int*)(self + core::offsets::actor::actor_inv_raw_weight) / 10000;
			auto inv_gear_weight = *(int*)(self + core::offsets::actor::actor_inv_gear_weight) / 10000;
			ImGui::Text(std::string("max:").append(std::to_string(max_weight)).c_str());
			ImGui::Text(std::string("inv w:").append(std::to_string(inv_weight)).c_str());
			ImGui::Text(std::string("gear w:").append(std::to_string(inv_gear_weight)).c_str());
			ImGui::Text(std::string("sp:").append(std::to_string(sdk::player::player_->gsp(self))).c_str());
			ImGui::Text(std::string("anim:").append(sdk::player::player_->ganim(self)).c_str());

			ImGui::InputText("##luatest", this->dscr, 128);
			if (ImGui::Button("test-lua")) sys::lua_q->add(this->dscr); ImGui::SameLine();
			if (ImGui::Button("test-interact"))
			{
				auto nnpc = sdk::player::player_->npcs.front();
				if (nnpc.ptr != 0)
				{
					sdk::util::log->add(nnpc.name, sdk::util::e_info, true);
					typedef uint64_t(__stdcall* k)(uint64_t);
					k l = (k)(core::offsets::fn::start_npc_interaction);
					l(nnpc.ptr);
				}
			}
			if (ImGui::Button("test-use-0")) sys::lua_q->useitem(0);

			ImGui::Text("log"); ImGui::Separator(); auto n = sdk::util::log->gcollector(); std::reverse(std::begin(n), std::end(n));
			for (auto a : n) ImGui::Text(a.c_str());

			break;
		}
		default: break;
		}
		ImGui::End();
	}

	sdk::menu::m_packet->work_ui();
	//
	ImGui::Render();
	ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
}
void sdk::menu::c_menu::sactive()
{
	this->menu_active = !this->menu_active;
	if (!this->menu_active) sys::config->save();
}
sdk::menu::c_menu* sdk::menu::menu;