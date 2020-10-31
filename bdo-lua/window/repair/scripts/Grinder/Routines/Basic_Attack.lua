CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Basic Attack"

setmetatable(CombatRoutine, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatRoutine.new()
  	local self = setmetatable({}, CombatRoutine)   
  
  	self.Attack = SkillAction("Attack", {KeyCode_LBUTTON}, {"BT_STAND_ATTACK_", "WAIT"}, {2613}, nil, 300)   	

	self.SkillActions = 
	{
		self.Attack
	}
	
	self.TargetRange = 1000

	self.Target = nil
	
	self.QueuedAction = false
	self.QueuedDefenseAction = false

	self.CurrentAction = nil

	self:init()

  	return self
end

function CombatRoutine:init()
	for kT, sa in pairs(self.SkillActions) do
		sa.DoneActionCallback = function(sA) self:onDoneAction(sA) end
	end
end

function CombatRoutine:setCombatStance()
	Actor.setAction("BT_WAIT")
end

function CombatRoutine:setAWCombatStance()
	Actor.setAction("BT_ARO_WAIT")
end

function CombatRoutine:onMonsterAttack(attacker)
	if self.QueuedDefenseAction then
		return
	end	
end

function CombatRoutine:onPulse()
	if self.QueuedAction or self.QueuedDefenseAction then
		return
	end
		
	if self.Attack:canUse(self.Target) then
		
		self.Attack:use(self.Target)
		self.QueuedAction = true
	else

		Grinder.MoveState:MoveTo(self.Target:getPosition())		
	end
end

function CombatRoutine:onDoneAction(skillAction)
	self.QueuedAction = false
end

return CombatRoutine()