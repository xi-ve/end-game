#include <inc.h>
void sdk::util::c_log::proc(std::string& i, e_log_type t)
{
	switch (t)
	{
	case e_log_type::e_none:
	{
		return; break;
	}
	case e_log_type::e_info:
	{
		auto n = std::string("?: ").append(i); i = n;
		break;
	}
	case e_log_type::e_warn:
	{
		auto n = std::string("!: ").append(i); i = n;
		break;
	}
	case e_log_type::e_critical:
	{
		auto n = std::string("*: ").append(i); i = n;
		break;
	}
	default: break;
	}
}
void sdk::util::c_log::add(std::string i, e_log_type t, bool file)
{
	this->file_stream.open("end_game_log.txt", std::ios_base::app);
	this->proc(i, t);
	//if (this->gcollector().size() > 20) this->log_collector.clear();
	if (file) this->file(i); 
	if (this->console) std::cout << i << "\n";
	this->array(i);
	this->file_stream.close();
}
void sdk::util::c_log::a(const char* a, ...)
{
	char buffer[4096];
	va_list args;
	va_start(args, a);
	int rc = vsnprintf(buffer, sizeof(buffer), a, args);
	va_end(args);
	//
	this->log_collector.push_back(buffer);
}
sdk::util::c_log* sdk::util::log;