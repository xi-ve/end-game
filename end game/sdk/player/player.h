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
			s_self_actor_proxy* self;
		public:
			bool				update();
			bool				gself_valid();
			s_self_actor_proxy* gself();
			util::c_vector3     gpos(uint64_t a);
		};
		extern c_player* player_;
		template<class T>
	}
}