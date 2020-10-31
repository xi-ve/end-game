ChangePetSpeedReq = { }
ChangePetSpeedReq.__index = ChangePetSpeedReq

setmetatable(ChangePetSpeedReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ChangePetSpeedReq.new()
  local self = setmetatable({}, ChangePetSpeedReq)   
  
  self.Name = "ChangePetSpeedReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("ChangePetSpeed") 
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function ChangePetSpeedReq:construct(petNo, speed)  
   
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.ChangePetSpeedReq.Size) 

  self.Packet.byteBuffer:_put(speed, self.rawDataOffset + PacketStruct_Offsets.REQ.ChangePetSpeedReq.Speed) 
  self.Packet.byteBuffer:_putLong(petNo, self.rawDataOffset + PacketStruct_Offsets.REQ.ChangePetSpeedReq.PetNo)

  return self
end