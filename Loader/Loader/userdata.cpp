#pragma once
#include "inc.h"

std::string userdata::get_val(std::string name)
{
	VMProtectBegin("get_val");
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
	VMProtectEnd();
}

bool userdata::del_val()
{
	VMProtectBegin("del_val");
	return RegDeleteTree(HKEY_LOCAL_MACHINE, "SOFTWARE\\28802");
	VMProtectEnd();
}

void userdata::set_val(std::string name, std::string value)
{
	VMProtectBegin("set_val");
	HKEY hKey;
	LONG nError = RegOpenKeyEx(HKEY_LOCAL_MACHINE, "SOFTWARE\\28802", NULL, KEY_ALL_ACCESS, &hKey);
	if (nError == ERROR_FILE_NOT_FOUND) nError = RegCreateKeyEx(HKEY_LOCAL_MACHINE, "SOFTWARE\\28802", NULL, NULL, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &hKey, NULL);
	RegSetValueExA(hKey, name.c_str(), 0, REG_SZ, (LPBYTE)value.c_str(), value.size());
	return;
	VMProtectEnd();
}
