ItemMarketState = { }
ItemMarketState.__index = ItemMarketState
ItemMarketState.Name = "ItemMarketState"

setmetatable(ItemMarketState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ItemMarketState.new()
  local self = setmetatable({}, ItemMarketState)   
  
  self.lastTick = 0
  
  self.marketActor = Utils.findNpc_ItemMarket()
  self.localPlayer = Infinity.BDO.getLocalPlayer()

  self.Running = false

  self.MarketItems = {}
  self.MarketItemsCount = 0

  return self
end

function ItemMarketState:NeedToRun()  
    if FishBot.Settings.Paths.Market == "" then
      return false
    end

    if self.localPlayer:getIsDead() then
        return false
    end
        
    if self.lastTick + 2000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()
    
    if not Infinity.Scripting.GetScript("AutoSell").IsRunning then
      Infinity.Scripting.GetScript("AutoSell"):Start()
    end

    if FishBot.Settings.OnlyMaids then
      return false
    end

    self:getSellItems()

      if self.Running then
        return true
      elseif not self.Running and (Inventory.getFreeSlotCount() <= 2 or self.MarketItemsCount >= FishBot.Settings.MinMarketItemCount) and self.MarketItemsCount ~= 0 and FishBot.CheckSpotState.isFishingSpot then
        return true
      else
        return false
      end    
end

function ItemMarketState:shouldSell(itemId)
  for k,v in pairs(FishBot.Settings.MarketList) do
    if v.ItemId == itemId then
      return true
    end
  end

  return false
end

function ItemMarketState:getSellItems()
    local invenMaxSize = Inventory.getMaxSize()

    local tItems = {}
    local tCount = 0

    if invenMaxSize == 0 then
        return tItems
    end
    
    for i = 2, invenMaxSize - 1 do
        if Inventory.hasItemWrapper(i) then
            local name
            local itemId
            local count

            name, itemId, count = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil and self:shouldSell(itemId) then
                table.insert(tItems, {Slot = i, ItemId = itemId, Count = count})
                tCount = tCount + 1
            end
        end
    end

    self.MarketItems = tItems   
    self.MarketItemsCount = tCount 
end

function ItemMarketState:getSoldItems()
  Infinity.BDO.Lua.Execute("requestItemMarketMyItems(true, false)")

  return ItemMarket.getSaleCount()
end

function ItemMarketState:getRegistredCount()
  Infinity.BDO.Lua.Execute("requestItemMarketMyItems(true, false)")

  return ItemMarket.getRegistredCount()
end

function ItemMarketState:Run()
  if not self.Running then    
    print("Starting ItemMarketState")
    self.Running = true
  end

  
    if self.MarketItemsCount == 0 then
      print("Stopping ItemMarketState!")
      self.Running = false
      return
    end
   
    if Maids.hasMarketMaid() and Maids.getMarketMaidCooldown() <= 0 then
      return
    end

  self.marketActor = Utils.findNpc_ItemMarket()

  if self.marketActor == nil then
    --self.Stop = true
    --print("No Repair NPC found! Stopping RepairState until next restart of FishBot!")

    print("No Market Actor found!")

    if FishBot.Settings.Paths.Market ~= nil and FishBot.Settings.Paths.Market ~= "" then

      print("Init new Path -> Market")
      FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Market, false)
      print("Set Teleport Spot->Market")
    end

    return
  end

  if self.marketActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000 then
    --self.Stop = true
    --print("Repair NPC too far away! Stopping RepairState until next restart of FishBot!")

    print("Market Actor too far!")

    if FishBot.Settings.Paths.Market ~= nil and FishBot.Settings.Paths.Market ~= "" then

      print("Init new Path -> Market")
      FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Market, false)
      print("Set Teleport Spot->Market")
    end

    return
  end
end