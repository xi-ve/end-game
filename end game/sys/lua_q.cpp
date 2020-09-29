#include <inc.h>
void* sys::c_lua_q::glp()
{
	return this->lua_state;
}
void sys::c_lua_q::sparam(void* a)
{
	this->lua_state = a;;
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
	fn::o_lua_dobuffer(this->lua_state, b.c_str());
	this->lua_queue.pop_back();
}
sys::c_lua_q* sys::lua_q;
