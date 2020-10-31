EquipItemReq = { }
EquipItemReq.__index = EquipItemReq

setmetatable(EquipItemReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function EquipItemReq.new()
  local self = setmetatable({}, EquipItemReq)   
  
  self.Name = "EquipItemReq"
  
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("EquipItem") 
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function EquipItemReq:construct(selfActorKey, inventoryWhereType, inventorySlot, equipSlot)  
   
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.EquipItemReq.Size)

  self.Packet.byteBuffer:_put(equipSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.EquipItemReq.EquipSlot)
  self.Packet.byteBuffer:_put(inventorySlot, self.rawDataOffset + PacketStruct_Offsets.REQ.EquipItemReq.InventorySlot)
  self.Packet.byteBuffer:_putInt(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.EquipItemReq.FixValue01)  
  self.Packet.byteBuffer:_putInt(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.EquipItemReq.FixValue01 + 4)  
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.EquipItemReq.SelfActorKey)  
  self.Packet.byteBuffer:_put(inventoryWhereType, self.rawDataOffset + PacketStruct_Offsets.REQ.EquipItemReq.InventoryWhereType)
  
  return self
end