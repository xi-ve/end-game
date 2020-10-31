DeleteRodState = { }
DeleteRodState.__index = DeleteRodState
DeleteRodState.Name = "Delete Rods"

setmetatable(DeleteRodState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function DeleteRodState.new()
  local self = setmetatable({}, DeleteRodState)   
  self.lastValidationTick = 0  
  self.nextNonRepairableRodSlot = -1

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  return self
end

function DeleteRodState:NeedToRun()    
    if self.localPlayer:getIsDead() then
        return false
    end
        
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastValidationTick = Infinity.Win32.GetTickCount()

    self.nextNonRepairableRodSlot = Inventory.getNextNonRepairableFishingRodSlot()

    return self.nextNonRepairableRodSlot ~= -1 and self.nextNonRepairableRodSlot ~= nil
end

function DeleteRodState:Run()    
     print("Deleting FishingRod on Slot " .. tostring(self.nextNonRepairableRodSlot))
     
     Inventory.deleteItem(self.nextNonRepairableRodSlot)
end