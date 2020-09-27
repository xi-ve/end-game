#pragma once
#include <inc.h>
namespace sdk
{
	namespace util
	{
		enum e_log_type
		{
			e_none = 0,
			e_warn,
			e_info,
			e_critical
		};
		class c_log
		{
		public:
			c_log()
			{
				this->file_stream = std::ofstream("end_game_log.txt");
				if (!this->file_stream.is_open()) { this->array("failure creating file stream!"); }
				else this->add("file stream created", e_log_type::e_info, true);
				if (this->console) { }
				this->file_stream.close();
			};
		private:
			std::vector<std::string> log_collector;
			std::ofstream file_stream;
			bool console = true;
			//
			void array(std::string i) { this->log_collector.push_back(i); }
			void file(std::string i) { this->file_stream << i << "\n"; }
			void proc(std::string& i, e_log_type t);
		public:
			std::vector<std::string> gcollector() { return this->log_collector; }
			void add(std::string i, e_log_type t = e_log_type::e_none, bool file = false);
			std::string as_hex(uint64_t i) { std::stringstream a; a << std::hex << i; return a.str(); }
		};
		extern c_log* log;
	}
}