CatchFishMinigameState = { }
CatchFishMinigameState.__index = CatchFishMinigameState
CatchFishMinigameState.Name = "Catch Fish Minigame"

setmetatable(CatchFishMinigameState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CatchFishMinigameState.new()
  local self = setmetatable({}, CatchFishMinigameState) 
  self.lastValidationTick = 0  
  self.currentAction = ""
  return self
end

function CatchFishMinigameState:NeedToRun()
    
    if localPlayer:getIsDead() then
        return false
    end
        
    if not Equip.hasFishingRodEquipped() then
        return false
    end
      
    if self.lastValidationTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.currentAction = localPlayer:getCharacterControler():getCurrentAnimation():getName()

    return self.currentAction == "FISHING_HOOK_START"
end

function CatchFishMinigameState:Run()      
    print("Catching Fish!")

    self.lastValidationTick = Infinity.Win32.GetTickCount()

    Infinity.BDO.getLocalPlayer():setMiniGameResult(3)
end