Timer = {}
Timer.__index = Timer

setmetatable(Timer, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Timer.new(seconds)
local self = setmetatable({}, Timer) 

  self._expireSeconds = seconds 
  self._startTime = nil 
  self._stopTime = nil 

  return self
end


function Timer:Start()
  self._startTime = os.clock()
  self._stopTime = nil
end

function Timer:Stop()

  self._stopTime = os.clock ()
end

function Timer:Reset()
  if self._stopTime == nil then
    self._startTime = os.clock ()
  else
    self._startTime = nil
    self._stopTime = nil
  end
end

function Timer:IsRunning()
  if self._startTime ~= nil and self._stopTime == nil then
    return true
  end
  return false
end

function Timer:Expired()

  if self._startTime ~= nil and self._stopTime == nil and self._expireSeconds + self._startTime <= os.clock ()
    or self._startTime ~= nil and self._stopTime ~= nil and self._expireSeconds + self._startTime <= self._stopTime then
    return true
  end

  return false

end

function Timer:TimeLeft()

  return math.floor((self._startTime + self._expireSeconds) - os.clock())
end