#pragma once
#include <inc.h>
namespace sys
{
	struct s_cfg_v
	{
		s_cfg_v(std::string a, std::string b, std::string c)
		{
			table = a; val = b; rval = c;
			auto type = b.front();
			switch (type)
			{
			case 'i':
			{
				iv = std::stoi(c);
				t = 1;
				break;
			}
			case 'f':
			{
				fv = std::stof(c);
				t = 2;
				break;
			}
			default: break;
			}
		}
		std::string table;
		std::string val;
		std::string rval;
		int iv = 0; float fv = 0; int t = 0;
	};
	class c_config
	{
	private:
		std::vector<s_cfg_v*> cfg_list;
		bool proc(std::string a, std::string b, std::string c);
	public:
		s_cfg_v* gvar(std::string t, std::string v);
		void read();
		void save();
	};
	extern c_config* config;
}