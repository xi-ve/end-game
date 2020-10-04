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
void sdk::menu::roar_menu()
{
	
}
void sdk::menu::visuals_menu()
{
	ImGui::Text("haha cool func");
	if (ImGui::Button("test##vis_btn1")) sdk::util::log->add("test", sdk::util::e_info, true);
	ImGui::SameLine(); ImGui::BulletText("test-button");
}
void sdk::menu::test_func()
{
	sdk::util::log->add("test func called!", sdk::util::e_info, true);
}
bool sdk::menu::c_menu::setup()
{
	//s_imgui_node(std::string n, int t, std::string ct, std::string vn)
	if (!string_last_path) string_last_path = sys::config->gvar("roar_bot", "string_last_path");
	if (!this->add_tab("roar-bot",
		{
		{	{"roar-bot"},
			{
				{"toggel_switch", 5, "", "", false, [&]() 
					{ 
						if (!sys::roar_bot->dwork)
						{
							if (ImGui::Button("enable-bot")) { sys::roar_bot->snear(); sys::roar_bot->dwork = true; }
						}
						else 
						{
							if (ImGui::Button("disable-bot-rb")) { sys::roar_bot->dwork = false; sys::roar_bot->reset(); sys::roar_bot->load(); }
						}
					}
				},
				{"roar_set_button_manual", 5, "", "", true, [this]()
					{
						if (ImGui::Button("load")) { sys::roar_bot->pathname = string_last_path->cin; string_last_path->rval = string_last_path->cin; strcpy(string_last_path->cin, string_last_path->cin); sys::roar_bot->load(); }
					}
				},
				{"##rbpath_by_name", 3, "roar_bot", "string_last_path", false}
			}
		}
		})) return false;
	if (!this->add_tab("visuals",
		{ 
		{	{"monster-actor"},
			{
				{"dead-info  "	, 0, "visuals", "ienable_debug", false},
				{"esp-by-name"	, 0, "visuals", "ialive_byname", true},
				{"##mob-name", 3, "", "", false, (void*)sdk::menu::menu->mob_target}
			}			
		},
		{
			{"environment"},
			{
				{"roar-grind-path"	, 0, "visuals", "ienable_roar_path", true},
				{"roar-store-path"	, 0, "visuals", "ienable_store_path", false},
				{"roar-start     "  , 0, "roar_bot", "ivis_linestart", true},
				{"roar-pauses    "  , 0, "visuals", "ienable_roar_path_pauses", false},
				{"show-portals   "  , 0, "visuals", "ienable_portal", false}
			}
		},
		{
			{"menu-tests"},
			{
				{"test-button"	 , 4 , "", "", false, (void*)test_func},
				{"test-input"	 , 3 , "locals", "string_test_input", false},
				{"test-input-vt" , 3 , "", "", false, (void*)sdk::menu::menu->test_input_ptr},
				{"test-slider-int", 2 , "roar_bot", "ibot_timescale", false, new s_imgui_intslider(250, 1000)},
				{"test-slider-fl", 1 , "roar_bot", "ibot_timescale", false,	 new s_imgui_floatslider(0.1f, 10.f)},
				{"function-call", 5, "","", false, (void*)sdk::menu::visuals_menu}
			}
		}
		}
	)) return false;
	
	return true;
}
bool sdk::menu::c_menu::add_tab(std::string n, std::vector<s_imgui_treenode> node)
{
	for (auto &&a : node)
	{
		for (auto &&b : a.nodes)
		{
			if (b.cfg) continue;
			if (b.cfg_table != "locals") continue;
			sys::config->proc(b.cfg_table, b.cfg_var, "", true);
			b.cfg = sys::config->gvar(b.cfg_table, b.cfg_var);
		}
	}
	this->tabs.emplace_back(n, node);
	return true;
}
void sdk::menu::c_menu::work_tabs()
{
	ImGui::Begin("##core-tab", 0, ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_::ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_::ImGuiWindowFlags_NoTitleBar);
	{
		auto main_window_pos = ImGui::GetWindowPos();
		auto width = ImGui::GetWindowWidth();

		for (auto &&a : this->tabs)
		{
			ImGui::SetNextWindowPos(ImVec2(main_window_pos.x + width + 5, main_window_pos.y), ImGuiCond_::ImGuiCond_Appearing);
			if (a.toggle)
			{
				if (ImGui::ArrowButton(a.name.c_str(), ImGuiDir_::ImGuiDir_Left)) a.toggle = !a.toggle; 
				ImGui::SameLine(); ImGui::BulletText(a.name.c_str());
	
				ImGui::Begin(a.name.c_str(), 0, ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_::ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_::ImGuiWindowFlags_NoCollapse);
				{
					ImGui::TextColored(ImColor(0, 255, 0), a.name.c_str());
					for (auto&& b : a.tree)
					{
						if (ImGui::TreeNode(b.main_name.c_str()))
						{
							for (auto&& c : b.nodes)
							{
								switch (c.type)
								{
								case 0://checkbox
								{
									ImGui::Checkbox(c.name.c_str(), (bool*)&c.cfg->iv);											
									break;
								}
								case 1://float slider
								{
									auto s = (sdk::menu::s_imgui_floatslider*)(c.strct);
									ImGui::PushItemWidth(125);
									ImGui::SliderFloat(c.name.c_str(), &c.cfg->fv, s->min, s->max);
									break;
								}
								case 2://int slider
								{
									auto s = (sdk::menu::s_imgui_intslider*)(c.strct);
									ImGui::PushItemWidth(125);
									ImGui::SliderInt(c.name.c_str(), &c.cfg->iv, s->min, s->max);
									break;
								}
								case 3://text input
								{
									ImGui::PushItemWidth(125);
									if (c.cfg != NULL) ImGui::InputText(c.name.c_str(), c.cfg->cin, 2048);
									else ImGui::InputText(c.name.c_str(), (char*)c.strct, 2048);
									break;
								}
								case 4://button
								{
									if (ImGui::Button(c.name.c_str())) c.f_func();
									break;
								}
								case 5://func to run
								{
									if (c.f_func != NULL) c.f_func();
									else c.f_lambda();
									break;
								}
								default: break;
								}
								if (c.use_sameline) ImGui::SameLine();
							}
							ImGui::TreePop();
						}
					}
					ImGui::End();
				}
			}
			else 
			{
				if (ImGui::ArrowButton(a.name.c_str(), ImGuiDir_::ImGuiDir_Right))
				{
					for (auto&& b : this->tabs) b.toggle = false;
					a.toggle = !a.toggle;
				}
				ImGui::SameLine(); ImGui::BulletText(a.name.c_str());
			}
		}
	}
	//ImGui::SetNextWindowPos(ImVec2(main_window_pos.x + width + 5, main_window_pos.y), ImGuiCond_::ImGuiCond_Appearing);
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
	if (this->using_test_menu) { this->work2(); return; }

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
		this->tab(7, "rebuffer", 18);
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
			if (!ibot_storage_roar) ibot_storage_roar = sys::config->gvar("roar_bot", "ibot_storage_roar");
			if (!sys::roar_bot->dwork) if (ImGui::Button("toggle on")) { sys::roar_bot->snear(); sys::roar_bot->dwork = true; }
			if (sys::roar_bot->dwork) if (ImGui::Button("toggle off")) { sys::roar_bot->dwork = false; sys::roar_bot->reset(); sys::roar_bot->load(); }
			ImGui::Text(std::string("gp:").append(std::to_string(sys::roar_bot->gpsize())).c_str()); ImGui::SameLine();
			ImGui::Text(std::string("sp:").append(std::to_string(sys::roar_bot->gssize())).c_str()); ImGui::SameLine();
			ImGui::Text(std::string("si:").append(std::to_string(sys::roar_bot->assize())).c_str());
			ImGui::InputText("path-name", ct, 128); ImGui::SameLine(); if (ImGui::Button("set-path##ct")) sys::roar_bot->pathname = ct;
			if (!sdk::util::file->roar_paths.empty())
			{
				ImGui::Combo2("##path-select", &ps, sdk::util::file->roar_paths); ImGui::SameLine();
				if (ImGui::Button("set-path##cs")) sys::roar_bot->pathname = sdk::util::file->roar_paths[ps];
			}
			if (ImGui::Button("load path")) sys::roar_bot->load(); ImGui::SameLine(); 
			if (ImGui::Button("reset-full")) sys::roar_bot->reset(); ImGui::SameLine();
			if (ImGui::Button("test-SP")) sys::roar_bot->force_store = true;

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
			ImGui::Checkbox("storage-use-roar", (bool*)&ibot_storage_roar->iv);
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
			if (!ivis_linestart) ivis_linestart = sys::config->gvar("roar_bot", "ivis_linestart");
			if (!ialive_byname) ialive_byname = sys::config->gvar("visuals", "ialive_byname");
			ImGui::Checkbox("roar-path ", (bool*)&iroar_path->iv); ImGui::SameLine(); ImGui::Checkbox("roar-pause", (bool*)&iroar_pause->iv); ImGui::SameLine(); ImGui::Checkbox("portals", (bool*)&ienable_portal->iv); ImGui::SameLine();  ImGui::Checkbox("mob-debug", (bool*)&ienable_debug->iv); 
			ImGui::Checkbox("store-path", (bool*)&istore_path->iv); ImGui::SameLine(); ImGui::Checkbox("roar-start-line", (bool*)&ivis_linestart->iv); ImGui::SameLine(); ImGui::Checkbox("alive-by-name", (bool*)&ialive_byname->iv);
			ImGui::InputText("mob-name-esp", mob_target, 128);
			//
			if (iroar_path->iv && istore_path->iv) { istore_path->iv = 0; iroar_path->iv = 0; }
			break;
		}
		case 6://debug
		{
			auto self = *(uint64_t*)(core::offsets::actor::actor_self);
			if (!self) 
			{
				if (ImGui::Button("use-test-menu"))
				{
					ImGuiStyle* style = &ImGui::GetStyle();

					style->WindowPadding = ImVec2(15, 15);
					style->WindowRounding = 5.0f;
					style->FramePadding = ImVec2(5, 5);
					style->FrameRounding = 4.0f;
					style->ItemSpacing = ImVec2(12, 8);
					style->ItemInnerSpacing = ImVec2(8, 6);
					style->IndentSpacing = 25.0f;
					style->ScrollbarSize = 15.0f;
					style->ScrollbarRounding = 9.0f;
					style->GrabMinSize = 5.0f;
					style->GrabRounding = 3.0f;

					style->Colors[ImGuiCol_Text] = ImVec4(0.80f, 0.80f, 0.83f, 1.00f);
					style->Colors[ImGuiCol_TextDisabled] = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
					style->Colors[ImGuiCol_WindowBg] = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
					style->Colors[ImGuiCol_ChildBg] = ImVec4(0.07f, 0.07f, 0.09f, 1.00f);
					style->Colors[ImGuiCol_PopupBg] = ImVec4(0.07f, 0.07f, 0.09f, 1.00f);
					style->Colors[ImGuiCol_Border] = ImVec4(0.80f, 0.80f, 0.83f, 0.88f);
					style->Colors[ImGuiCol_BorderShadow] = ImVec4(0.92f, 0.91f, 0.88f, 0.00f);
					style->Colors[ImGuiCol_FrameBg] = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
					style->Colors[ImGuiCol_FrameBgHovered] = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
					style->Colors[ImGuiCol_FrameBgActive] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_TitleBg] = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
					style->Colors[ImGuiCol_TitleBgCollapsed] = ImVec4(1.00f, 0.98f, 0.95f, 0.75f);
					style->Colors[ImGuiCol_TitleBgActive] = ImVec4(0.07f, 0.07f, 0.09f, 1.00f);
					style->Colors[ImGuiCol_MenuBarBg] = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
					style->Colors[ImGuiCol_ScrollbarBg] = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
					style->Colors[ImGuiCol_ScrollbarGrab] = ImVec4(0.80f, 0.80f, 0.83f, 0.31f);
					style->Colors[ImGuiCol_ScrollbarGrabHovered] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_ScrollbarGrabActive] = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
					style->Colors[ImGuiCol_CheckMark] = ImVec4(0.80f, 0.80f, 0.83f, 0.31f);
					style->Colors[ImGuiCol_SliderGrab] = ImVec4(0.80f, 0.80f, 0.83f, 0.31f);
					style->Colors[ImGuiCol_SliderGrabActive] = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
					style->Colors[ImGuiCol_Button] = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
					style->Colors[ImGuiCol_ButtonHovered] = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
					style->Colors[ImGuiCol_ButtonActive] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_Header] = ImVec4(0.10f, 0.09f, 0.12f, 1.00f);
					style->Colors[ImGuiCol_HeaderHovered] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_HeaderActive] = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
					style->Colors[ImGuiCol_Separator] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_SeparatorHovered] = ImVec4(0.24f, 0.23f, 0.29f, 1.00f);
					style->Colors[ImGuiCol_SeparatorActive] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_ResizeGrip] = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
					style->Colors[ImGuiCol_ResizeGripHovered] = ImVec4(0.56f, 0.56f, 0.58f, 1.00f);
					style->Colors[ImGuiCol_ResizeGripActive] = ImVec4(0.06f, 0.05f, 0.07f, 1.00f);
					style->Colors[ImGuiCol_PlotLines] = ImVec4(0.40f, 0.39f, 0.38f, 0.63f);
					style->Colors[ImGuiCol_PlotLinesHovered] = ImVec4(0.25f, 1.00f, 0.00f, 1.00f);
					style->Colors[ImGuiCol_PlotHistogram] = ImVec4(0.40f, 0.39f, 0.38f, 0.63f);
					style->Colors[ImGuiCol_PlotHistogramHovered] = ImVec4(0.25f, 1.00f, 0.00f, 1.00f);
					style->Colors[ImGuiCol_TextSelectedBg] = ImVec4(0.25f, 1.00f, 0.00f, 0.43f);
					style->Colors[ImGuiCol_ModalWindowDarkening] = ImVec4(1.00f, 0.98f, 0.95f, 0.73f);

					this->using_test_menu = true;
				}

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
			ImGui::Checkbox("dobuffer-log", &fn::log_dobuffer);
			if (ImGui::Button("manual-loot")) sys::loot->mloot();

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
			if (ImGui::Button("test-ghp_")) sdk::player::player_->ghp(self);


			ImGui::Text("items left to sell");
			for (auto sad : sys::roar_bot->gitm_left()) ImGui::Text(std::to_string(sad).c_str());

			ImGui::Text("log"); ImGui::Separator(); auto n = sdk::util::log->gcollector(); std::reverse(std::begin(n), std::end(n));
			for (auto a : n) ImGui::Text(a.c_str());

			break;
		}
		case 7:
		{
			auto buffs = sys::rebuff->gbuffs();
			auto il = sdk::player::player_->ginv();
			if (buffs.size() && il.size())
			{
				if (!irebuffer_enable) irebuffer_enable = sys::config->gvar("rebuffer", "ienable");
				ImGui::Combo2("##buffselect", &this->selected_buff, buffs);
				ImGui::Combo2("##select-item", &selected_buff_item, il);
				ImGui::Checkbox("toggle", (bool*)&irebuffer_enable->iv);//im vegan
				if (ImGui::Button("add")) sys::rebuff->add(buffs[this->selected_buff], sys::rebuff->gibyname(il[selected_buff_item]));
				if (ImGui::Button("reset")) sys::rebuff->reset();

				ImGui::Text("registered buffs");
				for (auto t : sys::rebuff->gabuffs())
				{
					ImGui::Text(std::string(t.n).append(":").append(std::to_string(t.i)).c_str());
				}
			}
			else ImGui::Text("no buffs active");
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
void sdk::menu::c_menu::work2()
{
	//
	if (this->tabs.empty()) this->setup();
	ImGui::ShowDemoWindow();
	this->work_tabs();
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

