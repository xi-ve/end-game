DetectionStopState = { }
DetectionStopState.__index = DetectionStopState
DetectionStopState.Name = "DetectionStopState"

setmetatable(DetectionStopState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function DetectionStopState.new()
  local self = setmetatable({}, DetectionStopState)
  
  self.localPlayer = Infinity.BDO.getLocalPlayer()
  
  self.lastTick = 0

  self.Stop = false

  return self
end

function DetectionStopState:NeedToRun()    
    if self.lastTick + 1000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsOtherPlayersNearby() then
      self.Stop = true

      return true
    else
      self.Stop = false
      
      return false
    end
end

function DetectionStopState:Run()
--print("DetectionStopState:Run()")  

  if FishBot.Settings.Security.EquipCamo_NearbyPlayers then
    FishBot.TeleportState:HiddenTravel()
  end

  if FishBot.Settings.Security.NearbyPlayers_Crouch and self.localPlayer:getCharacterControler():getCurrentAnimation():getName() == "WAIT" then
    --Actor.setAction("HUNKERDOWN_WAIT")

    Infinity.BDO.Input.PressKeys_Once({KeyCode_Q}, 50)
  end
end