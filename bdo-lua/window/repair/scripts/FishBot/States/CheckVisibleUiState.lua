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

function CheckVisibleUiState:NeedToRun()        
    if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
      return false
    end
    
    return true
end

function CheckVisibleUiState:Run()       
     self.lastValidationTick = Infinity.Win32.GetTickCount()

     if UI.getShow("Panel_Window_DailyStamp") then

        UI.setShow("Panel_Window_DailyStamp", false)
     end

     if UI.getShow("Panel_Win_System") then

        local titelText = UI.getTitleText("Panel_Win_System")

        if titelText == "Party Invite" or titelText == "Challenge to a Duel" or titelText == "Confirm Trade Cancellation" then

          Infinity.BDO.Lua.Execute("allClearMessageData()")
        end
     end
end