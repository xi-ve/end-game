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

     FishBot.AvailableDurability = Inventory.getAvailableFishingRodDurability() + Equip.getFishingRodDurability()

     if FishBot.StartDurability == 0 then
     
      FishBot.StartDurability = FishBot.AvailableDurability
     end

    if FishBot.StartDurability ~= 0 then

      local hUptimeHours = ((FishBot.UpTime / 1000) /(60 * 60))

      FishBot.DurabilityPerHour = math.floor((FishBot.StartDurability - FishBot.AvailableDurability) / hUptimeHours)
    end
end