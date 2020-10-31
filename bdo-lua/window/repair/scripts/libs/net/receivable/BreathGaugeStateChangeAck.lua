BreathGaugeStateChangeAck = { }
BreathGaugeStateChangeAck.__index = BreathGaugeStateChangeAck

setmetatable(BreathGaugeStateChangeAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function BreathGaugeStateChangeAck.new(byteBuffer)
  local self = setmetatable({}, BreathGaugeStateChangeAck)   
    
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("BreathGaugeStateChange")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize
    
  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)  

  return self
end

function BreathGaugeStateChangeAck:parse()
  self.Parsed = {}
      
  self.Parsed.Type = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.BreathGaugeStateChange.Type)
  self.Parsed.ServerTimeMillis = self.Packet.Data:_getLong(self.rawDataOffset + PacketStruct_Offsets.ACK.BreathGaugeStateChange.ServerTimeMillis):getUnsafe()
  self.Parsed.SelfActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.BreathGaugeStateChange.SelfActorKey)
    
  return self
end

function BreathGaugeStateChangeAck:construct(selfActorKey, type, serverTimeMillis)

  self.Packet.byteBuffer:putEmptyBytes(self.minDataSize + self.rawDataOffset) -- fill complete size with 0 bytes
  
  self.Packet.byteBuffer:_putInt(type, self.rawDataOffset + PacketStruct_Offsets.ACK.BreathGaugeStateChange.Type)
  self.Packet.byteBuffer:_putIntAsLong(serverTimeMillis, self.rawDataOffset + PacketStruct_Offsets.ACK.BreathGaugeStateChange.ServerTimeMillis)
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.ACK.BreathGaugeStateChange.SelfActorKey)

  return self
end