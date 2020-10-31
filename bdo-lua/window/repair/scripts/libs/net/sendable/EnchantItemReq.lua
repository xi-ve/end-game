EnchantItemReq = { }
EnchantItemReq.__index = EnchantItemReq

setmetatable(EnchantItemReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function EnchantItemReq.new()
  local self = setmetatable({}, EnchantItemReq)   
  
  self.Name = "EnchantItemReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("EnchantItem")
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function EnchantItemReq:construct(itemSlot, enchantItemSlot)
  
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.EnchantItemReq.Size)

  self.Packet.byteBuffer:_put(255, self.rawDataOffset + PacketStruct_Offsets.REQ.EnchantItemReq.FixValue01) 
  self.Packet.byteBuffer:_put(enchantItemSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.EnchantItemReq.EnchantItemSlot)
  self.Packet.byteBuffer:_put(itemSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.EnchantItemReq.ItemSlot)  
  
  return self
end