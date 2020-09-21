#include <inc.h>
bool sys::c_config::proc(std::string a, std::string b, std::string c)
{
	if (a.empty() || b.empty()) return false;
	if (this->gvar(a, b)) return false;
	auto t = new sys::s_cfg_v(a, b, c);
	this->cfg_list.push_back(t);
	return true;
}
sys::s_cfg_v* sys::c_config::gvar(std::string t, std::string v)
{
	for (auto a : this->cfg_list) if (strstr(a->table.c_str(), t.c_str()) && strstr(a->val.c_str(), v.c_str())) return a;	
	return nullptr;
}
void sys::c_config::read()
{
	std::ifstream t("28802.cfg.txt");
	if (!t.is_open()) return;
	std::string s;
	while (std::getline(t, s))
	{
		if (s.empty()) continue;
		auto f = s.find(":");
		auto cpy = s;
		if (f == std::string::npos) continue;
		cpy.erase(f, cpy.size());
		auto first_var = cpy;
		s.erase(0, f + 1);
		cpy = s;
		f = cpy.find(":");
		cpy.erase(f, cpy.size());
		auto second_var = cpy;
		s.erase(0, f + 1);
		cpy = s;
		this->proc(first_var, second_var, s);
	}
	t.close();
}
void sys::c_config::save()
{
	std::ofstream t("28802.cfg.txt");
	if (!t.is_open()) return;
	for (auto&& a : this->cfg_list)
	{
		switch (a->t)
		{
		case 0:
		{
			t << a->table << ":" << a->val << ":" << a->rval << "\n";
			break;
		}
		case 1:
		{
			t << a->table << ":" << a->val << ":" << a->iv << "\n";
			break;
		}
		case 2:
		{
			t << a->table << ":" << a->val << ":" << a->fv << "\n";
			break;
		}
		default: break;
		}
	}
	t.close();
}
void sys::c_config::vars()
{
	this->proc("loot", "ienable", "1");
	this->proc("packet", "ibypass_trial", "1");
	this->proc("packet", "iteleport_gen2", "1");
	this->proc("debug", "ientity_update", "1");
	this->proc("auto_loot", "string_whitelist_config", "");
	this->proc("auto_loot", "string_blacklist_config", "");
	this->proc("auto_loot", "ipick_grey", "1");
	this->proc("auto_loot", "ipick_green", "1");
	this->proc("auto_loot", "ipick_blue", "1");
	this->proc("auto_loot", "ipick_orange", "1");
	this->proc("auto_loot", "ipick_yellow", "1");
	this->proc("auto_loot", "ienable", "1");
	this->proc("auto_loot", "ienable_filter", "1");
	this->proc("keybinds", "itp_key", "96");
}
sys::c_config* sys::config;