UnsealPetReq = { }
UnsealPetReq.__index = UnsealPetReq

setmetatable(UnsealPetReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function UnsealPetReq.new()
  local self = setmetatable({}, UnsealPetReq)   
  
  self.Name = "UnsealPetReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("UnsealPet") 
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function UnsealPetReq:construct(petNo)  
   
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.UnsealPetReq.Size)

  self.Packet.byteBuffer:_putLong(petNo, self.rawDataOffset + PacketStruct_Offsets.REQ.UnsealPetReq.PetNo) 
  
  return self
end