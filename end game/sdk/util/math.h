#pragma once
#include <inc.h>
namespace sdk
{
	namespace util
	{
		struct c_4f
		{
			c_4f() {};
			c_4f(float a, float b, float c, float d)
			{
				f_1 = a; f_2 = b; f_3 = c; f_4 = d;
			}
			float f_1, f_2, f_3, f_4;
		};
		struct _4x4_float
		{
			_4x4_float(
				c_4f _0,
				c_4f _1,
				c_4f _2,
				c_4f _3
			)
			{
				matrice[0][0] = _0.f_1;
				matrice[1][0] = _0.f_2;
				matrice[2][0] = _0.f_3;
				matrice[3][0] = _0.f_4;

				matrice[0][1] = _1.f_1;
				matrice[1][1] = _1.f_2;
				matrice[2][1] = _1.f_3;
				matrice[3][1] = _1.f_4;

				matrice[0][2] = _2.f_1;
				matrice[1][2] = _2.f_2;
				matrice[2][2] = _2.f_3;
				matrice[3][2] = _2.f_4;

				matrice[0][3] = _3.f_1;
				matrice[1][3] = _3.f_2;
				matrice[2][3] = _3.f_3;
				matrice[3][3] = _3.f_4;
			}
			_4x4_float() {}
			float matrice[4][4];
		};
		class c_vector3
		{
		public:
			c_vector3() {};
			c_vector3(float a, float b, float c) { x = a; y = b; z = c; }
			bool cmp(c_vector3 a)
			{
				if (a.x == x &&
					a.y == y &&
					a.z == z) return true;
				return false;
			}
			float x, y, z;
		};
		class c_math
		{
		public:
			float gdst_3d(c_vector3 f, c_vector3 t);
			float gdst_2d(c_vector3 f, c_vector3 t);
			float gdst_1d(float f, float t);
			bool  w2s(c_vector3 p, c_vector3& r);
		};
		extern c_math* math;
	}
}