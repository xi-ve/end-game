CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Basic Warrior"

setmetatable(CombatRoutine, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatRoutine.new()
  	local self = setmetatable({}, CombatRoutine)   
  
  	self.GST = SkillAction("Great Sword Training", {KeyCode_LBUTTON}, {"BT_ARO_Att_Normal_", "WAIT"}, {1722, 1721, 1720, 1719, 1718}, nil, 300)  		
  	self.Dash = SkillAction("Head Chase", {KeyCode_W, KeyCode_SHIFT}, {"BT_ARO_Skill_DASH_F_End", "WAIT"}, {1725, 1724, 1723}, nil, 600) 

	self.SkillActions = 
	{
		self.GST,
		self.Dash
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
	
	--if string.find(self.CurrentAction, "WAIT") == nil then
		--return
	--end

	if self.GST:canUse(self.Target) then

		if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
			self:setAWCombatStance()
		end

		self.GST:use(self.Target)
		self.QueuedAction = true
	else

		if self.Dash:canUse(self.Target) then

			if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
				self:setAWCombatStance()
			end

			self.Dash:use(self.Target)
			self.QueuedAction = true
		else

			Grinder.MoveState:MoveTo(self.Target:getPosition())
		end
	end
end

function CombatRoutine:onDoneAction(skillAction)
	self.QueuedAction = false
end

return CombatRoutine()