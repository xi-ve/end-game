#pragma once
#include <inc.h>
namespace sdk
{
	namespace engine
	{
		struct s_sysvar
		{
			s_sysvar(std::string n, byte t, uint64_t b, float v)
			{
				name = n; type = t; ptr = b; var = v;
			};
			std::string name = "";
			uint64_t	ptr = 0;
			byte		type = 0;
			float		var = 0.f;
		};
		class c_symvar
		{
		public:
			std::vector<s_sysvar*> sys_vars = {};
			std::vector<std::string> sys_vars_str = {};
			bool get();
			s_sysvar* get_byname(std::string name);
		};
		extern c_symvar* symvar;
	}
}