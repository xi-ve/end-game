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
#include <d3d11.h>
#include <mutex>
#include <d3dx11.h>
#include <DXErr.h>
#include <D3DX11async.h>
#include <D3Dcompiler.h>
#include <D3D11Shader.h>
#include "..\\sdk\rendering\fx\d3dx11effect.h"
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
//SDK
#include <values.h>
#include "..\\sdk\rendering\font_wrapper\FW1FontWrapper.h"
#include "..\\sdk\rendering\shader.h"
#include "..\\sdk\rendering\render.h"
#include "..\\sdk\util\log.h"
#include "..\\sdk\util\bytebuffer.h"
#include "..\\fn\hooks.h"
#include "..\\sdk\\util\math.h"
#include "..\\sdk\\engine\funcs.h"
#include "..\\sdk\player\player.h"
#include "..\\lib\d3d\d3d11.h"
#include <workers.h>
#include <boot.h>
//FN
