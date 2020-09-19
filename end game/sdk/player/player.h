#pragma once
#include <inc.h>
namespace sdk
{
	namespace player
	{
		class c_proxy_name;
		class name_str;
		class c_proxy_name
		{
		public:
		private:
			char pad_0x0000[0x68]; //0x0000
		public:
			name_str* name_ptr; //0x0068 
		private:
			char pad_0x0070[0x50]; //0x0070

		}; //Size=0x00C0
		class name_str
		{
		public:
			wchar_t name[32]; //0x0000 
		private:
			char pad_0x0024[0x1C]; //0x0024
		}; //Size=0x0040
		struct s_blank_proxy
		{
			std::string			 name;
			uint64_t			 ptr = 0;
			sdk::util::c_vector3 pos;
			int					 type;
			int					 key;
			float				 rlt_dst;
			int					 key_target;
			int					 hp;
			BYTE				 state;
		};
		/*player utils*/
		class c_player
		{			
		public:
			bool thread_working = false;
			std::deque<s_blank_proxy> actors = std::deque<s_blank_proxy>();
			std::deque<s_blank_proxy> corpses = std::deque<s_blank_proxy>();
			template<class T>
			T get(uint64_t a, uint64_t b)
			{
				return *(T*)(a + b);
			}
			void						update_actors(uint64_t self);
			util::c_vector3				gpos(uint64_t a, bool raw = false);
			BYTE						gtype(uint64_t a) { return this->get<BYTE>(a, core::offsets::actor::actor_proxy_type); }
			int							gkey (uint64_t a) { return this->get<int> (a, core::offsets::actor::actor_proxy_key);  }
			float						ghp(uint64_t a);
		};
		extern c_player* player_;
	}
}