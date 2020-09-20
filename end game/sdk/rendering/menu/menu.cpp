#include <inc.h>
namespace ImGui
{
	static auto vector_getter = [](void* vec, int idx, const char** out_text)
	{
		auto& vector = *static_cast<std::vector<std::string>*>(vec);
		if (idx < 0 || idx >= static_cast<int>(vector.size())) { return false; }
		*out_text = vector.at(idx).c_str();
		return true;
	};

	bool Combo2(const char* label, int* currIndex, std::vector<std::string>& values)
	{
		if (values.empty()) { return false; }
		return Combo(label, currIndex, vector_getter,
			static_cast<void*>(&values), values.size());
	}
}
void sdk::menu::c_menu::tab(size_t Index, const char* Text, int height)
{
	static const size_t TabWidth = 100;
	static const size_t TabHeight = height;

	ImGui::PushID(Index);
	ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, 1);

	if (Index == 1)
		ImGui::SameLine(Index * (TabWidth + 5));
	else if (Index > 1)
		ImGui::SameLine(Index * (TabWidth + 5 - Index));

	if (ctab == Index)
		ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor(15, 15, 15));			// Color on tab open
	else
		ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor(30, 30, 30));			// Color on tab closed

	ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor(40, 40, 40));			// Color on mouse hover in tab
	ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor(35, 35, 35));			// Color on click tab

	if (ctab == Index) ImGui::PushStyleColor(ImGuiCol_Border, (ImVec4)ImColor(0, 255, 0, 255));
	else ImGui::PushStyleColor(ImGuiCol_Border, (ImVec4)ImColor(255, 0, 0, 255));

	if (ImGui::Button(Text, ImVec2(TabWidth, TabHeight)))	// If tab clicked
		ctab = Index;

	ImGui::PopStyleVar();
	ImGui::PopStyleColor(3);
	ImGui::PopID();
}
void sdk::menu::c_menu::work()
{
	ImGui_ImplDX11_NewFrame();
	//
	if (!this->was_setup)
	{
		
		ImGui::StyleColorsDark();
		this->was_setup = true;
	}
	if (!this->menu_active) return;

	ImGui::Begin("  28802  ", 0, ImGuiWindowFlags_::ImGuiWindowFlags_NoResize | ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize);
	{
		auto s = *(uint64_t*)(core::offsets::actor::actor_self);
		this->tab(0, "pack-fn"		, 18);
		this->tab(1, "pack-bypasses", 18);
		this->tab(2, "looting"		, 18);
		switch (this->ctab)
		{
		case 0://pack-fn
		{
			static auto iteleport_gen2 = sys::config->gvar("packet", "iteleport_gen2");
			ImGui::Checkbox("teleport-gen2", (bool*)&iteleport_gen2->iv);
			ImGui::Checkbox("teleport-setup", (bool*)&sys::pack_tp->get_packet_again);
			if (ImGui::Button("teleport-to-marker")) sys::pack_tp->teleport_to_marker();
			break;
		}
		case 1://pack-bypasses
		{
			static auto ibypass_trial = sys::config->gvar("packet", "ibypass_trial");
			ImGui::Checkbox("trial-escape-bypass", (bool*)&ibypass_trial->iv);
			break;
		}
		case 2://looting
		{			
			static auto iloot_enable = sys::config->gvar("loot", "ienable");
			static auto iloot_enable_filter = sys::config->gvar("loot", "ienable_filter");
			static auto grey = sys::config->gvar("auto_loot", "ipick_grey");
			static auto green = sys::config->gvar("auto_loot", "ipick_green");
			static auto blue = sys::config->gvar("auto_loot", "ipick_blue");
			static auto orange = sys::config->gvar("auto_loot", "ipick_orange");
			static auto yellow = sys::config->gvar("auto_loot", "ipick_yellow");
			ImGui::Checkbox("enable", (bool*)&iloot_enable->iv);
			ImGui::Checkbox("use-filter", (bool*)&iloot_enable_filter->iv);

			ImGui::Checkbox("pick-grey", (bool*)&grey->iv); ImGui::SameLine();
			ImGui::Checkbox("pick-green", (bool*)&green->iv);
			ImGui::Checkbox("pick-blue", (bool*)&blue->iv); ImGui::SameLine();
			ImGui::Checkbox("pick-orange", (bool*)&orange->iv);
			ImGui::Checkbox("pick-yellow", (bool*)&yellow->iv);
			if (s)
			{
				if (*(BYTE*)(s + core::offsets::actor::actor_can_play))
				{
					auto il = sdk::player::player_->ginv();
					if (il.size() > 2)
					{
						static auto selected_whitelist = 0;
						ImGui::Combo2("select-item", &selected_whitelist, il);
						if (ImGui::Button("add-item-to-whitelist")) sys::loot->add_whitelist(sdk::player::player_->gitm_by_name(il[selected_whitelist])); ImGui::SameLine();
						if (ImGui::Button("add-item-to-blacklist")) sys::loot->add_blacklist(sdk::player::player_->gitm_by_name(il[selected_whitelist]));
						if (ImGui::Button("clear-whitelist")) sys::loot->read_whitelist(); ImGui::SameLine();
						if (ImGui::Button("clear-blacklist")) sys::loot->read_blacklist();
					}
				}
			}
			break;
		}
		default: break;
		}
		ImGui::End();
	}

	//ImGui::Begin("packet-fn", 0, ImGuiWindowFlags_::ImGuiWindowFlags_NoResize | ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize);
	//{
	//	static auto ibypass_trial = sys::config->gvar("packet", "ibypass_trial");
	//	static auto iteleport_gen2 = sys::config->gvar("packet", "iteleport_gen2");
	//	static auto ientity_update = sys::config->gvar("debug", "ientity_update");
	//	static auto iloot_enable = sys::config->gvar("loot", "ienable");

	//	ImGui::Checkbox("Entity updates", (bool*)&ientity_update->iv);
	//	ImGui::Checkbox("Trial bypass", (bool*)&ibypass_trial->iv);
	//	ImGui::Checkbox("Loot toggle", (bool*)&iloot_enable->iv);

	//	ImGui::Checkbox("TGEN2", (bool*)&iteleport_gen2->iv); ImGui::SameLine();
	//	ImGui::Checkbox("Setup TGEN2", &sys::pack_tp->get_packet_again);
	//	if (iteleport_gen2->iv && !sys::pack_tp->get_packet_again) if (ImGui::Button("TGEN2 to marker")) sys::pack_tp->teleport_to_marker();

	//	//
	//	ImGui::Text(std::string("Proxies:").append(std::to_string(sdk::player::player_->actors.size())).c_str());
	//	ImGui::Text(std::string("DeadActors:").append(std::to_string(sdk::player::player_->corpses.size())).c_str());
	//	ImGui::Text(std::string("LastAct:").append(sdk::util::log->as_hex(sys::loot->last_ent)).c_str());

	//	ImGui::End();
	//}
	sdk::menu::m_packet->work_ui();
	//
	ImGui::Render();
}
void sdk::menu::c_menu::sactive()
{
	this->menu_active = !this->menu_active;
	if (!this->menu_active) sys::config->save();
}
sdk::menu::c_menu* sdk::menu::menu;