#include <inc.h>
void __stdcall sys::exchange()
{
	sys::gear_exchanger->done_exchange = false;
	auto arsha_chests = std::vector<int>();
	arsha_chests =
	{
		/*weapon chests for all classes*/
		617, 618, 621
	};
	auto arsha_items = std::vector<int>();
	arsha_items =
	{
		/*armor and acc.*/
		48291, 48292, 48294, 48296, 48343, 48346, 48340, 48348
	};
	auto arsha_weapons = std::vector<int>();
	arsha_weapons =
	{
		/*weapons*/
		/*archer*/	 48191, 48195, 48192,
		/*guardian*/ 35187, 48142, 48256,
		/*sorc*/     48149, 48241, 48150,
		/*zerker*/   48153, 48242, 48154,
		/*maewha*/   48161, 48162, 48247,
		/*warrior*/  48141, 48240,
		/*ranger*/   48145, 48146, 48243,
		/*lahn*/     48177, 48178, 48255,
		/*tamer*/    48157, 48158, 48244,
		/*shai*/	 63232, 63697, 34649,
		/*striker*/  48173, 48174, 48253,
		/*musa*/     48246,
		/*mystic*/   48254,
		/*valk*/     48245,
		/*kuno*/     48166, 48249,
		/*ninja*/    48169, 48248,
		/*dk*/       48172, 48252,
		/*witch*/    48165, 48250,
		/*witcher*/  48251
	};
	std::vector<sys::s_exchange> to_ungear = {};
	std::vector<sys::s_exchange> to_ungear2 = {};
	std::vector<sys::s_exchange> to_ungear3 = {};
	auto self = *(uint64_t*)(core::offsets::actor::actor_self);
	auto is_arsha = [&](uint64_t adr, byte slot) -> bool
	{
		auto id = *(WORD*)(self + adr);
		if (id < 1 || id == 0xFFFF) return 0;
		for (auto obj : arsha_items) if (obj == id)
		{
			to_ungear.emplace_back(slot, self + adr, id);
			to_ungear2.emplace_back(slot, self + adr, id);
			to_ungear3.emplace_back(slot, self + adr, id);
			return 1;
		}
		for (auto obj : arsha_weapons) if (obj == id)
		{
			to_ungear.emplace_back(slot, self + adr, id);
			to_ungear2.emplace_back(slot, self + adr, id);
			to_ungear3.emplace_back(slot, self + adr, id);
			return 1;
		}
		return 0;
	};
	int stage = 0;
	ULONGLONG execution = 0;
	int arsha_box_slot = -1;//so we can check if it was openend
	while (true)
	{
		if (execution > GetTickCount64()) continue;
		switch (stage)
		{
		case 0://filter real items from pool
		{
			is_arsha(core::offsets::actor::eq_dur_main_weapon, 0);
			is_arsha(core::offsets::actor::eq_dur_awak, 29);
			is_arsha(core::offsets::actor::eq_dur_sub_weapon, 1);
			is_arsha(core::offsets::actor::eq_dur_ear1, 10);
			is_arsha(core::offsets::actor::eq_dur_ear2, 11);
			is_arsha(core::offsets::actor::eq_dur_armor, 3);
			is_arsha(core::offsets::actor::eq_dur_helmet, 6);
			is_arsha(core::offsets::actor::eq_dur_neck, 7);
			is_arsha(core::offsets::actor::eq_dur_gloves, 4);
			is_arsha(core::offsets::actor::eq_dur_shoes, 5);
			is_arsha(core::offsets::actor::eq_dur_belt, 12);
			is_arsha(core::offsets::actor::eq_dur_ring1, 8);
			is_arsha(core::offsets::actor::eq_dur_ring2, 9);
			stage++;
			execution = GetTickCount64() + 50;
			break;
		}
		case 1://uneq the items
		{
			if (to_ungear.empty())
			{
				stage++;
				break;
			}
			auto cur = to_ungear.back();
			auto eitm = *(WORD*)(cur.adr);
			if (eitm < 1 || eitm == 0xFFFF)
			{
				to_ungear.pop_back();
			}
			else
			{
				sys::gear_exchanger->f_unequip(cur.slot);
			}
			execution = GetTickCount64() + 100;
			break;
		}
		case 2://delete ungeared items
		{
			if (to_ungear2.empty())
			{
				//sdk::util::log->b("no items left to delete");
				stage++;
				break;
			}
			auto cur = to_ungear2.back();
			auto has_item = false; int slot = 0;
			for (auto a : sdk::player::player_->inventory_items) if (a.item_index == cur.item) { has_item = true; slot = a.item_slot + 2; break; }
			if (has_item)
			{
				auto key = *(int*)(self + core::offsets::actor::actor_proxy_key);
				sys::gear_exchanger->f_delete_item(key, 0, slot, 1);
				execution = GetTickCount64() + 500;
				break;
			}
			else
			{
				to_ungear2.pop_back();
				execution = GetTickCount64() + 100;
			}
			break;
		}
		case 3://open arsha box
		{
			if (arsha_box_slot == -1)
			{
				for (auto a : sdk::player::player_->inventory_items) if (a.item_index == 946) { arsha_box_slot = a.item_slot; break; }
				if (arsha_box_slot == -1)
				{
					//sdk::util::log->b("no arsha box in inv found, exiting");
					ExitProcess(0);
				}
				else
				{
					sys::lua_q->useitem(arsha_box_slot);
					execution = GetTickCount64() + 100;
					break;
				}
			}
			else
			{
				auto has_slot_still = false;
				for (auto a : sdk::player::player_->inventory_items) if (a.item_slot == arsha_box_slot && a.count > 0) has_slot_still = true;
				if (has_slot_still)
				{
					sys::lua_q->useitem(arsha_box_slot);
					execution = GetTickCount64() + 100;
					break;
				}
				else
				{
					//sdk::util::log->b("used arsha box");
					stage++;
					execution = GetTickCount64() + 100;
				}
			}
			break;
		}
		case 4://use sub chests
		{
			auto has_sub_chest = false; int slot = -1;
			for (auto a : sdk::player::player_->inventory_items)
			{
				for (auto b : arsha_chests)
				{
					if (a.item_index == b)
					{ 
						has_sub_chest = true; 
						slot = a.item_slot;
						break;
					}
				}
				if (has_sub_chest) break;
			}
			if (has_sub_chest)
			{
				sys::lua_q->useitem(slot);
				execution = GetTickCount64() + 100;
				break;
			}
			else
			{
				//sdk::util::log->b("used sub arsha boxes");	
				stage++;
				execution = GetTickCount64() + 100;
			}
			break;
		}
		case 5://equip gear we need
		{
			auto has_item_to_equip = false; int slot = -1;
			sdk::player::player_->update_inventory(self);
			for (auto a : sdk::player::player_->inventory_items)
			{
				for (auto b : to_ungear3)
				{
					if (a.item_index == b.item)
					{
						has_item_to_equip = true;
						slot = a.item_slot;
						break;
					}
				}

				if (has_item_to_equip) break;
			}
			if (has_item_to_equip)
			{
				//sdk::util::log->b("equipping slot %i", slot);
				sys::lua_q->useitem(slot);
				execution = GetTickCount64() + 100;
			}
			else
			{
				//sdk::util::log->b("no items left to equip");
				stage++;
				execution = GetTickCount64() + 100;
			}
			break;
		}
		case 6://check for remaining items and nuke them
		{
			auto has_item_to_delete = false; int slot = -1;
			for (auto a : sdk::player::player_->inventory_items)
			{
				for (auto b : arsha_items) if (b == a.item_index)
				{
					has_item_to_delete = true;
					slot = a.item_slot +2;
					break;
				}
				for (auto b : arsha_weapons) if (b == a.item_index)
				{
					has_item_to_delete = true;
					slot = a.item_slot +2;
					break;
				}
				if (a.item_index == 622 || a.item_index == 623)
				{
					has_item_to_delete = true;
					slot = a.item_slot +2;
					break;
				}
				if (has_item_to_delete) break;
			}
			if (has_item_to_delete)
			{
				auto key = *(int*)(self + core::offsets::actor::actor_proxy_key);
				sys::gear_exchanger->f_delete_item(key, 0, slot, 1);
				execution = GetTickCount64() + 500;
			}
			else
			{
				//sdk::util::log->b("deleted remaining items");
				stage++;
				execution = GetTickCount64() + 100;
			}
			break;
		}
		case 7:
		{
			//sdk::util::log->b("done swap");
			sys::gear_exchanger->thread_is_working = false;
			sys::gear_exchanger->done_exchange = true;
			ExitThread(0);
		}
		default:break;
		}
	}
}
bool sys::c_gear_exchanger::work()
{
	if (this->thread_is_working) return false;
	this->thread_is_working = true;
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)sys::exchange, 0, 0, 0);
	return true;
}
sys::c_gear_exchanger* sys::gear_exchanger;
