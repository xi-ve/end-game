ActorStatus = { }
ActorStatus.__index = ActorStatus

setmetatable(ActorStatus, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ActorStatus.new()
  local self = setmetatable({}, ActorStatus)   
  
  self.Name = "ActorStatusReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("ActorStatus")
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)

  return self
end

function ActorStatus:construct(actorKey)

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.ActorStatusReq.Size)  

  self.Packet.byteBuffer:_putInt(actorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.ActorStatusReq.ActorKey)  

  return self
end