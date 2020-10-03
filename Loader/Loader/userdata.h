#pragma once
#include "inc.h"
class userdata {
public:
	std::string get_val(std::string name);
	bool del_val();
	void set_val(std::string name, std::string value);
};