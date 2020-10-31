TransferToContainerState = { }
TransferToContainerState.__index = TransferToContainerState
TransferToContainerState.Name = "TransferToContainerState"

setmetatable(TransferToContainerState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TransferToContainerState.new()
  local self = setmetatable({}, TransferToContainerState)
   
  self.Stop = false
  self.lastTick = 0 

  self.localPlayer = Infinity.BDO.getLocalPlayer()

  self.containerActor = Utils.findInstallation_Container()
  self.warehouseActor = Utils.findNpc_Warehouse()

  self.Running = false

  return self
end

function TransferToContainerState:NeedToRun()     
    if FishBot.Settings.Paths.Storage == "" then
      return false
    end

    if self.Stop then
      return false
    end

    if self.lastTick + 2000 >= Infinity.Win32.GetTickCount() then      
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsDead() then
        self.Running = false
        return false
    end
    
    if (self:hasItemsToTransfer() or not LocalPlayer.hasFreeWeight()) and (FishBot.CheckSpotState.isFishingSpot or self.Running) then
      return true
    else
      self.Running = false
      return false
    end
end

function TransferToContainerState:hasItemsToTransfer()
  for k,v in pairs(FishBot.Settings.TransferContainer) do

    local iCount, iSlot = Inventory.getItemDataByItemId(v.ItemId)

    if iSlot ~= -1 and iCount >= FishBot.Settings.TransferContainerMinCount then
      return true
    end
  end

  return false
end

function TransferToContainerState:Run()
  --print("TransferToContainerState:Run")
  self.Running = true

  self.containerActor = Utils.findInstallation_Container()
  self.warehouseActor = Utils.findNpc_Warehouse()

  if self.containerActor == nil and self.warehouseActor == nil then    
    print("No Container Actor found!")

    if FishBot.Settings.Paths.Storage ~= nil and FishBot.Settings.Paths.Storage ~= "" then

      print("Init new Path -> Storage")
      FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Storage, false)
      print("Set Teleport Spot->Storage")
    else

        print("No Storage Path found!")
    end

    return
  end

  if (self.containerActor ~= nil and self.containerActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000) or (self.warehouseActor ~= nil and self.warehouseActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000) then
    --self.Stop = true
    --print("Container Actor too far away! Stopping TransferMoneyState until next restart of FishBot!")

    print("Container Actor too far!")

    if FishBot.Settings.Paths.Storage ~= nil and FishBot.Settings.Paths.Storage ~= "" then

      print("Init new Path -> Storage")
      FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Storage, false)
      print("Set Teleport Spot->Storage")
    else

        print("No Storage Path found!")
    end

    return
  end
  
  print("moving silver to storage")

  local silverCount, silverSlot = Inventory.getItemDataByItemId(1)
  if silverSlot ~= -1 and silverCount > 0 then

      if self.containerActor ~= nil then

        print("moving silver to storage container")
        Warehouse.moveFromInventoryByInstallation(self.containerActor:getActorKey(), silverSlot, silverCount)
      elseif self.warehouseActor ~= nil then

        print("moving silver to storage")
        Warehouse.moveFromInventory(silverSlot, silverCount, self.warehouseActor:getActorKey())
      end
  end   

  print("moving items to storage")

  for k,v in pairs(FishBot.Settings.TransferContainer) do

    local iCount, iSlot = Inventory.getItemDataByItemId(v.ItemId)

    if iSlot ~= -1 and iCount >= FishBot.Settings.TransferContainerMinCount then      

      if self.containerActor ~= nil then

        print("moving item to container on slot " .. iSlot .. " with count " .. iCount)
        Warehouse.moveFromInventoryByInstallation(self.containerActor:getActorKey(), iSlot, iCount)
      elseif self.warehouseActor ~= nil then

        print("moving item to storage on slot " .. iSlot .. " with count " .. iCount)
        Warehouse.moveFromInventory(iSlot, iCount, self.warehouseActor:getActorKey())
      end       
    end
  end

  self.Running = false
end