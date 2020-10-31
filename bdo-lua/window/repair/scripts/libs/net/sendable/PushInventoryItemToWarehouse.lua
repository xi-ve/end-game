PushInventoryItemToWarehouse = { }
PushInventoryItemToWarehouse.__index = PushInventoryItemToWarehouse

setmetatable(PushInventoryItemToWarehouse, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PushInventoryItemToWarehouse.new()
  local self = setmetatable({}, PushInventoryItemToWarehouse)   
  
  self.Name = "PushInventoryItemToWarehouse"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("PushInventoryItemToWarehous")     
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  self.ThroughWhereType_NPC = 0
  self.ThroughWhereType_Maid = 3

  return self
end

function PushInventoryItemToWarehouse:construct(isMaid, inventoryType, itemId, slot, count, selfActorKey, npcActorKey) 
  local throughWhereType = self.ThroughWhereType_NPC
  local stackeeItemNo = LuaInt64(-1)

  if isMaid then 
    throughWhereType = self.ThroughWhereType_Maid
    npcActorKey = 0
  end

  if Inventory.isStackable(slot) then

    local whCount, whSlot = Warehouse.getItemDataByItemId(itemId, Warehouse.getCurrentWaypointKey())

    if whSlot ~= -1 then
      stackeeItemNo = Infinity.BDO.Warehouse.getWarehouseItemNoBySlotAndWaypointKey(whSlot, Warehouse.getCurrentWaypointKey())
    end

    if isMaid then

      whCount, whSlot = Warehouse.getItemDataByItemId(itemId, Warehouse.getCurrentWaypointKeyForMaid())

      if whSlot ~= -1 then
        stackeeItemNo = Infinity.BDO.Warehouse.getWarehouseItemNoBySlotAndWaypointKey(whSlot, Warehouse.getCurrentWaypointKeyForMaid())
      end
    end

    if stackeeItemNo == LuaInt64(-1) then
      stackeeItemNo = LuaInt64(0)
    end
  end
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.Size)

  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.NpcActorKey)
  self.Packet.byteBuffer:_putInt(throughWhereType, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.ThroughWhereType) -- 4 byte!
  self.Packet.byteBuffer:_putLong(stackeeItemNo, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.StackeeItemNo)
  self.Packet.byteBuffer:_putIntAsLong(count, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.Count)   
  self.Packet.byteBuffer:_put(slot, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.Slot)  
  self.Packet.byteBuffer:_put(inventoryType, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.InventoryType)
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.PushInventoryItemToWarehouseReq.SelfActorKey)
  return self
end