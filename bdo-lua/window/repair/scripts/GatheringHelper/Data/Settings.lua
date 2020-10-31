Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
  self.Actors = {}

  self.ShowRangeCircle = false
  self.UseAutoNav = false
  self.UseTpNav = false
  self.StopNavigatorOnNearbyPlayers = false
  self.StopRangeCollectOnNearbyPlayers = false

  return self
end
