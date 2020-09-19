#include <inc.h>
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
	ImGui::Begin("28802-dev", 0, ImGuiWindowFlags_::ImGuiWindowFlags_NoResize | ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize);
	{
		ImGui::Text(std::string("actors:").append(std::to_string(sdk::player::player_->actors.size())).c_str());
		auto self = *(uint64_t*)(core::offsets::actor::actor_self);
		if (self != NULL)
		{
			auto self_pos = sdk::player::player_->gpos(self, true);
			ImGui::Text(std::string("x:").append(std::to_string(self_pos.x)).c_str());
			ImGui::Text(std::string("y:").append(std::to_string(self_pos.y)).c_str());
			ImGui::Text(std::string("z:").append(std::to_string(self_pos.z)).c_str());
			if (sys::pack_tp->_poslist.size())
			{
				ImGui::Text(std::string("0x:").append(std::to_string(sys::pack_tp->_poslist.front().x)).c_str());
				ImGui::Text(std::string("0y:").append(std::to_string(sys::pack_tp->_poslist.front().y)).c_str());
				ImGui::Text(std::string("0z:").append(std::to_string(sys::pack_tp->_poslist.front().z)).c_str());

				ImGui::Text(std::string("sx:").append(std::to_string(sys::pack_tp->_startPos.x)).c_str());
				ImGui::Text(std::string("sy:").append(std::to_string(sys::pack_tp->_startPos.y)).c_str());
				ImGui::Text(std::string("sz:").append(std::to_string(sys::pack_tp->_startPos.z)).c_str());
			}

		}

		ImGui::End();
	}
	//
	ImGui::Render();
}
void sdk::menu::c_menu::sactive()
{
	this->menu_active = !this->menu_active;
}
sdk::menu::c_menu* sdk::menu::menu;