AddItemToInventoryAck = { }
AddItemToInventoryAck.__index = AddItemToInventoryAck

setmetatable(AddItemToInventoryAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function AddItemToInventoryAck.new(byteBuffer)
  local self = setmetatable({}, AddItemToInventoryAck)   
    
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("AddItemToInventory")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize
    
  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)  

  return self
end

function AddItemToInventoryAck:parse()
  self.Parsed = {}
      
  self.Parsed.ToActorKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.AddItemToInventory.ToActorKey)
  self.Parsed.ToWhereType = self.Packet.Data:_get(self.rawDataOffset + PacketStruct_Offsets.ACK.AddItemToInventory.ToWhereType)
  self.Parsed.ItemEnchantKey = self.Packet.Data:_getInt(self.rawDataOffset + PacketStruct_Offsets.ACK.AddItemToInventory.ItemEnchantKey)
  self.Parsed.Count = self.Packet.Data:_getLong(self.rawDataOffset + PacketStruct_Offsets.ACK.AddItemToInventory.ItemEnchantKey + 4):getUnsafe()
    
  return self
end