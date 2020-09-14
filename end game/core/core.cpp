#include <inc.h>
bool __stdcall DllMain(HINSTANCE a1, DWORD a2, void* a3)
{
	switch (a2)
	{
	case DLL_PROCESS_ATTACH:
	{
		DisableThreadLibraryCalls(a1);
		CreateThread(0, 0, (LPTHREAD_START_ROUTINE)init_thread, 0, 0, 0);
		break;
	}
	}
	return true;
}