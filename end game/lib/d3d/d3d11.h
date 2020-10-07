#pragma once
#include <inc.h>
extern HWND						g_hWnd;
extern ID3D11Device*			g_pd3dDevice;
extern ID3D11DeviceContext*		g_pd3dContext;
extern IDXGISwapChain*			g_pSwapChain;
extern std::once_flag			g_isInitialized;
namespace lib
{
	class c_d3d11
	{
	public:
		UINT last_key_press = NULL;
		HWND h;
		void setup();
	};
	extern c_d3d11* d3d11;
}