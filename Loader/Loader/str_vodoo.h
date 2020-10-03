#pragma once
#include "inc.h"
struct s_str_container
{
    s_str_container(std::vector<int> str_encr)
    {
        raw_str = str_encr;
        enc();
    }
    s_str_container(std::string str)
    {
        raw = str;
        enc();
    }
    std::string      get()
    {
        if (!decr.size() && raw_str.size()) for (auto obj : raw_str) decr.push_back((char)(obj ^= 9));
        return decr;
    }
    std::wstring     getW()
    {
        if (!decr.size() && raw_str.size()) for (auto obj : raw_str) decr.push_back((char)(obj ^= 9));
        std::wstring wsTmp(decr.begin(), decr.end());
        return wsTmp;
    }
    std::vector<int> enc()
    {
        if (!raw_str.size()) for (auto obj : raw) raw_str.push_back((int)(obj ^= 9));
        return raw_str;
    }
    std::string      str()
    {
        raw_as_str.clear();
        for (auto obj : raw_str) raw_as_str << obj;
        return raw_as_str.str();
    }
    std::vector<int> raw_str;
    std::stringstream      raw_as_str;
    std::string            decr;
    std::string            raw;
};