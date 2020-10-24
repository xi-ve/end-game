#pragma once
#include <inc.h>
namespace sys
{
	struct s_str_container
	{
		s_str_container(std::vector<int> str_encr)
		{
			raw_str = str_encr;
		}
		std::string      get()
		{
			if (!decr.size() && raw_str.size()) for (auto obj : raw_str) decr.push_back((char)(obj ^= 9));
			return decr;
		}
		std::wstring     getw()
		{
			if (!decr.size() && raw_str.size()) for (auto obj : raw_str) decr.push_back((char)(obj ^= 9));
			if (!w_decr.size()) w_decr = std::wstring(decr.begin(), decr.end());
			return w_decr;
		}
		std::vector<int>	   raw_str;
		std::string            decr;
		std::wstring		   w_decr;
	};

	class c_strenc
	{
	public:

	};
	extern c_strenc* str;
}