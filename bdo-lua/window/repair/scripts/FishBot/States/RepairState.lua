RepairState = { }
RepairState.__index = RepairState
RepairState.Name = "RepairState"

setmetatable(RepairState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RepairState.new()
  local self = setmetatable({}, RepairState)
    
  self.lastTick = 0
  
  self.tentActor = Servant.getTent()
  self.localPlayer = Infinity.BDO.getLocalPlayer()

  return self
end

function RepairState:NeedToRun()  
    if not FishBot.Settings.TentRepair then
      return false
    end

    if self.localPlayer:getIsDead() then      
        return false
    end
        
    if self.lastTick + 2000 > Infinity.Win32.GetTickCount() then     
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if Equip.getMainhandDurabilityPercentage() <= 5.0 or table.length(Inventory.getRepairableFishingRodSlotsByPercentage(5.0)) > 0 then
      return true
    else      
      return false
    end
end

function RepairState:Run()  
  --print("RepairState:Run()")    
  self.tentActor = Servant.getTent()

  if self.tentActor == nil then    
    print("No Tent Actor found!")
    return
  end

  if self.tentActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000 then    
    print("Tent Actor too far!")
    return
  end
    
  if Equip.hasAnyFishingRodEquipped() then
    print("Repairing Mainhand Slot")
    --tentObjectId, slot, moneyWhereType, inventoryType, selfActorKey, npcActorKey, moneyNo
    RepairItemReq():construct(self.localPlayer:getMyTentObjectId(), 0, 0, 1, self.localPlayer:getActorKey(), -1024, self.localPlayer:getInventoryMoneyNo()).Packet:send()
  end

  for k,v in pairs(Inventory.getRepairableFishingRodSlots()) do
    print("Repairing Inventory Slot " .. v)
    --tentObjectId, slot, moneyWhereType, inventoryType, selfActorKey, npcActorKey, moneyNo
    RepairItemReq():construct(self.localPlayer:getMyTentObjectId(), v, 0, 0, self.localPlayer:getActorKey(), -1024, self.localPlayer:getInventoryMoneyNo()).Packet:send()
  end
end