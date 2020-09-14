#include <inc.h>
//
static fn::t_packet_outbound fn::o_packet_outbound;
//
bool fn::setup()
{
	if (!fn::hook((void*)core::offsets::hk::packet_outbound, &fn::f_packet_outbound, (void**)&fn::o_packet_outbound)) return false;
	sdk::util::log->add("hooking completed", sdk::util::e_info, true);
	return true;
}
bool fn::hook(LPVOID offset, LPVOID exchangee, LPVOID* backup)
{
	if (MH_CreateHook(offset, exchangee, backup) != MH_OK) return false;
	if (MH_EnableHook(offset) != MH_OK)					   return false;
	sdk::util::log->add(std::string(sdk::util::log->as_hex((uint64_t)offset)).append(" -> ").append(sdk::util::log->as_hex((uint64_t)exchangee)), sdk::util::e_info, true);
	return true;
}
uint64_t fn::f_packet_outbound(void* pack, uint16_t size, uint8_t enc, uint8_t unk, uint64_t unk2, const CHAR* xkey)
{
	if (!pack )	return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
	__int16* a = (__int16*)pack; auto b = *a;
	ByteBuffer buf; for (auto c = 0; c < size; c++) buf.put(*(uint8_t*)((uint64_t)pack + c));
	sdk::util::log->add(std::string(__FUNCTION__) \
						.append(" opcode: ").append(std::to_string(b)) \
						.append(" size  : ").append(std::to_string(size)) \
						.append(" packet: ").append(buf.printHex()), sdk::util::e_info, true);	
	return fn::o_packet_outbound(pack, size, enc, unk, unk2, xkey);
}
