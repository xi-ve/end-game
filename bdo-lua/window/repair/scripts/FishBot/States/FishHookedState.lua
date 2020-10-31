FishHookedState = { }
FishHookedState.__index = FishHookedState
FishHookedState.Name = "Fish Hooked"

setmetatable(FishHookedState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function FishHookedState.new()
  local self = setmetatable({}, FishHookedState) 
  self.lastValidationTick = 0  
  self.currentAction = ""

  self.timer = nil
  return self
end

function FishHookedState:NeedToRun()
    
    if localPlayer:getIsDead() then
        return false
    end
        
    if not Equip.hasFishingRodEquipped() then
        return false
    end
      
    if self.lastValidationTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end
        
    if FishBot.Settings.NearbyPlayersFishingStop and localPlayer:getIsOtherPlayersNearby() then            
      return false
    end

    if localPlayer:getCharacterControler():getCurrentAnimation():getName() ~= "FISHING_HOOK_ING" then
      return false
    end

    local otherPlayers = localPlayer:getIsOtherPlayersNearby()

    if FishBot.Settings.NearbyPlayersRandomCatchTimer and not otherPlayers then
      self.timer = nil
    end

    if FishBot.Settings.RandomCatchTimer or (FishBot.Settings.NearbyPlayersRandomCatchTimer and otherPlayers) then            
      
      if self.timer == nil then
        
        self.timer = Timer(FishHookedState:getRandomCatchTime())
        self.timer:Start()

        return false
      end

      if self.timer:IsRunning() and not self.timer:Expired() then
        return false
      end

      if self.timer:Expired() then
        self.timer = nil
      end
    else

      self.timer = nil
    end
    
    return true
end

function FishHookedState:getRandomCatchTime()
  
  local nextAutoCatchTick = localPlayer:getNextFishAutoCatch()
  local currentTick = Infinity.BDO.getTime()

  local autoCatchDif = nextAutoCatchTick - currentTick

  local minTime = math.floor(autoCatchDif * 0.40)
  local maxTime = math.floor(autoCatchDif * 0.80)

  local rndSeconds = math.floor(math.random(minTime, maxTime) / 1000)

  print("Set next Random Catch Timer to " .. rndSeconds .. " sec")
  return rndSeconds
end

function FishHookedState:Run()      
    print("Fish Hooked!")

    self.lastValidationTick = Infinity.Win32.GetTickCount()
    
    Infinity.BDO.Input.PressKeys_Once({KeyCode_SPACE}, 50)
end