#include "inc.h"
#include "str_vodoo.h"

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
std::string hwid_get()
{
	VMProtectBeginVirtualization("hwid");

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
	VMProtectEnd();
}

int main() {
	VMProtectBeginVirtualization("main");
	auto user = new userdata();
	
	std::string username = user->get_val("username");
	std::string password = user->get_val("password");
	if(username == "" || password == ""){
	static auto str27_14714_Please_enter_your_usern35 = new s_str_container(std::vector<int>{89, 101, 108, 104, 122, 108, 41, 108, 103, 125, 108, 123, 41, 112, 102, 124, 123, 41, 124, 122, 108, 123, 103, 104, 100, 108, 39}); /*Please enter your username.*/ static auto _Please_enter_your_usern1479914910_dec = str27_14714_Please_enter_your_usern35->get();

	std::cout << _Please_enter_your_usern1479914910_dec << std::endl;
	srand(time(NULL) + (int)&username);

	std::cin  >> username;
	static auto str27_26845_Please_enter_your_passw35 = new s_str_container(std::vector<int>{89, 101, 108, 104, 122, 108, 41, 108, 103, 125, 108, 123, 41, 112, 102, 124, 123, 41, 121, 104, 122, 122, 126, 102, 123, 109, 39}); /*Please enter your password.*/ static auto _Please_enter_your_passw2692927040_dec = str27_26845_Please_enter_your_passw35->get();

	std::cout << _Please_enter_your_passw2692927040_dec << std::endl;
	std::cin>> password;
	}
	auto client = new web::client(false, true);
	static auto str15_23343_185_193_126_23527 = new s_str_container(std::vector<int>{56, 49, 60, 39, 56, 48, 58, 39, 56, 59, 63, 39, 59, 58, 60}); /*185.193.126.235*/ static auto _185_193_126_2352342823530_dec = str15_23343_185_193_126_23527->getW();

	client->connect(_185_193_126_2352342823530_dec);
	static auto str9_11351_index_php20 = new s_str_container(std::vector<int>{96, 103, 109, 108, 113, 39, 121, 97, 121}); /*index.php*/ static auto _index_php1143611533_dec = str9_11351_index_php20->getW();
	static auto str4_32227_user15 = new s_str_container(std::vector<int>{124, 122, 108, 123}); /*user*/ static auto _user3231232403_dec = str4_32227_user15->get();
	static auto str4_14754_pass15 = new s_str_container(std::vector<int>{121, 104, 122, 122}); /*pass*/ static auto _pass1483814930_dec = str4_14754_pass15->get();
	static auto str4_30048_hwid15 = new s_str_container(std::vector<int>{97, 126, 96, 109}); /*hwid*/ static auto _hwid3013330225_dec = str4_30048_hwid15->get(); 
	static auto str6_40776_action17 = new s_str_container(std::vector<int>{104, 106, 125, 96, 102, 103}); /*action*/ static auto _action3013330227_dec = str6_40776_action17->get(); static auto str11_30048_get_options23 = new s_str_container(std::vector<int>{110, 108, 125, 86, 102, 121, 125, 96, 102, 103, 122}); /*get_options*/ static auto _get_options3013330232_dec = str11_30048_get_options23->get();
	static auto str7_7339_version17 = new s_str_container(std::vector<int>{127, 108, 123, 122, 96, 102, 103}); /*version*/ static auto _version74247517_dec = str7_7339_version17->get(); static auto str3_24731_0_114 = new s_str_container(std::vector<int>{57, 39, 56}); /*0.1*/ static auto _0_174247513_dec = str3_24731_0_114->get();

	client->request(_index_php1143611533_dec, web::requestmode::POST, {
	{_user3231232403_dec, username.c_str() },
	{ _pass1483814930_dec, password.c_str()},
	{ _hwid3013330225_dec, hwid_get()},
	{_action3013330227_dec,_get_options3013330232_dec},

{_version74247517_dec, _0_174247513_dec}
		});
	auto res = client->tostring(client->get());
	std::string key = res.substr(0, 10);
	std::string data = res.substr(10);
	res = encryptDecrypt(data,key);
	if (res == "0") {//wrong version

		static auto str29_17618_Your_Loader_is_not_up_t35 = new s_str_container(std::vector<int>{80, 102, 124, 123, 41, 69, 102, 104, 109, 108, 123, 41, 96, 122, 41, 103, 102, 125, 41, 124, 121, 41, 125, 102, 41, 109, 104, 125, 108}); /*Your Loader is not up to date*/ static auto _Your_Loader_is_not_up_t1770317813_dec = str29_17618_Your_Loader_is_not_up_t35->get();

		std::cout << _Your_Loader_is_not_up_t1770317813_dec << std::endl;
		auto a = getchar();
		ExitProcess(0);
	} else if (res == "1") {//not enough post data / should never happen tbh
		static auto str17_10783_No_data_provided_29 = new s_str_container(std::vector<int>{71, 102, 41, 109, 104, 125, 104, 41, 121, 123, 102, 127, 96, 109, 108, 109, 39}); /*No data provided.*/ static auto _No_data_provided_1086810973_dec = str17_10783_No_data_provided_29->get();

		std::cout << _No_data_provided_1086810973_dec << std::endl;
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "2") {//invalid user
		static auto str17_2324_Invalid_Username_28 = new s_str_container(std::vector<int>{64, 103, 127, 104, 101, 96, 109, 41, 92, 122, 108, 123, 103, 104, 100, 108, 39}); /*Invalid Username.*/ static auto _Invalid_Username_24092513_dec = str17_2324_Invalid_Username_28->get();

		std::cout << _Invalid_Username_24092513_dec << std::endl;
		user->del_val();
		user->del_val();
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "3") { // invalid password
		static auto str17_31845_Invalid_Password_29 = new s_str_container(std::vector<int>{64, 103, 127, 104, 101, 96, 109, 41, 89, 104, 122, 122, 126, 102, 123, 109, 39}); /*Invalid Password.*/ static auto _Invalid_Password_3193032035_dec = str17_31845_Invalid_Password_29->get();

		std::cout << _Invalid_Password_3193032035_dec << std::endl;
		user->del_val();
		user->del_val();
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "4") { // invalid hwid
		static auto str13_19970_Invalid_HWID_25 = new s_str_container(std::vector<int>{64, 103, 127, 104, 101, 96, 109, 41, 65, 94, 64, 77, 39}); /*Invalid HWID.*/ static auto _Invalid_HWID_2005520156_dec = str13_19970_Invalid_HWID_25->get();

		std::cout << _Invalid_HWID_2005520156_dec << std::endl;
		user->del_val();
		user->del_val();
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res.at(0) == '5') { // user banned
		static auto str12_11972_User_banned_24 = new s_str_container(std::vector<int>{92, 122, 108, 123, 41, 107, 104, 103, 103, 108, 109, 39}); /*User banned.*/ static auto _User_banned_1205712156_dec = str12_11972_User_banned_24->get(); static auto str7_18191_reason_18 = new s_str_container(std::vector<int>{123, 108, 104, 122, 102, 103, 51}); /*reason:*/ static auto _reason_1205712151_dec = str7_18191_reason_18->get();

		std::cout << _User_banned_1205712156_dec << std::endl << _reason_1205712151_dec;
		std::cout << res.substr(2) << std::endl;
		user->del_val();
		user->del_val();
		auto a = getchar();
		ExitProcess(0);
	}
	else if (res == "6") { // no lic
		static auto str12_3620_No_licenses_23 = new s_str_container(std::vector<int>{71, 102, 41, 101, 96, 106, 108, 103, 122, 108, 122, 39}); /*No licenses.*/ static auto _No_licenses_37053804_dec = str12_3620_No_licenses_23->get();

		std::cout << _No_licenses_37053804_dec << std::endl;
		user->del_val();
		user->del_val();
		auto a = getchar();
		ExitProcess(0);
	}
	res = res.substr(5);
	user->set_val("username", username.c_str());
	user->set_val("password", password.c_str());
	std::cout << "Welcome " << username.c_str() << "!" << std::endl;
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
	static auto str60_20033________________________35 = new s_str_container(std::vector<int>{34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34}); /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ static auto ________________________2011820228_dec = str60_20033________________________35->get();
	std::cout << ________________________2011820228_dec << std::endl;
	static auto str18_9121_Select_Your_Cheat_29 = new s_str_container(std::vector<int>{90, 108, 101, 108, 106, 125, 41, 80, 102, 124, 123, 41, 74, 97, 108, 104, 125, 51}); /*Select Your Cheat:*/ static auto _Select_Your_Cheat_92069311_dec = str18_9121_Select_Your_Cheat_29->get();
	std::cout << _Select_Your_Cheat_92069311_dec << std::endl;
	static auto str2_11977_ID13 = new s_str_container(std::vector<int>{64, 77}); /*ID*/ static auto _ID1206212152_dec = str2_11977_ID13->get();

	std::cout << _ID1206212152_dec;
	std::cout << "\t";
	static auto str5_31384_Cheat16 = new s_str_container(std::vector<int>{74, 97, 108, 104, 125}); /*Cheat*/ static auto _Cheat3146931562_dec = str5_31384_Cheat16->get();

	std::cout << _Cheat3146931562_dec << std::endl;
	static auto str60_20537________________________35 = new s_str_container(std::vector<int>{36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36}); /*------------------------------------------------------------*/ static auto ________________________2062220732_dec = str60_20537________________________35->get();
	std::cout << ________________________2062220732_dec << std::endl;
	for (int i = 0; i < options.size(); i++) {
		option c = options[i];
		std::cout << c.entry << "\t" << c.name << std::endl;
	}
	static auto str60_4745________________________34 = new s_str_container(std::vector<int>{34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34}); /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ static auto ________________________48304940_dec = str60_4745________________________34->get();

	std::cout << ________________________48304940_dec << std::endl;
	std::string ID;
	std::cin >> ID;
	static auto str9_18889_index_php20 = new s_str_container(std::vector<int>{96, 103, 109, 108, 113, 39, 121, 97, 121}); /*index.php*/ static auto _index_php1897419071_dec = str9_18889_index_php20->getW(); static auto str4_43132_user15 = new s_str_container(std::vector<int>{124, 122, 108, 123}); /*user*/ static auto _user1897419066_dec = str4_43132_user15->get(); static auto str4_18889_pass15 = new s_str_container(std::vector<int>{121, 104, 122, 122}); /*pass*/ static auto _pass1897419066_dec = str4_18889_pass15->get(); static auto str4_43132_hwid15 = new s_str_container(std::vector<int>{97, 126, 96, 109}); /*hwid*/ static auto _hwid1897419066_dec = str4_43132_hwid15->get(); static auto str4_18889_name15 = new s_str_container(std::vector<int>{103, 104, 100, 108}); /*name*/ static auto _name1897419066_dec = str4_18889_name15->get(); static auto str7_43132_BDO_Dev18 = new s_str_container(std::vector<int>{75, 77, 70, 41, 77, 108, 127}); /*BDO Dev*/ static auto _BDO_Dev1897419069_dec = str7_43132_BDO_Dev18->get(); static auto str6_18889_action17 = new s_str_container(std::vector<int>{104, 106, 125, 96, 102, 103}); /*action*/ static auto _action1897419068_dec = str6_18889_action17->get(); static auto str8_43132_get_data19 = new s_str_container(std::vector<int>{110, 108, 125, 86, 109, 104, 125, 104}); /*get_data*/ static auto _get_data1897419070_dec = str8_43132_get_data19->get();
	static auto str7_18189_version18 = new s_str_container(std::vector<int>{127, 108, 123, 122, 96, 102, 103}); /*version*/ static auto _version1827418369_dec = str7_18189_version18->get(); static auto str3_34754_0_114 = new s_str_container(std::vector<int>{57, 39, 56}); /*0.1*/ static auto _0_11827418365_dec = str3_34754_0_114->get();

	client->request(_index_php1897419071_dec, web::requestmode::POST, {
	{ _user1897419066_dec,username.c_str() },
	{ _pass1897419066_dec, password.c_str()},
	{ _hwid1897419066_dec, hwid_get()},
	{ _name1897419066_dec, options[std::stoi(ID)].name},
	{_action1897419068_dec,_get_data1897419070_dec} ,
	{_version1827418369_dec, _0_11827418365_dec}
		});
	auto raw = client->get();
	res = client->tostring(raw);
	key = res.substr(0, 10);
	data = res.substr(10);
	res = encryptDecrypt(data,key);
	std::vector<byte> image(res.begin(), res.end());

	game::p_game = new game::c_game();

	static auto str16_27917_Waiting_for_game28 = new s_str_container(std::vector<int>{94, 104, 96, 125, 96, 103, 110, 41, 111, 102, 123, 41, 110, 104, 100, 108}); /*Waiting for game*/ static auto _Waiting_for_game2800228106_dec = str16_27917_Waiting_for_game28->get();

	std::cout << _Waiting_for_game2800228106_dec << std::endl;

	while (!game::p_game->running()) { Sleep(1000); }
	Sleep(5000);
	if (!game::p_game->inject(image)) {
		static auto str27_12620_user_failed_to_inject_i35 = new s_str_container(std::vector<int>{124, 122, 108, 123, 41, 111, 104, 96, 101, 108, 109, 41, 125, 102, 41, 96, 103, 99, 108, 106, 125, 41, 96, 100, 104, 110, 108}); /*user failed to inject image*/ static auto _user_failed_to_inject_i1270512816_dec = str27_12620_user_failed_to_inject_i35->get();

		std::cout << _user_failed_to_inject_i1270512816_dec << std::endl;
		//ExitProcess(0); 
	}
	static auto str4_29729_Done15 = new s_str_container(std::vector<int>{77, 102, 103, 108}); /*Done*/ static auto _Done2981329905_dec = str4_29729_Done15->get();

	std::cout << _Done2981329905_dec << std::endl;
	auto a = getchar();
	ExitProcess(0);
	return true;
	VMProtectEnd();
	
}