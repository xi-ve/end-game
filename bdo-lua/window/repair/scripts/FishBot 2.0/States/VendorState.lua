VendorState = { }
VendorState.__index = VendorState
VendorState.Name = "VendorState"

setmetatable(VendorState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function VendorState.new()
  local self = setmetatable({}, VendorState)
    
  self.lastTick = 0

  self.Stop = false
  
  self.vendorActor = Utils.findNpc_NormalShop()
  
  self.localPlayer = Infinity.BDO.getLocalPlayer()
  
  self.VendorItems = {}   
  self.VendorItemsCount = 0 

  self.Running = false
  
  return self
end

function VendorState:NeedToRun() 
    if FishBot.Settings.Paths.Vendor == "" then
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
    
    self:getVendorItems()

    if self.Running then
      return true
    elseif not self.Running and self.VendorItemsCount >= FishBot.Settings.MinVendorItemCount and self.VendorItemsCount ~= 0 and FishBot.CheckSpotState.isFishingSpot then
      return true
    else
      return false
    end    
end

function VendorState:shouldTrade(itemId)
  for k,v in pairs(FishBot.Settings.VendorList) do
    if v.ItemId == itemId then
      return true
    end
  end

  return false
end

function VendorState:getVendorItems()
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
                tCount = tCount + count
            end
        end
    end

    self.VendorItems = tItems   
    self.VendorItemsCount = tCount 
end

function VendorState:getVendorActor()
    self.vendorActor = Utils.findNpc_NormalShop()  
end

function VendorState:Run()
  self.Running = true

  --print("VendorState:Run()")  
  
  if self.VendorItemsCount == 0 then
    self.Running = false
    return
  end

  self:getVendorActor()

  if self.vendorActor == nil then
    
      print("No Vendor Actor found!")

      if FishBot.Settings.Paths.Vendor ~= nil and FishBot.Settings.Paths.Vendor ~= "" then

        print("Init new Path -> Vendor")
        FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Vendor, false)
        print("Set Teleport Spot->Vendor")
      else

        print("No Vendor Path found!")
      end

      return  
  end
    
    if self.vendorActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000 then
    
      print("Vendor Actor too far!")

      if FishBot.Settings.Paths.Vendor ~= nil and FishBot.Settings.Paths.Vendor ~= "" then

        print("Init new Path -> Vendor")
        FishBot.TeleportState:SetPath(FishBot.Settings.Paths.Trade, false)
        print("Set Teleport Spot->Vendor")
      else

        print("No Vendor Path found!")
      end

      return
    end
    
    self:sellAll()
end

function VendorState:sellAll()
  
  if self.vendorActor == nil then

    print("Could not find any Vendor NPC")
    return
  end

  Infinity.BDO.getShopManager():requestShopData(self.vendorActor:getActorKey())
  local moneyNo = Infinity.BDO.Warehouse.getCurrentMoneyNoByWaypointKey(Warehouse.getCurrentWaypointKey())

  print("Trying to sell items to vendor npc")

  for k,v in pairs(self.VendorItems) do
    
    local shopSlotId = Infinity.BDO.getShopManager():getShopSlotId(v.ItemId)

    if shopSlotId ~= 0 then

      print("Selling item " .. v.ItemId .. " on slot " .. v.Slot .. " with count " .. v.Count)
      SellItemInShop():construct(self.vendorActor:getActorKey(), self.localPlayer:getActorKey(), v.ItemId, v.Slot, v.Count, moneyNo, 2, 0, shopSlotId).Packet:send()
    else
     print("Could not find ShopSlotId for ItemKey " .. v.ItemId) 
    end
  end
end