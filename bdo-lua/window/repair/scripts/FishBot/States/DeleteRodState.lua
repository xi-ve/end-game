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
  return self
end

function DeleteRodState:NeedToRun()
    
    if localPlayer:getIsDead() then
        return false
    end
        
    if not FishBot.Settings.DeleteRods.Enabled then
      return false
    end
        
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.nextNonRepairableRodSlot = Inventory.getNextNonRepairableFishingRodSlot()

    return self.nextNonRepairableRodSlot ~= -1 and self.nextNonRepairableRodSlot ~= nil
end

function DeleteRodState:Run()    
     print("Deleting FishingRod on Slot " .. tostring(self.nextNonRepairableRodSlot))

     self.lastValidationTick = Infinity.Win32.GetTickCount()

     Inventory.deleteItem(self.nextNonRepairableRodSlot)
end