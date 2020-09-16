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
sdk::util::c_math* sdk::util::math;