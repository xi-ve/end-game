#include <inc.h>
void sys::c_lua_q::sparam(void* a, const char* b)
{
	this->lua_state = a; this->lua_base = b;
}
void sys::c_lua_q::add(std::string q)
{
	this->lua_queue.push_back(q);
}
void sys::c_lua_q::work()
{
	if (this->lua_queue.empty() || this->lua_state == NULL) return;
	auto b = this->lua_queue.back();
	if (b.empty()) { this->lua_queue.pop_back(); return; }
	sdk::util::log->add(std::string("running lua:").append(b), sdk::util::e_info, true);
	fn::o_lua_dobuffer(this->lua_state, b.c_str(), b.size(), this->lua_base);
}
sys::c_lua_q* sys::lua_q;
