#include <inc.h>

void sys::c_pack_tp::set_tp()
{
	this->teleport_to_marker();
}
sys::c_pack_tp* sys::pack_tp;

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
					pack_tp->_poslist.push_back(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100) + 400, pack_tp->_endPos.z * 100));
					pack_tp->send_pos_tp(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100) + 400, pack_tp->_endPos.z * 100), _self);

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
