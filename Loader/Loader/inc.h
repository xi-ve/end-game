#pragma once
#define _CRT_SECURE_NO_WARNINGS
/*sdl-sdk*/
#include <Windows.h>
#include <string>
#include <vector>
#include <unordered_map>
#include <iostream>
#include <fstream>
#include <sstream>
#include <thread>
#include <chrono>
#include <array>
#include <filesystem>
#include <winhttp.h>
#include <psapi.h>
#include <tlhelp32.h>
#include <Shlwapi.h>
#include <Winternl.h>
#include <comdef.h>
#include <functional>
#include <WbemCli.h>
#include <Wbemidl.h>
#include <ctime>  
#include <random>
#include <cctype>
#include <iomanip>
/*lib*/
#pragma comment(lib, "wbemuuid.lib")
#pragma comment(lib, "ntdll.lib")
#pragma comment(lib, "Winhttp.lib")

#include "web.h"