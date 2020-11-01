#include <inc.h>
int sys::c_reconnect::is_reconnecting()
{
	auto uimgr = *(uint64_t*)(core::offsets::cl::ui_manager);
	if (!uimgr) return -1;
	auto panel_reconnect = *(uint64_t*)(uimgr + 0x3d8);
	if (!panel_reconnect) return -1;
	auto visible = *(BYTE*)(panel_reconnect + 0x239);
	if (visible == 0x8) return 1;
	return 0;
}
void sys::c_reconnect::work()
{
	if (!this->ienable)
	{
		auto str11_13931_reconnector23 = new sys::s_str_container(std::vector<int>{123, 108, 106, 102, 103, 103, 108, 106, 125, 102, 123}); /*reconnector*/
		auto str7_18536_ienable18 = new sys::s_str_container(std::vector<int>{96, 108, 103, 104, 107, 101, 108}); /*ienable*/
		this->ienable = sys::config->gvar(str11_13931_reconnector23->get(), str7_18536_ienable18->get());
		delete str11_13931_reconnector23;
		delete str7_18536_ienable18;
	}
	if (!this->ienable->iv) return;

	if (GetTickCount64() > this->execution) this->execution = GetTickCount64() + 500;
	else return;

	auto reconnecting = this->is_reconnecting();
	if (reconnecting == -1) return;

	auto alive = sdk::player::player_->alive();
	if (sys::roar_bot->dwork && reconnecting == 1 && !alive && !this->should_restart_roar)
	{
		this->should_restart_roar = true;
		sys::roar_bot->dwork = false;	
		this->wait_timer = 0;
		sys::roar_bot->load();
		return;
	}
	if (this->should_restart_roar && alive && reconnecting == 0)
	{
		if (!this->wait_timer) this->wait_timer = GetTickCount64() + 2500;
		else
		{
			if (GetTickCount64() > this->wait_timer)
			{
				this->did_walk = false;
				this->wait_timer = 0;
				this->should_restart_roar = false;
				sys::roar_bot->snear();
				sys::roar_bot->dwork = true;
				sdk::util::log->b("rcon done");
			}
			if (GetTickCount64() > this->wait_timer - 1000 && !this->did_walk)//fix cam
			{
				sys::key_q->add(new sys::s_key_input({ VK_LBUTTON }, 100));
				this->did_walk = true;
			}
		}
	}
}
sys::c_reconnect* sys::reconnect;