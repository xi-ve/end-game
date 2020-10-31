CheckStopState = { }
CheckStopState.__index = CheckStopState
CheckStopState.Name = "Check Stop"

setmetatable(CheckStopState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CheckStopState.new()
  local self = setmetatable({}, CheckStopState)   
  self.lastValidationTick = 0 

  self.cachedPosition = localPlayer:getPosition()
  self.cachedHealth = LocalPlayer.getHp()
  return self
end

function CheckStopState:NeedToRun()        
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end
    
    return true
end

function CheckStopState:Run()       
     self.lastValidationTick = Infinity.Win32.GetTickCount()

     if localPlayer:getIsDead() then
        FishBot.StopBot()
        print("Stopped cause player is dead!")
      elseif Inventory.getFreeSlotCount() <= 0 then
        FishBot.StopBot()
        print("Stopped cause no more inventory slots!")
      elseif not Equip.hasFishingRodEquipped() and Inventory.getNextFishingRodSlot() == -1 then
        FishBot.StopBot()
        print("Stopped cause no more available fishing rods!")
      elseif self.cachedPosition:getDistance(localPlayer:getPosition()) > 1000 then
        FishBot.StopBot()
        print("Stopped cause unintentional movement!")
      elseif LocalPlayer.getHp() < self.cachedHealth then
        FishBot.StopBot()
        print("Stopped cause change in hitpoints detected!")
      end
end