#include <inc.h>
void __stdcall sys::tp_thread_gen1()
{
	while (1)
	{
		if (!cursor_tp->_doneTp)
		{
			auto _self = *(uint64_t*)(core::offsets::actor::actor_self);
			if (!_self || !cursor_tp->_startPos.valid() || !cursor_tp->_endPos.valid()) return;

			auto c_x = cursor_tp->_startPos.x;
			auto c_y = cursor_tp->_startPos.y;
			auto c_z = cursor_tp->_startPos.z;

			while (true)
			{
				auto d_x = cursor_tp->_endPos.x - c_x;
				auto d_y = cursor_tp->_endPos.y - c_y;
				auto d_z = cursor_tp->_endPos.z - c_z;
				if (d_x != 0 && d_y != 0 && d_z != 0)
				{
					float _jmdDst = 3.5f;

					auto dst = sqrt(pow(d_x, 2) + pow(d_y, 2) + pow(d_z, 2));
					auto mul = 1.f;
					if (dst > _jmdDst) mul = _jmdDst / dst;

					auto additive_X = (d_x * mul);
					auto additive_y = (d_y * mul);
					auto additive_z = (d_z * mul);

					c_x += additive_X;
					c_y += additive_y;
					c_z += additive_z;


					//cursor_tp->_poslist.push_back(sdk::util::c_vector3(c_x * 100, 60000, c_z * 100));
					//cursor_tp->send_pos_tp(sdk::util::c_vector3(c_x * 100, 60000, c_z * 100), _self);
					sys::cursor_tp->set_pos(_self, sdk::util::c_vector3(c_x, c_y, c_z));
				}
				else
				{
					//packcursor_tp_tp->_poslist.push_back(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100) + 600, pack_tp->_endPos.z * 100));
					//cursor_tp->send_pos_tp(sdk::util::c_vector3(pack_tp->_endPos.x * 100, (pack_tp->_endPos.y * 100) + 600, pack_tp->_endPos.z * 100), _self);
					sys::cursor_tp->set_pos(_self, cursor_tp->_endPos);

					cursor_tp->_doneTp = 1;
					cursor_tp->_endPos.clear();
					cursor_tp->_startPos.clear();
					cursor_tp->_setTp = 0;

					ExitThread(0);
					break;
				}
			}
		}
		else break;
	}
}

void sys::c_cursor_tp::work(uint64_t s)
{
	if (!_doneTp) return;
	static auto tpgen2 = sys::config->gvar("packet", "iteleport_gen2");
	if (tpgen2->iv)
	{
		sys::pack_tp->teleport_to_cursor(s);
		return;
	}

	auto x = *(float*)(s + core::offsets::actor::actor_cursor_3d_x);
	auto y = *(float*)(s + core::offsets::actor::actor_cursor_3d_y);
	auto z = *(float*)(s + core::offsets::actor::actor_cursor_3d_z);
	auto cv = sdk::util::c_vector3(x, y, z);

	auto pos = sdk::player::player_->gpos(s);
	_startPos = sdk::util::c_vector3(pos.x / 100, pos.y / 100, pos.z / 100);
	_endPos = sdk::util::c_vector3(cv.x / 100, cv.y / 100, cv.z / 100);
	_doneTp = 0;
	_setTp = 1;
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)tp_thread_gen1, 0, 0, 0);
}
void sys::c_cursor_tp::set_pos(uint64_t s, sdk::util::c_vector3 p)
{
	auto c = *(uint64_t*)(s + core::offsets::actor::actor_char_ctrl);
	if (!c) return;
	auto cs = *(uint64_t*)(c + core::offsets::actor::actor_mov_base);
	if (!cs) return;
	auto m = *(uint64_t*)(cs + core::offsets::actor::actor_networked_move);
	if (!m) return;
	*(float*)(m + core::offsets::actor::actor_mov_cx) = p.x;
	*(float*)(m + core::offsets::actor::actor_mov_cy) = p.y;
	*(float*)(m + core::offsets::actor::actor_mov_cz) = p.z;
}
sys::c_cursor_tp* sys::cursor_tp;