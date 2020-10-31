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

  self.Stop = false

  self.tentActor = Servant.getTent()
  self.repairActor = Utils.findNpc_Repair()
  self.cached_tActorKey = nil
  self.cached_tActorPosition = nil

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  
  self.Running = false
  self.reachedRepairNPC = false

  return self
end

function RepairState:NeedToRun() 
    if FishBot.Settings.Paths.Repair == "" then
      return false
    end

    if self.Stop then
      self.Running = false
      self.reachedRepairNPC = false
      return false
    end

    if self.localPlayer:getIsDead() then
      self.Running = false
      self.reachedRepairNPC = false
        return false
    end
        
    if self.lastTick + 2000 > Infinity.Win32.GetTickCount() then      
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    local repairableRods = Inventory.getRepairableFishingRodSlots()

    if FishBot.Settings.VendorWhileRepair then
      FishBot.VendorState:getVendorItems()
    end

    if not FishBot.Settings.VendorWhileRepair then

      if (Inventory.getNextFishingRodSlot() == -1 and table.length(repairableRods) > 0 and FishBot.CheckSpotState.isFishingSpot) or self.Running then
        return true
      else
        self.Running = false
        self.reachedRepairNPC = false
        return false
      end
    else

      if (Inventory.getNextFishingRodSlot() == -1 and table.length(repairableRods) > 0 and FishBot.CheckSpotState.isFishingSpot) or
        (FishBot.VendorState.VendorItemsCount ~= 0 and self.reachedRepairNPC) or
       self.Running then
        return true
      else
        self.Running = false
        self.reachedRepairNPC = false
        return false
      end
    end
end

function RepairState:Run()
  self.Running = true
    --print("RepairState:Run()")  
  
    local repairableRods = Inventory.getRepairableFishingRodSlots()

    if table.length(repairableRods) == 0 then
      self.Running = false
      return
    end

  self.repairActor = Utils.findNpc_Repair()
  self.tentActor = Servant.getTent()

  if self.tentActor == nil and self.repairActor == nil then
      print("No Repair Actor found!")

      if FishBot.Settings.InstallTent then

        print("Tent spot handling")

        if FishBot.TentSpot:getDistance(self.localPlayer:getPosition()) > 1000 then

          print("Tent spot too far (>1000), trying to move to")

          if FishBot.Settings.Paths.Repair ~= nil and FishBot.Settings.Paths.Repair ~= "" then

            print("Init new Path -> Repair")
            FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Repair, false)
            print("Set Teleport Spot->Repair")
            return
          else

            print("No Repair Path found!")
          end
        elseif FishBot.TentSpot:getDistance(self.localPlayer:getPosition()) < 1000 and FishBot.TentSpot:getDistance(self.localPlayer:getPosition()) > 100 then

          print("Tent spot too far (>100), trying to move to")
          FishBot.TeleportState:teleportToCoords(FishBot.TentSpot.X, FishBot.TentSpot.Y + 25, FishBot.TentSpot.Z)
          return
        elseif FishBot.TentSpot:getDistance(self.localPlayer:getPosition()) < 100 then

          if Tent.hasInstalledTent() then

            print("Remote Collecting Tent")
            Tent.remoteCollectTent()
            return
          else

            print("Installing Tent")
            Tent.installTent()
            return
          end
        end
      end

      if FishBot.Settings.Paths.Repair ~= nil and FishBot.Settings.Paths.Repair ~= "" then

        print("Init new Path -> Repair")
        FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Repair, false)
        print("Set Teleport Spot->Repair")
      else

        print("No Repair Path found!")
      end

      return
  elseif (self.tentActor ~= nil and self.tentActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000) or
          (self.repairActor ~= nil and self.repairActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000) then

      print("Repair Actor too far!")

      if FishBot.Settings.Paths.Repair ~= nil and FishBot.Settings.Paths.Repair ~= "" then

        print("Init new Path -> Repair")
        FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Repair, false)
        print("Set Teleport Spot->Repair")
      else

        print("No Repair Path found!")
      end

      return  
  end  

  if self.tentActor == nil then
    
    self.reachedRepairNPC = true

    local moneyWhereType = 2
    local moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())

    if FishBot.Settings.UseInventorySilverToRepair then

      moneyWhereType = 0
      moneyNo = self.localPlayer:getInventoryMoneyNo()
    end

    if Equip.hasAnyFishingRodEquipped() then
      print("Repairing Mainhand Slot")
      RepairItemReq():construct(0, 0, moneyWhereType, 1, self.localPlayer:getActorKey(), self.repairActor:getActorKey(), moneyNo).Packet:send()
    end

    if Equip.hasAnyFloatEquipped() then
      print("Repairing Offhand Slot")
      RepairItemReq():construct(0, 1, moneyWhereType, 1, self.localPlayer:getActorKey(), self.repairActor:getActorKey(), moneyNo).Packet:send()
    end

    for k,v in pairs(Inventory.getRepairableFishingRodSlots()) do
      print("Repairing Inventory Slot " .. v)
      RepairItemReq():construct(0, v, moneyWhereType, 0, self.localPlayer:getActorKey(), self.repairActor:getActorKey(), moneyNo).Packet:send()
    end

    for k,v in pairs(Inventory.getRepairableFloatSlots()) do
      print("Repairing Inventory Slot " .. v)
      RepairItemReq():construct(0, v, moneyWhereType, 0, self.localPlayer:getActorKey(), self.repairActor:getActorKey(), moneyNo).Packet:send()
    end

    if FishBot.Settings.VendorWhileRepair then

      FishBot.VendorState:getVendorActor()
      FishBot.VendorState:sellAll()
    end
  else

    self.reachedRepairNPC = true

    if Inventory.getItemCountByItemId(1,0) < 100000 then

      print("Trying to Transfer Money into Inventory via Maid")

      if not Maids.hasStorageMaid() then
        print("No Storage Maid available!")
        return
      end

      if Maids.getStorageMaidCooldown() > 0 then
        print("No Free Storage Maid available!")
        return
      end

      local whMoneyItemCount, whMoneyItemSlot = Warehouse.getItemDataByItemId(1, Warehouse.getCurrentWaypointKeyForMaid())

      if whMoneyItemCount <= 0 then
        print("No more silver available in Warehouse!")
        return
      end

      local countToTransfer = 500000 - Inventory.getItemCountByItemId(1,0)

      if whMoneyItemCount < countToTransfer then
        countToTransfer = whMoneyItemCount
      end

      Warehouse.moveToInventoryByMaid(whMoneyItemSlot, countToTransfer)
      print("Transfered " .. countToTransfer .. " to Inventory via Maid!")
      return
    end

    if self.tentActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000 then    
      print("Tent Actor too far!")
      return
    end

    if Equip.hasAnyFishingRodEquipped() then
      print("(Tent)Repairing Mainhand Slot")
    
      RepairItemReq():construct(self.localPlayer:getMyTentObjectId(), 0, 0, 1, self.localPlayer:getActorKey(), -1024, self.localPlayer:getInventoryMoneyNo()).Packet:send()
    end

    if Equip.hasAnyFloatEquipped() then
      print("(Tent)Repairing Offhand Slot")
    
      RepairItemReq():construct(self.localPlayer:getMyTentObjectId(), 1, 0, 1, self.localPlayer:getActorKey(), -1024, self.localPlayer:getInventoryMoneyNo()).Packet:send()
    end

    for k,v in pairs(Inventory.getRepairableFishingRodSlots()) do
      print("(Tent)Repairing Inventory Slot " .. v)
    
      RepairItemReq():construct(self.localPlayer:getMyTentObjectId(), v, 0, 0, self.localPlayer:getActorKey(), -1024, self.localPlayer:getInventoryMoneyNo()).Packet:send()
    end

    for k,v in pairs(Inventory.getRepairableFloatSlots()) do
      print("(Tent)Repairing Inventory Slot " .. v)
    
      RepairItemReq():construct(self.localPlayer:getMyTentObjectId(), v, 0, 0, self.localPlayer:getActorKey(), -1024, self.localPlayer:getInventoryMoneyNo()).Packet:send()
    end    
  end
  

  --self.Running = false
end