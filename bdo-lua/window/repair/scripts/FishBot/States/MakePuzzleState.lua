MakePuzzleState = { }
MakePuzzleState.__index = MakePuzzleState
MakePuzzleState.Name = "MakePuzzleState"

setmetatable(MakePuzzleState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function MakePuzzleState.new()
  local self = setmetatable({}, MakePuzzleState)   
  self.lastValidationTick = 0  
  return self
end

function MakePuzzleState:NeedToRun()        
    if self.lastValidationTick + 1000 >= Infinity.Win32.GetTickCount() then
      return false
    end
        
    self.lastValidationTick = Infinity.Win32.GetTickCount()

    if not FishBot.Settings.AutoCombineRelics then
      return false
    end

    if UI.getChecked("Panel_Window_Inventory", "CheckButton_ItemSort") then
      print("Please disable Auto Arrange in your inventory or Auto Relic Combine will not work!")
      return false
    end

    return Inventory.getItemCountByItemId(40218, 0) >= 5
end

function MakePuzzleState:Run() 
     Inventory.combineRelics()
end