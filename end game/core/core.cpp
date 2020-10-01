#include <inc.h>
bool __stdcall DllMain(HINSTANCE a1, DWORD a2, void* a3)
{
	//4 2 
	ClearStart();
	switch (a2)
	{
	case DLL_PROCESS_ATTACH:
	{
		CreateThread(0, 0, (LPTHREAD_START_ROUTINE)init_thread, 0, 0, 0);
		break;
	}
	}
	ClearEnd();
	return true;
}