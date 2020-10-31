SpeedhackState = { }
SpeedhackState.__index = SpeedhackState
SpeedhackState.Name = "SpeedhackState"

setmetatable(SpeedhackState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SpeedhackState.new()
  local self = setmetatable({}, SpeedhackState) 
  self.lastTick = 0 

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  self.characterScene = self.localPlayer:getCharacterControler():getCharacterScene()
  return self
end

function SpeedhackState:NeedToRun()  
     if self.lastTick + 1000 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsDead() then
        return false
    end
        
    return self.characterScene:getAnimationSpeed() ~= ExtremeFisher.Settings.Speedhack and not ExtremeFisher.ItemMarketState.Running and ExtremeFisher.SpotTeleportState.isFishingSpot
end

function SpeedhackState:Run() 
  --print("SpeedhackState:Run()")  

  self.characterScene:setAnimationSpeed(ExtremeFisher.Settings.Speedhack)
end