#pragma once
#include <inc.h>
namespace sdk
{
	namespace menu
	{
		typedef void(__fastcall* t_func)();
		extern void roar_menu();
		extern void visuals_menu();
		struct s_imgui_intslider
		{
			s_imgui_intslider() {};
			s_imgui_intslider(int l, int h)
			{
				min = l; max = h;
			};
			int min = 0, max = 0;
		};
		struct s_imgui_floatslider
		{
			s_imgui_floatslider() {};
			s_imgui_floatslider(float l, float h)
			{
				min = l; max = h;
			};
			float min = 0.f, max = 0.f;
		};
		struct s_imgui_node
		{
			s_imgui_node(std::string n, int t, std::string ct, std::string vn, bool sl)
			{
				if (ct.size() && ct != "locals") cfg = sys::config->gvar(ct, vn);
				cfg_table = ct;
				cfg_var = vn;
				name = n;
				type = t;
				use_sameline = sl;
			};
			s_imgui_node(std::string n, int t, std::string ct, std::string vn, bool sl, void* strc)
			{
				if (ct.size() && ct != "locals") cfg = sys::config->gvar(ct, vn);
				name = n;
				type = t;
				strct = strc;
				f_func = (t_func)strc;
				use_sameline = sl;
			};
			s_imgui_node(std::string n, int t, std::string ct, std::string vn, bool sl, std::function<void()> strc)
			{
				if (ct.size() && ct != "locals") cfg = sys::config->gvar(ct, vn);
				name = n;
				type = t;				
				f_lambda = strc;
				use_sameline = sl;
			};
			s_imgui_node(std::string n, int t, std::string ct, std::string vn, bool sl, s_imgui_floatslider* strc)
			{
				if (ct.size() && ct != "locals") cfg = sys::config->gvar(ct, vn);
				name = n;
				type = t;
				strct = (void*)strc;
				use_sameline = sl;
			};
			s_imgui_node(std::string n, int t, std::string ct, std::string vn, bool sl, s_imgui_intslider* strc)
			{
				if (ct.size() && ct != "locals") cfg = sys::config->gvar(ct, vn);
				name = n;
				type = t;
				strct = (void*)strc;
				use_sameline = sl;
			};
			std::string				cfg_table = "";
			std::string				cfg_var = "";
			t_func					f_func = NULL;
			std::function<void()>	f_lambda = NULL;
			void*					strct = NULL;
			std::string				name = "";
			int						type = 0;
			sys::s_cfg_v*			cfg = NULL;
			bool					use_sameline = false;
		};
		struct s_imgui_treenode
		{
			s_imgui_treenode() {};
			s_imgui_treenode(std::string n, std::vector<s_imgui_node> ns)
			{
				main_name = n; nodes = ns;
			};
			std::string main_name = "";
			std::vector<s_imgui_node> nodes = {};
		};
		struct s_imgui_tab
		{
			s_imgui_tab(std::string n, std::vector<s_imgui_treenode> t)
			{
				name = n; tree = t;
			};
			std::string name = "";
			bool toggle = false;
			std::vector<s_imgui_treenode> tree = {};
		};
		extern void test_func();
		class c_menu
		{
		private:
			sys::s_cfg_v* iteleport_gen2 = NULL; sys::s_cfg_v* ibypass_trial = NULL; sys::s_cfg_v* iloot_enable = NULL;
			sys::s_cfg_v* iloot_enable_filter = NULL; sys::s_cfg_v* grey = NULL; sys::s_cfg_v* green = NULL;
			sys::s_cfg_v* blue = NULL; sys::s_cfg_v* orange = NULL; sys::s_cfg_v* yellow = NULL; 
			sys::s_cfg_v* ikey_ctp = NULL; sys::s_cfg_v* ibot_timescale = NULL; sys::s_cfg_v* ibot_lootrange = NULL;
			sys::s_cfg_v* iroar_path = NULL; sys::s_cfg_v* iroar_pause = NULL; sys::s_cfg_v* ienable_portal = NULL;
			sys::s_cfg_v* ienable_debug = NULL; sys::s_cfg_v* ient_alt = NULL; sys::s_cfg_v* istore_path = NULL;
			sys::s_cfg_v* ibot_storage_roar = NULL; sys::s_cfg_v* ivis_linestart = NULL; sys::s_cfg_v* ialive_byname = NULL;
			sys::s_cfg_v* irebuffer_enable = NULL; sys::s_cfg_v* string_last_path = NULL;
			size_t TabHeight = 0; size_t TabWidth = 100; size_t ctab = 0;
			int selected_whitelist = 0; float t = 1.1f; char ct[128] = "def.28"; int ps = 0; int si = 0; int ni = 0; int is_scr = 0; int witem_s = 0;
			int selected_buff = 0; int selected_buff_item = 0; int selected_packet = 0; char lua_input[2048] = "empty";

			bool overlay_moveable = false; int overlay_selected_id = 0; bool overlay_active = true;
			sys::s_cfg_v* ioverlay_toggled = NULL;
			void overlay(bool* acti);

			char dscr[128];
			void tab(size_t Index, const char* Text, int height);
			bool was_setup = false;
			bool menu_active = false;

			std::vector<s_imgui_tab> tabs;
			bool setup_tabs = false; bool has_tab_open = false;
			bool setup();
			bool add_tab(std::string n, std::vector<s_imgui_treenode> node);
			//
			void work_tabs();
		public:
			bool packet_log_enabled = false;
			char mob_target[128] = "Raccoon"; char test_input_ptr[2048] = "Test"; bool using_test_menu = false;
			void work();
			//
			void work2();
			//
			void sactive();
			bool gactive() { return this->menu_active; };
		};
		extern c_menu* menu;
	}
}