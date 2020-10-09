#pragma once
#include <inc.h>
namespace sdk
{
	namespace util
	{
		class c_file
		{
		public:
			std::vector<std::string> roar_paths;
			std::vector<std::string> legit_paths;
			void update();
		};
		extern c_file* file;
	}
}