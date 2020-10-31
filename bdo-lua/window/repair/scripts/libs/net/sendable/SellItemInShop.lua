SellItemInShop = { }
SellItemInShop.__index = SellItemInShop

setmetatable(SellItemInShop, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SellItemInShop.new()
  local self = setmetatable({}, SellItemInShop)   
  
  self.Name = "SellItemInShopReq"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("SellItemInShop")
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function SellItemInShop:construct(npcActorKey, selfActorKey, itemEnchantKeyRaw, slot, count, moneyNo, moneyToWhereType, isTradeShop, shopSlotId)       
    
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.SellItemInShopReq.Size)

  self.Packet.byteBuffer:_putLong(moneyNo, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.MoneyNo)
  self.Packet.byteBuffer:_put(moneyToWhereType, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.MoneyToWhereType)
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.SelfActorKey)
  self.Packet.byteBuffer:_putIntAsLong(count, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.Count)
  self.Packet.byteBuffer:_putInt(itemEnchantKeyRaw, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.ItemEnchantKeyRaw)
  self.Packet.byteBuffer:_put(slot, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.Slot) 
  self.Packet.byteBuffer:_putShort(shopSlotId, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.ShopSlotId)  
  self.Packet.byteBuffer:_put(isTradeShop, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.IsTradeShop)
  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.SellItemInShopReq.NpcActorKey)  
  
  return self
end