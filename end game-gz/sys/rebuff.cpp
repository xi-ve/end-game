#include <inc.h>
std::string sys::c_rebuff::gstr(uint64_t p, int s)
{
	auto r = std::string("");
	//
	for (auto c = p; c < p + s; c++)
	{
		auto chr = *(char*)(c);
		if (chr == '\0' || chr == '?') break;
		r.push_back(chr);
	}
	if (r.size() <= 6)
	{
		r.clear();
		auto st = *(uint64_t*)(p); if (!st) return "";
		for (auto c = st; c < st + s; c++)
		{
			auto chr = *(char*)(c);
			if (chr == '\0' || chr == '?') break;
			r.push_back(chr);
		}
	}
	if (r.size() <= 6)
	{
		r = *(char**)(p);
	}
	//
	return r;
}
bool sys::c_rebuff::update()
{
	if (sdk::dialog::dialog->find_panel(sdk::dialog::dialog->core_dialogs["NPC_Interaction"])) return false;
	auto m_c = *(BYTE*)(this->self + 0x1c0);
	auto n = *(uint64_t*)(this->self + 0x1b8);
	auto nf = *(uint64_t*)(n);
	std::vector<std::string> nbuffs;
	for (auto c = 0; c < m_c; c++)
	{
		if (!nf) break;
		auto t = *(BYTE*)(nf + 0x28);
		if (t)
		{
			auto ico = this->gstr(nf + 0x18, 64);
			if (ico.empty()) { nf = *(uint64_t*)(nf); continue; }
			this->f_get_buff_desc(nf + 0x18);
			auto dsc = this->gstr(nf + 0x18, 64);
			if (dsc.empty()) { nf = *(uint64_t*)(nf); continue; }
			auto f = dsc.find("\n");
			if (f != std::string::npos) dsc.erase(f, dsc.size());
			f = dsc.find(">"); 
			if (f != std::string::npos) dsc.erase(0, f + 1);
			f = dsc.find("<"); 
			if (f != std::string::npos) dsc.erase(f, dsc.size());
			for (auto&& u : dsc) if (u == '?') u = '\'';
			nbuffs.push_back(dsc);
		}
		nf = *(uint64_t*)(nf);
	}
	this->buffs = nbuffs;
	return true;
}
bool sys::c_rebuff::hitem(int i)
{
	for (auto a : sdk::player::player_->inventory_items) if (a.item_index == i) return true;
	return false;
}
int sys::c_rebuff::gslot(int i)
{
	for (auto a : sdk::player::player_->inventory_items) if (a.item_index == i) return a.item_slot;
	return 0;
}
int sys::c_rebuff::gibyname(std::string n)
{
	for (auto a : sdk::player::player_->inventory_items) if (strstr(n.c_str(), a.name.c_str())) return a.item_index;
	return 0;
}
std::vector<std::string> sys::c_rebuff::gbuffs()
{
	return this->buffs;
}
std::vector<std::string> sys::c_rebuff::gsbuffs()
{
	auto r = std::vector<std::string>();
	for (auto a : this->buffs_set) r.push_back(a.n);
	return r;
}
std::vector<sys::s_buff_info> sys::c_rebuff::gabuffs()
{
	return this->buffs_set;
}
bool sys::c_rebuff::load()
{
	if (!string_buffs) string_buffs = sys::config->gvar("rebuffer", "string_buffs");
	if (string_buffs->rval.empty()) return false;
	this->buffs_set.clear();
	auto cpy = string_buffs->rval;
	while (cpy.size())
	{
		auto t = sys::s_buff_info("",0);
		auto cpy2 = cpy;
		auto pos = cpy2.find("_");
		if (pos == std::string::npos) { cpy.clear(); break; }
		cpy2.erase(pos, cpy2.size());

		cpy.erase(0, pos + 1);
		t.n = cpy2;

		cpy2 = cpy;

		pos = cpy2.find(";");
		if (pos == std::string::npos) { cpy.clear(); break; }
		cpy2.erase(pos, cpy2.size());

		t.i = std::stoi(cpy2);

		cpy.erase(0, pos + 1);

		this->buffs_set.push_back(t);
	}
	return false;
}
bool sys::c_rebuff::add(std::string b, int i)
{
	if (!string_buffs) string_buffs = sys::config->gvar("rebuffer", "string_buffs");
	for (auto r : this->buffs_set) if (r.i == i || r.n == b) return false;
	//buff_123;
	string_buffs->rval.append(std::string(b).append("_").append(std::to_string(i)).append(";"));
	this->buffs_set.emplace_back(b,i);
	return false;
}
void sys::c_rebuff::work(uint64_t s)
{
	if (!ienable) ienable = sys::config->gvar("rebuffer", "ienable");
	if (!string_buffs) string_buffs = sys::config->gvar("rebuffer", "string_buffs");
	this->self = s;
	if (GetTickCount64() > this->exection) this->exection = GetTickCount64() + 5000;
	else return;
	if (GetTickCount64() < fn::time_since_player_playable + 10000) return;
	if (!this->update()) return;
	if (!ienable->iv) return;
	//
	for (auto a : this->buffs_set)
	{
		if (!this->hitem(a.i)) continue;
		auto skip = false; for (auto b : this->buffs) if (strstr(a.n.c_str(), b.c_str())) skip = true;
		if (skip) continue;
		sys::lua_q->useitem(this->gslot(a.i));
	}
}
sys::c_rebuff* sys::rebuff;