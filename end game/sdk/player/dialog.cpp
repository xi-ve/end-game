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
sdk::dialog::c_dialog* sdk::dialog::dialog;