UpdateEnchantFailCountAck = { }
UpdateEnchantFailCountAck.__index = UpdateEnchantFailCountAck

setmetatable(UpdateEnchantFailCountAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function UpdateEnchantFailCountAck.new(byteBuffer)
  local self = setmetatable({}, UpdateEnchantFailCountAck)   

  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("UpdateEnchantFailCount")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function UpdateEnchantFailCountAck:parse()
  self.Parsed = {}
    
  self.Parsed.FailStack = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.UpdateEnchantFailCount.FailStack)
    
  return self
end