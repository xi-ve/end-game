PurchaseFromTentReq = {}
PurchaseFromTentReq.__index = PurchaseFromTentReq

setmetatable(PurchaseFromTentReq, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function PurchaseFromTentReq.new()
	local self = setmetatable({}, PurchaseFromTentReq)

	self.Name = "PurchaseFromTentReq"

	self.isEncrypted = false
	self.opCode = OpCodes.getReqOpCode("PurchaseFromTent")
	self.rawDataOffset = 5

	self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)

	return self
end

function PurchaseFromTentReq:construct(tentId, tentActorKey, itemId, count, isPotion, shopSlot)
	self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.PurchaseFromTentReq.Size)

	self.Packet.byteBuffer:_put(3, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.FixValue01)
	self.Packet.byteBuffer:_putLong(tentId, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.TentNo)
	self.Packet.byteBuffer:_putInt(itemId, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.ItemId)
	self.Packet.byteBuffer:_putInt(Infinity.BDO.getLocalPlayer():getActorKey(),
                               	self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.SelfActorKey)
	self.Packet.byteBuffer:_putLong(Infinity.BDO.getLocalPlayer():getInventoryMoneyNo(),
                                	self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.MoneyNo)

	-- Removed self.Packet.byteBuffer:_put(0, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.IsPotion)
	self.Packet.byteBuffer:_put(isPotion, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.IsPotion) -- Removed +0x1. It is actor key and then directly one byte isPotion

	self.Packet.byteBuffer:_putIntAsLong(count, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.Count)
	self.Packet.byteBuffer:_putInt(tentActorKey,
                               	self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.TentActorKey)

	if shopSlot ~= nil then
		self.Packet.byteBuffer:_putShort(shopSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseFromTentReq.ShopSlot)
	end

	return self
end
