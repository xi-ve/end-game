FeedPetReq = { }
FeedPetReq.__index = FeedPetReq

setmetatable(FeedPetReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function FeedPetReq.new()
  local self = setmetatable({}, FeedPetReq)   
  
  self.Name = "FeedPetReqReq"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("FeedPet")
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function FeedPetReq:construct(actorKey, petNo)       
    
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.FeedPetReq.Size)

  self.Packet.byteBuffer:_putShort(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.FeedPetReq.FixValue01) 
  self.Packet.byteBuffer:_putShort(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.FeedPetReq.FixValue02)  
  self.Packet.byteBuffer:_putInt(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.FeedPetReq.FixValue03) 
  self.Packet.byteBuffer:_putInt(actorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.FeedPetReq.ActorKey)
  self.Packet.byteBuffer:_putInt(0, self.rawDataOffset + PacketStruct_Offsets.REQ.FeedPetReq.FixValue04)
  self.Packet.byteBuffer:_putLong(petNo, self.rawDataOffset + PacketStruct_Offsets.REQ.FeedPetReq.PetNo)
  
  return self
end