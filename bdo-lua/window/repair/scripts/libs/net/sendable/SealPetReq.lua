SealPetReq = { }
SealPetReq.__index = SealPetReq

setmetatable(SealPetReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SealPetReq.new()
  local self = setmetatable({}, SealPetReq)   
  
  self.Name = "SealPetReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("SealPet") 
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function SealPetReq:construct(petNo)  
      
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.SealPetReq.Size)

  self.Packet.byteBuffer:_putLong(petNo, self.rawDataOffset + PacketStruct_Offsets.REQ.SealPetReq.PetNo) 
    
  return self
end