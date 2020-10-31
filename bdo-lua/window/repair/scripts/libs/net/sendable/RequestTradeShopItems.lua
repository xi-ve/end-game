RequestTradeShopItems = { }
RequestTradeShopItems.__index = RequestTradeShopItems

setmetatable(RequestTradeShopItems, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RequestTradeShopItems.new()
  local self = setmetatable({}, RequestTradeShopItems)   
  
  self.Name = "GetShopItemsReq"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("GetShopItems") 
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function RequestTradeShopItems:construct(npcActorKey)       
    
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.GetShopItemsReq.Size)

  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.GetShopItemsReq.NpcActorKey)

  return self
end