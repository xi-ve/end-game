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
void sys::c_lua_q::useitem(int s)
{
	for (auto a : sdk::player::player_->inventory_items)
	{
		if (a.item_slot == s && a.count != 0)
		{
			this->add(std::string("inventoryUseItem(CppEnums.ItemWhereType.eInventory, ").append(std::to_string(a.item_slot + 2)).append(", 0, true)"));
			return;
		}
	}
}
void sys::c_lua_q::work()
{
	if (this->lua_queue.empty() || this->lua_state == NULL) return;
	auto b = this->lua_queue.back();
	if (b.empty()) { this->lua_queue.pop_back(); return; }
	//sdk::util::log->add(std::string("running lua:").append(b), sdk::util::e_info, true);
	fn::o_lua_dobuffer(this->lua_state, b.c_str());
	this->lua_queue.pop_back();
}
sys::c_lua_q* sys::lua_q;
