TransferMoneyState = { }
TransferMoneyState.__index = TransferMoneyState
TransferMoneyState.Name = "TransferMoneyState"

setmetatable(TransferMoneyState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TransferMoneyState.new()
  local self = setmetatable({}, TransferMoneyState)
    
  self.lastTick = 0

  self.Stop = false

  --Infinity.BDO.Lua.Execute("Warehouse_OpenPanel(1002, CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation)")
  --Infinity.BDO.Lua.Execute("Warehouse_Close()")

  self.containerActor = Utils.findInstallation_Container()
  self.warehouseActor = Utils.findNpc_Warehouse()

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  
  return self
end

function TransferMoneyState:NeedToRun() 
    if self.Stop then
      return false
    end

    if self.lastTick + 2000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsDead() then
        return false
    end
   
    return Inventory.getItemCountByItemId(1,0) < 10000    
end

function TransferMoneyState:Run()
  --print("TransferMoneyState:Run()")
  
  self.containerActor = Utils.findInstallation_Container()
  self.warehouseActor = Utils.findNpc_Warehouse()

  if self.containerActor == nil and self.warehouseActor == nil then
    --print("No Container Actor found!Stopped TransferMoneyState until next restart of ExtremeFisher!")
    --self.Stop = true

    print("No Container Actor found!")

    if ExtremeFisher.Settings.Paths.Storage ~= nil and ExtremeFisher.Settings.Paths.Storage ~= "" then

      print("Init new Path -> Storage")
      ExtremeFisher.TeleportState:SetPath(ExtremeFisher.Settings.Paths.Storage, false)
      print("Set Teleport Spot->Storage")
    end

    return
  end

  if (self.containerActor ~= nil and self.containerActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000) or (self.warehouseActor ~= nil and self.warehouseActor:getPosition():getDistance(self.localPlayer:getPosition()) > 1000) then
    --self.Stop = true
    --print("Container Actor too far away! Stopping TransferMoneyState until next restart of ExtremeFisher!")

    print("Container Actor too far!")

    if ExtremeFisher.Settings.Paths.Storage ~= nil and ExtremeFisher.Settings.Paths.Storage ~= "" then

      print("Init new Path -> Storage")
      ExtremeFisher.TeleportState:SetPath(ExtremeFisher.Settings.Paths.Storage, false)
      print("Set Teleport Spot->Storage")
    end

    return
  end
    
  if self.containerActor ~= nil then

    local whMoneyItemCount, whMoneyItemSlot = Warehouse.getItemDataByItemId(1, 1002)

    if whMoneyItemCount <= 0 then
      self.Stop = true
      print("No more silver in Illya Island Warehouse! Stopping TransferMoneyState until next restart of ExtremeFisher!")
      return
    end

    local countToTransfer = 100000

    if whMoneyItemCount < countToTransfer then
      countToTransfer = whMoneyItemCount
    end

    Warehouse.moveToInventoryByInstallation(self.containerActor:getActorKey(), whMoneyItemSlot, countToTransfer)

    print("Init new Path -> Spot")
    ExtremeFisher.TeleportState:SetPath(ExtremeFisher.Settings.Paths.Storage, true)
    print("Set Teleport Storage->Spot")
  elseif self.warehouseActor ~= nil then

    local whMoneyItemCount, whMoneyItemSlot = Warehouse.getItemDataByItemId(1)

    if whMoneyItemCount <= 0 then
      self.Stop = true
      print("No more silver in Warehouse! Stopping TransferMoneyState until next restart of ExtremeFisher!")
      return
    end

    local countToTransfer = 100000

    if whMoneyItemCount < countToTransfer then
      countToTransfer = whMoneyItemCount
    end

    Warehouse.moveToInventory(whMoneyItemSlot, countToTransfer)

    --ExtremeFisher.TeleportState:SetPath(ExtremeFisher.Settings.Paths.Storage, true)
    --print("Set Teleport Storage->Spot")
  end
end