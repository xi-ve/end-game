#include <inc.h>
void sys::c_key_q::bypass()
{
	auto fw = GetForegroundWindow();
	auto base = *(uint64_t*)(core::offsets::cl::client_base); if (!base) return;
	auto x1b0 = *(uint64_t*)(base + 0x1B0);					  if (!x1b0) return;
	*(byte*)(x1b0 + 0xd1) = 0; *(byte*)(x1b0 + 0xd2) = 0; *(byte*)(x1b0 + 0xda) = 0;
	auto wb = *(uint64_t*)(core::offsets::patch::window_base);
	*(BYTE*)(wb + 0x1490) = 1;
	*(BYTE*)(base + 0x150) = 1;
	if (this->lh != fw)
	{
		this->lh = fw;
		auto& key_p = *((uint64_t*)(*((uint64_t*)(core::offsets::cl::client_base)) + 0x8));		
		fn::o_reset_input_class(key_p);
	}
}
void sys::c_key_q::add(s_key_input* k)
{
	this->key_queue.push_back(k);
}
void sys::c_key_q::rm()
{
	this->key_queue.pop_front();
}
void sys::c_key_q::rma()
{
	this->key_queue.clear();
}
void sys::c_key_q::work()
{
	if (this->key_queue.empty() || this->thread_working) return;
	auto f = this->key_queue.front();
	this->bypass();
	if (!f->n) CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sys::key_worker, (PVOID)f, 0, 0);
	else
	{
		uint64_t& input_adr = *((uint64_t*)(*((uint64_t*)(core::offsets::cl::client_base)) + 0x08));
		if (!input_adr) return;
		*((uint64_t*)((input_adr + 0x840) + (f->k[0] * 4))) = 1;
		if (GetTickCount64() > f->end_time)
		{			
			*((uint64_t*)((input_adr + 0x840) + (f->k[0] * 4))) = 0;
			delete f;
			this->key_queue.pop_back();
		}
	}
}
void __stdcall sys::key_worker(void* a)
{
	sys::key_q->thread_working = true;
	auto strc = (sys::s_key_input*)a;
	if (strc == NULL) return;
	auto& key_p = *((uint64_t*)(*((uint64_t*)(core::offsets::cl::client_base)) + 0x8));
	if (!key_p) return;
	while (1337 != 69420)
	{
		auto delay = strc->d;
		for (auto a : strc->k)
		{
			if (a == -1) continue;
			auto k = a;
			*((uint64_t*)((key_p + 0x840) + (k * 4))) = 1;
		}
		std::this_thread::sleep_for(std::chrono::milliseconds(delay));
		for (auto a : strc->k)
		{
			if (a == -1) continue;
			auto k = a;
			*((uint64_t*)((key_p + 0x840) + (k * 4))) = 0;
		}
		sys::key_q->rm();
		sys::key_q->thread_working = false;
		break;
	}
	
}
sys::c_key_q* sys::key_q;