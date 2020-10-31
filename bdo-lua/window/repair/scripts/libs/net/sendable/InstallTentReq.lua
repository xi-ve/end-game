InstallTentReq = { }
InstallTentReq.__index = InstallTentReq

setmetatable(InstallTentReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function InstallTentReq.new()
  local self = setmetatable({}, InstallTentReq)   
  
  self.Name = "InstallTentReq"
   
  self.isEncrypted = false
  self.opCode = OpCodes.getReqOpCode("InstallTent") 
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function InstallTentReq:construct(tentId,x,y,z)

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.InstallTentReq.Size)
  
  self.Packet.byteBuffer:_putFloat(z, self.rawDataOffset + PacketStruct_Offsets.REQ.InstallTentReq.PosZ)
  self.Packet.byteBuffer:_putFloat(x, self.rawDataOffset + PacketStruct_Offsets.REQ.InstallTentReq.PosX)
  self.Packet.byteBuffer:_putFloat(y, self.rawDataOffset + PacketStruct_Offsets.REQ.InstallTentReq.PosX + 4)
  self.Packet.byteBuffer:_putShort(231, self.rawDataOffset + PacketStruct_Offsets.REQ.InstallTentReq.FixValue01)
  self.Packet.byteBuffer:_putShort(9999, self.rawDataOffset + PacketStruct_Offsets.REQ.InstallTentReq.ActorId)  
  self.Packet.byteBuffer:_putLong(tentId, self.rawDataOffset + PacketStruct_Offsets.REQ.InstallTentReq.TentNo)
   
  return self
end
