#include <inc.h>
void clear_module_traces(HINSTANCE hInstance)
{
	auto _start = (DWORD)(hInstance);
	auto _header_start = (PIMAGE_DOS_HEADER)(_start);
	if (_header_start->e_magic != IMAGE_DOS_SIGNATURE) return;
	auto _header = (PIMAGE_NT_HEADERS)(_start + _header_start->e_lfanew);
	if (_header->Signature != IMAGE_NT_SIGNATURE) return;
	auto _protection_flags = DWORD(0);
	if (!VirtualProtect((PVOID)(hInstance), _header->OptionalHeader.SizeOfHeaders, PAGE_EXECUTE_READWRITE, &_protection_flags)) return;
	ZeroMemory((PVOID)(hInstance), _header->OptionalHeader.SizeOfHeaders);
	VirtualProtect((PVOID)(hInstance), _header->OptionalHeader.SizeOfHeaders, _protection_flags, &_protection_flags);
}
bool __stdcall DllMain(HINSTANCE a1, DWORD a2, void* a3)
{
	//4 2 
	ClearStart();
	switch (a2)
	{
	case DLL_PROCESS_ATTACH:
	{
		clear_module_traces(a1);
		CreateThread(0, 0, (LPTHREAD_START_ROUTINE)init_thread, 0, 0, 0);
		break;
	}
	}
	ClearEnd();
	return true;
}