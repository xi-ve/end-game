AntiStuckState = { }
AntiStuckState.__index = AntiStuckState
AntiStuckState.Name = "AntiStuckState"

setmetatable(AntiStuckState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function AntiStuckState.new()
  local self = setmetatable({}, AntiStuckState) 
    
  self.LastTick = 0

  self.LastPos = nil

  return self
end

function AntiStuckState:NeedToRun()
  if LocalPlayer.isDead() then
    return false
  end
    
  if self.LastTick + 3000 > Infinity.Win32.GetTickCount() then
    return false
  end

  self.LastTick = Infinity.Win32.GetTickCount()

  if Grinder.MoveState.UseTp then
    return false
  end

  if self.LastPos ~= nil and (Grinder.MoveState.MvmtController:getIsMoving() or NavigatorUtils.isNavMoving()) and self.LastPos:getDistance(Infinity.BDO.getLocalPlayer():getPosition()) <= 10 then
    return true
  else
    self.LastPos = Infinity.BDO.getLocalPlayer():getPosition()
    return false
  end
end

function AntiStuckState:Run()
  if Grinder.CombatState.Target ~= nil then
      Grinder.CombatState:addToBlacklist(Grinder.CombatState.Target)   
  end

    Grinder.MoveState:ResetMvmtController()
    Grinder.MoveState:SetPrevious()
    Grinder.MoveState.ShouldRun = true
end