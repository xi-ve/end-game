#pragma once
#include <inc.h>
namespace lib
{
	class c_d3d11
	{
	public:
		HWND h;
		void setup();
	};
	extern c_d3d11* d3d11;
}