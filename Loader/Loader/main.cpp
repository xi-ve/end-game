#include "inc.h"

class option {
public:
	int entry;
	std::string name;
};

std::string encryptDecrypt(std::string buffer, std::string key)
{
	for (auto c = 0; c < buffer.size(); c++) buffer[c] ^= key[c % key.length()];
	return buffer;
}


std::string rstr(int size)
{
	srand((int)std::chrono::high_resolution_clock::now);
	static auto range = std::string("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
	auto out = std::stringstream();
	for (auto c = 0; c < size; c++)
	{
		auto slc = range[rand() % 52];
		out << slc;
	}
	return out.str();
}



std::string prepare(std::string data) {
	//return data;
	std::string key_data = rstr(10);
	key_data.append(encryptDecrypt(data,key_data));
	return key_data.c_str();
}

std::string hwid_get()
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
	auto user = GetUserNameA(username,&username_len);
	//std::to_string(user)
	return encryptDecrypt(serialNumber_s,std::to_string(user));
	//VMProtectEnd();
}

int main() {
	srand(time(NULL));
	std::string username;
	std::cout << "Please enter your username." << std::endl;
	std::cin  >> username;
	std::string password;
	std::cout << "Please enter your password." << std::endl;
	std::cin>> password;
	auto client = new web::client(false, true);
	client->connect(L"127.0.0.1");
	client->request(L"cheat/index.php", web::requestmode::POST, { { "user", prepare(username.c_str()) }, { "pass", prepare(password.c_str())}, { "hwid", prepare(hwid_get())},{"action",prepare("get_options")} });
	auto res = client->tostring(client->get());
	std::string key = res.substr(0, 10);
	std::string data = res.substr(10);
	res = encryptDecrypt(data,key);
	if (res == "1") {//not enough post data / should never happen tbh
		std::cout << "No data provided." << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "2") {//invalid user
		std::cout << "Invalid Username." << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "3") { // invalid password
		std::cout << "Invalid Password." << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "4") { // invalid hwid
		std::cout << "Invalid HWID." << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res.at(0) == '5') { // user banned
		std::cout << "User banned." << std::endl << "reason:";
		std::cout << res.substr(2) << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "6") { // no lic
		std::cout << "No licenses." << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	res = res.substr(5);

	std::vector<option> options;
	std::string buffer;
	int counter = 0;
	for (int i = 0; i < res.length(); i++) {
		if (res.at(i) == '\n') {
			option c;
			c.entry = counter;
			c.name = buffer;
			options.push_back(c);
			buffer = "";
			counter += 1;
			continue;
		}
		buffer.push_back(res.at(i));
	}
	std::cout << "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" << std::endl;
	std::cout << "Select Your Cheat:" << std::endl;
	std::cout << "ID\tName"  << std::endl;
	std::cout << "------------------------------------------------------------" << std::endl;
	for (int i = 0; i < options.size(); i++) {
		option c = options[i];
		std::cout << c.entry << "\t" << c.name << std::endl;
	}
	std::cout << "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" << std::endl;
	std::string ID;
	std::cin >> ID;
	client->request(L"cheat/index.php", web::requestmode::POST, { { "user", prepare(username.c_str()) }, { "pass", prepare(password.c_str())}, { "hwid", prepare(hwid_get())},{ "name", prepare("BDO Dev")},{"action",prepare("get_data")} });
	res = client->tostring(client->get());
	key = res.substr(0, 10);
	data = res.substr(10);
	res = encryptDecrypt(data,key);
	std::cout << "data: " << res << std::endl;
	auto a = getchar();
}