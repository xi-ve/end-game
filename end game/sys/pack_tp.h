#pragma once
#include <inc.h>
namespace sys
{
	extern void __stdcall tp_thread();
	class c_pack_tp
	{
		public:
		void send_packet(ByteBuffer p, int opc, int size)
		{
			if (param5 != 0) fn::f_packet_outbound(&p.buf[0], size, 1, 0, param5, "eee");
		}
		void send_pos_tp(sdk::util::c_vector3 pos, uint64_t self)
		{
			auto packet = packet_copy;
			/*fix tickcount*/
			packet.putLong(GetTickCount64(), time_signature);
			/*set up x*/
			for (auto obj : x_pos) packet.putFloat(pos.x, obj);
			/*set up y*/
			for (auto obj : x_pos) packet.putFloat(pos.y, obj + 4);
			/*set up z*/
			for (auto obj : x_pos) packet.putFloat(pos.z, obj + 8);
			/*send pack*/
			send_packet(packet, packet_id, packet.buf.size());
		}
		bool                 _doneTp = 0;
		bool                 _alt = 0;
		bool                 _setTp = 0;
		sdk::util::c_vector3             _startPos;
		sdk::util::c_vector3             _endPos;
		std::vector<sdk::util::c_vector3> _poslist;		

		void teleport_to_marker()
		{
			std::deque<sdk::util::c_vector3> pthv;

			auto scene_manager = *(uint64_t*)(core::offsets::cl::client_base);
			if (!scene_manager) return;
			auto path_scene = *(uint64_t*)(scene_manager + 0x18);
			if (!path_scene) return;
			auto path_scene_base = *(uint64_t*)(path_scene + 0x1a8);
			if (!path_scene_base) return;

			auto path_container = *(uint64_t*)(path_scene_base + 0x20);
			if (!path_container) return;
			auto path_is_set = *(float*)(path_container + 0xE0);
			if (path_is_set)
			{
				auto path_x100_base = *(uint64_t*)(path_container + 0x40);
				auto path_x100_end = *(uint64_t*)(path_container + 0x48);
				if (!path_x100_base) return;
				bool completed_read = 0; auto count = 0;
				while (!completed_read)
				{
					auto x = *(float*)(path_x100_base + count);
					if (!x)
					{
						count += 0x4;
						x = *(float*)(path_x100_base + count);
						if (!x) { completed_read = 1; break; }
					}
					count += 4;
					auto z = *(float*)(path_x100_base + count); count += 4;
					auto y = *(float*)(path_x100_base + count); count += 4;
					if ((path_x100_base + count) >= path_x100_end) { completed_read = 1; break; }
					pthv.push_back(sdk::util::c_vector3(x, y, z));
				}
			}
			else
			{
				sdk::util::log->add("no waypoint set");
				return;
			}
			//
			auto self = *(uint64_t*)(core::offsets::actor::actor_self);
			auto pos = sdk::player::player_->gpos(self);
			_startPos = sdk::util::c_vector3(pos.x / 100, pos.y / 100, pos.z / 100);
			_endPos = sdk::util::c_vector3(pthv.back().x / 100, pthv.back().z / 100, pthv.back().y / 100);
			_doneTp = 0;
			_setTp = 1;
			CreateThread(0, 0, (LPTHREAD_START_ROUTINE)tp_thread, 0, 0, 0);
			sdk::util::log->add("starting");
		}
	public:
		ByteBuffer packet_copy;
		std::vector<int> x_pos;
		int time_signature = 0;
		int packet_id = 0;
		bool get_packet_again = true;
		uint64_t param5;

		void set_tp();
	};
	extern c_pack_tp* pack_tp;
}