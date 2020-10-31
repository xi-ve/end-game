GetDroppedItemsAck = { }
GetDroppedItemsAck.__index = GetDroppedItemsAck

setmetatable(GetDroppedItemsAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function GetDroppedItemsAck.new(byteBuffer)
  local self = setmetatable({}, GetDroppedItemsAck)   
    
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("GetDroppedItems")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize
  self.itemEntryDataSize = PacketStruct_Offsets.ACK.GetDroppedItems.ItemEntryDataSize
  self.maxItemEntries = (self.maxDataSize - self.minDataSize)/self.itemEntryDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function GetDroppedItemsAck:parse()
  self.Parsed = {}
      
  self.Parsed.ListCount = self.Packet.Data:_getShort(self.rawDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ListCount)
  self.Parsed.ActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ActorKey)  

  self.Parsed.Items = {}  

  for i = 0, self.Parsed.ListCount - 1 do
        
    local entryDataOffset = self.rawDataOffset + (self.itemEntryDataSize * i)

    local item = {}  
        
    item.ItemEnchantKey = self.Packet.Data:_getInt(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey)

    item.Count = self.Packet.Data:_getLong(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 4):getUnsafe()
    item.ExpirationPeriod = self.Packet.Data:_getLong(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 12):getUnsafe()
    item.IsVested = self.Packet.Data:_get(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 20)
    item.Price = self.Packet.Data:_getLong(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 21):getUnsafe()
    item.RegionId = self.Packet.Data:_getShort(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 29)
    item.Endurance = self.Packet.Data:_getShort(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 31)
    item.MaxEndurance = self.Packet.Data:_getShort(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 33)
    item.ObjectId = self.Packet.Data:_getLong(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 35)
    item.AlchemyStoneExp = self.Packet.Data:_getInt(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.ItemEnchantKey + 68)

    item.Index = self.Packet.Data:_get(entryDataOffset + PacketStruct_Offsets.ACK.GetDroppedItems.Index) 

    table.insert(self.Parsed.Items, item)
  end 

  return self
end

function GetDroppedItemsAck:construct()
    
  return self
end