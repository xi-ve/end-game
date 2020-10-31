CombatState = { }
CombatState.__index = CombatState
CombatState.Name = "CombatState"

setmetatable(CombatState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatState.new()
  local self = setmetatable({}, CombatState) 
  
  self.MonstersInRange = {}
  self.Target = nil  
  self.ClosestMonsterAttack = nil

  self.LastTick = 0

  self.Blacklist = {}

  return self
end

function CombatState:NeedToRun()
  if LocalPlayer.isDead() then
    return false
  end
  
  if Grinder.Routine == nil then
    return false
  end
        
  if self.LastTick + 100 > Infinity.Win32.GetTickCount() then
    return false
  end

  return Grinder.MoveState.ShouldRun == false
end

function CombatState:addToBlacklist(actor)
  table.insert(self.Blacklist, actor:getPosition())
end

function CombatState:selectTarget()

  self.MonstersInRange = {}

  if Grinder.Routine.BlackList_Monsters == nil then
    --print("Routine got no BlackList")
    self.MonstersInRange = TargetHelper.getMonstersInRangeOfLocation(Grinder.MoveState:GetCurrent(), Grinder.Routine.TargetRange, nil)
  else
    --print("Routine got BlackList")
    self.MonstersInRange = TargetHelper.getMonstersInRangeOfLocation(Grinder.MoveState:GetCurrent(), Grinder.Routine.TargetRange, Grinder.Routine.BlackList_Monsters)
  end

  self.Target = TargetHelper.getClosestMonsterTargetFromContainer(self.MonstersInRange, self.Blacklist)
  self.ClosestMonsterAttack = TargetHelper.getClosestMonsterAttack(self.MonstersInRange)  
end

function CombatState:Run()
    self.LastTick = Infinity.Win32.GetTickCount()

    self:selectTarget()

    if self.Target == nil then
      Grinder.MoveState.ShouldRun = true
      return
    end

    Grinder.MoveState:ResetMvmtController()

    Grinder.Routine.Target = self.Target

    if self.ClosestMonsterAttack ~= nil then
      Grinder.Routine:onMonsterAttack(self.ClosestMonsterAttack)
    end

    if self.Target ~= nil then
      Grinder.Routine:onPulse()
    end     
end