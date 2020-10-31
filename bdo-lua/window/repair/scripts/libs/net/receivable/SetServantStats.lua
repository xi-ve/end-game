SetServantStats = { }
SetServantStats.__index = SetServantStats

setmetatable(SetServantStats, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SetServantStats.new(byteBuffer)
  local self = setmetatable({}, SetServantStats)   
 
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("SetServantStats")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function SetServantStats:parse()
  self.Parsed = {}
    
  self.Parsed.ActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.SetServantStats.ActorKey)
      
  return self
end

function SetServantStats:construct(actorKey, speed, accel, turn, brake) 

  self.Packet.byteBuffer:putEmptyBytes(self.minDataSize + self.rawDataOffset) -- fill complete size with 0 bytes
  
  self.Packet.byteBuffer:_putInt(accel, self.rawDataOffset + PacketStruct_Offsets.ACK.SetServantStats.Speeds)
  self.Packet.byteBuffer:_putInt(speed, self.rawDataOffset + PacketStruct_Offsets.ACK.SetServantStats.Speeds + 4) 
  self.Packet.byteBuffer:_putInt(turn, self.rawDataOffset + PacketStruct_Offsets.ACK.SetServantStats.Speeds + 8) 
  self.Packet.byteBuffer:_putInt(brake, self.rawDataOffset + PacketStruct_Offsets.ACK.SetServantStats.Speeds + 12) 

  self.Packet.byteBuffer:_putInt(actorKey, self.rawDataOffset + PacketStruct_Offsets.ACK.SetServantStats.ActorKey) 
  
  return self
end