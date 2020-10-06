#include <inc.h>
#include "..\\..\\lib\win\dirent.h"
void sdk::util::c_file::update()
{
	this->roar_paths.clear();
	char r[MAX_PATH];
	auto p = std::string(r, GetModuleFileNameA(NULL, r, MAX_PATH));
	for (auto a = 0; a < 17; a++) p.pop_back();
	sdk::util::log->add(p, sdk::util::e_info, true);
	auto dir = opendir(p.c_str()); struct dirent* h;
	auto str3_2852__2813 = new core::s_str_container(std::vector<int>{39, 59, 49}); /*.28*/
	while ((h = readdir(dir)) != NULL)
	{
		if (!strstr(h->d_name, str3_2852__2813->get().c_str())) continue;
		this->roar_paths.push_back(h->d_name);
	}
	delete str3_2852__2813;
	closedir(dir);
}
sdk::util::c_file* sdk::util::file;