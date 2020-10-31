GetTradeShopItems = { }
GetTradeShopItems.__index = GetTradeShopItems

setmetatable(GetTradeShopItems, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function GetTradeShopItems.new(byteBuffer)
  local self = setmetatable({}, GetTradeShopItems)   
   
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("GetTradeShopItems")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize
  self.itemEntryDataSize = PacketStruct_Offsets.ACK.GetTradeShopItems.ItemEntryDataSize
  self.maxItemEntries = (self.maxDataSize - self.minDataSize)/self.itemEntryDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function GetTradeShopItems:parse()
  self.Parsed = {}
    
  self.Parsed.NpcActorId = self.Packet.Data:_getShort(self.rawDataOffset + PacketStruct_Offsets.ACK.GetTradeShopItems.NpcActorId) 
  self.Parsed.NpcActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.GetTradeShopItems.NpcActorKey)
  self.Parsed.TotalSize = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.GetTradeShopItems.TotalSize) 
  self.Parsed.TradingType = self.Packet.Data:_get(self.rawDataOffset + PacketStruct_Offsets.ACK.GetTradeShopItems.TradingType) --0=none 1=normal 2=imperial 
  self.Parsed.ItemsSize = self.Packet.Data:_getShort(self.rawDataOffset + PacketStruct_Offsets.ACK.GetTradeShopItems.ItemsSize)

  self.Parsed.Items = {}

  local First_ShopSlotId = self.headerDataSize + PacketStruct_Offsets.ACK.GetTradeShopItems.ItemDataOffset_ShopSlotId

  for i = 0 , self.Parsed.ItemsSize - 1 do

    local entryDataOffset = self.rawDataOffset + (self.itemEntryDataSize * i)

    local shopItem = {} 
    
    shopItem.ItemEnchantKeyRaw = self.Packet.Data:_getInt(entryDataOffset + PacketStruct_Offsets.ACK.GetTradeShopItems.First_ItemEnchantKeyRaw)    
    shopItem.ShopSlotId = self.Packet.Data:_getShort(entryDataOffset + First_ShopSlotId)

    table.insert(self.Parsed.Items, shopItem)
  end

  return self
end