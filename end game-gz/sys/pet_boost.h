#pragma once
#include <inc.h>
namespace sys
{
	class c_pet_boost
	{
	private:
		void make_unseal(uint64_t id);
		void make_seal(uint64_t id);
		void make_petspeed(uint64_t id);
	public:
		bool work(uint64_t pack);
	};
	extern c_pet_boost* pet_boost;
}