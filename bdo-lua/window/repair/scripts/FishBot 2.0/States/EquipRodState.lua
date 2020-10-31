EquipRodState = { }
EquipRodState.__index = EquipRodState
EquipRodState.Name = "EquipRodState"

setmetatable(EquipRodState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function EquipRodState.new()
  local self = setmetatable({}, EquipRodState)
   
  self.Stop = false
  self.lastEquipTick = 0 

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  self.characterController = self.localPlayer:getCharacterControler()
  self.CurrentAction = self.characterController:getCurrentAnimation():getName()

  return self
end

function EquipRodState:NeedToRun()     
    if self.Stop then
      return false
    end

    if self.lastEquipTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastEquipTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsDead() then
        return false
    end
    
    self.CurrentAction = self.characterController:getCurrentAnimation():getName()

    if string.find(self.CurrentAction, "HUNKERDOWN") ~= nil or string.find(self.CurrentAction, "JUMP") ~= nil then
      
      Infinity.BDO.Input.clearQueue()
      return false
    end

    if Inventory.getNextFloatSlot() == -1 then
      return not Equip.hasFishingRodEquipped() and not FishBot.ItemMarketState.Running and FishBot.SpotTeleportState.isFishingSpot
    else
      return (not Equip.hasFishingRodEquipped() or not Equip.hasFloatEquipped()) and not FishBot.ItemMarketState.Running and FishBot.SpotTeleportState.isFishingSpot
    end
end

function EquipRodState:Run()
  print("EquipRodState:Run")
  local nextRod = Inventory.getNextFishingRodSlot()

  if nextRod == -1 then
    --print("Auto Rod Equip stopped cause no more rods available!")
    --self.Stop = true
    return
  end

  Equip.equip(nextRod, 0)

  local nextFloat = Inventory.getNextFloatSlot()

  if nextFloat == -1 then
    --print("Auto Rod Equip stopped cause no more rods available!")
    --self.Stop = true
    return
  end
  
  Equip.equip(nextFloat, 1)
end