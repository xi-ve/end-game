PickupDroppedItemAck = { }
PickupDroppedItemAck.__index = PickupDroppedItemAck

setmetatable(PickupDroppedItemAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PickupDroppedItemAck.new(byteBuffer)
  local self = setmetatable({}, PickupDroppedItemAck)   
   
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("PickupDroppedItem")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize
  
  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function PickupDroppedItemAck:parse()
  self.Parsed = {}
    
  self.Parsed.DeadBody_ActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.PickupDroppedItem.DeadBody_ActorKey)
    
  return self
end

function PickupDroppedItemAck:construct()

  return self
end