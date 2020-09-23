#include <inc.h>
void sys::c_roar_bot::load(std::string p)
{
	auto parse_position = [&](std::string l) -> sdk::util::c_vector3
	{
		auto line = l;
		sdk::util::c_vector3 res; res.clear(); res.pause = 0;

		while (line.size() > 0)
		{
			if (res.pause != 0) break; /*finish*/
			/*parse all 4 vector parts*/
			auto pos = line.find("(");

			if (!pos) break; 
			line.erase(0, pos + 1);
			pos = line.find(")");

			auto cpy = line;
			cpy.erase(pos, cpy.size()); /*cpy only contains the seperated string now*/

			line.erase(0, pos); /*line now has the seperated part removed from it*/

			auto flt = std::stof(cpy);

			if (res.x == 0) res.x = flt;
			else if (res.y == 0) res.y = flt;
			else if (res.z == 0) res.z = flt;
			else if (res.pause == 0) res.pause = flt;
		}

		return res;
	};
	auto parse_storage = [&](std::string l) -> s_path_script
	{
		auto line = l;
		s_path_script res;
		//"(sp){" << obj.pos.x << "}{" << obj.pos.y << "}{" << obj.pos.z << "}{" << obj.npc_name << "}{" << obj.script << "}"
		while (line.size() > 0)
		{
			if (res.script.size() > 0) break;/*done parsing*/

			if (res.pos.hasZero()) /*parse pos vec3*/
			{
				auto pos = line.find("{");
				line.erase(0, pos + 1); /*delete header and first {*/

				pos = line.find("}");

				auto cpy = line;
				cpy.erase(pos, cpy.size());/*only leaves var behind*/

				line.erase(0, pos); /*erase current vec entry*/

				auto var = std::stof(cpy);

				if (res.pos.x == 0) res.pos.x = var;
				else if (res.pos.y == 0) res.pos.y = var;
				else if (res.pos.z == 0) res.pos.z = var;
			}
			else if (res.npc_name.empty()) /*parse npc name from script*/
			{
				/* "NONE" = no npc*/
				auto pos = line.find("{");
				line.erase(0, pos + 1);

				pos = line.find("}");

				auto cpy = line;
				cpy.erase(pos, cpy.size()); /*erase all after npc name*/

				line.erase(0, pos); /*delete npc name from line*/

				res.npc_name = cpy;
			}
			else if (res.script.empty()) /*parse lua script line*/
			{
				/* "NONE" = no scr*/
				auto pos = line.find("{");
				line.erase(0, pos + 1);

				pos = line.find("}");

				auto cpy = line;
				cpy.erase(pos, cpy.size()); /*erase all after scr*/

				line.erase(0, pos); /*delete scr from line*/

				res.script = cpy;
			}
		}
		res.pause = 0.1f;
		res.pos.pause = 0.1f;
		return res;
	};
	auto parse_item = [&](std::string l) -> int
	{
		auto line = l;
		auto pos = line.find("(");

		line.erase(0, pos + 1);

		pos = line.find(")");
		line.erase(pos, line.size());

		return std::stoi(line);
	};
	this->grind.clear();
	std::ifstream v(p); std::string s;
	if (!v.is_open()) return;
	while (std::getline(v, s))
	{
		if (s.empty()) continue;
		if (strstr(s.c_str(), "(sp)"))
		{
			auto res = parse_storage(s);
			if (res.script != "NONE") { res.special_event = 1; res.pause = 1.2f; }
			if (res.npc_name != "NONE") { res.special_event = 1; res.pause = 8.0f; }
			if (res.pos.valid() && res.script.size() > 0) { this->store.push_back(res); continue; }
		}
		if (strstr(s.c_str(), "[gp]"))
		{
			/*grinding path line would look like __gp__1234_12__1234_12__28973007_dec */
			/*                                    head   x         y        z     pause  */
			auto res = parse_position(s);
			if (res.valid()) { this->grind.push_back(res); continue; }
			else { v.close(); return; }
			continue;
		}
		if (strstr(s.c_str(), "[item]"))
		{
			/*item whitelist line would look like __item__1234_1643616536_dec */
			/*                                      head  item idx*/
			auto res = parse_item(s);
			if (res != 0) { this->allowed_sell_items.push_back(res); continue; }
			else v.close(); return;
			continue;
		}
	}
	v.close();
	sdk::util::log->add(std::string("done load"), sdk::util::e_info, true);
}
void sys::c_roar_bot::work(uint64_t s)
{
	this->self = s;
}
sys::c_roar_bot* sys::roar_bot;