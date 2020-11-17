#pragma once
#include "inc.h"

std::string base64_encode(unsigned char const* bytes_to_encode, size_t in_len);
std::string base64_encode(const std::string& s);
std::string base64_decode(std::string const& encoded_string);

