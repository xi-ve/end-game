PopWarehouseItemToInventory = { }
PopWarehouseItemToInventory.__index = PopWarehouseItemToInventory

setmetatable(PopWarehouseItemToInventory, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PopWarehouseItemToInventory.new()
  local self = setmetatable({}, PopWarehouseItemToInventory)   
  
  self.Name = "PopWarehouseItemToInventory"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("PopWarehouseItemToInventory")   
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  self.ThroughWhereType_NPC = 0
  self.ThroughWhereType_Maid = 3
  
  return self
end

function PopWarehouseItemToInventory:construct(isMaid, itemEnchantKey, slot, count, selfActorKey, npcActorKey) 
  local throughWhereType = self.ThroughWhereType_NPC
  local itemNo = Infinity.BDO.Warehouse.getWarehouseItemNoBySlotAndWaypointKey(slot, Warehouse.getCurrentWaypointKey())

  if isMaid then 
    throughWhereType = self.ThroughWhereType_Maid
    npcActorKey = 0

    itemNo = Infinity.BDO.Warehouse.getWarehouseItemNoBySlotAndWaypointKey(slot, Warehouse.getCurrentWaypointKeyForMaid())
  end

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.Size)

  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.NpcActorKey)
  self.Packet.byteBuffer:_putShort(1, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.FixValue01)
  self.Packet.byteBuffer:_putInt(itemEnchantKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.ItemEnchantKey) 
  self.Packet.byteBuffer:_putLong(itemNo, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.ItemNo)
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.SelfActorKey)
  self.Packet.byteBuffer:_putInt(throughWhereType, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.ThroughWhereType) -- 4 byte!
  self.Packet.byteBuffer:_putIntAsLong(count, self.rawDataOffset + PacketStruct_Offsets.REQ.PopWarehouseItemToInventoryReq.Count)   

  return self
end