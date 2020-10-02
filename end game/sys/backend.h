#pragma once
#include <inc.h>
namespace sys
{
	struct s_process_info
	{
		s_process_info(TCHAR a1[MAX_PATH], const DWORD a2, const TCHAR a3[MAX_PATH], const char a4[MAX_PATH])
		{
			proc_id = a2;
			exe_name = a1;
			full_path = a3;
			title = a4;
		}
		std::string exe_name;
		std::string full_path;
		std::string title;
		std::vector<std::string> modules;
		DWORD proc_id;
	};
	struct handle_data
	{
		unsigned long process_id;
		HWND window_handle;
	};
	extern void __stdcall backend_worker();
	class c_backend
	{
	private:
		std::string get_val(std::string name);
		PROCESS_INFORMATION open_pid(const int pid);
		HWND find_main_window(unsigned long process_id);
	public:
		std::string xor_fn(std::string i, std::string k);
		std::vector<s_process_info> gather();
		std::string ghwid(); void setup();
		ULONGLONG last_run = 0;	std::string usr, pass, hwid;
		bool thread_working = false;
		BOOL is_main_window(const HWND handle);
		void work();
	};
	extern c_backend* backend;
}