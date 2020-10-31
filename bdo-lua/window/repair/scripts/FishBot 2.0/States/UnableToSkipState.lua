UnableToSkipState = { }
UnableToSkipState.__index = UnableToSkipState
UnableToSkipState.Name = "UnableToSkipState"

setmetatable(UnableToSkipState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function UnableToSkipState.new()
  local self = setmetatable({}, UnableToSkipState)
    
  return self
end

function UnableToSkipState:NeedToRun()
    return FishBot.DetectionStopState.Stop
end

function UnableToSkipState:Run()

end