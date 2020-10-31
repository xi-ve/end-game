RepairItemReq = { }
RepairItemReq.__index = RepairItemReq

setmetatable(RepairItemReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RepairItemReq.new()
  local self = setmetatable({}, RepairItemReq)   
  
  self.Name = "RepairItemReq"
 
  self.isEncrypted = true
  self.opCode = OpCodes.getReqOpCode("RepairItem")  
  self.rawDataOffset = 5
  
  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function RepairItemReq:construct(tentObjectId, slot, moneyWhereType, inventoryType, selfActorKey, npcActorKey, moneyNo, fuelSlot, fuelQuantity, repairType) 
  if (tentObjectId == 0) then
    --Fix for when scripts just give 0 as tentObjectId since they do not want to use the tent to repair
    tentObjectId = LuaInt64(0)
  end

  -- Set default values for optional parameters used for alchemy stone recharging.
  if fuelSlot == nil then fuelSlot = 0 end
  if fuelQuantity == nil then fuelQuantity = 0 end
  if repairType == nil then repairType = 0 end -- 0 for normal repair, 2 for alch stone.
  
  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.RepairItemReq.Size)

  self.Packet.byteBuffer:_putLong(tentObjectId, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.TentObjectId)
  self.Packet.byteBuffer:_putLong(moneyNo, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.MoneyNo)
  self.Packet.byteBuffer:_put(moneyWhereType, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.MoneyWhereType)
  self.Packet.byteBuffer:_putIntAsLong(slot, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.Slot)
  self.Packet.byteBuffer:_put(inventoryType, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.InventoryType)
  self.Packet.byteBuffer:_putInt(selfActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.SelfActorKey)  
  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.NpcActorKey)  
  self.Packet.byteBuffer:_put(fuelSlot, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.FuelSlot)
  self.Packet.byteBuffer:_putIntAsLong(fuelQuantity, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.FuelQuantity)
  self.Packet.byteBuffer:_put(repairType, self.rawDataOffset + PacketStruct_Offsets.REQ.RepairItemReq.RepairType)

  return self
end