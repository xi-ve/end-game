EquipRodState = { }
EquipRodState.__index = EquipRodState
EquipRodState.Name = "Equip Rod"

setmetatable(EquipRodState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function EquipRodState.new()
  local self = setmetatable({}, EquipRodState)
  self.lastEquipTick = 0 
  self.nextFishingRodSlot = -1  
  self.skipNextCheck = false
  return self
end

function EquipRodState:NeedToRun()
    if self.skipNextCheck then
      self.skipNextCheck = false
      self.lastEquipTick = self.lastEquipTick + 1000
    end    

    if localPlayer:getIsDead() then
        return false
    end
      
    if Equip.hasFishingRodEquipped() then
      return false
    end

    if self.lastEquipTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.nextFishingRodSlot = Inventory.getNextFishingRodSlot()

   return self.nextFishingRodSlot ~= -1
end

function EquipRodState:Run()       
    self.lastEquipTick = Infinity.Win32.GetTickCount()
    
    Equip.equip(self.nextFishingRodSlot)
    print("Equipped Rod!")
end