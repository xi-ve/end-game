SpotTeleportState = { }
SpotTeleportState.__index = SpotTeleportState
SpotTeleportState.Name = "SpotTeleportState"

setmetatable(SpotTeleportState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SpotTeleportState.new()
  local self = setmetatable({}, SpotTeleportState)
  
  self.lastTick = 0

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  self.spotDistance = 1000

  self.isFishingSpot = false

  return self
end

function SpotTeleportState:NeedToRun()
    if self.lastTick + 1000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsDead() then
        return false
    end

    if FishBot.ItemMarketState.Running or FishBot.RepairState.Running or FishBot.TransferToContainerState.Running or FishBot.TradeState.Running or FishBot.VendorState.Running then
      self.isFishingSpot = false
      return false
    end

    self.spotDistance = FishBot.FishingSpot:getDistance2D(self.localPlayer:getPosition())

    if self.spotDistance >= 100 then
      self.isFishingSpot = false
      return true
    else
      self.isFishingSpot = true
      return false
    end
end

function SpotTeleportState:Run()
--print("SpotTeleportState:Run()")  

  if self.spotDistance >= 1000 then
    
    local actorPaths = 
    {
      Repair = {Name = "Repair", Actor = Utils.findNpc_Repair(), Path = FishBot.Settings.Paths.Repair},
      Storage = {Name = "Storage", Actor = Utils.findNpc_Warehouse(), Path = FishBot.Settings.Paths.Storage},
      Container = {Name = "Container", Actor = Utils.findInstallation_Container(), Path = FishBot.Settings.Paths.Storage},
      Market = {Name = "Market", Actor = Utils.findNpc_ItemMarket(), Path = FishBot.Settings.Paths.Market},
      Trade = {Name = "Trade", Actor = Utils.findNpc_Trade(), Path = FishBot.Settings.Paths.Trade},
      Vendor = {Name = "Vendor", Actor = Utils.findNpc_NormalShop(), Path = FishBot.Settings.Paths.Vendor}
    }

    local closestPath = nil
    local minDistance = nil

    for k,v in pairs(actorPaths) do

      if v.Actor ~= nil then

        local dist = v.Actor:getPosition():getDistance(self.localPlayer:getPosition())

        if minDistance == nil then

          minDistance = dist
          closestPath = v
        else

          if dist < minDistance then

            minDistance = dist
            closestPath = v
          end
        end
      end
    end

    if closestPath == nil then
      print("Could not find closestPath. Set Path to Repair!")
      closestPath = actorPaths.Repair
    end

    print("Init new Path -> " .. closestPath.Name)
    FishBot.TeleportState:SetPath(closestPath.Path, true)
    print("Set Teleport " .. closestPath.Name .. "->Spot")
    return
  elseif self.spotDistance < 1000 and self.spotDistance >= 100 then
    FishBot.TeleportState:teleportToCoords(FishBot.FishingSpot.X, FishBot.FishingSpot.Y, FishBot.FishingSpot.Z)
    return     
  end
end