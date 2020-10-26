#include <inc.h>
bool sdk::dialog::c_dialog::gbuttons()
{
	this->buttons_map.clear();
	auto act = *(uint64_t*)(core::offsets::cl::dialog_base + 0x30);
	if (!act) return false;
	auto p_s = *(uint64_t*)(core::offsets::cl::dialog_base + 0x70);
	auto p_e = *(uint64_t*)(core::offsets::cl::dialog_base + 0x78);
	if (!p_s || !p_e) return false;
	auto delta = ((p_e - p_s) / 0x68);
	for (auto a = 0; a < delta; a++)
	{
		auto btn = getdialog(core::offsets::cl::dialog_base, a);
		if (!btn) continue;
		auto txt = gettext(btn);	
		this->buttons_map[a] = txt;
	}
	if (this->buttons_map.size()) return true;
	else return false;
}
bool sdk::dialog::c_dialog::gpanels()
{
	this->panels_map.clear();
	auto uimgr = *(uint64_t*)(core::offsets::cl::ui_manager);
	if (!uimgr) return false;
	auto p_s = *(uint64_t*)(uimgr + 0x3c0);
	auto p_e = *(uint64_t*)(uimgr + 0x3c8);
	if (!p_s || !p_e) return false;
	auto delta = ((p_e - p_s) / 8);
	for (auto a = 0; a < delta * 8; a += 8)
	{
		auto panel = *(uint64_t*)(p_s + a);
		if (!panel) continue;
		auto panel_state = *(BYTE*)(panel + 0x239);
		if (panel_state == 0xC) continue;
		auto panel_name = sdk::player::player_->gstring(panel + 0xD0, 64);
		if (panel_name.empty()) continue;
		this->panels_map[panel_name] = 1;
	}
	if (this->panels_map.size()) return true;
	else return false;
}
bool sdk::dialog::c_dialog::gchildren(std::string t)
{
	this->children_by_panel.clear();
	auto uimgr = *(uint64_t*)(core::offsets::cl::ui_manager);
	if (!uimgr) return false;
	auto p_s = *(uint64_t*)(uimgr + 0x3c0);
	auto p_e = *(uint64_t*)(uimgr + 0x3c8);
	if (!p_s || !p_e) return false;
	auto delta = ((p_e - p_s) / 8);
	for (auto a = 0; a < delta * 8; a += 8)
	{
		auto panel = *(uint64_t*)(p_s + a);
		if (!panel) continue;
		auto panel_state = *(BYTE*)(panel + 0x239);
		if (panel_state == 0xC) continue;
		auto panel_name = sdk::player::player_->gstring(panel + 0xD0, 64);
		if (panel_name.empty()) continue;
		if (!strstr(panel_name.c_str(), t.c_str())) continue;
		auto c_s = *(uint64_t*)(panel + 0xF0);
		auto c_e = *(uint64_t*)(panel + 0xF8);
		if (!c_s || !c_e) continue;
		auto c_delta = ((c_e - c_s) / 8);
		if (!c_delta) continue;
		for (auto b = 0; b < c_delta * 8; b += 8)
		{
			auto child = *(uint64_t*)(c_s + b);
			if (!child) continue;
			auto child_name = sdk::player::player_->gstring(child + 0xD0, 64);
			if (child_name.empty()) continue;
			auto has_txt = *(BYTE*)(child + 0x298);
			if (!has_txt || !*(uint64_t*)(child + 0x298)) continue;
			auto txt = *(sdk::dialog::str_btn*)(*(uint64_t*)(child + 0x298));
			if (!txt.str_btn_) continue;
			auto s = std::wstring(txt.str_btn_); if (!s.size()) continue;
			auto e = std::string(s.begin(), s.end()); if (!e.size() || e.size() < 3) continue;
			this->children_by_panel[e] = child_name;
			//+0x120 -> +0x98 = lua for buttons
		}
	}
	return true;
}
std::string sdk::dialog::c_dialog::find_button(std::string display_name, std::string t)
{
	auto uimgr = *(uint64_t*)(core::offsets::cl::ui_manager);
	if (!uimgr) return "";
	auto p_s = *(uint64_t*)(uimgr + 0x3c0);
	auto p_e = *(uint64_t*)(uimgr + 0x3c8);
	if (!p_s || !p_e) return "";
	auto delta = ((p_e - p_s) / 8);
	for (auto a = 0; a < delta * 8; a += 8)
	{
		auto panel = *(uint64_t*)(p_s + a);
		if (!panel) continue;
		auto panel_state = *(BYTE*)(panel + 0x239);
		if (panel_state == 0xC) continue;
		auto panel_name = sdk::player::player_->gstring(panel + 0xD0, 64);
		if (panel_name.empty()) continue;
		if (!strstr(panel_name.c_str(), t.c_str())) continue;
		auto c_s = *(uint64_t*)(panel + 0xF0);
		auto c_e = *(uint64_t*)(panel + 0xF8);
		if (!c_s || !c_e) continue;
		auto c_delta = ((c_e - c_s) / 8);
		if (!c_delta) continue;
		for (auto b = 0; b < c_delta * 8; b += 8)
		{
			auto child = *(uint64_t*)(c_s + b);
			if (!child) continue;
			auto child_name = sdk::player::player_->gstring(child + 0xD0, 64);
			if (child_name.empty()) continue;
			auto has_txt = *(BYTE*)(child + 0x298);
			if (!has_txt || !*(uint64_t*)(child + 0x298)) continue;
			auto txt = *(sdk::dialog::str_btn*)(*(uint64_t*)(child + 0x298));
			if (!txt.str_btn_) continue;
			auto s = std::wstring(txt.str_btn_); if (!s.size()) continue;
			auto e = std::string(s.begin(), s.end()); if (!e.size() || e.size() < 3) continue;
			//sdk::util::log->a("panel: %s button: %s > %s", panel_name.c_str(), child_name.c_str(), e.c_str());
			if (!strstr(e.c_str(), display_name.c_str())) continue;
			auto idx = std::string(); idx.push_back(child_name.back());
			return idx;
		}
	}
	return "";
}
bool sdk::dialog::c_dialog::find_panel(std::string panel)
{
	if (!this->gpanels()) return false;
	for (auto a : this->panels_map) if (strstr(a.first.c_str(), panel.c_str())) return true;
	return false;
}
bool sdk::dialog::c_dialog::sell_test(int id)
{
	if (this->sell_state == 4) return true;
	if (this->last_execution + 15 > GetTickCount64()) return false;
	this->last_execution = GetTickCount64();
	switch (this->sell_state)
	{
		//rework this this is bad, make it threaded with thread_active check for bot to see when its done and validate items existance always
	case 0://clicking the dialog option wanted
	{
		auto sell_p = this->find_panel(this->core_dialogs["Shop"]);
		if (sell_p) { this->sell_state++; break; }
		auto r = this->find_panel("Panel_Npc_Dialog_All");
		if (!r) return false;
		auto l = this->find_button("Shop", "Panel_Npc_Dialog_All");
		if (l.empty()) return false;
		auto str = std::string("HandleEventLUp_DialogMain_All_FuncButton(").append(l).append(")");
		sys::lua_q->add(str);
		this->sell_state++;
		break;
	}
	case 1://validate entry to sell panel
	{
		auto r = this->find_panel(this->core_dialogs["Shop"]);
		if (!r) return false;
		auto i = 0;
		for (auto a : sdk::player::player_->inventory_items)
		{
			if (a.item_index == id) { i = a.item_slot; if (a.count > 1) needs_numberpad = true; break; }
		}
		if (i == 0) { this->sell_reset(); return true; }
		auto s = std::string("HandleEventRUp_Inventory_All_SlotRClick(").append(std::to_string(i)).append(")");
		sys::lua_q->add(s);
		this->sell_state++;
		break;
	}
	case 2:
	{
		if (this->needs_numberpad)
		{
			auto r = this->find_panel(this->core_dialogs["NumberPad"]);
			if (r)
			{
				//set max quantity
				sys::lua_q->add("HandleEventLUp_NumberPad_All_AllButton_Click(0)");
				this->sell_state++;
				break;
			}
		}
		else this->sell_state++;
		//if none pops up its a single item and was already sold
		break;
	}
	case 3:
	{
		if (!this->needs_numberpad)
		{
			this->sell_state++;
			break;
		}
		auto r = this->find_panel(this->core_dialogs["NumberPad"]);
		if (r)
		{
			sys::lua_q->add("HandleEventLUp_NumberPad_All_ConfirmButton_Click()");
			this->sell_state++;
		}
		break;
	}
	default: break;
	}
	return false;
}

void __stdcall sdk::dialog::do_sell(void* a)
{
	auto data = (sdk::dialog::s_thread_p*)(a);
	sdk::dialog::dialog->thread_running = true;
	while (1)
	{
		if (sdk::dialog::dialog->last_execution + 100 > GetTickCount64()) continue;
		sdk::dialog::dialog->last_execution = GetTickCount64();
		if (!data->items.empty())
		{
			auto interacting = sdk::dialog::dialog->find_panel("Panel_Npc_Dialog_All");
			if (!interacting)
			{
				for (auto a : sdk::player::player_->npcs) if (strstr(a.name.c_str(), data->npc.c_str())) sys::roar_bot->f_npc_interaction(a.ptr);
				//sdk::util::log->b("interacted with %s", npc.c_str());
				continue;
			}
			auto shop_panel = sdk::dialog::dialog->find_panel("Panel_Dialog_NPCShop_All");
			if (!shop_panel)
			{
				auto btn = sdk::dialog::dialog->find_button("Shop", "Panel_Npc_Dialog_All");
				if (btn.empty()) return;
				auto str = std::string("HandleEventLUp_DialogMain_All_FuncButton(").append(btn).append(")");
				sys::lua_q->add(str);
				//sdk::util::log->b("shop button > %s", str.c_str());
				continue;
			}
		}
		if (data->items.empty())//to exit dialog
		{
			auto interacting = sdk::dialog::dialog->find_panel("Panel_Npc_Dialog_All");
			if (interacting)
			{
				if (sdk::dialog::dialog->last_click_time != 0)
				{
					if (GetTickCount64() > sdk::dialog::dialog->last_click_time + 150)//max timeout to try again if failed
					{
						sdk::dialog::dialog->last_click_time = 0;
						sys::lua_q->add("HandleEventLUp_DialogMain_All_ExitClick()");
						continue;
					}
				}
				else
				{
					sys::lua_q->add("HandleEventLUp_DialogMain_All_ExitClick()");
					sdk::dialog::dialog->last_click_time = GetTickCount64();
					continue;
				}
			}
			else
			{
				sdk::dialog::dialog->completed_sales = true;
				sdk::dialog::dialog->needs_numberpad = false;
				sdk::dialog::dialog->last_click_time = 0;
				sdk::dialog::dialog->did_click = false;
				sdk::dialog::dialog->did_select_confirm = false;
				sdk::dialog::dialog->did_select_max = false;
				sdk::dialog::dialog->thread_running = false;
				delete a;
				ExitThread(0);
				return;
			}
			continue;
		}
		auto i = data->items.back();
		if (i != -1)
		{
			if (sdk::dialog::dialog->last_click_time != 0)
			{
				if (GetTickCount64() > sdk::dialog::dialog->last_click_time + 150)//max timeout to try again if failed
				{
					sdk::dialog::dialog->last_click_time = 0;
					goto do_it;
				}
			}
			else
			{
			do_it:
				auto has_item = false; int slot = -1;
				for (auto a : sdk::player::player_->inventory_items)
				{
					if (a.item_index == i)
					{
						has_item = true;
						slot = a.item_slot;
						if (a.count > 1) sdk::dialog::dialog->needs_numberpad = true;
						else sdk::dialog::dialog->needs_numberpad = false;
						break;
					}
				}
				if (has_item)
				{
					if (!sdk::dialog::dialog->did_click)
					{
						sdk::dialog::dialog->last_click_time = GetTickCount64();
						auto s = std::string("HandleEventRUp_Inventory_All_SlotRClick(").append(std::to_string(slot)).append(")");
						sys::lua_q->add(s);
						sdk::dialog::dialog->did_click = true;
						continue;
					}
					else if (GetTickCount64() > sdk::dialog::dialog->last_click_time + 150)
					{
						if (sdk::dialog::dialog->needs_numberpad)
						{
							if (!sdk::dialog::dialog->did_select_max)
							{
								auto r = sdk::dialog::dialog->find_panel(sdk::dialog::dialog->core_dialogs["NumberPad"]);
								if (r)
								{
									sys::lua_q->add("HandleEventLUp_NumberPad_All_AllButton_Click(0)");
									sdk::dialog::dialog->did_select_max = true;
									sdk::dialog::dialog->last_click_time = GetTickCount64();
									continue;
								}
							}
							if (!sdk::dialog::dialog->did_select_confirm)
							{
								auto r = sdk::dialog::dialog->find_panel(sdk::dialog::dialog->core_dialogs["NumberPad"]);
								if (r)
								{
									sys::lua_q->add("HandleEventLUp_NumberPad_All_ConfirmButton_Click()");
									sdk::dialog::dialog->did_select_confirm = true;
									sdk::dialog::dialog->last_click_time = GetTickCount64();
									continue;
								}
							}
							else
							{
								sdk::dialog::dialog->did_select_confirm = false;
								sdk::dialog::dialog->did_select_max = false;
								continue;
							}
						}
					}
				}
				else
				{
					sdk::dialog::dialog->needs_numberpad = false;
					sdk::dialog::dialog->last_click_time = 0;
					sdk::dialog::dialog->did_click = false;
					sdk::dialog::dialog->did_select_confirm = false;
					sdk::dialog::dialog->did_select_max = false;
					data->items.pop_back();
				}
			}
		}
	}
}
sdk::dialog::c_dialog* sdk::dialog::dialog;