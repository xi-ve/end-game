CheckVisibleUiState = { }
CheckVisibleUiState.__index = CheckVisibleUiState
CheckVisibleUiState.Name = "CheckVisibleUiState"

setmetatable(CheckVisibleUiState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CheckVisibleUiState.new()
  local self = setmetatable({}, CheckVisibleUiState)   
  self.lastValidationTick = 0  
  return self
end

function CheckVisibleUiState:hasClosablePanels()
  if UI.getShow("Panel_Window_DailyStamp") then
    return true
  end

  if UI.getShow("Panel_Win_System") then
    return true
  end

  if UI.getShow("Panel_Window_DailyChallenge") then
    return true
  end
end

function CheckVisibleUiState:NeedToRun()        
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end
    
    self.lastValidationTick = Infinity.Win32.GetTickCount()

    return self:hasClosablePanels()
end

function CheckVisibleUiState:Run()
     UI.setShow("Panel_Window_DailyStamp", false)
     Infinity.BDO.Lua.Execute("allClearMessageData()")
     UI.setShow("Panel_Window_DailyChallenge", false)
end