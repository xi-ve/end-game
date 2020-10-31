TradeState = { }
TradeState.__index = TradeState
TradeState.Name = "TradeState"

setmetatable(TradeState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TradeState.new()
  local self = setmetatable({}, TradeState)
    
  self.lastTick = 0

  self.Stop = false
  
  self.tradeActor = Utils.findNpc_Trade()
  self.cached_tActorKey = nil
  self.cached_tActorPosition = nil

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  
  self.Running = false

  self.TradeItems = {}
  self.TradeItemsCount = 0

  self.ShopList = {}
  self.ShopListTotalSize = 0

  return self
end

function TradeState:NeedToRun() 
    if FishBot.Settings.Paths.Trade == "" then
      return false
    end

    if self.Stop then
      self.Running = false
      return false
    end

    if self.localPlayer:getIsDead() then
      self.Running = false
        return false
    end
        
    if self.lastTick + 2000 > Infinity.Win32.GetTickCount() then      
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    self:getTradeItems()

    if self.Running then
      return true
    elseif not self.Running and (Inventory.getFreeSlotCount() <= 2 or self.TradeItemsCount >= FishBot.Settings.MinTradeItemCount) and self.TradeItemsCount ~= 0 and FishBot.CheckSpotState.isFishingSpot then
      return true
    else
      return false
    end    
end

function TradeState:onGetTradeShopItems(packet)
  packet:parse()

  if self.tradeActor == nil then
    print("No TradeActor available, tradeActor = nil")
    return
  end

  if packet.Parsed.NpcActorKey ~= self.tradeActor:getActorKey() then
    print("NPC ActorKey is wrong!")
    return
  end

  if table.length(self.ShopList) == packet.Parsed.TotalSize then
    --print("ShopList alrdy populated!")
    return
  end

  self.ShopListTotalSize = packet.Parsed.TotalSize

  for k,v in pairs(packet.Parsed.Items) do
    self.ShopList[v.ItemEnchantKeyRaw] = v.ShopSlotId

    --print("Added ShopItem to ShopList! (" .. v.ItemEnchantKeyRaw .. " || " .. v.ShopSlotId .. ")")
  end
end

function TradeState:shouldTrade(itemId)
  for k,v in pairs(FishBot.Settings.TradeList) do
    if v.ItemId == itemId then
      return true
    end
  end

  return false
end

function TradeState:getTradeItems()
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

            if name ~= nil and itemId ~= nil and self:shouldTrade(itemId) then
                table.insert(tItems, {Slot = i, ItemId = itemId, Count = count})
                tCount = tCount + 1
            end
        end
    end

    self.TradeItems = tItems   
    self.TradeItemsCount = tCount 
end

function TradeState:Run()
  self.Running = true

  --print("TradeState:Run()")  
  
  if self.TradeItemsCount == 0 then
    self.Running = false
    return
  end

  self.tradeActor = Utils.findNpc_Trade()  

  if self.tradeActor == nil then
    
    print("No Trade Actor found!")

    if FishBot.Settings.Paths.Trade ~= nil and FishBot.Settings.Paths.Trade ~= "" then

      print("Init new Path -> Trade")
      FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Trade, false)
      print("Set Teleport Spot->Trade")
    else

      print("No Trade Path found!")
    end

    return
  elseif self.tradeActor ~= nil and self.tradeActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000 then

    print("Trade Actor too far!")

    if FishBot.Settings.Paths.Trade ~= nil and FishBot.Settings.Paths.Trade ~= "" then

      print("Init new Path -> Trade")
      FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Trade, false)
      print("Set Teleport Spot->Trade")
    else

      print("No Trade Path found!")
    end

    return  
  end
          
  if table.length(self.ShopList) == 0 then

    print("Requesting TradeShopItems")
    RequestTradeShopItems():construct(self.tradeActor:getActorKey()).Packet:send()
    return
  end

  print("Trying to sell items to trade npc")

  for k,v in pairs(self.TradeItems) do
    local itemKeyRaw = Utils.getItemKeyRaw(v.ItemId, 0)
    local shopSlotId = table.findKey(self.ShopList, itemKeyRaw)

    if shopSlotId ~= nil then

      print("Selling item " .. v.ItemId .. " on slot " .. v.Slot .. " with count " .. v.Count)
      SellItemInShop():construct(self.tradeActor:getActorKey(), self.localPlayer:getActorKey(), Utils.getItemKeyRaw(v.ItemId, 0), v.Slot, v.Count, self.localPlayer:getInventoryMoneyNo(), 0, 1, shopSlotId).Packet:send()
    else
      print("Could not find ShopSlotId for ItemKeyRaw " .. itemKeyRaw) 
    end
  end
end