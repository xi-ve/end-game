CheckSpotState = { }
CheckSpotState.__index = CheckSpotState
CheckSpotState.Name = "CheckSpotState"

setmetatable(CheckSpotState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CheckSpotState.new()
  local self = setmetatable({}, CheckSpotState)
  
  self.lastTick = 0

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  
  self.isFishingSpot = false

  return self
end

function CheckSpotState:NeedToRun()
    if self.lastTick + 1000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if self.localPlayer:getIsDead() then
        return false
    end

    self.spotDistance = FishBot.FishingSpot:getDistance2D(self.localPlayer:getPosition())

    --print("SpotDistance: " .. self.spotDistance)

    if self.spotDistance >= 100 then
      self.isFishingSpot = false      
    else
      self.isFishingSpot = true      
    end

    return false
end

function CheckSpotState:Run()
--print("CheckSpotState:Run()")  
end