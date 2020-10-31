CatchFishMinigameState = { }
CatchFishMinigameState.__index = CatchFishMinigameState
CatchFishMinigameState.Name = "CatchFishMinigameState"

setmetatable(CatchFishMinigameState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CatchFishMinigameState.new()
  local self = setmetatable({}, CatchFishMinigameState) 

  self.localPlayer = Infinity.BDO.getLocalPlayer()

  self.lastValidationTick = 0 
  return self
end

function CatchFishMinigameState:NeedToRun()    
    if self.localPlayer:getIsDead() then
        return false
    end
        
    if not Equip.hasFishingRodEquipped() then
        return false
    end
      
    if self.lastValidationTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastValidationTick = Infinity.Win32.GetTickCount()
    
    return self.localPlayer:getCharacterControler():getCurrentAnimation():getName() == "FISHING_HOOK_START"
end

function CatchFishMinigameState:Run()      
    --print("Catching Fish!")   
             
      Infinity.BDO.getLocalPlayer():setMiniGameResult(3)
end