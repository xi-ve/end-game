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
	if (r.size() < 6)
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
	//
	return r;
}
bool sys::c_rebuff::update()
{
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
std::vector<std::string> sys::c_rebuff::gbuffs()
{
	return this->buffs;
}
void sys::c_rebuff::work(uint64_t s)
{
	this->self = s;
	this->update();
	//
}
sys::c_rebuff* sys::rebuff;