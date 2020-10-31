SpeedhackState = { }
SpeedhackState.__index = SpeedhackState
SpeedhackState.Name = "Speedhack"

setmetatable(SpeedhackState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SpeedhackState.new()
  local self = setmetatable({}, SpeedhackState) 
  return self
end

function SpeedhackState:NeedToRun()
    
    if localPlayer:getIsDead() then
        return false
    end
      
    if not FishBot.Settings.Speedhack.Enabled then

      if localPlayer:getCharacterControler():getCharacterScene():getAnimationSpeed() > 1.0 then

        localPlayer:getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
      end

      return false
    end
 
    if (FishBot.Settings.NearbyPlayersStop or FishBot.Settings.NearbyPlayersFishingStop) and localPlayer:getIsOtherPlayersNearby() then
      
      localPlayer:getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
      return false
    end

    if string.find(localPlayer:getCharacterControler():getCurrentAnimation():getName() ,"WAIT") ~= nil or (FishBot.Settings.RandomCatchTimer and FishBot.FishHookedState.timer ~= nil) then
      localPlayer:getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
      return false
    end

    return localPlayer:getCharacterControler():getCharacterScene():getAnimationSpeed() ~= FishBot.Settings.Speedhack.Value
end

function SpeedhackState:Run()      
    print("Increasing AnimationSpeed!")
    
    localPlayer:getCharacterControler():getCharacterScene():setAnimationSpeed(FishBot.Settings.Speedhack.Value)
end