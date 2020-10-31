GetDroppedItemListReq = { }
GetDroppedItemListReq.__index = GetDroppedItemListReq

setmetatable(GetDroppedItemListReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function GetDroppedItemListReq.new()
  local self = setmetatable({}, GetDroppedItemListReq)   
  
  self.Name = "GetDroppedItemListReq"
   
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("GetDroppedItemList") 
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function GetDroppedItemListReq:construct(actorKey)

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.GetDroppedItemListReq.Size)  

  self.Packet.byteBuffer:_putInt(actorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.GetDroppedItemListReq.ActorKey)  

  return self
end