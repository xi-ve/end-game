CancelFishingState = { }
CancelFishingState.__index = CancelFishingState
CancelFishingState.Name = "CancelFishingState"

setmetatable(CancelFishingState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CancelFishingState.new()
  local self = setmetatable({}, CancelFishingState)
  
  self.localPlayer = Infinity.BDO.getLocalPlayer()
  self.characterController = self.localPlayer:getCharacterControler()

  self.Cache_CatchTime = 0

  self.lastRun = 0

  self.canCancel = true

  return self
end

function CancelFishingState:isValidGrade()  
  return FishBot.isValidFishgrade(Fishing.getFishGrade())
end

function CancelFishingState:getNextCatchTimeLimit()    
    return self.Cache_CatchTime + 15000
end

function CancelFishingState:NeedToRun()
    if self.localPlayer:getIsDead() then
      return false
    end
       
    if self.lastRun + 400 > Infinity.Win32.GetTickCount() then
      return false
    end
  
    self.lastRun = Infinity.Win32.GetTickCount()

    if self.Cache_CatchTime > 0 and Infinity.BDO.getTime():getUnsafe() >= self:getNextCatchTimeLimit() then

      print("Canceled Fishing due to fishingTime timeout")      
      return true
    end  

   return false
end

function CancelFishingState:Run()
--print("CancelFishingState:Run()")  

  local nextSlot = Inventory.getNextFishingRodSlot()

  if nextSlot == -1 then
    --print("No Next Rod Slot found")
    nextSlot = Inventory.getNextMainhandSlot()

    --print("Next Mainhand Slot " .. nextSlot)
  end

  if nextSlot ~= -1 then

    Equip.equip(nextSlot, 0)    
    return
  end

  Equip.unequip(0)  
end