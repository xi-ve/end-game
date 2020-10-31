GetStatsState = { }
GetStatsState.__index = GetStatsState
GetStatsState.Name = "Check Stop"

setmetatable(GetStatsState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function GetStatsState.new()
  local self = setmetatable({}, GetStatsState)   
  self.lastValidationTick = 0 
  return self
end

function GetStatsState:NeedToRun()        
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end
    
    return true
end

function GetStatsState:Run()       
     self.lastValidationTick = Infinity.Win32.GetTickCount()

     local availableDura = Inventory.getAvailableFishingRodDurability()
     local equipDura = Equip.getFishingRodDurability()

      if availableDura ~= nil and equipDura ~= nil then
        FishBot.AvailableDurability = availableDura + equipDura
      end
     
    FishBot.FreeInventorySlots = Inventory.getFreeSlotCount()
end