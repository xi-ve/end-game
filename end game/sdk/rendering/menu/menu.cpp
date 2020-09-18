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