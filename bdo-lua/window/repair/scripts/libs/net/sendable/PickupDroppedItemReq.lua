PickupDroppedItemReq = { }
PickupDroppedItemReq.__index = PickupDroppedItemReq

setmetatable(PickupDroppedItemReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PickupDroppedItemReq.new()
  local self = setmetatable({}, PickupDroppedItemReq)   
  
  self.Name = "PickupDroppedItemReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("PickupDroppedItem")
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
    
  return self
end

function PickupDroppedItemReq:construct(selfActorKey, actorKey, slot, count, lootBagType)
  if lootBagType == nil then
    lootBagType = 0
  end

  --So we support both count as a number or as a LuaInt64
  if (type(count) == "number") then 
    count = LuaInt64(count)
  end

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.PickupDroppedItemReq.Size)

  self.Packet.byteBuffer:_put(0, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.FixValue01)
  self.Packet.byteBuffer:_put(0, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.FixValue01_2)
  self.Packet.byteBuffer:_put(1, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.FixValue02)
  self.Packet.byteBuffer:_put(1, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.FixValue02_2)
  self.Packet.byteBuffer:_putLong(count, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.Count)
  self.Packet.byteBuffer:_put(lootBagType, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.LootBagType)
  self.Packet.byteBuffer:_put(slot, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.Slot)  
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.SelfActorKey)
  self.Packet.byteBuffer:_putInt(actorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PickupDroppedItemReq.ActorKey)
  
  return self
end