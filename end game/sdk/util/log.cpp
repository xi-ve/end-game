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
	auto str16_8893_end_game_log_txt27 = new core::s_str_container(std::vector<int>{108, 103, 109, 86, 110, 104, 100, 108, 86, 101, 102, 110, 39, 125, 113, 125}); /*end_game_log.txt*/
	this->file_stream.open(str16_8893_end_game_log_txt27->get(), std::ios_base::app);
	delete str16_8893_end_game_log_txt27;
	this->proc(i, t);
	//if (this->gcollector().size() > 20) this->log_collector.clear();
	if (file) this->file(i); 
	if (this->console) std::cout << i << "\n";
	this->array(i);
	this->file_stream.close();
}
sdk::util::c_log* sdk::util::log;