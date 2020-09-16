#include <inc.h>
typedef HRESULT(__stdcall* D3D11PresentHook) (IDXGISwapChain* pSwapChain, UINT SyncInterval, UINT Flags);
typedef void(__stdcall* D3D11DrawIndexedHook) (ID3D11DeviceContext* pContext, UINT IndexCount, UINT StartIndexLocation, INT BaseVertexLocation);
typedef void(__stdcall* D3D11ClearRenderTargetViewHook) (ID3D11DeviceContext* pContext, ID3D11RenderTargetView* pRenderTargetView, const FLOAT ColorRGBA[4]);

static HWND                     g_hWnd = nullptr;
static ID3D11Device* g_pd3dDevice = nullptr;
static ID3D11DeviceContext* g_pd3dContext = nullptr;
static IDXGISwapChain* g_pSwapChain = nullptr;
static std::once_flag           g_isInitialized;

D3D11PresentHook                phookD3D11Present = nullptr;
D3D11DrawIndexedHook            phookD3D11DrawIndexed = nullptr;
D3D11ClearRenderTargetViewHook  phookD3D11ClearRenderTargetViewHook = nullptr;

uint64_t* pSwapChainVTable = nullptr;
uint64_t* pDeviceContextVTable = nullptr;

HRESULT __stdcall PresentHook(IDXGISwapChain* pSwapChain, UINT SyncInterval, UINT Flags)
{
	std::call_once(g_isInitialized, [&]() 
	{
		pSwapChain->GetDevice(__uuidof(g_pd3dDevice), reinterpret_cast<void**>(&g_pd3dDevice));
		g_pd3dDevice->GetImmediateContext(&g_pd3dContext);
		sdk::render::render->InitializeRenderClass(g_pd3dDevice, g_pd3dContext, 16, (char*)"Consolas", 0);
		sdk::util::log->add("init d3d11 ok", sdk::util::e_info, true);
	});

	//ImplHookDX11_Present(g_pd3dDevice, g_pd3dContext, g_pSwapChain);
	if (sdk::render::render->IsRenderClassInitialized())
	{
		sdk::render::render->DrawBox(25, 25, 275, 275, 0xff00ff00, 0xff00ff00);
	}

	return phookD3D11Present(pSwapChain, SyncInterval, Flags);
}

void __stdcall DrawIndexedHook(ID3D11DeviceContext* pContext, UINT IndexCount, UINT StartIndexLocation, INT BaseVertexLocation)
{
	return phookD3D11DrawIndexed(pContext, IndexCount, StartIndexLocation, BaseVertexLocation);
}

void __stdcall ClearRenderTargetViewHook(ID3D11DeviceContext* pContext, ID3D11RenderTargetView* pRenderTargetView, const FLOAT ColorRGBA[4])
{
	return phookD3D11ClearRenderTargetViewHook(pContext, pRenderTargetView, ColorRGBA);
}
BOOL CALLBACK find_wnd(HWND h, LPARAM p)
{
	DWORD lpdwProcessId;
	GetWindowThreadProcessId(h, &lpdwProcessId);
	if (lpdwProcessId == p)
	{
		sdk::util::log->add("found hwnd", sdk::util::e_info, true);
		g_hWnd = h;
		return FALSE;
	}
	return TRUE;
}
DWORD __stdcall hook_dx11()
{
	while (g_hWnd == nullptr)
	{
		std::this_thread::sleep_for(std::chrono::seconds(10));
		EnumWindows(find_wnd, GetProcessId(GetCurrentProcess()));
		std::this_thread::sleep_for(std::chrono::seconds(5));
		EnumWindows(find_wnd, GetProcessId(GetCurrentProcess()));
	}
	sdk::util::log->add("bdo hwnd was found", sdk::util::e_info, true);

	D3D_FEATURE_LEVEL level = D3D_FEATURE_LEVEL_11_0;
	DXGI_SWAP_CHAIN_DESC sd;
	{
		ZeroMemory(&sd, sizeof(sd));
		sd.BufferCount = 1;
		sd.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
		sd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
		sd.OutputWindow = g_hWnd;
		sd.SampleDesc.Count = 1;
		sd.Windowed = TRUE;
		sd.BufferDesc.ScanlineOrdering = DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED;
		sd.BufferDesc.Scaling = DXGI_MODE_SCALING_UNSPECIFIED;
		sd.SwapEffect = DXGI_SWAP_EFFECT_DISCARD;
	}

	HRESULT hr = D3D11CreateDeviceAndSwapChain(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, 0, &level, 1, D3D11_SDK_VERSION, &sd, &g_pSwapChain, &g_pd3dDevice, nullptr, &g_pd3dContext);
	if (FAILED(hr)) return E_FAIL;	

	pSwapChainVTable = reinterpret_cast<uint64_t*>(g_pSwapChain);
	pSwapChainVTable = reinterpret_cast<uint64_t*>(pSwapChainVTable[0]);

	pDeviceContextVTable = reinterpret_cast<uint64_t*>(g_pd3dContext);
	pDeviceContextVTable = reinterpret_cast<uint64_t*>(pDeviceContextVTable[0]);

	MH_Initialize();
	if (MH_CreateHook((DWORD*)pSwapChainVTable[8], PresentHook, reinterpret_cast<void**>(&phookD3D11Present)) != MH_OK) { return 1; }
	if (MH_EnableHook((DWORD*)pSwapChainVTable[8]) != MH_OK) { return 1; }
	if (MH_CreateHook((DWORD*)pSwapChainVTable[12], DrawIndexedHook, reinterpret_cast<void**>(&phookD3D11DrawIndexed)) != MH_OK) { return 1; }
	if (MH_EnableHook((DWORD*)pSwapChainVTable[12]) != MH_OK) { return 1; }
	if (MH_CreateHook((DWORD*)pSwapChainVTable[50], ClearRenderTargetViewHook, reinterpret_cast<void**>(&phookD3D11ClearRenderTargetViewHook)) != MH_OK) { return 1; }
	if (MH_EnableHook((DWORD*)pSwapChainVTable[50]) != MH_OK) { return 1; }

	sdk::util::log->add("d3d11 hooking completed", sdk::util::e_info, true);

	DWORD old_protect;
	VirtualProtect(phookD3D11Present, 2, PAGE_EXECUTE_READWRITE, &old_protect);

	g_pd3dDevice->Release();
	g_pd3dContext->Release();
	g_pSwapChain->Release();

	return S_OK;
}
void lib::c_d3d11::setup()
{
	CreateThread(0, 0, (LPTHREAD_START_ROUTINE)hook_dx11, 0, 0, 0);
}
lib::c_d3d11* lib::d3d11;