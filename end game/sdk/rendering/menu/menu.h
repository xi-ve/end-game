#pragma once
#include <inc.h>
namespace sdk
{
	namespace menu
	{
		class c_menu
		{
		private:
			size_t ctab = 0;
			void tab(size_t Index, const char* Text, int height);
			bool was_setup = false;
			bool menu_active = false;
		public:
			void work();
			void sactive();
			bool gactive() { return this->menu_active; };
		};
		extern c_menu* menu;
	}
}