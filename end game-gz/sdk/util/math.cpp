#include <inc.h>
sdk::util::c_vector3 sdk::util::c_math::front(uint64_t s, float h, float d)
{
	auto controller = *(uint64_t*)(s + core::offsets::actor::actor_char_ctrl);
	if (!controller) return {};
	auto c_base = *(uint64_t*)(controller + 0x10);
	if (!c_base) return {};
	auto rot = *(float*)(c_base + 0x43C);
	if (!rot) return {};
	auto fp = sdk::player::player_->gpos(s);
	auto xr = (std::sin(rot) * -1);
	auto zr = (std::cos(rot) * -1);
	return sdk::util::c_vector3(fp.x + (d*xr), fp.y + h, fp.z + (d*zr));
}
float sdk::util::c_math::gdst_3d(c_vector3 f, c_vector3 t)
{
	auto a = f.x - t.x; auto b = f.y - t.y; auto c = f.z - t.z;
	return sqrtf(a * a + b * b + c * c);
}
float sdk::util::c_math::gdst_2d(c_vector3 f, c_vector3 t)
{
	auto a = f.x - t.x; auto c = f.z - t.z;
	return sqrtf(a * a + c * c);
}
float sdk::util::c_math::gdst_1d(float f, float t)
{
	auto a = f - t;
	return sqrtf(a * a);
}
bool sdk::util::c_math::w2s(c_vector3 p, c_vector3& r)
{
	auto gf = [&](uint64_t p) -> float
	{
		return *(float*)(p);
	};
	auto start = core::offsets::cl::camera_matrice;
	auto _0 = c_4f(gf(start + 0), gf(start + 4), gf(start + 8), gf(start + 12));
	auto _1 = c_4f(gf(start + 16), gf(start + 20), gf(start + 24), gf(start + 28));
	auto _2 = c_4f(gf(start + 32), gf(start + 36), gf(start + 40), gf(start + 44));
	auto _3 = c_4f(gf(start + 48), gf(start + 52), gf(start + 56), gf(start + 60));
	auto _4x4 = _4x4_float(_0, _1, _2, _3);
	auto resulting_pos = new double[2];
	auto svx = FindWindowA("BlackDesertWindowClass", NULL);
	RECT rect; GetClientRect(svx, &rect);
	float w = 0.0f;
	resulting_pos[0] = _4x4.matrice[0][0] * p.x + _4x4.matrice[0][1] * p.y + _4x4.matrice[0][2] * p.z + _4x4.matrice[0][3];
	resulting_pos[1] = _4x4.matrice[1][0] * p.x + _4x4.matrice[1][1] * p.y + _4x4.matrice[1][2] * p.z + _4x4.matrice[1][3];
	w = (float)(_4x4.matrice[3][0] * p.x + _4x4.matrice[3][1] * p.y + _4x4.matrice[3][2] * p.z + _4x4.matrice[3][3]);
	if (w < 0.01f) return 0;
	auto invw = 1.0f / w;
	resulting_pos[0] *= invw; resulting_pos[1] *= invw;
	auto x = (float)rect.right / 2; auto y = (float)rect.bottom / 2;
	x += (float)(0.5 * resulting_pos[0] * rect.right + 0.5); y -= (float)(0.5 * resulting_pos[1] * rect.bottom + 0.5);
	resulting_pos[0] = x + rect.left; resulting_pos[1] = y + rect.top;
	r.x = (int)resulting_pos[0]; r.z = (int)resulting_pos[1];
	return true;
}
sdk::util::c_math* sdk::util::math;