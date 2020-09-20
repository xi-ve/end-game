#include <inc.h>
void __stdcall sys::tp_thread()
{
	pack_tp->_poslist.clear();
	pack_tp->_poslist.push_back(pack_tp->_startPos.mult());
	while (1)
	{
		if (!pack_tp->_doneTp)
		{
			auto _self = *(uint64_t*)(core::offsets::actor::actor_self);
			if (!_self || !pack_tp->_startPos.valid() || !pack_tp->_endPos.valid()) return;

			auto c_x = pack_tp->_startPos.x;
			auto c_y = pack_tp->_startPos.y;
			auto c_z = pack_tp->_startPos.z;

			while (true)
			{
				auto d_x = pack_tp->_endPos.x - c_x;
				auto d_y = pack_tp->_endPos.y - c_y;
				auto d_z = pack_tp->_endPos.z - c_z;
				if (d_x != 0 && d_y != 0 && d_z != 0)
				{
					float _jmdDst = 8.f;

					auto dst = sqrt(pow(d_x, 2) + pow(d_y, 2) + pow(d_z, 2));
					auto mul = 1.f;
					if (dst > _jmdDst) mul = _jmdDst / dst;

					auto additive_X = (d_x * mul);
					auto additive_y = (d_y * mul);
					auto additive_z = (d_z * mul);

					c_x += additive_X;
					c_y += additive_y;
					c_z += additive_z;

					pack_tp->_poslist.push_back(sdk::util::c_vector3(c_x * 100, 60000, c_z * 100));
					pack_tp->send_pos_tp(sdk::util::c_vector3(c_x * 100, 60000, c_z * 100), _self);
				}
				else
				{
					pack_tp->_poslist.push_back(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100) + 600, pack_tp->_endPos.z * 100));
					pack_tp->send_pos_tp(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100) + 600, pack_tp->_endPos.z * 100), _self);

					pack_tp->_doneTp = 1;
					pack_tp->_endPos.clear();
					pack_tp->_startPos.clear();
					pack_tp->_setTp = 0;

					ExitThread(0);
					break;
				}
			}
		}
		else break;
	}
}
void __stdcall sys::tp_thread_rz()
{
	pack_tp->_poslist.clear();
	pack_tp->_poslist.push_back(pack_tp->_startPos.mult());
	while (1)
	{
		if (!pack_tp->_doneTp)
		{
			auto _self = *(uint64_t*)(core::offsets::actor::actor_self);
			if (!_self || !pack_tp->_startPos.valid() || !pack_tp->_endPos.valid()) return;

			auto c_x = pack_tp->_startPos.x;
			auto c_y = pack_tp->_startPos.y;
			auto c_z = pack_tp->_startPos.z;

			while (true)
			{
				auto d_x = pack_tp->_endPos.x - c_x;
				auto d_y = pack_tp->_endPos.y - c_y;
				auto d_z = pack_tp->_endPos.z - c_z;
				if (d_x != 0 && d_y != 0 && d_z != 0)
				{
					float _jmdDst = 8.f;

					auto dst = sqrt(pow(d_x, 2) + pow(d_y, 2) + pow(d_z, 2));
					auto mul = 1.f;
					if (dst > _jmdDst) mul = _jmdDst / dst;

					auto additive_X = (d_x * mul);
					auto additive_y = (d_y * mul);
					auto additive_z = (d_z * mul);

					c_x += additive_X;
					c_y += additive_y;
					c_z += additive_z;

					pack_tp->send_pos_tp(sdk::util::c_vector3(c_x * 100, c_y * 100, c_z * 100), _self);
				}
				else
				{
					pack_tp->send_pos_tp(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100), pack_tp->_endPos.z * 100), _self);

					pack_tp->_doneTp = 1;
					pack_tp->_endPos.clear();
					pack_tp->_startPos.clear();
					pack_tp->_setTp = 0;

					ExitThread(0);
					break;
				}
			}
		}
		else break;
	}
}

void sys::c_pack_tp::capture_packet(ByteBuffer buf, uint64_t pack, int size, int opcode)
{
	if (sys::pack_tp->get_packet_again && size <= 450 && size >= 300)
	{
		sys::pack_tp->x_pos.clear();
		auto self = *(uint64_t*)(core::offsets::actor::actor_self);
		if (!self) return;
		if (!sdk::player::player_->get<BYTE>(self, core::offsets::actor::actor_can_play)) return;
		auto pos = sdk::player::player_->gpos(self);
		auto t_min = GetTickCount64() - 5000;
		auto t_max = GetTickCount64() + 5000;
		for (auto c = 0; c < size; c++)
		{
			auto as_uulong = *(uint64_t*)((uint64_t)pack + c);
			if (as_uulong >= t_min && as_uulong <= t_max)
			{
				sys::pack_tp->time_signature = c;
				break;
			}
		}
		for (auto c = 0; c < size; c++)
		{
			auto as_flt = *(float*)((uint64_t)pack + c);
			if ((int)as_flt == (int)pos.x)
			{
				sys::pack_tp->x_pos.push_back(c);
			}
		}
		if (sys::pack_tp->x_pos.size() < 9) 
		{
			sys::pack_tp->x_pos.clear(); 
			return;
		}
		sys::pack_tp->packet_copy = buf;
		sys::pack_tp->packet_id = opcode;
		sys::pack_tp->get_packet_again = false;
		sdk::util::log->add(std::string("found packet:").append(std::to_string(opcode)).append(" pos count:").append(std::to_string(sys::pack_tp->x_pos.size())), sdk::util::e_info, true);
	}
}
sys::c_pack_tp* sys::pack_tp;