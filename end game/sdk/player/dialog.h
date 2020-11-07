#pragma once
#include <inc.h>
namespace sdk
{
	namespace dialog
	{
		struct s_thread_p
		{
			std::string npc = "";
			std::vector<int> items = {};
		};
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
			bool thread_running = false, completed_sales = false, completed_repair = false; 
			ULONGLONG last_execution = 0, last_click_time = 0; bool	needs_numberpad = 0; int item_id = 0; bool did_click = false; bool did_select_max = false; bool did_select_confirm = false;
			bool did_click_repair = false; bool did_click_confirm = false; bool did_enter_repair = false; bool did_enter_menu = false; int exit_stage = 0; bool did_finish_reapir = false;

			std::vector<uint64_t> disabled_panels = {};

			int			sell_state = 0;
			std::unordered_map<std::string, std::unordered_map<int,int>>  icon_idents =
			{
				{ "Shop",
					std::unordered_map<int,int>
					{
						{0x6C, 0x3da07a45},
						{0x70 ,0x3b000000},
						{0x74 ,0x3e1ca81f},
						{0x78 ,0x3b000000},
						{0x80 ,0x3da40000},
						{0x84 ,0x3e1ca81f},
						{0x88 ,0x3da40000},
						{0x8C ,0x0000}
					} 
				},
				{ "Repair",	
					std::unordered_map<int,int>
					{
						{0x6C ,0x3eebf0b7},
						{0x70 ,0x3e780000},
						{0x74 ,0x3f09131b},
						{0x78 ,0x3e780000},
						{0x80 ,0x3ea40000},
						{0x84 ,0x3f09131b},
						{0x88 ,0x3ea40000},
						{0x8C ,0x0000}
					}
				},
				{ "Store",
					std::unordered_map<int,int>
					{
						{0x6C ,0x3f098d60},
						{0x70 ,0x3e780000},
						{0x74 ,0x3f1ca81f},
						{0x78 ,0x3e780000},
						{0x80 ,0x3ea40000},
						{0x84 ,0x3f1ca81f},
						{0x88 ,0x3ea40000},
						{0x8C ,0x0000}
					}
				}
			};
			std::unordered_map<std::string, std::string>	core_dialogs =
			{
				{"NPC_Interaction",	"Panel_Npc_Dialog_All"},
				{"Repair",			"Panel_Dialog_Repair_Function_All"},
				{"Shop",			"Panel_Dialog_NPCShop_All"},
				{"Storage",			"Panel_Window_Warehouse"},
				{"MessageBox",		"Panel_Window_MessageBox_All"},
				{"NumberPad",		"Panel_Window_NumberPad_All"}
			};
			std::unordered_map<int, std::string>			buttons_map = {};
			std::unordered_map<std::string, bool>			panels_map = {};
			std::unordered_map<std::string, std::string>	children_by_panel = {};
			bool disable_all();
			bool enable_all();
			bool gbuttons();
			bool gpanels();
			bool gchildren(std::string panel); 
			//
			std::string find_button(std::string display_name, std::string panel);
			int			find_button_ex(std::string display_name, std::string panel);
			bool		find_panel(std::string panel);
			//
			void		sell_reset()
			{
				this->did_click = false;
				this->did_select_confirm = false;
				this->did_select_max = false;
				this->needs_numberpad = false;
				this->sell_state = 0; 
				this->completed_repair = false;
				this->did_click_repair = 0;
				this->did_enter_repair = 0;
				this->did_enter_menu = 0;
				this->did_click_confirm = 0;
				this->exit_stage = 0;
				this->did_finish_reapir = 0;
			};
			bool		sell_test(int id);
		};
		extern c_dialog* dialog;
		extern void __stdcall do_sell	(void* p);
		extern void __stdcall do_store	(void* p);
		extern void __stdcall repair_eq	(void* a);
	}
}