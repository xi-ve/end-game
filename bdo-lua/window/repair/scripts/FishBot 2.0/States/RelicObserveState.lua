RelicObserveState = { }
RelicObserveState.__index = RelicObserveState
RelicObserveState.Name = "RelicObserveState"

setmetatable(RelicObserveState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RelicObserveState.new()
  local self = setmetatable({}, RelicObserveState)
  
  self.lastTick = 0

  return self
end

function RelicObserveState:NeedToRun()
    if not ExtremeFisher.Settings.RelicFlip then
      return false
    end

    if self.lastTick + 5000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    return true
end

function RelicObserveState:Run()
--print("RelicObserveState:Run()")  

  if Inventory.getRelicShardCount() >= 30 then
    ExtremeFisher.deleteRelics = true
  else
    ExtremeFisher.deleteRelics = false
  end
end