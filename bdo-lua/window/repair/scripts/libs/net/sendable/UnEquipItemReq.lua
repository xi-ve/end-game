UnEquipItemReq = { }
UnEquipItemReq.__index = UnEquipItemReq

setmetatable(UnEquipItemReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function UnEquipItemReq.new()
  local self = setmetatable({}, UnEquipItemReq)   
  
  self.Name = "UnEquipItemReq"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("UnEquipItem")  
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function UnEquipItemReq:construct(selfActorKey, equipSlot)  
   
   self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.UnEquipItemReq.Size)

   self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.UnEquipItemReq.SelfActorKey)   
   self.Packet.byteBuffer:_put(equipSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.UnEquipItemReq.EquipSlot)  
  
  return self
end