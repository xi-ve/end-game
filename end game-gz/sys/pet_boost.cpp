#include <inc.h>
void sys::c_pet_boost::make_unseal(uint64_t id)
{
	ByteBuffer b;
	b.putShort(3825);
	b.putLong(id);
	fn::send_packet(b, 3825, 10);
}
void sys::c_pet_boost::make_seal(uint64_t id)
{
	ByteBuffer b;
	b.putShort(3045);
	b.putLong(id);
	b.putShort(0x1b74);
	fn::send_packet(b, 3045, 12);
}
void sys::c_pet_boost::make_petspeed(uint64_t id)
{
	ByteBuffer b;
	b.putShort(3332);
	b.putShort(0x1b74);
	b.putLong(id);
	b.put(2);
	b.putEmptyBytes(3);
	b.put(0xc0);
	b.putEmptyBytes(1);
	fn::send_packet(b, 3332, 18);
}
bool sys::c_pet_boost::work(uint64_t pack)
{
	auto s = *(uint64_t*)(pack + 12);
	if (s <= 0) return false;
	//
	this->make_unseal(s);
	this->make_seal(s);
	this->make_petspeed(s);
	//
	return true;
}
sys::c_pet_boost* sys::pet_boost;