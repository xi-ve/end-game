WarehouseSilverObserveState = { }
WarehouseSilverObserveState.__index = WarehouseSilverObserveState
WarehouseSilverObserveState.Name = "WarehouseSilverObserveState"

setmetatable(WarehouseSilverObserveState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function WarehouseSilverObserveState.new()
  local self = setmetatable({}, WarehouseSilverObserveState)
  
  self.lastTick = 0

  return self
end

function WarehouseSilverObserveState:NeedToRun()   
    if self.lastTick + 5000 > Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastTick = Infinity.Win32.GetTickCount()

    return true
end

function WarehouseSilverObserveState:Run()
--print("WarehouseSilverObserveState:Run()")  

  local currentSilver = Warehouse.getCurrentSilverCount()

  if currentSilver ~= -1 then
    local gainedSilver = currentSilver - ExtremeFisher.InitialSilver

    if gainedSilver < 0 then
      gainedSilver = 0
    end

    ExtremeFisher.GainedSilver = gainedSilver
  end
end