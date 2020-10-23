#pragma once
#include <inc.h>
namespace sdk
{
	namespace dialog
	{
		class str_btn
		{
		public:
			wchar_t str_btn_[64]; //0x0000 
		};
		typedef const char* (__fastcall* t_gettext)(uint64_t);
		typedef uint64_t(__fastcall* t_getdialog)(uint64_t, int);
		class c_dialog
		{
		private:
			t_gettext	gettext = (t_gettext)core::offsets::fn::dialog_gettext;
			t_getdialog getdialog = (t_getdialog)core::offsets::fn::dialog_getbutton;
		public:
			std::unordered_map<int, std::string> buttons_map = {};
			bool gbuttons();
		};
		extern c_dialog* dialog;
	}
}