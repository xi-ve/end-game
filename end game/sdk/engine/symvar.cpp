#include <inc.h>
bool sdk::engine::c_symvar::get()
{
	//143C50418
	//0x1BCFFFFFFFF

	if (this->sys_vars.size())
	{
		for (auto&& a : this->sys_vars) delete a;
		this->sys_vars.clear();
		this->sys_vars_str.clear();
	}

	auto base = core::offsets::cl::symvar_base + 0x10;
	while (1)
	{
		auto v_base = *(DWORD*)(base);
		if (*(uint64_t*)(base + 0x10) == NULL) break;
		auto v_name = *(char**)(base + 0x8);
		if (strlen(v_name) <= 4) break;
		if (v_base >= 100000)
		{
			auto v_var = *(float*)(base);
			this->sys_vars.push_back(new sdk::engine::s_sysvar(v_name, 1, base, v_var));
		}
		else
		{
			auto v_var = *(int*)(base);
			this->sys_vars.push_back(new sdk::engine::s_sysvar (v_name, 0, base, (float)v_var));
		}
		base += 0x20;
	}

	for (auto a : this->sys_vars) this->sys_vars_str.push_back(a->name);	

	return true;
}
sdk::engine::s_sysvar* sdk::engine::c_symvar::get_byname(std::string name)
{
	for (auto a : this->sys_vars) if (a->name == name) return a;
	return nullptr;
}
sdk::engine::c_symvar* sdk::engine::symvar;