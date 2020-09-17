#pragma once
#include <inc.h>
namespace sdk
{
	namespace player
	{
		struct s_self_actor_proxy
		{
			std::string			 name;
			sdk::util::c_vector3 pos;
			uint64_t			 ptr;
		};
		/*player utils*/
		class c_player
		{
		private:
			template<class T>
			T get(uint64_t a, uint64_t b)
			{
				return *(T*)(a + b);
			}
			s_self_actor_proxy* self = nullptr;
		public:
			bool				update();
			bool				gself_valid();
			s_self_actor_proxy* gself();
			util::c_vector3     gpos(uint64_t a);
			BYTE				gtype(uint64_t a) { return this->get<BYTE>(a, core::offsets::actor::actor_proxy_type); }
			int					gkey (uint64_t a) { return this->get<int> (a, core::offsets::actor::actor_proxy_key);  }
			float				ghp(uint64_t a);
		};
		extern c_player* player_;
	}
}