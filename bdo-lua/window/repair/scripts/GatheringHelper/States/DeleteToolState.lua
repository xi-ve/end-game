DeleteToolState = { }
DeleteToolState.__index = DeleteToolState
DeleteToolState.Name = "DeleteToolState"

setmetatable(DeleteToolState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function DeleteToolState.new()
  local self = setmetatable({}, DeleteToolState)   
  self.lastValidationTick = 0  
  return self
end

function DeleteToolState:NeedToRun()    
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end

    return true
end

function DeleteToolState:Run()
     self.lastValidationTick = Infinity.Win32.GetTickCount()

     local nextSlot = Inventory.getNextToolSlotZeroDurabilityNonRepairable()

      if nextSlot == -1 then
        return
      end

     Inventory.deleteItem(nextSlot)
end