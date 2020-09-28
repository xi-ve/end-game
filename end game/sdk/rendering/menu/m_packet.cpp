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

	bool Combo(const char* label, int* currIndex, std::vector<std::string>& values)
	{
		if (values.empty()) { return false; }
		return Combo(label, currIndex, vector_getter,
			static_cast<void*>(&values), values.size());
	}
	void Button_new(const char* label, int& value, const char* tooltip = "")
	{
		if (value) { ImGui::TextColored(ImVec4(0, 255, 0, 255), "[ON ]"); ImGui::SameLine(); if (ImGui::SmallButton(label)) value = !value; }
		else { ImGui::TextColored(ImVec4(255, 0, 0, 255), "[OFF]"); ImGui::SameLine(); if (ImGui::SmallButton(label)) value = !value; }
		if (tooltip != "") if (ImGui::IsItemHovered()) ImGui::SetTooltip(tooltip);
	}
	void Button_new_b(const char* label, bool& value, const char* tooltip = "")
	{
		if (value) { ImGui::TextColored(ImVec4(0, 255, 0, 255), "[ON ]"); ImGui::SameLine(); if (ImGui::SmallButton(label)) value = !value; }
		else { ImGui::TextColored(ImVec4(255, 0, 0, 255), "[OFF]"); ImGui::SameLine(); if (ImGui::SmallButton(label)) value = !value; }
		if (tooltip != "") if (ImGui::IsItemHovered()) ImGui::SetTooltip(tooltip);
	}
}
template <typename Out>
static void split(const std::string& s, char delim, Out result)
{
	std::istringstream iss(s);
	std::string item;
	while (std::getline(iss, item, delim))
	{
		*result++ = item;
	}
}
static std::vector<std::string> split(const std::string& s, char delim)
{
	std::vector<std::string> elems;
	split(s, delim, std::back_inserter(elems));
	return elems;
}
ByteBuffer sdk::menu::c_m_packet::convert_char_to_buff(const char* charbuff)
{
	ByteBuffer p;
	auto copy = std::string(charbuff);
	auto split_to = split(copy, 0x20);

	for (auto obj : split_to)
	{
		unsigned long hex_value = std::strtoul(obj.c_str(), 0, 16);
		if (hex_value != 0) p.put(hex_value);
		else p.putEmptyBytes(1);
	}
	return p;
}
std::string sdk::menu::c_m_packet::get_packet_info(sdk::menu::s_packet packet)
{
	std::stringstream log;
	for (auto c = 0; c < packet.size; c++)
	{
		if (packet.data.buf[c] <= 15) log << std::dec << "0";
		log << std::hex << (int)packet.data.buf[c] << " " << std::dec;
	}
	return log.str();
}
void sdk::menu::c_m_packet::reset_packets()
{
	this->packets.clear();
}
std::vector<sdk::menu::s_packet> sdk::menu::c_m_packet::get_all_packets()
{
	return this->packets;
}
std::vector<std::string> sdk::menu::c_m_packet::get_all_packets_names()
{
	std::vector<std::string> list;
	for (auto obj : this->packets)
	{
		list.push_back(obj.text_name);
	}
	return list;
}
sdk::menu::s_packet sdk::menu::c_m_packet::get_packet(short opcode)
{
	for (auto obj : this->packets) if (obj.opcode == opcode) return obj;
	return {};
}
sdk::menu::s_packet sdk::menu::c_m_packet::get_packet(int size)
{
	for (auto obj : this->packets) if (obj.size == size) return obj;
	return {};
}
sdk::menu::s_packet sdk::menu::c_m_packet::get_packet(std::string text_desc)
{
	for (auto obj : this->packets) if (strstr(obj.text_name.c_str(), text_desc.c_str())) return obj;
	return {};
}
bool sdk::menu::c_m_packet::register_packet(uint64_t ptr, short packet_size)
{
	if (this->packets.size())
	{
		for (auto&& obj : this->packets) if (obj.size == packet_size)
		{
			auto tmp = ptr;
			__int16* a = (__int16*)tmp;
			auto b = *a;
			if (obj.opcode != b) continue;
			auto packet = sdk::menu::s_packet(b, packet_size, ptr);
			obj = packet;
			return 1;
		}/*overwrite data of existing packet!*/
	}
	auto tmp = ptr;
	__int16* a = (__int16*)tmp;
	auto b = *a;
	auto packet = sdk::menu::s_packet(b, packet_size, ptr);
	if (!packet.data.size()) return 0;
	this->packets.push_back(packet);
	return 1;
}
void sdk::menu::c_m_packet::work(uint64_t a1, uint16_t a2, uint8_t a3, uint8_t a4, uint64_t a5, const CHAR* a6)
{
	if (!a1 || !a2 || !a5) return;
	this->register_packet(a1, a2);
}
void sdk::menu::c_m_packet::work_ui()
{
	ImGui::SetNextWindowSizeConstraints(ImVec2(100, 100), ImVec2(750, 450));
	ImGui::Begin("packet-editor", 0, ImGuiWindowFlags_::ImGuiWindowFlags_AlwaysAutoResize);
	//
	auto packets = this->get_all_packets_names();
	if (packets.size())
	{
		ImGui::Text("send packet by manual input");

		ImGui::InputText("packet body  ", packet_body, 24000);
		ImGui::InputInt("packet opcode", &packet_opcode);
		ImGui::InputInt("packet size  ", &packet_size);

		if (ImGui::Button("assemble-resign and send packet"))
		{
			auto buf = this->convert_char_to_buff(packet_body);

			auto time_min = GetTickCount64() - 60000;
			auto time_max = GetTickCount64() + 60000;

			auto offset_time = 0;

			/*timing scanner*/
			if (!offset_time)
			{
				for (auto c = 0; c < buf.buf.size(); c++)
				{
					auto as_uulong = *(uint64_t*)((uint64_t)&buf.buf + c);
					if (as_uulong >= time_min && as_uulong <= time_max)
					{
						offset_time = c;
						break;
					}
				}
			}

			if (offset_time)
			{
				buf.putLong(GetTickCount64(), offset_time);
				//utils::cfg->cheat_log.push_back(std::string("(assemble) resigning time at:").append(std::to_string(offset_time)));
			}

			fn::send_packet(buf, packet_opcode, packet_size);
		}

		ImGui::Separator();
		selected_packet = 0;
		ImGui::Combo("packets captured", &selected_packet, packets);

		auto packet = this->get_packet(packets[selected_packet]);
		auto packet_data = this->get_packet_info(packet);

		ImGui::Text("selected packet data:");
		if (ImGui::Button("copy cont"))
		{
			OpenClipboard(lib::d3d11->h); EmptyClipboard();
			auto hg = GlobalAlloc(GMEM_MOVEABLE, packet_data.size() + 1);
			if (!hg) { CloseClipboard(); return; }
			memcpy(GlobalLock(hg), packet_data.c_str(), packet_data.size() + 1);
			GlobalUnlock(hg); SetClipboardData(CF_TEXT, hg); CloseClipboard(); GlobalFree(hg);
		}
		ImGui::SameLine();
		if (ImGui::Button("replay+sign"))
		{
			if (packet.timestamp_pos)
			{
				packet.data.putLong(GetTickCount64(), packet.timestamp_pos);
				//utils::cfg->cheat_log.push_back(std::string("(assemble) resigning time at:").append(std::to_string(packet.timestamp_pos)));
			}

			fn::send_packet(packet.data, packet.opcode, packet.size);
			//utils::cfg->cheat_log.push_back(std::string("(packet-manager) replayed packet!"));
		}
		ImGui::Text(std::string("size    (").append(std::to_string(packet.size)).append(")").c_str());
		ImGui::Text(std::string("code    (").append(std::to_string(packet.opcode)).append(")").c_str());
		ImGui::Text(std::string("pointer (").append(sdk::util::log->as_hex(packet.ptr)).append(")").c_str());
		if (packet.timestamp_pos != 0) ImGui::Text(std::string("time at (").append(std::to_string(packet.timestamp_pos)).append(")").c_str());

		if (packet.data.buf.size() < 18) ImGui::Text(std::string("content (").append(packet_data).append(")").c_str());
		else
		{
			auto part_size = packet_data.size() / (packet_data.size() / 18);
			int i = 0;
			std::string to_prnt = "";
			ImGui::Text("content :");
			for (i = 0; i < packet_data.size(); i++)
			{
				if (i % part_size == 0) { ImGui::Text(to_prnt.c_str()); to_prnt.clear(); }
				to_prnt.push_back(packet_data[i]);
				if (i >= packet_data.size()) { ImGui::Text(to_prnt.c_str()); to_prnt.clear(); }
			}
		}
	}

	//
	ImGui::End();
}
sdk::menu::c_m_packet* sdk::menu::m_packet;
