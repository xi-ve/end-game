CleanseItemReq = { }
CleanseItemReq.__index = CleanseItemReq

setmetatable(CleanseItemReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CleanseItemReq.new()
  local self = setmetatable({}, CleanseItemReq)   
  
  self.Name = "CleanseItemReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("CleanseItem") 
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function CleanseItemReq:construct(npcActorKey, moneyWhereType, moneyNo, itemSlot)  
      
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.CleanseItemReq.Size)

  self.Packet.byteBuffer:_putLong(moneyNo, self.rawDataOffset + PacketStruct_Offsets.REQ.CleanseItemReq.MoneyNo)
  self.Packet.byteBuffer:_put(moneyWhereType, self.rawDataOffset + PacketStruct_Offsets.REQ.CleanseItemReq.MoneyWhereType)
  self.Packet.byteBuffer:_put(itemSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.CleanseItemReq.ItemSlot)
  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.CleanseItemReq.NpcActorKey)
    
  return self
end