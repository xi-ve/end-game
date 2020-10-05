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
void sdk::menu::c_menu::overlay(bool* acti)
{
	const float DISTANCE = 10.0f;
	static bool corner = 0;
	ImGuiIO& io = ImGui::GetIO();
	ImGuiWindowFlags window_flags = ImGuiWindowFlags_NoDecoration | ImGuiWindowFlags_AlwaysAutoResize | ImGuiWindowFlags_NoFocusOnAppearing | ImGuiWindowFlags_NoNav;
	if (corner != 1)
	{
		window_flags |= ImGuiWindowFlags_NoMove;
	}
	ImGui::SetNextWindowBgAlpha(0.35f); // Transparent background
	if (ImGui::Begin("info-overlay", acti, window_flags))
	{
		char buf[128];
		sprintf(buf, "info-panel %c", "|/-\\"[(int)(ImGui::GetTime() / 0.25f) & 3]);
		ImGui::Text(buf);
		if (ImGui::BeginPopupContextWindow())
		{
			if (ImGui::MenuItem("move-overlay", NULL, corner == 1)) corner = !corner;			
			if (acti && ImGui::MenuItem("disable-overlay")) this->ioverlay_toggled->iv = 0;
			ImGui::EndPopup();
		}
	}
	ImGui::End();
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
		{	{"core-options"},
			{
				{"toggel_switch", 5, "", "", false, [&]() 
					{ 
						if (!sdk::player::player_->alive()) return;
						if (!sys::roar_bot->dwork)
						{
							if (ImGui::Button("enable-bot")) { sys::roar_bot->snear(); sys::roar_bot->dwork = true; }
						}
						else 
						{
							if (ImGui::Button("disable-bot-rb")) { sys::roar_bot->dwork = false; sys::roar_bot->reset(); sys::roar_bot->load(); }
						}
						ImGui::SameLine();
					}
				},								
				{"timescale", 2, "roar_bot", "ibot_timescale", true, new sdk::menu::s_imgui_intslider(400, 1000)}, 
				{"loot-range", 2, "roar_bot", "ibot_lootrange", false, new sdk::menu::s_imgui_intslider(300, 800)},
				{"store-roar", 0, "roar_bot", "ibot_storage_roar", true},				
				{"store-test", 0, "", "", false, (void*)&sys::roar_bot->force_store}
			}			
		},
		{
			{"path-utils"},
			{
				{"roar_set_button_manual", 5, "", "", false, [this]()
					{
						if (ImGui::Button("re-list")) sdk::util::file->update();
						ImGui::SameLine();
						if (ImGui::Button("load"))
						{
							if (sys::roar_bot->pathname != string_last_path->cin)
							{
								sys::roar_bot->pathname = string_last_path->cin;
								string_last_path->rval = string_last_path->cin;
							}
							else
							{
								sys::roar_bot->pathname = sdk::util::file->roar_paths[this->ps];
								string_last_path->rval = sdk::util::file->roar_paths[this->ps];
							}
							sys::roar_bot->load();
						}
					}
				},
				{"##rbpath_by_name", 3, "roar_bot", "string_last_path", false},
				{"combo_path_list", 5, "","",false, [this]()
					{
						if (sdk::util::file->roar_paths.size())
						{
							ImGui::PushItemWidth(125); ImGui::SameLine();
							ImGui::Combo2("##rb-paths-combo", &this->ps, sdk::util::file->roar_paths);
						}
						else ImGui::TextColored(ImColor(255,0,0), "no paths found");
					}
				},
				{"sell_combo_options", 5, "", "", false, [this]()
					{
						auto v = sys::roar_bot->gitm();
						if (v.size())
						{
							ImGui::PushItemWidth(125);
							ImGui::Combo2("##sell_combo_slct", &this->witem_s, v);
							ImGui::SameLine();
							if (ImGui::Button("add")) sys::roar_bot->sitem(sys::roar_bot->gitem_bn(v[this->witem_s]));
						}
						else ImGui::TextColored(ImColor(255, 0, 0), "no items found");
					}
				},
				{"recording_stuff", 5, "", "", false, [this]()
					{
						if (!sys::roar_bot->recording_s) ImGui::Checkbox("record-grind", &sys::roar_bot->recording_g);
						if (!sys::roar_bot->recording_s && !sys::roar_bot->recording_g) ImGui::SameLine();
						if (!sys::roar_bot->recording_g) ImGui::Checkbox("record-store", &sys::roar_bot->recording_s);
						if (sys::roar_bot->recording_g)
						{
							ImGui::PushItemWidth(125);
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
								ImGui::PushItemWidth(125);
								ImGui::Combo2("##select-npc", &ni, npcs); ImGui::SameLine();
								if (ImGui::Button("set-npc")) { sys::roar_bot->glua_actions = true; sys::roar_bot->snpc(npcs[ni]); sys::roar_bot->sscr("NONE"); sys::roar_bot->sepoint(); sys::roar_bot->snpc("NONE"); si++; }
							}
							else ImGui::TextColored(ImColor(255, 0, 0), "no npcs found");
						}
						if (si == 2 && sys::roar_bot->recording_s)
						{
							sys::roar_bot->glua_actions = true;
							if (!sys::roar_bot->last_lua_actions.empty())
							{
								ImGui::PushItemWidth(125);
								ImGui::Combo2("##script", &is_scr, sys::roar_bot->last_lua_actions); ImGui::SameLine();
								if (ImGui::Button("test-scr")) sys::lua_q->add(sys::roar_bot->last_lua_actions[is_scr]);
								if (ImGui::Button("add-scr")) { sys::roar_bot->sscr(sys::roar_bot->last_lua_actions[is_scr]); sys::roar_bot->sepoint(); sys::roar_bot->last_lua_actions.clear(); }
								if (ImGui::Button("add-store/sell")) { sys::roar_bot->sscr("sell_routine()"); sys::roar_bot->sepoint(); sys::roar_bot->last_lua_actions.clear(); }
							}
							if (ImGui::Button("done-store")) { si = 0; sys::roar_bot->glua_actions = false; sys::roar_bot->store_can_path = true; sys::roar_bot->recording_s = false; sys::roar_bot->load(); sys::roar_bot->sscr("NONE"); sys::roar_bot->snpc("NONE"); }
						}
					}
				}
			}
		}
		}
	)) return false;
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
			{"menu-related"},
			{
				{"info-overlay", 0, "overlay", "ioverlay_toggled", false}
			}
		}
		}
	)) return false;
	if (!this->add_tab("packets",
		{
		{
			{"teleporter"},
			{
				{"tele-options", 5, "", "", false, [this]() 
					{
						ImGui::Checkbox("setup-packet", (bool*)&sys::pack_tp->get_packet_again);
						if (sys::pack_tp->x_pos.size())
						{
							ImGui::TextColored(ImColor(0, 255, 0), std::string("timestamp:").append(std::to_string(sys::pack_tp->time_signature)).c_str());
							ImGui::TextColored(ImColor(0, 255, 0), std::string("opcode   :").append(std::to_string(sys::pack_tp->packet_id)).c_str());
							ImGui::TextColored(ImColor(0, 255, 0), std::string("packet is captured!").c_str());
							if (ImGui::Button("tp-to-marker")) sys::pack_tp->teleport_to_marker();
						}
					}
				}
			}
		},
		{
			{"functions"},
			{
				{"allow-trial-chars", 0, "packet", "ibypass_trial", true},
				{"cursor-tp-packet ", 0, "packet", "iteleport_gen2", false}
			}
		},
		{
			{"packet-sniffer"},
			{
				{"editor_part", 5 , "", "", false, [this]()
					{
						auto v = sdk::menu::m_packet->get_all_packets_names();
						if (v.size())
						{
							ImGui::PushItemWidth(125);
							ImGui::Combo2("##packets_captured", &this->selected_packet, v);
							auto p = v[this->selected_packet];
							if (p.size())
							{
								auto pack = sdk::menu::m_packet->get_packet(p);
								auto pack_i = sdk::menu::m_packet->get_packet_info(pack);
								if (ImGui::Button("copy-body"))
								{
									OpenClipboard(lib::d3d11->h); EmptyClipboard();
									auto hg = GlobalAlloc(GMEM_MOVEABLE, pack_i.size() + 1);
									if (!hg) { CloseClipboard(); return; }
									memcpy(GlobalLock(hg), pack_i.c_str(), pack_i.size() + 1);
									GlobalUnlock(hg); SetClipboardData(CF_TEXT, hg); CloseClipboard(); GlobalFree(hg);
								}
								ImGui::SameLine();
								if (ImGui::Button("re-send")) if (pack.timestamp_pos) pack.data.putLong(GetTickCount64(), pack.timestamp_pos);
								ImGui::TextColored(ImColor(0, 255, 0), std::string("size     :").append(std::to_string(pack.size)).c_str());
								ImGui::TextColored(ImColor(0, 255, 0), std::string("opcode   :").append(std::to_string(pack.opcode)).c_str());
								if (pack.timestamp_pos) ImGui::TextColored(ImColor(0, 255, 0), std::string("timestamp:").append(std::to_string(pack.timestamp_pos)).c_str());
								if (pack.data.buf.size() < 27) ImGui::Text(std::string("body     :").append(pack_i).c_str());
								else
								{									
									ImGui::Text("body     :"); std::string buf;
									auto parts = sdk::menu::m_packet->split(pack_i, 27);
									for (auto a : parts) ImGui::Text(a.c_str());
								}
							}
						}
						else ImGui::TextColored(ImColor(255, 0, 0), "no packets registered");
					}				
				}
			}
		},
		{
			{"packet-creator"},
			{
				{"body   ", 3, "", "", false, (void*)sdk::menu::m_packet->packet_body},
				{"packet-creation", 5, "", "", false, [this]() 
					{
						ImGui::PushItemWidth(125); ImGui::InputInt("opcode", &sdk::menu::m_packet->packet_opcode);
						ImGui::PushItemWidth(125); ImGui::InputInt("size  ", &sdk::menu::m_packet->packet_size);
						if (ImGui::Button("send"))
						{
							auto buf = sdk::menu::m_packet->convert_char_to_buff(sdk::menu::m_packet->packet_body);
							auto tm = GetTickCount64() - 180000;
							auto tx = GetTickCount64() + 180000;
							auto time = 0;
							for (auto a = 0; a < buf.buf.size(); a++)
							{
								auto ul = *(uint64_t*)(&buf.buf + a);
								if (ul >= tm && ul <= tx) { time = a; break; }
							}
							if (time) buf.putLong(GetTickCount64(), time);
							fn::send_packet(buf, sdk::menu::m_packet->packet_opcode, sdk::menu::m_packet->packet_size);
						}
					}
				}
			}
		}
		}
	)) return false;
	if (!this->add_tab("looting",
		{
		{
			{"core-options"},
			{
				{"enable      ", 0, "loot", "ienable", true},
				{"filtering", 0, "loot", "ienable_filter", false},
				{"allow-grey  ", 0, "auto_loot", "ipick_grey", true},
				{"allow-green", 0, "auto_loot", "ipick_green", false},
				{"allow-blue  ", 0, "auto_loot", "ipick_blue", true},
				{"allow-orange", 0, "auto_loot", "ipick_orange", false},
				{"allow-yellow", 0, "auto_loot", "ipick_yellow", false}
			}			
		},
		{
			{"item-filter"},
			{
				{"filtering_menu", 5, "", "", false, [this]()
					{
						auto v = sdk::player::player_->ginv();
						if (v.size())
						{
							ImGui::PushItemWidth(125);
							ImGui::Combo2("##select-item", &selected_whitelist, v);
							if (ImGui::Button("to-whitelist")) sys::loot->add_whitelist(sdk::player::player_->gitm_by_name(v[selected_whitelist])); ImGui::SameLine();
							if (ImGui::Button("to-blacklist")) sys::loot->add_blacklist(sdk::player::player_->gitm_by_name(v[selected_whitelist]));
							if (ImGui::Button("clear-whitelist")) sys::loot->read_whitelist(); ImGui::SameLine();
							if (ImGui::Button("clear-blacklist")) sys::loot->read_blacklist();
						}
						else ImGui::TextColored(ImColor(255 ,0, 0), "no items found");
					}
				}
			}
		},
		{
			{"set-items"},
			{
				{"display_cur_list", 5, "", "", false, [this]()
					{
						auto wl = sys::loot->gwl();
						auto bl = sys::loot->gbl();
						if (wl.size())
						{
							ImGui::Text("whitelist-objects");
							for (auto a : wl) ImGui::Text(a.c_str());
						}
						else ImGui::TextColored(ImColor(255, 0, 0), "no entries in whitelist found");
						if (bl.size())
						{
							ImGui::Text("blacklist-objects");
							for (auto a : bl) ImGui::Text(a.c_str());
						}
						else ImGui::TextColored(ImColor(255, 0, 0), "no entries in blacklist found");
					}
				}
			}
		},
		{
			{"stats"},
			{
				{"session_stats", 5, "", "", false, [this]() 
					{ 
						ImGui::BulletText(std::string("grey   items looted: ").append(std::to_string(sys::loot->loot_count_grey)).c_str());
						ImGui::BulletText(std::string("green  items looted: ").append(std::to_string(sys::loot->loot_count_green)).c_str());
						ImGui::BulletText(std::string("blue   items looted: ").append(std::to_string(sys::loot->loot_count_blue)).c_str());
						ImGui::BulletText(std::string("orange items looted: ").append(std::to_string(sys::loot->loot_count_orange)).c_str());
						ImGui::BulletText(std::string("yellow items looted: ").append(std::to_string(sys::loot->loot_count_yellow)).c_str());
						for (auto a : sys::loot->looted_items)
						{
							ImGui::Text(std::string(a.second.name).append(": ").append(std::to_string(a.second.count)).append("x").c_str());
						}
					}
				}
			}
		}
		}
	)) return false;	
	if (!this->add_tab("buff-bot",
		{
		{
			{"core-options"},
			{
				{"enable", 0, "rebuffer", "ienable", false},
				{"buff_adding_part", 5 , "", "", false, [this]() 
					{	
						auto b = sys::rebuff->gbuffs();
						auto i = sdk::player::player_->ginv();
						if (b.size() && i.size())
						{
							ImGui::PushItemWidth(125); ImGui::Combo2("##buff_select", &this->selected_buff, b); ImGui::SameLine();
							ImGui::PushItemWidth(125); ImGui::Combo2("##select_item", &this->selected_buff_item, i);
							if (ImGui::Button("add")) sys::rebuff->add(b[this->selected_buff], sys::rebuff->gibyname(i[this->selected_buff_item]));
						}
						else ImGui::TextColored(ImColor(255, 0, 0), "no buffs/items found");
					}		
				}
			}
		},
		{
			{"set-buffs"},
			{
				{"listing-and-reset", 5, "", "", false, [this]() 
					{
						auto b = sys::rebuff->gabuffs();
						if (b.size())
						{
							for (auto a : b)
							{
								ImGui::Text(std::string(a.n).append(" < > ").append(std::to_string(a.i)).c_str());
							}
						}
						else ImGui::TextColored(ImColor(255, 0, 0), "no set buffs found");
						if (ImGui::Button("reset")) sys::rebuff->reset();
					}				
				}
			}
		}
		}
	)) return false;
	if (!this->add_tab("debug",
		{
		{			
			{"logs"},
			{
				{"log_panel", 5, "", "", false, [this]() 
					{
						auto v = sdk::util::log->gcollector(); std::reverse(v.begin(), v.end());
						if (v.size())
						{
							ImGui::BeginChild(1, ImVec2(350, 350), false, ImGuiWindowFlags_::ImGuiWindowFlags_NoResize | ImGuiWindowFlags_HorizontalScrollbar);
							//
							for (auto a : v)
							{
								ImGui::TextUnformatted(a.c_str());
							}
							//
							ImGui::EndChild();
						}
						else ImGui::TextColored(ImColor(255,0,0), "no log entries found");
					}
				}
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
	
				ImGui::SetNextWindowSizeConstraints(ImVec2(150,50) ,ImVec2(650, 500));
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
									if (c.cfg != NULL) ImGui::Checkbox(c.name.c_str(), (bool*)&c.cfg->iv);
									else
									{
										auto v = (bool*)(c.strct);
										ImGui::Checkbox(c.name.c_str(), v);
									}
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
}
void sdk::menu::c_menu::work()
{
	if (!this->ioverlay_toggled) this->ioverlay_toggled = sys::config->gvar("overlay", "ioverlay_toggled");
	ImGui_ImplDX11_NewFrame();
	ImGui_ImplWin32_NewFrame();
	ImGui::NewFrame();
	//
	if (!this->was_setup)
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
		this->was_setup = true;
	}
	if (ioverlay_toggled->iv)
	{
		this->overlay((bool*)this->ioverlay_toggled->iv);
		if (!this->menu_active)
		{
			ImGui::Render();
			ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
		}
	}
	if (!this->menu_active) return;
	this->work2(); 
}
void sdk::menu::c_menu::work2()
{
	//
	if (this->tabs.empty()) this->setup();
	//ImGui::ShowDemoWindow();
	this->work_tabs();
	//
	ImGui::Render();
	ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
}
void sdk::menu::c_menu::sactive()
{
	this->menu_active = !this->menu_active;
	if (!this->menu_active) { sys::config->save(); ImGui::SaveIniSettingsToDisk("imgui"); }
}
sdk::menu::c_menu* sdk::menu::menu;