#include <inc.h>
bool sdk::dialog::c_dialog::gbuttons()
{
	this->buttons_map.clear();
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
sdk::dialog::c_dialog* sdk::dialog::dialog;