#include <inc.h>
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
	auto gf = [&](uint64_t p) -> auto
	{
		return *(float*)(p);
	};
	auto s = core::offsets::cl::camera_matrice;
	auto _0 = sdk::util::c_4f(gf(s + 0), gf(s + 4), gf(s + 8), gf(s + 12));
	auto _1 = sdk::util::c_4f(gf(s + 16), gf(s + 20), gf(s + 24), gf(s + 28));
	auto _2 = sdk::util::c_4f(gf(s + 32), gf(s + 36), gf(s + 40), gf(s + 44));
	auto _3 = sdk::util::c_4f(gf(s + 48), gf(s + 52), gf(s + 56), gf(s + 60));
	auto _4x4 = sdk::util::_4x4_float(_0, _1, _2, _3);
	auto res = new double[2];
	res[0] = _4x4.matrice[0][0] * p.x + _4x4.matrice[0][1] * p.y + _4x4.matrice[0][2] * p.z + _4x4.matrice[0][3];
	res[1] = _4x4.matrice[1][0] * p.x + _4x4.matrice[1][1] * p.y + _4x4.matrice[1][2] * p.z + _4x4.matrice[1][3];
	auto rect = RECT();
	GetClientRect(lib::d3d11->h, &rect);
	auto w = (float)(_4x4.matrice[3][0] * p.x + _4x4.matrice[3][1] * p.y + _4x4.matrice[3][2] * p.z + _4x4.matrice[3][3]);
	auto c = 1.0f / w;
	res[0] *= c; res[1] *= c;
	auto x_p = (float)rect.right / 2; auto y_p = (float)rect.bottom / 2;
	x_p += (float)(0.5 * res[0] * rect.right + 0.5);
	y_p -= (float)(0.5 * res[1] * rect.bottom + 0.5);
	r.x = x_p + rect.left; r.y = y_p + rect.top;
	return true;
}
sdk::util::c_math* sdk::util::math;