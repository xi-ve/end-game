#pragma once
#include <inc.h>
namespace sdk
{
	namespace menu
	{
		class c_menu
		{
		private:
			bool was_setup = false;
			bool menu_active = false;
		public:
			void work();
			void sactive();
		};
		extern c_menu* menu;
	}
}