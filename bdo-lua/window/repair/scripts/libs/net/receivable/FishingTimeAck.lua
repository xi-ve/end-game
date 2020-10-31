FishingTimeAck = { }
FishingTimeAck.__index = FishingTimeAck

setmetatable(FishingTimeAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function FishingTimeAck.new(byteBuffer)
  local self = setmetatable({}, FishingTimeAck)   
    
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("FishingTime")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function FishingTimeAck:parse()
  self.Parsed = {}
    
  self.Parsed.NextAutoCatchTime = self.Packet.Data:_getLong(self.rawDataOffset + PacketStruct_Offsets.ACK.FishingTime.NextAutoCatchTime):getUnsafe()
  self.Parsed.NextCatchTime = self.Packet.Data:_getLong(self.rawDataOffset + PacketStruct_Offsets.ACK.FishingTime.NextCatchTime):getUnsafe()
  self.Parsed.Grade = 0
    
  return self
end