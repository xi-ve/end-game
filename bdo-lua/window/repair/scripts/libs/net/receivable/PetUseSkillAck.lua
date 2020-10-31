PetUseSkillAck = { }
PetUseSkillAck.__index = PetUseSkillAck

setmetatable(PetUseSkillAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PetUseSkillAck.new(byteBuffer)
  local self = setmetatable({}, PetUseSkillAck)   
   
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("PetUseSkill")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function PetUseSkillAck:parse()
  self.Parsed = {}

  self.Parsed.SkillNo = self.Packet.Data:_get(self.rawDataOffset + PacketStruct_Offsets.ACK.PetUseSkill.SkillNo)
  self.Parsed.PetNo = self.Packet.Data:_getLong(self.rawDataOffset + PacketStruct_Offsets.ACK.PetUseSkill.PetNo)
  
    
  return self
end