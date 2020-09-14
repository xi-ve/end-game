#pragma once
#include <inc.h>
namespace sdk
{
	namespace util
	{
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
		};
		extern c_math* math;
	}
}