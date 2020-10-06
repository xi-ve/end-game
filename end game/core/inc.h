#pragma once
#define _CRT_SECURE_NO_WARNINGS
#include <Windows.h>
#include <vector>
#include <string>
#include <stdio.h>
#include <fstream>
#include <sstream>
#include <iostream>
#include <thread>
#include <atomic>
#include <unordered_map>
#include <xmmintrin.h>
#include <d3d11.h>
#include <mutex>
#include <TlHelp32.h>
#include <Psapi.h>
#include <functional>
#include <d3dx11.h>
#include <DXErr.h>
#include <D3DX11async.h>
#include <D3Dcompiler.h>
#include <D3D11Shader.h>
#include "..\\sdk\rendering\fx\d3dx11effect.h"
#include <ThemidaSDK.h>
#include <winhttp.h>
#include <iomanip>
//
#pragma warning ( disable: 4102 )
#pragma warning ( disable: 4311 )
#pragma warning ( disable: 4312 )
#pragma warning ( disable: 4244 )
#pragma warning ( disable: 4996 )
//LIB
#include "..\\lib\mh\mh.h"
#pragma comment (lib, "mh_lib.lib")
#pragma comment(lib, "d3d11.lib")
#pragma comment( lib, "DXErr" )
#pragma comment (lib, "D3D11.lib")
#pragma comment (lib, "D3DX11.lib")
#pragma comment (lib, "d3dcompiler.lib")
#pragma comment (lib, "Effects11.lib")
#pragma comment (lib, "SecureEngineSDK64.lib")
#pragma comment (lib, "winhttp.lib")
#pragma comment (lib, "ws2_32.lib")
//SDK
#include <values.h>
#include "..\\lib\web\base64.h"
#include "..\\lib\web\web.h"
#include "..\\sys\str_enc.h"
#include "..\\sys\\backend.h"
#include "..\\sdk\rendering\font_wrapper\FW1FontWrapper.h"
#include "..\\sdk\rendering\shader.h"
#include "..\\lib\imgui\imgui.h"
#include "..\\lib\\imgui\imgui_impl_win32.h"
#include "..\\lib\imgui\imgui_impl_dx11.h"
#include "..\\fn\patches.h"
#include "..\\sdk\util\file.h"
#include "..\\sdk\util\log.h"
#include "..\\sys\cfg.h"
#include "..\\sdk\util\bytebuffer.h"
#include "..\\fn\hooks.h"
#include "..\\sys\\lua_q.h"
#include "..\\sys\\key_q.h"
#include "..\\lib\imgui\imgui_internal.h"
#include "..\\sdk\rendering\menu\m_packet.h"
#include "..\\sdk\rendering\menu\menu.h"
#include "..\\sdk\rendering\render.h"
#include "..\\sdk\\util\math.h"
#include "..\\sdk\\engine\funcs.h"
#include "..\\sdk\player\player.h"
#include "..\\sys\rebuff.h"
#include "..\\sys\pack_tp.h"
#include "..\\sys\\cursor_tp.h"
#include "..\\sys\\pet_boost.h"
#include "..\\sys\loot.h"
#include "..\\sys\\roar_bot.h"
#include "..\\sys\visual.h"
#include "..\\lib\d3d\d3d11.h"
#include <workers.h>
#include <boot.h>
//FN
