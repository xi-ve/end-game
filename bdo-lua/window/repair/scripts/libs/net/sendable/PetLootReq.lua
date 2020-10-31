-- 1220

PetLootReq = { }
PetLootReq.__index = PetLootReq

setmetatable(PetLootReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PetLootReq.new()
  local self = setmetatable({}, PetLootReq)   
  
  self.Name = "PetLootReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("PetLoot")

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function PetLootReq:construct(petNo, deadBodyActorKey)

  self.Packet.byteBuffer:putLong(petNo)
  self.Packet.byteBuffer:putEmptyBytes(4)
  self.Packet.byteBuffer:putInt(deadBodyActorKey)
  self.Packet.byteBuffer:putInt(-1)
  self.Packet.byteBuffer:putInt(-1)
  
  return self
end