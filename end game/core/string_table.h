#pragma once
#include <inc.h>
namespace core
{
	struct s_str_container
	{
		s_str_container()
		{

		}
		s_str_container(std::vector<int> str_encr)
		{
			raw_str = str_encr;
			enc();
		}
		s_str_container(std::string str)
		{
			raw = str;
			enc();
		}
		std::wstring      getW()
		{
			if (!decr.size() && raw_str.size()) for (auto obj : raw_str) decr.push_back((char)(obj ^= 9));
			std::wstring ws(decr.begin(), decr.end());
			return ws;
		}
		std::string      get()
		{
			if (!decr.size() && raw_str.size()) for (auto obj : raw_str) decr.push_back((char)(obj ^= 9));
			return decr;
		}
		std::vector<int> enc()
		{
			if (!raw_str.size()) for (auto obj : raw) raw_str.push_back((int)(obj ^= 9));
			return raw_str;
		}
		std::string      str()
		{
			raw_as_str.clear();
			for (auto obj : raw_str) raw_as_str << obj;
			return raw_as_str.str();
		}
		std::string		 var()
		{
			return var_name;
		}		
		std::vector<int>	   raw_str;
		std::stringstream      raw_as_str;
		std::string            decr;
		std::string            raw;
		std::string		       var_name;
	};
	extern std::unordered_map<int, std::string> table;
	extern void init_string_table();
	extern std::string gstr(int i);
}