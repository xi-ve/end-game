StartFishingState = { }
StartFishingState.__index = StartFishingState
StartFishingState.Name = "Start Fishing"

setmetatable(StartFishingState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function StartFishingState.new()
  local self = setmetatable({}, StartFishingState)
  self.LastStartFishTickcount = 0  
  return self
end

function StartFishingState:NeedToRun()
    
    if localPlayer:getIsDead() then
        return false
    end
        
    if not Equip.hasFishingRodEquipped() then
        return false
    end
    
    if self.LastStartFishTickcount + 1000 >= Infinity.Win32.GetTickCount() then
        return false
    end
    
    if FishBot.Settings.NearbyPlayersFishingStop and localPlayer:getIsOtherPlayersNearby() then            
      return false
    end

    return localPlayer:getCharacterControler():getCurrentAnimation():getName() == "WAIT"
end

function StartFishingState:Run()    
    print("Start fishing ...")
    
    Infinity.BDO.Input.PressKeys_Once({KeyCode_SPACE}, 50)
    
    self.LastStartFishTickcount = Infinity.Win32.GetTickCount()
end