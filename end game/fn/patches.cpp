#include <inc.h>
void fn::c_patcher::patch(uint64_t a, uint64_t e, BYTE i)
{
	while (a < e)
	{
		WriteProcessMemory(GetCurrentProcess(), (void*)a, &i, 1, nullptr);
		a += 1;
	}
}
void fn::c_patcher::create_patches()
{
	ClearStart();
	this->patch(core::offsets::patch::walk_to_pos, core::offsets::patch::walk_to_pos + 7, 0x90);
	/**(BYTE*)(core::offsets::patch::walk_mouse) = 0xEB;
	*(BYTE*)(core::offsets::patch::walk_mouse + 1) = 0x63;
	*(BYTE*)(core::offsets::patch::walk_mouse + 2) = 0x90;
	*(BYTE*)(core::offsets::patch::walk_mouse + 3) = 0x90;
	*(BYTE*)(core::offsets::patch::walk_mouse + 4) = 0x90;
	*(BYTE*)(core::offsets::patch::walk_mouse + 5) = 0x90;*/
	//
	//*(BYTE*)(core::offsets::patch::window_focus_validity) = 0x0F;
	//*(BYTE*)(core::offsets::patch::window_focus_validity + 1) = 0x95;
	//*(BYTE*)(core::offsets::patch::window_focus_validity + 2) = 0xC0;
	ClearEnd();
}
fn::c_patcher* fn::patcher;