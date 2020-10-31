RemoveActorAck = { }
RemoveActorAck.__index = RemoveActorAck

setmetatable(RemoveActorAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RemoveActorAck.new(byteBuffer)
  local self = setmetatable({}, RemoveActorAck)   
    
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("RemoveActor")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function RemoveActorAck:parse()
  self.Parsed = {}
    
  self.Parsed.ActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.RemoveActor.ActorKey)
    
  return self
end

function RemoveActorAck:construct()

  return self
end