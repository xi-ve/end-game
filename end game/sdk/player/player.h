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
		struct s_item_info
		{
			s_item_info(uint64_t a1, int a2, int a3, int a4, int a5, int a6, uint64_t a7, std::string a8)
			{
				address = a1; item_index = a2; count = a3; durability = a4; max_durability = a5; item_slot = a6; nameid = a7; name = a8;
			};
			uint64_t address;
			uint64_t nameid;
			std::string name;
			int item_slot;
			int item_index;
			int count;
			int durability;
			int max_durability;
		};
		class s_pet_data
		{
		public:
		private:
			char pad_0x0000[0x8]; //0x0000
		public:
			__int64 i; //0x0008 
			wchar_t n[16]; //0x0010 
		private:
			char pad_0x0030[0x30]; //0x0030
		public:
			__int32 N00001520; //0x0060 
			__int32 h; //0x0064 
		private:
			char pad_0x0068[0x20]; //0x0068

		}; //Size=0x0088
		class s_pet_data_s
		{
		public:
			__int64 i; //0x0000 
			unsigned char N00000D7C; //0x0008 
			unsigned char N00000D9C; //0x0009 
			wchar_t n[16]; //0x000A 
		private:
			char pad_0x002A[0x26]; //0x002A
		public:
			__int32 h; //0x0050 
		private:
			char pad_0x0054[0xC]; //0x0054

		}; //Size=0x0060
		struct s_trace
		{
			s_trace() { start_point.clear(), end_point.clear(); set_end.clear(); end_distance = 0; };
			s_trace(sdk::util::c_vector3 s, sdk::util::c_vector3 e, float f, bool t, sdk::util::c_vector3 v) { start_point = s; end_point = e; end_distance = f; success = t; set_end = v; };
			sdk::util::c_vector3 start_point;
			sdk::util::c_vector3 end_point;
			sdk::util::c_vector3 set_end;
			float          end_distance;
			bool		   success = 0;
		};
		/*player utils*/
		class c_player
		{
		public:
			bool thread_working = false;
			std::deque<s_blank_proxy> actors = std::deque<s_blank_proxy>();
			std::deque<s_blank_proxy> corpses = std::deque<s_blank_proxy>();
			std::deque<s_item_info> inventory_items = std::deque<s_item_info>();
			std::deque<s_pet_data> unsealed_pets = std::deque<s_pet_data>();
			std::deque<s_pet_data_s> sealed_pets = std::deque<s_pet_data_s>();
			template<class T>
			T							get(uint64_t a, uint64_t b)
			{
				return *(T*)(a + b);
			}
			void						update_inventory(uint64_t self);
			void						update_actors(uint64_t self);
			void						update_pets(uint64_t self);
			util::c_vector3				gpos(uint64_t a, bool raw = false);
			BYTE						gtype(uint64_t a) { return this->get<BYTE>(a, core::offsets::actor::actor_proxy_type); }
			int							gkey(uint64_t a)  { return this->get<int>(a, core::offsets::actor::actor_proxy_key);   }
			float						ghp(uint64_t a);
			std::vector<std::string>	ginv();
			int							gitm_by_name(std::string n);
			float						grot(uint64_t s);
			util::c_vector3				ray_cast_rvec(util::c_vector3 pos1, util::c_vector3 pos2);
			s_trace						trace(sdk::util::c_vector3 f, sdk::util::c_vector3 t, uint64_t s, float h, int fl = 34, bool a = true);
		};
		extern c_player* player_;
	}
}