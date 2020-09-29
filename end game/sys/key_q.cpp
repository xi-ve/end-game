#include <inc.h>
void sys::c_key_q::add(s_key_input* k)
{
	this->key_queue.push_back(k);
}
void sys::c_key_q::rm()
{
	this->key_queue.pop_front();
}
void sys::c_key_q::work()
{
	if (this->key_queue.empty() || this->thread_working) return;
	auto f = this->key_queue.front();
	this->thread_working = true;
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sys::key_worker, (PVOID)f, 0, 0);
}
void __stdcall sys::key_worker(void* a)
{
	auto strc = (sys::s_key_input*)a;
	if (strc == NULL) return;
	auto& key_p = *((uint64_t*)(*((uint64_t*)(core::offsets::cl::client_base)) + 0x8));
	if (!key_p) return;
	while (1337 != 69420)
	{
		auto delay = strc->d;
		for (auto a : strc->k)
		{
			auto k = a;
			*((uint64_t*)((key_p + 0x840) + (k * 4))) = 1;
		}
		std::this_thread::sleep_for(std::chrono::milliseconds(delay));
		for (auto a : strc->k)
		{
			auto k = a;
			*((uint64_t*)((key_p + 0x840) + (k * 4))) = 0;
		}
		sys::key_q->rm();
		sys::key_q->thread_working = false;
		break;
	}
	
}
sys::c_key_q* sys::key_q;