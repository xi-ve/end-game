TimedStopState = { }
TimedStopState.__index = TimedStopState
TimedStopState.Name = "TimedStopState"

setmetatable(TimedStopState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TimedStopState.new()
  local self = setmetatable({}, TimedStopState)
  
  self.lastTick = 0
    
  return self
end

function TimedStopState:NeedToRun()    
    if self.lastTick + 2000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    if not ExtremeFisher.Settings.TimedStop then
      return false
    end

    return ((ExtremeFisher.UpTime / 1000) /(60 * 60)) >= ExtremeFisher.Settings.TimedStopValue
end

function TimedStopState:Run()
  --print("TimedStopState:Run()")
    
  print("Stopped due to Timed Stop after " .. ExtremeFisher.Settings.TimedStopValue .. " hours!")

  ExtremeFisher.TeleportState:HiddenTravel()
  ExtremeFisher.StopBot()
end