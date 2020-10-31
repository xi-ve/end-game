CollectTentReq = { }
CollectTentReq.__index = CollectTentReq

setmetatable(CollectTentReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CollectTentReq.new()
  local self = setmetatable({}, CollectTentReq)   
  
  self.Name = "CollectTentReq"
   
  self.isEncrypted = false
  self.opCode = OpCodes.getReqOpCode("CollectTent") 
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function CollectTentReq:construct(tentId)

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.CollectTentReq.Size)

  self.Packet.byteBuffer:_putLong(tentId, self.rawDataOffset + PacketStruct_Offsets.REQ.CollectTentReq.TentNo)
  self.Packet.byteBuffer:_put(1, self.rawDataOffset + PacketStruct_Offsets.REQ.CollectTentReq.FixValue01)
  return self
end