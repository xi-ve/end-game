#pragma once
#include <inc.h>

namespace sdk
{
	namespace menu
	{
		struct s_packet
		{
			s_packet(short id, short sz, uint64_t pt)
			{
				for (auto c = 0; c < sz; c++) data.put(*(uint8_t*)((uint64_t)pt + c));
				auto time_min = GetTickCount64() - 5000;
				auto time_max = GetTickCount64() + 5000;
				for (auto c = 0; c < sz; c++)
				{
					auto as_uulong = *(uint64_t*)((uint64_t)pt + c);
					if (as_uulong >= time_min && as_uulong <= time_max)
					{
						timestamp_pos = c;
						break;
					}
				}
				std::stringstream pack;
				pack << "Pack (" << id << ") (" << sz << ")";
				if (timestamp_pos) pack << " (" << timestamp_pos << ")";
				text_name = pack.str();
				opcode = id;
				size = sz;
				ptr = pt;
			};
			s_packet(short id, short sz, ByteBuffer buf)
			{
				std::stringstream pack;
				pack << "Pack (" << id << ") (" << sz << ")";
				text_name = pack.str();
				opcode = id;
				size = sz;
				data = buf;
			};
			s_packet()
			{
			}
			uint64_t			 ptr = 0;
			short				 opcode = 0;
			short				 size = 0;
			int                  timestamp_pos = 0;
			ByteBuffer			 data;
			std::string			 text_name = "";
		};
		class c_m_packet
		{
		public:
			char packet_body[2048];
			int selected_packet = 0;
			int packet_opcode = 1337;
			int packet_size = 420;
			std::vector<std::string> split(const std::string& str, int splitLength)
			{
				int NumSubstrings = str.length() / splitLength;
				std::vector<std::string> ret;

				for (auto i = 0; i < NumSubstrings; i++)
				{
					ret.push_back(str.substr(i * splitLength, splitLength));
				}

				// If there are leftover characters, create a shorter item at the end.
				if (str.length() % splitLength != 0)
				{
					ret.push_back(str.substr(splitLength * NumSubstrings));
				}


				return ret;
			}
			std::vector<s_packet>   packets;		/*hold all packets received by the game with their packet contents*/
			bool					register_packet(uint64_t ptr, short packet_size);
			void					reset_packets();/*this will reset the packet buffer*/
			std::vector<s_packet>   get_all_packets();
			/*returns the vector containing all registered packets*/
			std::vector<std::string>get_all_packets_names();
			/*returns a string vector with basic packet data used for the menu*/
			s_packet			    get_packet(short opcode);
			/*returns packet based on opcode match*/
			s_packet				get_packet(int   size);
			/*returns packet based on size match*/
			s_packet				get_packet(std::string text_desc);
			/*returns packet based on description match*/
			ByteBuffer				convert_char_to_buff(const char* charbuff);
			/*this can convert a char* with bytes to a ByteBuffer that is sendable*/
			std::string				get_packet_info(s_packet packet);
			/*gets the content of the packet as str in hex*/

			void					work(uint64_t a1, uint16_t a2, uint8_t a3, uint8_t a4, uint64_t a5, const CHAR* a6);
			void					work_ui();
		};
		extern c_m_packet* m_packet;
	}
}