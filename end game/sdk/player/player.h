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

		public:
			bool		update();
			uint64_t	gself_actor_ptr();
		};
		extern c_player* player;
	}
}